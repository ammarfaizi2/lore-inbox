Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVCTVjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVCTVjF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 16:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVCTVjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 16:39:04 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:43434 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261284AbVCTVio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 16:38:44 -0500
Date: Sun, 20 Mar 2005 22:43:15 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       video4linux-list@redhat.com
Subject: [PATCH 2.6.11.2][2/2] printk with anti-cluttering-feature
In-Reply-To: <Pine.LNX.4.58.0503202151360.2869@be1.lrz>
Message-ID: <Pine.LNX.4.58.0503202235380.3051@be1.lrz>
References: <Pine.LNX.4.58.0503200528520.2804@be1.lrz> <423D6353.5010603@tls.msk.ru>
 <Pine.LNX.4.58.0503201425080.2886@be1.lrz> <Pine.LNX.4.58.0503202151360.2869@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update some functions to use printk_nospam

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>

diff -purNXdontdiff linux-2.6.11/drivers/block/scsi_ioctl.c linux-2.6.11.new/drivers/block/scsi_ioctl.c
--- linux-2.6.11/drivers/block/scsi_ioctl.c	2005-03-03 15:41:28.000000000 +0100
+++ linux-2.6.11.new/drivers/block/scsi_ioctl.c	2005-03-20 14:56:55.000000000 +0100
@@ -547,7 +547,7 @@ int scsi_cmd_ioctl(struct file *file, st
 		 * old junk scsi send command ioctl
 		 */
 		case SCSI_IOCTL_SEND_COMMAND:
-			printk(KERN_WARNING "program %s is using a deprecated SCSI ioctl, please convert it to SG_IO\n", current->comm);
+			printk_nospam(2296159591, KERN_WARNING "program %s is using a deprecated SCSI ioctl, please convert it to SG_IO\n", current->comm);
 			err = -EINVAL;
 			if (!arg)
 				break;
diff -purNXdontdiff linux-2.6.11/drivers/input/keyboard/atkbd.c linux-2.6.11.new/drivers/input/keyboard/atkbd.c
--- linux-2.6.11/drivers/input/keyboard/atkbd.c	2005-03-03 15:41:33.000000000 +0100
+++ linux-2.6.11.new/drivers/input/keyboard/atkbd.c	2005-03-20 14:56:55.000000000 +0100
@@ -320,7 +320,7 @@ static irqreturn_t atkbd_interrupt(struc
 			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
 			goto out;
 		case ATKBD_RET_ERR:
-			printk(KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
+			printk_nospam(2260620158, KERN_DEBUG "atkbd.c: Keyboard on %s reports too many keys pressed.\n", serio->phys);
 			goto out;
 	}
 
diff -purNXdontdiff linux-2.6.11/drivers/media/video/tuner.c linux-2.6.11.new/drivers/media/video/tuner.c
--- linux-2.6.11/drivers/media/video/tuner.c	2005-03-20 20:54:54.000000000 +0100
+++ linux-2.6.11.new/drivers/media/video/tuner.c	2005-03-20 14:56:55.000000000 +0100
@@ -1048,7 +1048,7 @@ static void set_tv_freq(struct i2c_clien
 		   right now we don't have that in the config
 		   struct and this way is still better than no
 		   check at all */
-		printk("tuner: TV freq (%d.%02d) out of range (%d-%d)\n",
+		printk_nospam(1801459135, "tuner: TV freq (%d.%02d) out of range (%d-%d)\n",
 		       freq/16,freq%16*100/16,tv_range[0],tv_range[1]);
 		return;
 	}
