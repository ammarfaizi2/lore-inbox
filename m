Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751889AbWCMU3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbWCMU3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWCMU3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:29:17 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:787 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751889AbWCMU3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:29:16 -0500
Date: Mon, 13 Mar 2006 21:29:16 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: [PATCH 1/8] saa7110: Fix array overrun
Message-Id: <20060313212916.f601aa64.khali@linux-fr.org>
In-Reply-To: <20060313210933.88a42375.khali@linux-fr.org>
References: <20060313210933.88a42375.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a (probably harmless) array overrun in the DECODER_DUMP command
of the saa7110 driver. No big deal as this command is not used
anywhere anyway. Also reformat the dump so that it displays nicely.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/saa7110.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- linux-2.6.16-rc5.orig/drivers/media/video/saa7110.c	2006-03-01 21:09:59.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/saa7110.c	2006-03-01 21:10:01.000000000 +0100
@@ -431,15 +431,13 @@
 		break;
 
 	case DECODER_DUMP:
-		for (v = 0; v < 0x34; v += 16) {
+		for (v = 0; v < SAA7110_NR_REG; v += 16) {
 			int j;
-			dprintk(1, KERN_INFO "%s: %03x\n", I2C_NAME(client),
+			dprintk(1, KERN_DEBUG "%s: %02x:", I2C_NAME(client),
 				v);
-			for (j = 0; j < 16; j++) {
-				dprintk(1, KERN_INFO " %02x",
-					decoder->reg[v + j]);
-			}
-			dprintk(1, KERN_INFO "\n");
+			for (j = 0; j < 16 && v + j < SAA7110_NR_REG; j++)
+				dprintk(1, " %02x", decoder->reg[v + j]);
+			dprintk(1, "\n");
 		}
 		break;
 

-- 
Jean Delvare
