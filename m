Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTK1S3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 13:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTK1S3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 13:29:49 -0500
Received: from [139.30.44.16] ([139.30.44.16]:55717 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263387AbTK1S31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 13:29:27 -0500
Date: Fri, 28 Nov 2003 19:29:24 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] another jiffies wrap bug
In-Reply-To: <Pine.LNX.4.53.0311281826250.9728@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.53.0311281927150.10787@gockel.physik3.uni-rostock.de>
References: <20031128141927.5ff1f35a.rnsanchez@terra.com.br>
 <Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.53.0311281826250.9728@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> HOWEVER, we seem to have some jiffies wrap bugs in this file.

Should have checked the whole directory first, the chance of cut'n paste 
bugs was just too high...

Tim


--- linux-2.6.0-test11/arch/i386/kernel/timers/timer_hpet.c.orig	2003-11-28 19:21:32.000000000 +0100
+++ linux-2.6.0-test11/arch/i386/kernel/timers/timer_hpet.c	2003-11-28 19:22:28.000000000 +0100
@@ -108,7 +108,8 @@
 	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
 	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
 		int lost_ticks = (offset - hpet_last) / hpet_tick;
-		jiffies += lost_ticks;
+		/* only called under xtime_lock */
+		jiffies_64 += lost_ticks;
 	}
 	hpet_last = offset;
 
