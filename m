Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbWBAP1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbWBAP1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWBAP1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:27:12 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:45788 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1161093AbWBAP1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:27:10 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Wed,  1 Feb 2006 16:26:57 +0100
Cc: linux-kernel@vger.kernel.org, linux-kernel-announce@vger.kernel.org,
       Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>, jirislaby@gmail.com,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       "Antonino Daplas" <adaplas@pol.net>, ", "@fi.muni.cz, Martin@fi.muni.cz,
       Mares@fi.muni.cz, " <mj@ucw.cz>"@fi.muni.cz
To: "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH -mm] vgacon printk scrolling fix
Message-Id: <20060201152656.8DEBC22AEF3@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vgacon printk scrolling fix

As Jindrich Makovicka suggested, there is a stray printk("vgacon delta: %i\n",
lines); which effectively disables the scrollback of the vga console (at least
when not using the new soft scrollback). Removing it fixes the problem.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Acked-by: Antonino Daplas <adaplas@pol.net>
Cc: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: Martin Mares <mj@ucw.cz>
--
 vgacon.c |    1 -
 1 files changed, 1 deletion(-)
--- linux-2.6.16-rc1-mm4/drivers/video/console/vgacon.c	2006-01-25 19:16:35.000000000 +0100
+++ linux-2.6.16-rc1-mm4/drivers/video/console/vgacon.c	2006-01-31 21:33:40.433055896 +0100
@@ -331,7 +331,6 @@
 		int margin = c->vc_size_row * 4;
 		int ul, we, p, st;
 
-		printk("vgacon delta: %i\n", lines);
 		if (vga_rolled_over >
 		    (c->vc_scr_end - vga_vram_base) + margin) {
 			ul = c->vc_scr_end - vga_vram_base;
