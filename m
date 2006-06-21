Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWFUNZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWFUNZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWFUNZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:25:27 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:27778 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S932121AbWFUNZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:25:26 -0400
Date: Wed, 21 Jun 2006 14:42:36 +0100
From: John Rigg <lk@sound-man.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rt1 unknown symbol monotonic_clock
Message-ID: <20060621134236.GA3409@localhost.localdomain>
References: <20060621100623.GA2960@localhost.localdomain> <20060621110613.GA22322@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621110613.GA22322@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 01:06:13PM +0200, Ingo Molnar wrote:
> 
> * John Rigg <lk@sound-man.co.uk> wrote:
> 
> > Just compiled 2.6.17-rt1 on x86_64 UP system and got the following
> > message when doing `make modules_install':
> > WARNING: /lib/modules/2.6.17-rt1/kernel/drivers/char/hangcheck-timer.ko \
> > needs unknown symbol monotonic_clock
> 
> please try -rt2 - does it work any better?

I'd try it if I could find it :)

In the meantime I tried the patch below (don't know if it's correct but it works
so far).

John

____________________________________________________________________

diff -uprN linux-2.6.17.orig/arch/x86_64/kernel/time.c linux-2.6.17/arch/x86_64/kernel/time.c
--- linux-2.6.17.orig/arch/x86_64/kernel/time.c	2006-06-21 14:29:09.000000000 +0100
+++ linux-2.6.17/arch/x86_64/kernel/time.c	2006-06-21 14:30:56.000000000 +0100
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
