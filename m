Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263747AbTCUSgo>; Fri, 21 Mar 2003 13:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263737AbTCUSfL>; Fri, 21 Mar 2003 13:35:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2436
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263736AbTCUSeU>; Fri, 21 Mar 2003 13:34:20 -0500
Date: Fri, 21 Mar 2003 19:49:35 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211949.h2LJnZlh026037@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: xjack memory leak fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/telephony/ixj.c linux-2.5.65-ac2/drivers/telephony/ixj.c
--- linux-2.5.65/drivers/telephony/ixj.c	2003-03-06 17:04:31.000000000 +0000
+++ linux-2.5.65-ac2/drivers/telephony/ixj.c	2003-03-14 00:42:07.000000000 +0000
@@ -5999,12 +5999,14 @@
 		if(ixjdebug & 0x0001) {
 			printk(KERN_INFO "Could not copy cadence to kernel\n");
 		}
+		kfree(lcp);
 		return -EFAULT;
 	}
 	if (lcp->filter > 5) {
 		if(ixjdebug & 0x0001) {
 			printk(KERN_INFO "Cadence out of range\n");
 		}
+		kfree(lcp);
 		return -1;
 	}
 	j->cadence_f[lcp->filter].state = 0;
