Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268167AbUIGO5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268167AbUIGO5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268185AbUIGOym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:54:42 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:23979 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S268167AbUIGOu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:50:59 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R8
From: Alexander Nyberg <alexn@dsv.su.se>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
In-Reply-To: <20040907115722.GA10373@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu>
	 <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen>
	 <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu>
	 <20040907115722.GA10373@elte.hu>
Content-Type: text/plain
Message-Id: <1094568658.670.11.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 07 Sep 2004 16:50:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-07 at 13:57, Ingo Molnar wrote:
> test-booted the x64 kernel and found a number of bugs in the x64 port of
> the VP patch. I've uploaded -R8 that fixes them:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R8
> 
> NOTE: i tested a (non-modular) 64-bit bzImage on a 32-bit OS (FC2) but
> havent booted it on a 64-bit userland yet. But i'd expect 64-bit
> userspace to work just fine too.

Looks fine over here on 2-CPU, debian 64-bit user-space with both preempt &
voluntary preempt turned on. Init seems to explode 
(gets killed over and over, not sure how this happens) on CONFIG_LATENCY_TRACE, 
I'll take a look at that later today unless you have any offender you're aware of.

===== linux-2.5/arch/x86_64/kernel/x8664_ksyms.c 1.34 vs edited =====
--- 1.34/arch/x86_64/kernel/x8664_ksyms.c	2004-08-24 11:08:31 +02:00
+++ edited/linux-2.5/arch/x86_64/kernel/x8664_ksyms.c	2004-09-07 16:31:46 +02:00
@@ -221,3 +221,7 @@
 #endif
 
 EXPORT_SYMBOL(cpu_khz);
+
+#ifdef CONFIG_LATENCY_TRACE
+EXPORT_SYMBOL(mcount);
+#endif


