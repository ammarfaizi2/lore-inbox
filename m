Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422809AbWJLIKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422809AbWJLIKO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWJLIKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:10:14 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:10178 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932506AbWJLIKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:10:12 -0400
Date: Thu, 12 Oct 2006 10:02:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au
Subject: Re: [PATCH] lockdep: annotate i386 apm
Message-ID: <20061012080212.GA14307@elte.hu>
References: <1160574022.2006.82.camel@taijtu> <20061011141813.79fb278f.akpm@osdl.org> <1160633180.2006.94.camel@taijtu> <20061011233925.c9ba117a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011233925.c9ba117a.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > So, say interrupts were enabled when entering apm_bios_call*(); you now
> > save that in flags, disable interrupts, and enable them again.
> > Upon reaching local_irq_restore(), we'll hit the else branch with irq's
> > enabled and call trace_hardirqs_on(), which goes EEEK!
> 
> I'd assumed lockdep was less stupid than that ;) This?  Seems a bit 
> overdone..

the problem is not lockdep but that the BIOS enables IRQs behind the 
back of the kernel. Lockdep needs to be taught about that - if this 
happens unconditionally then i'd suggest to insert an unconditional 
trace_hardirqs_on() call to after the local_irq_save() that we do prior 
calling the BIOS. (that will be a NOP if lockdep is not enabled)

	Ingo
