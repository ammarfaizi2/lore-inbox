Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbUL0WDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbUL0WDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 17:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUL0WDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 17:03:13 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:39185 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261547AbUL0WCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 17:02:50 -0500
Date: Sun, 26 Dec 2004 15:13:51 +0100
From: Jean Delvare <khali@linux-fr.org>
To: James Simmons <jsimmons@users.sf.net>, Antonino Daplas <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] FB: Possible fbcon cleanups
Message-Id: <20041226151351.32608309.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While browsing the video/fbcon.c source file (Linux 2.6.10-rc3) I found
some possible cleanups. Patch follows, feel free to apply all or parts
of it if it looks OK to you.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc3/drivers/video/fbmon.c.orig	2004-10-24 09:48:34.000000000 +0200
+++ linux-2.6.10-rc3/drivers/video/fbmon.c	2004-12-24 16:18:18.000000000 +0100
@@ -66,10 +66,9 @@
 	},
 };
 
-const unsigned char edid_v1_header[] = { 0x00, 0xff, 0xff, 0xff,
+static const unsigned char edid_v1_header[] = { 0x00, 0xff, 0xff, 0xff,
 	0xff, 0xff, 0xff, 0x00
 };
-const unsigned char edid_v1_descriptor_flag[] = { 0x00, 0x00 };
 
 static void copy_string(unsigned char *c, unsigned char *s)
 {
@@ -632,7 +631,7 @@
 
 	fb_get_monitor_limits(edid, specs);
 
-	c = (block[0] & 0x80) >> 7;
+	c = block[0] & 0x80;
 	specs->input = 0;
 	if (c) {
 		specs->input |= FB_DISP_DDI;
@@ -656,13 +655,10 @@
 			DPRINTK("0.700V/0.000V");
 			specs->input |= FB_DISP_ANA_700_000;
 			break;
-		default:
-			DPRINTK("unknown");
-			specs->input |= FB_DISP_UNKNOWN;
 		}
 	}
 	DPRINTK("\n      Sync: ");
-	c = (block[0] & 0x10) >> 4;
+	c = block[0] & 0x10;
 	if (c)
 		DPRINTK("      Configurable signal level\n");
 	c = block[0] & 0x0f;


-- 
Jean Delvare
http://khali.linux-fr.org/
