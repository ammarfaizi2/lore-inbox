Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVDESRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVDESRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVDESP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:15:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18912 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261846AbVDESKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:10:04 -0400
Date: Tue, 5 Apr 2005 20:09:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, stsp@aknet.ru
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-ID: <20050405180951.GB6351@elte.hu>
References: <20050405065544.GA21360@elte.hu> <20050405000319.4fa1d962.akpm@osdl.org> <20050405071604.GA23355@elte.hu> <20050405072929.GA24560@elte.hu> <20050405074014.GA25122@elte.hu> <16978.24488.116056.678482@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16978.24488.116056.678482@alkaid.it.uu.se>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mikael Pettersson <mikpe@csd.uu.se> wrote:

>  > -	jz restore_all
>  > +	jz restore_nocheck
>  >  	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
>  > -	jz restore_all
>  > +	jz restore_nocheck
>  >  	call preempt_schedule_irq
>  >  	jmp need_resched
>  >  #endif
> 
> Is this sufficient or do we also need the 
> s/restore_all/restore_nocheck/ at around line 553 which was in the 
> first posted patch?

all 3 restore_all->restore_nocheck changes are needed to make the bug 
not trigger. I dont think it's a real fix because whatever is being 
preempted involuntarily, it ought to have a proper kernel stack to begin 
with. I'll do some more debugging.

	Ingo
