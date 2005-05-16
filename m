Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVEPSae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVEPSae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVEPSad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:30:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:19917 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261785AbVEPS34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:29:56 -0400
Date: Mon, 16 May 2005 11:26:20 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Re: Linux 2.6.11.10
Message-ID: <20050516182620.GB9960@kroah.com>
References: <20050516182544.GA9960@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050516182544.GA9960@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Naur linux-2.6.11.9/Makefile linux-2.6.11.10/Makefile
--- linux-2.6.11.9/Makefile	2005-05-11 15:42:25.000000000 -0700
+++ linux-2.6.11.10/Makefile	2005-05-16 10:50:30.000000000 -0700
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 11
-EXTRAVERSION = .9
+EXTRAVERSION = .10
 NAME=Woozy Beaver
 
 # *DOCUMENTATION*
diff -Naur linux-2.6.11.9/drivers/block/ioctl.c linux-2.6.11.10/drivers/block/ioctl.c
--- linux-2.6.11.9/drivers/block/ioctl.c	2005-05-11 15:41:10.000000000 -0700
+++ linux-2.6.11.10/drivers/block/ioctl.c	2005-05-16 10:50:31.000000000 -0700
@@ -237,3 +237,5 @@
 	}
 	return ret;
 }
+
+EXPORT_SYMBOL_GPL(blkdev_ioctl);
diff -Naur linux-2.6.11.9/drivers/block/pktcdvd.c linux-2.6.11.10/drivers/block/pktcdvd.c
--- linux-2.6.11.9/drivers/block/pktcdvd.c	2005-05-11 15:41:09.000000000 -0700
+++ linux-2.6.11.10/drivers/block/pktcdvd.c	2005-05-16 10:50:31.000000000 -0700
@@ -2400,7 +2400,7 @@
 	case CDROM_LAST_WRITTEN:
 	case CDROM_SEND_PACKET:
 	case SCSI_IOCTL_SEND_COMMAND:
-		return ioctl_by_bdev(pd->bdev, cmd, arg);
+		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
 
 	case CDROMEJECT:
 		/*
@@ -2408,7 +2408,7 @@
 		 * have to unlock it or else the eject command fails.
 		 */
 		pkt_lock_door(pd, 0);
-		return ioctl_by_bdev(pd->bdev, cmd, arg);
+		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
 
 	default:
 		printk("pktcdvd: Unknown ioctl for %s (%x)\n", pd->name, cmd);
diff -Naur linux-2.6.11.9/drivers/char/raw.c linux-2.6.11.10/drivers/char/raw.c
--- linux-2.6.11.9/drivers/char/raw.c	2005-05-11 15:42:19.000000000 -0700
+++ linux-2.6.11.10/drivers/char/raw.c	2005-05-16 10:50:31.000000000 -0700
@@ -122,7 +122,7 @@
 {
 	struct block_device *bdev = filp->private_data;
 
-	return ioctl_by_bdev(bdev, command, arg);
+	return blkdev_ioctl(bdev->bd_inode, filp, command, arg);
 }
 
 static void bind_device(struct raw_config_request *rq)
