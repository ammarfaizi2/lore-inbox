Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262512AbTCMUK6>; Thu, 13 Mar 2003 15:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262515AbTCMUK6>; Thu, 13 Mar 2003 15:10:58 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:4517 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262512AbTCMUK5>;
	Thu, 13 Mar 2003 15:10:57 -0500
Date: Thu, 13 Mar 2003 23:20:35 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org, eokerson@quicknet.net,
       torvalds@transmeta.com
Subject: Memleak in Internet PhoneJACK driver
Message-ID: <20030313202035.GA3292@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is unfree memory on error return path in ixj_build_filter_cadence().
   Trivial patch that applies to both 2.4 and 2.5 is below.
   Found with help of smatch + enhanced ufree patch.

Bye,
    Oleg

===== drivers/telephony/ixj.c 1.16 vs edited =====
--- 1.16/drivers/telephony/ixj.c	Fri Aug 23 04:23:39 2002
+++ edited/drivers/telephony/ixj.c	Thu Mar 13 23:15:51 2003
@@ -6001,12 +6001,14 @@
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
