Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTK1QTc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTK1QTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:19:32 -0500
Received: from itaqui.terra.com.br ([200.176.3.19]:44733 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262546AbTK1QTa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:19:30 -0500
Date: Fri, 28 Nov 2003 14:19:27 -0200
From: Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sisop-iii-l <sisopiii-l@cscience.org>
Subject: [PATCH] fix #endif misplacement
Message-Id: <20031128141927.5ff1f35a.rnsanchez@terra.com.br>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an #endif misplacement, which leads to dead code in
sched_clock() in arch/i386/kernel/timers/timer_tsc.c, due to a return
outside the ifdef/endif.

Please consider applying, as sched_clock() apparently does not behave as
expected. Patched against 2.6.0-test11.

Regards.

-- 
Ricardo Nabinger Sanchez
GNU/Linux #140696 [http://counter.li.org]
Slackware Linux

  Warning: 
    Trespassers will be shot.
    Survivors will be shot again.



diff -urN linux-2.6.0-test11/arch/i386/kernel/timers/timer_tsc.c
linux-2.6.0-test11-sched_clock/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.0-test11/arch/i386/kernel/timers/timer_tsc.c	2003-11-26 18:44:45.000000000 -0200
+++ linux-2.6.0-test11-sched_clock/arch/i386/kernel/timers/timer_tsc.c	2003-11-28 12:58:59.000000000 -0200
@@ -140,8 +140,8 @@
 	 */
 #ifndef CONFIG_NUMA
 	if (!use_tsc)
-#endif
 		return (unsigned long long)jiffies * (1000000000 / HZ);
+#endif
 
 	/* Read the Time Stamp Counter */
 	rdtscll(this_offset);
