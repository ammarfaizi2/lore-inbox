Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270599AbTGTB4k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 21:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270600AbTGTB4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 21:56:40 -0400
Received: from web41804.mail.yahoo.com ([66.218.93.138]:19796 "HELO
	web41804.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270599AbTGTB4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 21:56:35 -0400
Message-ID: <20030720021133.53368.qmail@web41804.mail.yahoo.com>
Date: Sun, 20 Jul 2003 04:11:33 +0200 (CEST)
From: =?iso-8859-1?q?Roberto=20Sanchez?= <rcsanchez97@yahoo.es>
Subject: [PATCH] drivers/video/vesafb.c, kernel 2.6.0-test1
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: jsimmons@infradead.org, geert@linux-m68k.org, torvalds@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial patch I made against the 2.6.0-test1 kernel to fix the
"vesafb: abort, cannot ioremap video memory 0x8000000 @ 0xe8000000" error
on systems with 1 GB RAM or more trying to use the framebuffer.

The trivial fix was mentioned on this list in this message:
http://www.ussg.iu.edu/hypermail/linux/kernel/0303.3/1236.html

The thread for the above message started here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0303.3/1098.html

-Roberto Sanchez

Here is the patch (it is only a change to one line):

--- linux-2.6.0-test1.orig/drivers/video/vesafb.c       2003-07-13
23:30:36.000000000 -0400
+++ linux/drivers/video/vesafb.c        2003-07-19 20:30:18.000000000 -0400
@@ -227,7 +227,7 @@
        vesafb_defined.xres = screen_info.lfb_width;
        vesafb_defined.yres = screen_info.lfb_height;
        vesafb_fix.line_length = screen_info.lfb_linelength;
-       vesafb_fix.smem_len = screen_info.lfb_size * 65536;
+       vesafb_fix.smem_len = screen_info.lfb_width * screen_info.lfb_height *
screen_info.lfb_depth;
        vesafb_fix.visual   = (vesafb_defined.bits_per_pixel == 8) ?
                FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
                                                                               



___________________________________________________
Yahoo! Messenger - Nueva versión GRATIS
Super Webcam, voz, caritas animadas, y más...
http://messenger.yahoo.es
