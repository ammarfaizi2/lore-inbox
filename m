Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTFPDXf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 23:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTFPDXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 23:23:35 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:26599 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263275AbTFPDXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 23:23:34 -0400
Date: Sun, 15 Jun 2003 23:34:45 -0400
From: Chris Heath <chris@heathens.co.nz>
Subject: [PATCH][2.5] fbcon.c complement_mask bug
To: linux-kernel@vger.kernel.org
Message-id: <20030615232235.D979.CHRIS@heathens.co.nz>
MIME-version: 1.0
X-Mailer: Becky! ver. 2.06.02
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-Antirelay: Good relay from local net1 127.0.0.1/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using a frame buffer console with a 512-character font, the mouse
pointer starts using the wrong complement_mask after a console reset.

This patch is against 2.5.71.  It fixes s_complement_mask so that it is
always a valid default value for complement_mask.

Chris


--- a/drivers/video/console/fbcon.c	2003-06-01 09:56:46.000000000 -0400
+++ b/drivers/video/console/fbcon.c	2003-06-15 22:54:47.000000000 -0400
@@ -1826,8 +1826,10 @@
 	vc->vc_font.height = h;
 	if (vc->vc_hi_font_mask && cnt == 256) {
 		vc->vc_hi_font_mask = 0;
-		if (vc->vc_can_do_color)
+		if (vc->vc_can_do_color) {
 			vc->vc_complement_mask >>= 1;
+			vc->vc_s_complement_mask >>= 1;
+		}
 
 		/* ++Edmund: reorder the attribute bits */
 		if (vc->vc_can_do_color) {
@@ -1847,8 +1849,10 @@
 		}
 	} else if (!vc->vc_hi_font_mask && cnt == 512) {
 		vc->vc_hi_font_mask = 0x100;
-		if (vc->vc_can_do_color)
+		if (vc->vc_can_do_color) {
 			vc->vc_complement_mask <<= 1;
+			vc->vc_s_complement_mask <<= 1;
+		}
 
 		/* ++Edmund: reorder the attribute bits */
 		{

