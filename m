Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWF2SjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWF2SjV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWF2SjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:39:21 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:43160 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1751257AbWF2SjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:39:20 -0400
Date: Thu, 29 Jun 2006 19:53:43 +0100
From: John Rigg <lk@sound-man.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-rt4 x86_64 unknown symbol monotonic_clock
Message-ID: <20060629185343.GA2947@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I'm still getting this warning from `make modules_install':

WARNING: /lib/modules/2.6.17-rt4/kernel/drivers/char/hangcheck-timer.ko \
needs unknown symbol monotonic_clock

The patch below appears to fix it.

John


diff -uprN linux-2.6.17-rt4/arch/x86_64/kernel/time.c linux-2.6.17-rt4-patched/arch/x86_64/kernel/time.c
--- linux-2.6.17-rt4/arch/x86_64/kernel/time.c	2006-06-29 19:38:29.000000000 +0100
+++ linux-2.6.17-rt4-patched/arch/x86_64/kernel/time.c	2006-06-29 19:37:06.000000000 +0100
@@ -247,6 +247,15 @@ unsigned long long sched_clock(void)
 	return cycles_2_ns(a);
 }
 
+/*
+ * Monotonic_clock - returns # of nanoseconds passed since time_init()
+ */
+unsigned long long monotonic_clock(void)
+{
+	return sched_clock();
+}
+EXPORT_SYMBOL(monotonic_clock);
+
 static int tsc_unstable;
 
 static inline int check_tsc_unstable(void)
