Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263305AbTC0REy>; Thu, 27 Mar 2003 12:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263309AbTC0REt>; Thu, 27 Mar 2003 12:04:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52613
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263305AbTC0RDa>; Thu, 27 Mar 2003 12:03:30 -0500
Date: Thu, 27 Mar 2003 18:20:58 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271820.h2RIKwWu019672@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up 3w-xxxx. I didnt test SMP and it shows

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/drivers/scsi/3w-xxxx.c linux-2.5.66-ac1/drivers/scsi/3w-xxxx.c
--- linux-2.5.66-bk3/drivers/scsi/3w-xxxx.c	2003-03-27 17:13:11.000000000 +0000
+++ linux-2.5.66-ac1/drivers/scsi/3w-xxxx.c	2003-03-26 20:10:23.000000000 +0000
@@ -677,7 +677,7 @@
 			dprintk(KERN_WARNING "3w-xxxx: tw_chrdev_ioctl(): caught TW_AEN_LISTEN.\n");
 			memset(tw_ioctl->data_buffer, 0, tw_ioctl->data_buffer_length);
 
-			spin_lock_irqsave(&tw_dev->host->host_lock, flags);
+			spin_lock_irqsave(tw_dev->host->host_lock, flags);
 			if (tw_dev->aen_head == tw_dev->aen_tail) {
 				tw_aen_code = TW_AEN_QUEUE_EMPTY;
 			} else {
@@ -688,7 +688,7 @@
 					tw_dev->aen_head = tw_dev->aen_head + 1;
 				}
 			}
-			spin_unlock_irqrestore(&tw_dev->tw_lock, flags);
+			spin_unlock_irqrestore(tw_dev->host->host_lock, flags);
 			memcpy(tw_ioctl->data_buffer, &tw_aen_code, sizeof(tw_aen_code));
 			break;
 		case TW_CMD_PACKET_WITH_DATA:
