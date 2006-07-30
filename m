Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWG3VoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWG3VoT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 17:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWG3VoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 17:44:19 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:59338 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932393AbWG3VoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 17:44:18 -0400
Date: Sun, 30 Jul 2006 23:44:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>,
       Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH/RFC] kconfig/lxdialog: make lxdialof a built-in
Message-ID: <20060730214415.GB9617@mars.ravnborg.org>
References: <20060727202726.GA3900@mars.ravnborg.org> <Pine.LNX.4.64.0607281348420.6761@scrub.home> <20060728145947.GA29095@mars.ravnborg.org> <200607301442.07426.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607301442.07426.vda.linux@googlemail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 02:42:07PM +0200, Denis Vlasenko wrote:
> 
> I don't like "double ESC" idea at all.
> 
> I am a Midnight Commander user and I use "old ESC mode"
> where single ESC works after a delay.
> 
> I patched mc to look at KEYBOARD_KEY_TIMEOUT_US environment variable 
> so that delay is configurable (instead of hardcoded 0.5 second one).
> Will push the patch to mc-devel.
How did you tell ncurses to change timeout value?
notimeout() and wnotimeout() did not work out when I tried it. Delay was
still ~.5 seconds.

Any help aprpeciated.

	Sam

My try:

diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index bf8052f..2b59657 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -198,6 +198,7 @@ int dialog_menu(const char *title, const
 
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
+	wtimeout(dialog, 25);
 
 	draw_box(dialog, 0, 0, height, width, dialog_attr, border_attr);
 	wattrset(dialog, border_attr);
@@ -221,6 +222,7 @@ int dialog_menu(const char *title, const
 	menu = subwin(dialog, menu_height, menu_width,
 		      y + box_y + 1, x + box_x + 1);
 	keypad(menu, TRUE);
+	wtimeout(menu, 25);
 
 	/* draw a box around the menu items */
 	draw_box(dialog, box_y, box_x, menu_height + 2, menu_width + 2,
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index f82cebb..0973b53 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -142,7 +142,7 @@ void init_dialog(void)
 	keypad(stdscr, TRUE);
 	cbreak();
 	noecho();
-
+	timeout(25);
 	if (use_colors)		/* Set up colors */
 		color_setup();
 
