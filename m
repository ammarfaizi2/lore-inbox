Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUBJRc7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUBJRai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:30:38 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:8717 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265986AbUBJR04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:26:56 -0500
Date: Tue, 10 Feb 2004 17:26:51 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: framebuffer GPM corruption fix.
Message-ID: <Pine.LNX.4.44.0402101726130.6600-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the GPM cursor corruption people where seeing.

--- fbcon.c	2004-02-09 16:41:26.000000000 -0800
+++ fbcon.c.fix	2004-02-09 16:41:17.000000000 -0800
@@ -1826,9 +1826,11 @@
 	vc->vc_font.height = h;
 	if (vc->vc_hi_font_mask && cnt == 256) {
 		vc->vc_hi_font_mask = 0;
-		if (vc->vc_can_do_color)
+		if (vc->vc_can_do_color) {
 			vc->vc_complement_mask >>= 1;
-
+			vc->vc_s_complement_mask >>= 1;
+		}
+			
 		/* ++Edmund: reorder the attribute bits */
 		if (vc->vc_can_do_color) {
 			unsigned short *cp =
@@ -1847,9 +1849,11 @@
 		}
 	} else if (!vc->vc_hi_font_mask && cnt == 512) {
 		vc->vc_hi_font_mask = 0x100;
-		if (vc->vc_can_do_color)
+		if (vc->vc_can_do_color) {
 			vc->vc_complement_mask <<= 1;
-
+			vc->vc_s_complement_mask <<= 1;
+		}
+			
 		/* ++Edmund: reorder the attribute bits */
 		{
 			unsigned short *cp =

