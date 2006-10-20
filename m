Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992584AbWJTISB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992584AbWJTISB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 04:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992589AbWJTISB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 04:18:01 -0400
Received: from ns2.suse.de ([195.135.220.15]:55989 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S2992584AbWJTISA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 04:18:00 -0400
From: Neil Brown <neilb@suse.de>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Date: Fri, 20 Oct 2006 18:17:52 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17720.34352.587510.727157@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: sysrq-t broke in -mm :  sysrq-x-show-blocked-tasks.patch
   needs fixing
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a test in the above mentioned patch in -mm that is backwards,
so
  echo t > /proc/sysrq-trigger
stopped working.
echo p > /proc/sysrq-trigger isn't working on my x86-64 either just at
the moment, but that must be something else...

NeilBrown


diff .prev/kernel/sched.c ./kernel/sched.c
--- .prev/kernel/sched.c	2006-10-20 18:01:12.000000000 +1000
+++ ./kernel/sched.c	2006-10-20 18:01:22.000000000 +1000
@@ -4825,7 +4825,7 @@ void show_state_filter(unsigned long sta
 		 * console might take alot of time:
 		 */
 		touch_nmi_watchdog();
-		if (state_filter && (p->state & state_filter))
+		if (state_filter == 0  || (p->state & state_filter))
 			show_task(p);
 	} while_each_thread(g, p);
 

