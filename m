Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269056AbUHMKT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269056AbUHMKT0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269054AbUHMKTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:19:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44725 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269057AbUHMKTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:19:15 -0400
Date: Fri, 13 Aug 2004 12:19:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: lkml@lpbproduction.scom, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040813101928.GE8135@elte.hu>
References: <20040726082330.GA22764@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <200408122149.41490.lkml@lpbproductions.com> <1092390820.6815.11.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092390820.6815.11.camel@twins>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> > arch/i386/kernel/traps.c: In function `do_nmi':
> > arch/i386/kernel/traps.c:539: error: syntax error before "do"

> This fixes it.
> 
> --- ./include/asm-i386/hardirq.h~       2004-08-13 11:17:38.668333125 +0200
> +++ ./include/asm-i386/hardirq.h        2004-08-13 11:51:40.835968747 +0200
> @@ -73,7 +73,7 @@
>  #define hardirq_endlock()      do { } while (0)
>  
>  #define irq_enter()            add_preempt_count(HARDIRQ_OFFSET)
> -#define nmi_enter()            (irq_enter())
> +#define nmi_enter()            irq_enter()

yep - thx, this fix too will be in -O7. It seems this compilation error
only happens with older gcc and i'm using 3.3.

	Ingo
