Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756668AbWKSNoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668AbWKSNoX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 08:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756669AbWKSNoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 08:44:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:5340 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1756668AbWKSNoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 08:44:23 -0500
Date: Sun, 19 Nov 2006 14:43:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt4, changed yum repository
Message-ID: <20061119134301.GA2792@elte.hu>
References: <20061118163032.GA14625@elte.hu> <200611191539.42023.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611191539.42023.fzu@wemgehoertderstaat.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0009]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:

> work_resched:
> 	DISABLE_INTERRUPTS
> 	call __schedule
> 					# make sure we don't miss an interrupt
> 					# setting need_resched or sigpending
> 					# between sampling and the iret
> 	movl TI_flags(%ebp), %ecx
> 	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done other
> 					# than syscall tracing?
> 	jz restore_all
> 	testl $(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED), %ecx
> 	jnz work_resched
> 
> The hwclock page_fault happens at the
>  	movl TI_flags(%ebp), %ecx
> line.

hm, weird - maybe something corrupts %ebp here? Could you try to add 
this to before the faulting instruction:

	GET_THREAD_INFO(%ebp)

this will make sure %ebp has the right contents.

	Ingo
