Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVE0F7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVE0F7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 01:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVE0F7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 01:59:24 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:28735 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261882AbVE0F7R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 01:59:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WbnsOoswpIy5QYHQxb/TQKUrBbRIntCOo5pRxM2WwSuVQhdKnWgUjuW8hDp/QEh16JvSQz7NgtDhQJkM5bVrbRUVCpNHqDKdyI5CEjSFXl9VUTzYyDev4JZcgUACAzvI+H4B1hCPij+RLXU4Vt8RtYlmnNKfn8lIKrM+oJUdyj0=
Message-ID: <8e6f947205052622595eab8a67@mail.gmail.com>
Date: Fri, 27 May 2005 01:59:17 -0400
From: Will Dyson <will.dyson@gmail.com>
Reply-To: Will Dyson <will.dyson@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc5-V0.7.47-09
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050526073559.GA3634@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050526073559.GA3634@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/05, Ingo Molnar <mingo@elte.hu> wrote:
> 
> i have released the -V0.7.47-09 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> Changes:
> 
>  - merge to -rc5
> 
>  - small fixes

Building on x86_64 gets me this:

arch/x86_64/kernel/nmi.c: In function `nmi_watchdog_tick':
arch/x86_64/kernel/nmi.c:497: error: `cpu' undeclared (first use in
this function)

I'm guessing the following is what you had intended:

Index: arch/x86_64/kernel/nmi.c
===================================================================
--- cb5507f7a63eaba785afcead3bc5cf7454a8f98d/arch/x86_64/kernel/nmi.c 
(mode:100644)
+++ uncommitted/arch/x86_64/kernel/nmi.c  (mode:100644)
@@ -492,6 +492,7 @@
 {
        int sum;
        int touched = 0;
+       int cpu = safe_smp_processor_id();

        sum = read_pda(apic_timer_irqs);
        if (nmi_show_regs[cpu]) {


-- 
Will Dyson
