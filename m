Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272635AbTHKOZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272584AbTHKNlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:41:53 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:42123 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272635AbTHKNlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:41:07 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: [PATCH] misc 3c505 bits
Message-Id: <E19mCuP-0003dp-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove unneeded breaks
- Fix double spin_unlock_irqrestore problem

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/3c505.c linux-2.5/drivers/net/3c505.c
--- bk-linus/drivers/net/3c505.c	2003-05-26 12:57:43.000000000 +0100
+++ linux-2.5/drivers/net/3c505.c	2003-06-04 14:07:40.000000000 +0100
@@ -449,18 +449,18 @@ static int send_pcb(struct net_device *d
 		case ASF_PCB_ACK:
 			adapter->send_pcb_semaphore = 0;
 			return TRUE;
-			break;
+
 		case ASF_PCB_NAK:
 #ifdef ELP_DEBUG
 			printk(KERN_DEBUG "%s: send_pcb got NAK\n", dev->name);
 #endif
 			goto abort;
-			break;
 		}
 	}
 
 	if (elp_debug >= 1)
 		printk(KERN_DEBUG "%s: timeout waiting for PCB acknowledge (status %02x)\n", dev->name, inb_status(dev->base_addr));
+	goto abort;
 
       sti_abort:
 	spin_unlock_irqrestore(&adapter->lock, flags);
