Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVBOTZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVBOTZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVBOTZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:25:43 -0500
Received: from gator7.brazosport.edu ([206.40.176.7]:39947 "EHLO
	caddo.brazosport.cc.tx.us") by vger.kernel.org with ESMTP
	id S261826AbVBOTZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:25:24 -0500
Subject: [PATCH] Change fb.h to compile with GCC-4.0
From: Art Haas <ahaas@airmail.net>
To: Antonio Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1108494519.16101.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Feb 2005 13:24:03 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The current GCC cvs code does not like the include/linux/fb.h file:

In file included from drivers/video/aty/atyfb_base.c:63:
include/linux/fb.h:865: error: array type has incomplete element type

This error is due to recent changes in GCC. A thread discussing this
change can be found by following the link below:

http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html

The patch moves the array declaration after the definition of the 
fb_modelist structure, and with this small change GCC is happy once
again. Maybe this can sneak in for 2.6.11?

Art Haas
===== include/linux/fb.h 1.94 vs edited =====
--- 1.94/include/linux/fb.h	2005-01-20 23:01:17 -06:00
+++ edited/include/linux/fb.h	2005-02-15 11:38:28 -06:00
@@ -862,7 +862,6 @@
 
 /* drivers/video/modedb.c */
 #define VESA_MODEDB_SIZE 34
-extern const struct fb_videomode vesa_modes[];
 extern void fb_var_to_videomode(struct fb_videomode *mode,
 				struct fb_var_screeninfo *var);
 extern void fb_videomode_to_var(struct fb_var_screeninfo *var,
@@ -906,6 +905,8 @@
 	u32 vmode;
 	u32 flag;
 };
+
+extern const struct fb_videomode vesa_modes[];
 
 struct fb_modelist {
 	struct list_head list;


