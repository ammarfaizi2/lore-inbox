Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269046AbUHMJxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269046AbUHMJxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 05:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269049AbUHMJxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 05:53:48 -0400
Received: from nl-ams-slo-l4-01-pip-8.chellonetwork.com ([213.46.243.27]:50741
	"EHLO amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S269046AbUHMJxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 05:53:45 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: lkml@lpbproduction.scom
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <200408122149.41490.lkml@lpbproductions.com>
References: <20040726082330.GA22764@elte.hu>
	 <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	 <200408122149.41490.lkml@lpbproductions.com>
Content-Type: text/plain
Date: Fri, 13 Aug 2004 11:53:40 +0200
Message-Id: <1092390820.6815.11.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 21:49 -0700, Matt Heler wrote:
> Ingo,
> 
> I get the following error when I have CONFIG_PREEMPT_TIMING=n
> 
>   AS      arch/i386/kernel/entry.o
>   CC      arch/i386/kernel/traps.o
> arch/i386/kernel/traps.c: In function `do_nmi':
> arch/i386/kernel/traps.c:539: error: syntax error before "do"
> arch/i386/kernel/traps.c:539: error: syntax error before ')' token
> arch/i386/kernel/traps.c:537: warning: unused variable `cpu'
> arch/i386/kernel/traps.c: At top level:
> arch/i386/kernel/traps.c:541: warning: type defaults to `int' in declaration 
> of `cpu'
> arch/i386/kernel/traps.c:541: warning: data definition has no type or storage 
> class
> arch/i386/kernel/traps.c:542: error: syntax error before '++' token
> arch/i386/kernel/traps.c:500: warning: `default_do_nmi' defined but not used
> make[1]: *** [arch/i386/kernel/traps.o] Error 1
> make: *** [arch/i386/kernel] Error 2
> 
> 
> Matt 
> 

This fixes it.

--- ./include/asm-i386/hardirq.h~       2004-08-13 11:17:38.668333125 +0200
+++ ./include/asm-i386/hardirq.h        2004-08-13 11:51:40.835968747 +0200
@@ -73,7 +73,7 @@
 #define hardirq_endlock()      do { } while (0)
 
 #define irq_enter()            add_preempt_count(HARDIRQ_OFFSET)
-#define nmi_enter()            (irq_enter())
+#define nmi_enter()            irq_enter()
 #define nmi_exit()             sub_preempt_count(HARDIRQ_OFFSET)
 
 #ifdef CONFIG_PREEMPT



-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

