Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269476AbUJLGE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269476AbUJLGE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269474AbUJLGE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:04:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30944 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269476AbUJLGCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:02:48 -0400
Date: Tue, 12 Oct 2004 08:04:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] i386 CPU hotplug updated for -mm
Message-ID: <20041012060410.GE1479@elte.hu>
References: <20041001204533.GA18684@elte.hu> <20041001204642.GA18750@elte.hu> <20041001143332.7e3a5aba.akpm@osdl.org> <Pine.LNX.4.61.0410091550300.2870@musoma.fsmlabs.com> <Pine.LNX.4.61.0410102302170.2745@musoma.fsmlabs.com> <1097560787.6557.99.camel@biclops>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097560787.6557.99.camel@biclops>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathan Lynch <nathanl@austin.ibm.com> wrote:

> I fixed up the warning in cpu_down with the following patch and now am
> running with that + 2.6.9-rc4-mm1 + your patch while doing continuous
> online/offline and make -j8.  It's been running for about 45 minutes
> and I haven't seen the panic yet, although I'm at a loss to explain
> why the change would fix it.  Will let it run overnight and report
> back...

>  	/* Move it here so it can run. */
> -	kthread_bind(p, smp_processor_id());
> +	kthread_bind(p, get_cpu());
> +	put_cpu();

>  	/* CPU is completely dead: tell everyone.  Too late to complain. */
>  	if (notifier_call_chain(&cpu_chain, CPU_DEAD, (void *)(long)cpu)

hm, is there any assurance that smp_processor_id() == cpu?

but i agree, this fix shouldnt impact the bio-destruct slab crash you
were seeing.

	Ingo
