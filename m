Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVI1HNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVI1HNK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVI1HNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:13:05 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:26499 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S1030201AbVI1HMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:12:46 -0400
Date: Wed, 28 Sep 2005 09:12:10 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/7] HPET: remove superfluous register reads
In-reply-to: <20050928071155.23025.43523.balrog@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20050928071210.23025.1810.balrog@turing>
Content-transfer-encoding: 7BIT
References: <20050928071155.23025.43523.balrog@turing>
X-Scan-Signature: a35061c0abf4d8fa2201d8bd9fe648d3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes several reads of a timer's config register that
serve no purpose whatsoever.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Index: linux-2.6.13/drivers/char/hpet.c
===================================================================
--- linux-2.6.13.orig/drivers/char/hpet.c	2005-09-27 21:42:12.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-09-27 21:44:11.000000000 +0200
@@ -367,7 +367,6 @@ static int hpet_ioctl_ieon(struct hpet_d
 	if (!devp->hd_ireqfreq)
 		return -EIO;
 
-	v = readq(&timer->hpet_config);
 	spin_lock_irq(&hpet_lock);
 
 	if (devp->hd_flags & HPET_IE) {
@@ -378,7 +377,6 @@ static int hpet_ioctl_ieon(struct hpet_d
 	devp->hd_flags |= HPET_IE;
 	spin_unlock_irq(&hpet_lock);
 
-	t = readq(&timer->hpet_config);
 	irq = devp->hd_hdwirq;
 
 	if (irq) {
@@ -855,11 +853,9 @@ int hpet_alloc(struct hpet_data *hdp)
 	}
 
 	for (i = 0, devp = hpetp->hp_dev; i < hpetp->hp_ntimer; i++, devp++) {
-		unsigned long v;
 		struct hpet_timer __iomem *timer;
 
 		timer = &hpet->hpet_timers[devp - hpetp->hp_dev];
-		v = readq(&timer->hpet_config);
 
 		devp->hd_hpets = hpetp;
 		devp->hd_hpet = hpet;
