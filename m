Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVDEJ53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVDEJ53 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVDEJyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:54:53 -0400
Received: from aun.it.uu.se ([130.238.12.36]:36341 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261645AbVDEJvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:51:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16978.24488.116056.678482@alkaid.it.uu.se>
Date: Tue, 5 Apr 2005 11:51:36 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, stsp@aknet.ru
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
In-Reply-To: <20050405074014.GA25122@elte.hu>
References: <20050405065544.GA21360@elte.hu>
	<20050405000319.4fa1d962.akpm@osdl.org>
	<20050405071604.GA23355@elte.hu>
	<20050405072929.GA24560@elte.hu>
	<20050405074014.GA25122@elte.hu>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > 
 > * Ingo Molnar <mingo@elte.hu> wrote:
 > 
 > > > this fixed my crashes too.
 > > 
 > > spoke too soon - they still trigger even with the patch applied.
 > 
 > the patch below fixes the crash, it was related to CONFIG_PREEMPT.
 > 
 > 	Ingo
 > 
 > --
 > fix entry.S crash with PREEMPT+PAGEALLOC
 > 
 > Signed-off-by: Ingo Molnar <mingo@elte.hu>
 > 
 > --- linux/arch/i386/kernel/entry.S.orig
 > +++ linux/arch/i386/kernel/entry.S
 > @@ -165,9 +165,9 @@ ENTRY(resume_kernel)
 >  need_resched:
 >  	movl TI_flags(%ebp), %ecx	# need_resched set ?
 >  	testb $_TIF_NEED_RESCHED, %cl
 > -	jz restore_all
 > +	jz restore_nocheck
 >  	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
 > -	jz restore_all
 > +	jz restore_nocheck
 >  	call preempt_schedule_irq
 >  	jmp need_resched
 >  #endif

Is this sufficient or do we also need the s/restore_all/restore_nocheck/
at around line 553 which was in the first posted patch?

/Mikael
