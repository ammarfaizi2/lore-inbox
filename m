Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUBTV6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 16:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbUBTV6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 16:58:10 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:8977 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261416AbUBTV6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 16:58:05 -0500
Date: Fri, 20 Feb 2004 21:58:02 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: fb_console_init fix.
Message-ID: <Pine.LNX.4.44.0402202156340.6798-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  This patch fixes fb_console_init from being called twice. I still need 
to fix set_con2fb but this helps but this is still important to get in.

--- linus-2.6/drivers/video/console/fbcon.c	2004-02-18 20:59:11.000000000 -0800
+++ fbdev-2.6/drivers/video/console/fbcon.c	2004-02-19 18:14:52.000000000 -0800
@@ -2335,6 +2335,7 @@
 {
 	if (!num_registered_fb)
 		return -ENODEV;
+
 	take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
 	acquire_console_sem();
 	if (!fbcon_event_notifier_registered) {
@@ -2342,10 +2343,11 @@
 		fbcon_event_notifier_registered = 1;
 	} 
 	release_console_sem();
-
 	return 0;
 }
 
+#ifdef MODULE
+
 void __exit fb_console_exit(void)
 {
 	acquire_console_sem();
@@ -2360,6 +2362,8 @@
 module_init(fb_console_init);
 module_exit(fb_console_exit);
 
+#endif
+
 /*
  *  Visible symbols for modules
  */

