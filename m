Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWCMUb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWCMUb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWCMUb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:31:56 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:17427 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932448AbWCMUbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:31:55 -0500
Date: Mon, 13 Mar 2006 21:31:56 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: [PATCH 4/8] adv7175: Drop unused encoder dump command
Message-Id: <20060313213156.50b14efe.khali@linux-fr.org>
In-Reply-To: <20060313210933.88a42375.khali@linux-fr.org>
References: <20060313210933.88a42375.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drop support for the ENCODER_DUMP command in the adv7175 driver.
ENCODER_DUMP was never actually defined as far as I can see, so the
code was ifdef'd out, and I suspect it was never used, not even once,
as it includes an obvious array overrun.

The register values of this specific chip can be dumped in a generic
way using the i2c-dev driver and the "i2cdump" user-space tool if it
is ever really needed.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/media/video/adv7175.c |   26 --------------------------
 1 file changed, 26 deletions(-)

--- linux-2.6.16-rc5.orig/drivers/media/video/adv7175.c	2006-03-01 21:09:59.000000000 +0100
+++ linux-2.6.16-rc5/drivers/media/video/adv7175.c	2006-03-01 21:10:12.000000000 +0100
@@ -170,24 +170,6 @@
 	adv7175_write(client, 0x05, 0x25);
 }
 
-#ifdef ENCODER_DUMP
-static void
-dump (struct i2c_client *client)
-{
-	struct adv7175 *encoder = i2c_get_clientdata(client);
-	int i, j;
-
-	printk(KERN_INFO "%s: registry dump\n", I2C_NAME(client));
-	for (i = 0; i < 182 / 8; i++) {
-		printk("%s: 0x%02x -", I2C_NAME(client), i * 8);
-		for (j = 0; j < 8; j++) {
-			printk(" 0x%02x", encoder->reg[i * 8 + j]);
-		}
-		printk("\n");
-	}
-}
-#endif
-
 /* ----------------------------------------------------------------------- */
 // Output filter:  S-Video  Composite
 
@@ -406,14 +388,6 @@
 	}
 		break;
 
-#ifdef ENCODER_DUMP
-	case ENCODER_DUMP:
-	{
-		dump(client);
-	}
-		break;
-#endif
-
 	default:
 		return -EINVAL;
 	}

-- 
Jean Delvare
