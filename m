Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268168AbUJNXta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268168AbUJNXta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 19:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268100AbUJNXsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 19:48:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54229 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267916AbUJNXqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 19:46:12 -0400
Date: Fri, 15 Oct 2004 01:46:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel@vger.kernel.org, Thomas Zanussi <trz@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014234603.GA22964@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <416F0071.3040304@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416F0071.3040304@opersys.com>
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


* Karim Yaghmour <karim@opersys.com> wrote:

> 
> Ingo Molnar wrote:
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U0
> 
> I notice:
> +	local_irq_save(flags);
> +	____trace(&__get_cpu_var(trace), eip, parent_eip);
> +	local_irq_restore(flags);
> 
> Why not use the lockless logging available in relayfs, you'll avoid
> the interrupt disabling altogether since, umm ... it's lockless.

i just added something ad-hoc. I wanted it to be accurate across
interrupt entries. I have not looked at the relayfs locking but how does
it solve that? Also, cli/sti makes it obviously SMP-safe and is pretty
cheap on all x86 CPUs. (Also, i didnt want to use preempt_disable/enable
because the tracer interacts with that code quite heavily.)

	Ingo
