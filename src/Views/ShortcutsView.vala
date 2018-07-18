/*-
 * Copyright (c) 2018 elementary LLC. (https://elementary.io)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

public class ShortcutOverlay.ShortcutsView : Gtk.Grid {
    private static Gee.ArrayList<ShortcutEntry> system_entries;
    private static Gee.ArrayList<ShortcutEntry> screenshot_entries;
    private static Gee.ArrayList<ShortcutEntry> window_entries;
    private static Gee.ArrayList<ShortcutEntry> workspace_entries;

    private const string SCHEMA_WM = "org.mate.Marco.window-keybindings";
    private const string SCHEMA_MARCO = "org.mate.Marco.global-keybindings";
    private const string SCHEMA_MEDIA = "org.mate.SettingsDaemon.plugins.media-keys";

    private static Gtk.SizeGroup size_group;

    static construct {
        system_entries = new Gee.ArrayList<ShortcutEntry> ();
        system_entries.add (new ShortcutEntry (_("Applications Menu:"), SCHEMA_MARCO, "panel-main-menu"));
        /* system_entries.add (new ShortcutEntry (_("Cycle display mode:"), SCHEMA_MEDIA, "switch-monitor")); */
        system_entries.add (new ShortcutEntry (_("Magnifier:"), SCHEMA_MEDIA, "magnifier"));
        system_entries.add (new ShortcutEntry (_("Lock screen:"), SCHEMA_MEDIA, "screensaver"));
        system_entries.add (new ShortcutEntry (_("Log out:"), SCHEMA_MEDIA, "logout"));

        screenshot_entries = new Gee.ArrayList<ShortcutEntry> ();
        screenshot_entries.add (new ShortcutEntry (_("Grab the whole screen:"), SCHEMA_MARCO, "run-command-screenshot"));
        screenshot_entries.add (new ShortcutEntry (_("Grab the current window:"), SCHEMA_MARCO, "run-command-window-screenshot"));
        /* screenshot_entries.add (new ShortcutEntry (_("Select an area to grab:"), SCHEMA_MARCO, "area-screenshot")); */

        window_entries = new Gee.ArrayList<ShortcutEntry> ();
        window_entries.add (new ShortcutEntry (_("Cycle windows:"), SCHEMA_MARCO, "switch-windows"));
        window_entries.add (new ShortcutEntry (_("Toggle maximized:"), SCHEMA_WM, "toggle-maximized"));
        window_entries.add (new ShortcutEntry (_("Tile left:"), SCHEMA_WM, "tile-to-side-w"));
        window_entries.add (new ShortcutEntry (_("Tile right:"), SCHEMA_WM, "tile-to-side-e"));
        window_entries.add (new ShortcutEntry (_("Move to left workspace:"), SCHEMA_WM, "move-to-workspace-left"));
        window_entries.add (new ShortcutEntry (_("Move to right workspace:"), SCHEMA_WM, "move-to-workspace-right"));
        /* window_entries.add (new ShortcutEntry (_("Picture in Picture Mode:"), SCHEMA_MARCO, "pip")); */

        workspace_entries = new Gee.ArrayList<ShortcutEntry> (); 
        workspace_entries.add (new ShortcutEntry (_("Multitasking View:"), SCHEMA_MARCO, "show-desktop"));
        workspace_entries.add (new ShortcutEntry (_("Switch left:"), SCHEMA_MARCO, "switch-to-workspace-left"));
        workspace_entries.add (new ShortcutEntry (_("Switch right:"), SCHEMA_MARCO, "switch-to-workspace-right"));
        workspace_entries.add (new ShortcutEntry (_("Switch to first:"), SCHEMA_MARCO, "switch-to-workspace-1"));
        /* workspace_entries.add (new ShortcutEntry (_("Switch to new:"), SCHEMA_MARCO, "switch-to-workspace-last")); */
        /* workspace_entries.add (new ShortcutEntry (_("Cycle workspaces:"), SCHEMA_MARCO, "cycle-workspaces-next")); */
    }

    construct {
        var column_start = new Gtk.Grid ();
        column_start.hexpand = true;
        column_start.orientation = Gtk.Orientation.VERTICAL;
        column_start.row_spacing = 12;

        size_group = new Gtk.SizeGroup (Gtk.SizeGroupMode.HORIZONTAL);

        var window_header = new Granite.HeaderLabel (_("Windows"));
        column_start.add (window_header);
        add_shortcut_entries (window_entries, column_start);

        var workspace_header = new Granite.HeaderLabel (_("Workspaces"));
        column_start.add (workspace_header);
        add_shortcut_entries (workspace_entries, column_start);

        var column_end = new Gtk.Grid ();
        column_end.halign = Gtk.Align.START;
        column_end.hexpand = true;
        column_end.orientation = Gtk.Orientation.VERTICAL;
        column_end.row_spacing = 12;

        var system_header = new Granite.HeaderLabel (_("System"));
        column_end.add (system_header);
        add_shortcut_entries (system_entries, column_end);

        var screenshot_header = new Granite.HeaderLabel (_("Screenshots"));
        column_end.add (screenshot_header);
        add_shortcut_entries (screenshot_entries, column_end);

        var column_size_group = new Gtk.SizeGroup (Gtk.SizeGroupMode.HORIZONTAL);
        column_size_group.add_widget (column_start);
        column_size_group.add_widget (column_end);

        column_spacing = 24;
        add (column_start);
        add (new Gtk.Separator (Gtk.Orientation.VERTICAL));
        add (column_end);
    }

    private void add_shortcut_entries (Gee.ArrayList<ShortcutEntry> entries, Gtk.Grid column) {
        foreach (var entry in entries) {
            var label = new ShortcutLabel (entry);
            column.add (label);
            size_group.add_widget (label.name_label);
        }
    }
}
