Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268227AbUISOHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268227AbUISOHM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 10:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269075AbUISOHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 10:07:12 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:47554 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S268227AbUISOHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 10:07:11 -0400
Date: Sun, 19 Sep 2004 16:07:38 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: boot_cpu_data vs current_cpu_data in voluntary-preempt-2.6.9-rc2-mm1-S1
Message-ID: <20040919140738.GA8327@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	mingo@redhat.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Your voluntary-preempt-2.6.9-rc2-mm1-S1 patch contains this change

@@ -34,7 +34,7 @@ inline void __const_udelay(unsigned long
 	xloops *= 4;
 	__asm__("mull %0"
 		:"=d" (xloops), "=&a" (d0)
-		:"1" (xloops),"0" (current_cpu_data.loops_per_jiffy *
(HZ/4)));
+		:"1" (xloops),"0" (boot_cpu_data.loops_per_jiffy * (HZ/4)));
         __delay(++xloops);
 }

for both x86 and x86_64. And it's wrong. It assumes loops_per_jiffy being
consistent on all CPUs. There _are_ asymetric multiprocessor systems out
there, and some SMP systems can become asymetric as soon as
frequency scaling is enabled. Using boot_cpu_data's loops_per_jiffy instead
of current_cpu_data's loops_per_jiffy causes delays being too short or too
long. So please drop this change.

Thanks,
	Dominik
