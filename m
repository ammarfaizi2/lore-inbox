Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbULBBBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbULBBBe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 20:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbULBBBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 20:01:34 -0500
Received: from smtp09.auna.com ([62.81.186.19]:6583 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S261534AbULBBBE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 20:01:04 -0500
Date: Thu, 02 Dec 2004 01:01:03 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: [PATCH] make gconfig work with gtk-2.4
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20041130095045.090de5ea.akpm@osdl.org>
In-Reply-To: <20041130095045.090de5ea.akpm@osdl.org> (from akpm@osdl.org on
	Tue Nov 30 18:50:45 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101949263l.27549l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need this to make gconfig work under gtk-2.4. Without this, it just
coredumps. There is some problem with pixmap creation/usage from XPM in
the way it is done in gconf, so I just added some stock icons. It is even prettier..;)

Could someone test this still works on gtk-2.0 or 2.2 ?


Changes:

- change the wiget class 'button' in glade files to something known to
  glade (GtkToolButton)
- use 'stock-id' property for toolbar buttons instead of "stock_pixmap"
- change unknown signal "pressed" to "clicked"
- removed unused xpms
- remove manual setting of icons in gconf.c

Here it goes:

--- linux/scripts/kconfig/gconf.glade.orig	2004-12-02 00:41:02.000000000 +0100
+++ linux/scripts/kconfig/gconf.glade	2004-12-02 01:25:09.000000000 +0100
@@ -310,13 +310,13 @@
 	      <property name="tooltips">True</property>
 
 	      <child>
-		<widget class="button" id="button1">
+		<widget class="GtkToolButton" id="button1">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Goes up of one level (single view)</property>
 		  <property name="label" translatable="yes">Back</property>
 		  <property name="use_underline">True</property>
-		  <property name="stock_pixmap">gtk-undo</property>
-		  <signal name="pressed" handler="on_back_pressed"/>
+		  <property name="stock-id">gtk-undo</property>
+		  <signal name="clicked" handler="on_back_pressed"/>
 		</widget>
 	      </child>
 
@@ -327,24 +327,24 @@
 	      </child>
 
 	      <child>
-		<widget class="button" id="button2">
+		<widget class="GtkToolButton" id="button2">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Load a config file</property>
 		  <property name="label" translatable="yes">Load</property>
 		  <property name="use_underline">True</property>
-		  <property name="stock_pixmap">gtk-open</property>
-		  <signal name="pressed" handler="on_load_pressed"/>
+		  <property name="stock-id">gtk-open</property>
+		  <signal name="clicked" handler="on_load_pressed"/>
 		</widget>
 	      </child>
 
 	      <child>
-		<widget class="button" id="button3">
+		<widget class="GtkToolButton" id="button3">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Save a config file</property>
 		  <property name="label" translatable="yes">Save</property>
 		  <property name="use_underline">True</property>
-		  <property name="stock_pixmap">gtk-save</property>
-		  <signal name="pressed" handler="on_save_pressed"/>
+		  <property name="stock-id">gtk-save</property>
+		  <signal name="clicked" handler="on_save_pressed"/>
 		</widget>
 	      </child>
 
@@ -355,34 +355,34 @@
 	      </child>
 
 	      <child>
-		<widget class="button" id="button4">
+		<widget class="GtkToolButton" id="button4">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Single view</property>
 		  <property name="label" translatable="yes">Single</property>
 		  <property name="use_underline">True</property>
-		  <property name="stock_pixmap">gtk-missing-image</property>
+		  <property name="stock-id">gtk-indent</property>
 		  <signal name="clicked" handler="on_single_clicked" last_modification_time="Sun, 12 Jan 2003 14:28:39 GMT"/>
 		</widget>
 	      </child>
 
 	      <child>
-		<widget class="button" id="button5">
+		<widget class="GtkToolButton" id="button5">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Split view</property>
 		  <property name="label" translatable="yes">Split</property>
 		  <property name="use_underline">True</property>
-		  <property name="stock_pixmap">gtk-missing-image</property>
+		  <property name="stock-id">gtk-copy</property>
 		  <signal name="clicked" handler="on_split_clicked" last_modification_time="Sun, 12 Jan 2003 14:28:45 GMT"/>
 		</widget>
 	      </child>
 
 	      <child>
-		<widget class="button" id="button6">
+		<widget class="GtkToolButton" id="button6">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Full view</property>
 		  <property name="label" translatable="yes">Full</property>
 		  <property name="use_underline">True</property>
-		  <property name="stock_pixmap">gtk-missing-image</property>
+		  <property name="stock-id">gtk-justify-left</property>
 		  <signal name="clicked" handler="on_full_clicked" last_modification_time="Sun, 12 Jan 2003 14:28:50 GMT"/>
 		</widget>
 	      </child>
@@ -394,22 +394,24 @@
 	      </child>
 
 	      <child>
-		<widget class="button" id="button7">
+		<widget class="GtkToolButton" id="button7">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Collapse the whole tree in the right frame</property>
 		  <property name="label" translatable="yes">Collapse</property>
 		  <property name="use_underline">True</property>
-		  <signal name="pressed" handler="on_collapse_pressed"/>
+		  <property name="stock-id">gtk-zoom-out</property>
+		  <signal name="clicked" handler="on_collapse_pressed"/>
 		</widget>
 	      </child>
 
 	      <child>
-		<widget class="button" id="button8">
+		<widget class="GtkToolButton" id="button8">
 		  <property name="visible">True</property>
 		  <property name="tooltip" translatable="yes">Expand the whole tree in the right frame</property>
 		  <property name="label" translatable="yes">Expand</property>
 		  <property name="use_underline">True</property>
-		  <signal name="pressed" handler="on_expand_pressed"/>
+		  <property name="stock-id">gtk-zoom-in</property>
+		  <signal name="clicked" handler="on_expand_pressed"/>
 		</widget>
 	      </child>
 	    </widget>
--- linux/scripts/kconfig/images.c.orig	2004-06-16 07:18:55.000000000 +0200
+++ linux/scripts/kconfig/images.c	2004-12-02 01:50:47.000000000 +0100
@@ -3,260 +3,6 @@
  * Released under the terms of the GNU GPL v2.0.
  */
 
-static const char *xpm_load[] = {
-"22 22 5 1",
-". c None",
-"# c #000000",
-"c c #838100",
-"a c #ffff00",
-"b c #ffffff",
-"......................",
-"......................",
-"......................",
-"............####....#.",
-"...........#....##.##.",
-"..................###.",
-".................####.",
-".####...........#####.",
-"#abab##########.......",
-"#babababababab#.......",
-"#ababababababa#.......",
-"#babababababab#.......",
-"#ababab###############",
-"#babab##cccccccccccc##",
-"#abab##cccccccccccc##.",
-"#bab##cccccccccccc##..",
-"#ab##cccccccccccc##...",
-"#b##cccccccccccc##....",
-"###cccccccccccc##.....",
-"##cccccccccccc##......",
-"###############.......",
-"......................"};
-
-static const char *xpm_save[] = {
-"22 22 5 1",
-". c None",
-"# c #000000",
-"a c #838100",
-"b c #c5c2c5",
-"c c #cdb6d5",
-"......................",
-".####################.",
-".#aa#bbbbbbbbbbbb#bb#.",
-".#aa#bbbbbbbbbbbb#bb#.",
-".#aa#bbbbbbbbbcbb####.",
-".#aa#bbbccbbbbbbb#aa#.",
-".#aa#bbbccbbbbbbb#aa#.",
-".#aa#bbbbbbbbbbbb#aa#.",
-".#aa#bbbbbbbbbbbb#aa#.",
-".#aa#bbbbbbbbbbbb#aa#.",
-".#aa#bbbbbbbbbbbb#aa#.",
-".#aaa############aaa#.",
-".#aaaaaaaaaaaaaaaaaa#.",
-".#aaaaaaaaaaaaaaaaaa#.",
-".#aaa#############aa#.",
-".#aaa#########bbb#aa#.",
-".#aaa#########bbb#aa#.",
-".#aaa#########bbb#aa#.",
-".#aaa#########bbb#aa#.",
-".#aaa#########bbb#aa#.",
-"..##################..",
-"......................"};
-
-static const char *xpm_back[] = {
-"22 22 3 1",
-". c None",
-"# c #000083",
-"a c #838183",
-"......................",
-"......................",
-"......................",
-"......................",
-"......................",
-"...........######a....",
-"..#......##########...",
-"..##...####......##a..",
-"..###.###.........##..",
-"..######..........##..",
-"..#####...........##..",
-"..######..........##..",
-"..#######.........##..",
-"..########.......##a..",
-"...............a###...",
-"...............###....",
-"......................",
-"......................",
-"......................",
-"......................",
-"......................",
-"......................"};
-
-static const char *xpm_tree_view[] = {
-"22 22 2 1",
-". c None",
-"# c #000000",
-"......................",
-"......................",
-"......#...............",
-"......#...............",
-"......#...............",
-"......#...............",
-"......#...............",
-"......########........",
-"......#...............",
-"......#...............",
-"......#...............",
-"......#...............",
-"......#...............",
-"......########........",
-"......#...............",
-"......#...............",
-"......#...............",
-"......#...............",
-"......#...............",
-"......########........",
-"......................",
-"......................"};
-
-static const char *xpm_single_view[] = {
-"22 22 2 1",
-". c None",
-"# c #000000",
-"......................",
-"......................",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"..........#...........",
-"......................",
-"......................"};
-
-static const char *xpm_split_view[] = {
-"22 22 2 1",
-". c None",
-"# c #000000",
-"......................",
-"......................",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......#......#........",
-"......................",
-"......................"};
-
-static const char *xpm_symbol_no[] = {
-"12 12 2 1",
-"  c white",
-". c black",
-"            ",
-" .......... ",
-" .        . ",
-" .        . ",
-" .        . ",
-" .        . ",
-" .        . ",
-" .        . ",
-" .        . ",
-" .        . ",
-" .......... ",
-"            "};
-
-static const char *xpm_symbol_mod[] = {
-"12 12 2 1",
-"  c white",
-". c black",
-"            ",
-" .......... ",
-" .        . ",
-" .        . ",
-" .   ..   . ",
-" .  ....  . ",
-" .  ....  . ",
-" .   ..   . ",
-" .        . ",
-" .        . ",
-" .......... ",
-"            "};
-
-static const char *xpm_symbol_yes[] = {
-"12 12 2 1",
-"  c white",
-". c black",
-"            ",
-" .......... ",
-" .        . ",
-" .        . ",
-" .      . . ",
-" .     .. . ",
-" . .  ..  . ",
-" . ....   . ",
-" .  ..    . ",
-" .        . ",
-" .......... ",
-"            "};
-
-static const char *xpm_choice_no[] = {
-"12 12 2 1",
-"  c white",
-". c black",
-"            ",
-"    ....    ",
-"  ..    ..  ",
-"  .      .  ",
-" .        . ",
-" .        . ",
-" .        . ",
-" .        . ",
-"  .      .  ",
-"  ..    ..  ",
-"    ....    ",
-"            "};
-
-static const char *xpm_choice_yes[] = {
-"12 12 2 1",
-"  c white",
-". c black",
-"            ",
-"    ....    ",
-"  ..    ..  ",
-"  .      .  ",
-" .   ..   . ",
-" .  ....  . ",
-" .  ....  . ",
-" .   ..   . ",
-"  .      .  ",
-"  ..    ..  ",
-"    ....    ",
-"            "};
-
 static const char *xpm_menu[] = {
 "12 12 2 1",
 "  c white",
@@ -274,40 +20,6 @@
 " .......... ",
 "            "};
 
-static const char *xpm_menu_inv[] = {
-"12 12 2 1",
-"  c white",
-". c black",
-"            ",
-" .......... ",
-" .......... ",
-" ..  ...... ",
-" ..    .... ",
-" ..      .. ",
-" ..      .. ",
-" ..    .... ",
-" ..  ...... ",
-" .......... ",
-" .......... ",
-"            "};
-
-static const char *xpm_menuback[] = {
-"12 12 2 1",
-"  c white",
-". c black",
-"            ",
-" .......... ",
-" .        . ",
-" .     .. . ",
-" .   .... . ",
-" . ...... . ",
-" . ...... . ",
-" .   .... . ",
-" .     .. . ",
-" .        . ",
-" .......... ",
-"            "};
-
 static const char *xpm_void[] = {
 "12 12 2 1",
 "  c white",
--- linux/scripts/kconfig/gconf.c.orig	2004-12-02 00:55:52.000000000 +0100
+++ linux/scripts/kconfig/gconf.c	2004-12-02 01:49:27.000000000 +0100
@@ -187,8 +187,6 @@
 	GtkWidget *widget;
 	GtkTextBuffer *txtbuf;
 	char title[256];
-	GdkPixmap *pixmap;
-	GdkBitmap *mask;
 	GtkStyle *style;
 
 	xml = glade_xml_new(glade_file, "window1", NULL);
@@ -221,36 +219,6 @@
 	style = gtk_widget_get_style(main_wnd);
 	widget = glade_xml_get_widget(xml, "toolbar1");
 
-	pixmap = gdk_pixmap_create_from_xpm_d(main_wnd->window, &mask,
-					      &style->bg[GTK_STATE_NORMAL],
-					      (gchar **) xpm_single_view);
-	gtk_image_set_from_pixmap(GTK_IMAGE
-				  (((GtkToolbarChild
-				     *) (g_list_nth(GTK_TOOLBAR(widget)->
-						    children,
-						    5)->data))->icon),
-				  pixmap, mask);
-	pixmap =
-	    gdk_pixmap_create_from_xpm_d(main_wnd->window, &mask,
-					 &style->bg[GTK_STATE_NORMAL],
-					 (gchar **) xpm_split_view);
-	gtk_image_set_from_pixmap(GTK_IMAGE
-				  (((GtkToolbarChild
-				     *) (g_list_nth(GTK_TOOLBAR(widget)->
-						    children,
-						    6)->data))->icon),
-				  pixmap, mask);
-	pixmap =
-	    gdk_pixmap_create_from_xpm_d(main_wnd->window, &mask,
-					 &style->bg[GTK_STATE_NORMAL],
-					 (gchar **) xpm_tree_view);
-	gtk_image_set_from_pixmap(GTK_IMAGE
-				  (((GtkToolbarChild
-				     *) (g_list_nth(GTK_TOOLBAR(widget)->
-						    children,
-						    7)->data))->icon),
-				  pixmap, mask);
-
 	switch (view_mode) {
 	case SINGLE_VIEW:
 		widget = glade_xml_get_widget(xml, "button4");



--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam4 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #2


