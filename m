Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWIGX6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWIGX6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbWIGX6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:58:16 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:30358 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751916AbWIGX6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:58:15 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 8 Sep 2006 01:57:09 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 1/2] ieee1394: ohci1394: fix endianess bug in debug message
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Wolfgang Pfeiffer <roto@gmx.net>, Ben Collins <bcollins@ubuntu.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <tkrat.e9e9aee005df0fb6@s5r6.in-berlin.de>
Message-ID: <tkrat.e527c910c204d2e6@s5r6.in-berlin.de>
References: <tkrat.e9e9aee005df0fb6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The transaction labels were misprinted int the debug printk "Packet
received from node..." due two byte-swapping once too often.  Affected
were big endian machines, except UniNorth based ones.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/ohci1394.c
===================================================================
--- linux.orig/drivers/ieee1394/ohci1394.c	2006-09-06 23:50:53.000000000 +0200
+++ linux/drivers/ieee1394/ohci1394.c	2006-09-07 15:48:15.000000000 +0200
@@ -2743,7 +2743,7 @@ static void dma_rcv_tasklet (unsigned lo
 				(cond_le32_to_cpu(d->spb[length/4-1], ohci->no_swap_incoming)>>16)&0x1f,
 				(cond_le32_to_cpu(d->spb[length/4-1], ohci->no_swap_incoming)>>21)&0x3,
 				tcode, length, d->ctx,
-				(cond_le32_to_cpu(d->spb[0], ohci->no_swap_incoming)>>10)&0x3f);
+				(d->spb[0]>>10)&0x3f);
 
 			ack = (((cond_le32_to_cpu(d->spb[length/4-1], ohci->no_swap_incoming)>>16)&0x1f)
 				== 0x11) ? 1 : 0;


