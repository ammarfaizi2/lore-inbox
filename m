Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWILGFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWILGFR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 02:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWILGFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 02:05:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6795 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751174AbWILGFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 02:05:14 -0400
Date: Tue, 12 Sep 2006 07:57:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386-pda: Initialize the PDA early, before any C code runs.
Message-ID: <20060912055735.GB24298@elte.hu>
References: <4505E8C1.7010906@goop.org> <20060911160301.10789d6e.akpm@osdl.org> <4505F212.4040307@goop.org> <4505F33E.3020009@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4505F33E.3020009@goop.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Jeremy Fitzhardinge wrote:
> >Not sure, but I think this replicates the behaviour of the original 
> >code (ie, INIT_THREAD_INFO initializes cpu to 0, so smp_processor_id 
> >will return 0).  Hm, Voyager will probably need a little patch to 
> >update the the PDA cpu_number properly in smp_setup_processor_id().
> 
> Something like this, perhaps:
> 
> Subject: set the boot CPU number in the boot_pda
> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

> +++ b/arch/i386/mach-voyager/voyager_smp.c	Mon Sep 11 16:34:09 2006 

> smp_setup_processor_id(void)
> {
> 	current_thread_info()->cpu = hard_smp_processor_id();
> -}
> +	write_pda(cpu_number, hard_smp_processor_id());
> +}

yeah. On all other x86 SMP platforms we use the logical APIC ID 0 for 
the boot CPU. (the physical ID might be different, but that doesnt 
matter)

NOTE: you'll also need to patch smp_voyager.c:find_smp_config(), where 
it sets current_thread_info()->cpu to boot_cpu_id.

	Ingo
