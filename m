Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVFCFRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVFCFRE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 01:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFCFRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 01:17:04 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18611 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261258AbVFCFQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 01:16:57 -0400
Date: Fri, 3 Jun 2005 07:16:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [rfc] [patch] consolidate/clean up spinlock.h files
Message-ID: <20050603051629.GB14059@elte.hu>
References: <20050602144004.GA31807@elte.hu> <Pine.LNX.4.61.0506021817390.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506021817390.3743@scrub.home>
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


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi,
> 
> On Thu, 2 Jun 2005, Ingo Molnar wrote:
> 
> >  - consolidates and enhances the spinlock/rwlock debugging code
> > 
> >  - simplifies the asm/spinlock.h files
> > 
> >  - encapsulates the raw spinlock types and moves generic spinlock
> >    features (such as ->break_lock) into the generic code.
> > 
> >  - cleans up the spinlock code hierarchy to get rid of spaghetti.
> 
> That nicely splits the headers into several separate files, but the 
> problem is that all these new header files are only of limited value 
> outside the spinlock code.
> What I'd really to see is a split of definitions and implementation. That 
> means the definitions would be available via <linux/spinlock_types.h> and 
> could be used in other core headers and would pull in a lot less header 
> files. Header dependencies got worse especially since preempt got 
> included.
> The patch below does the minimum to provide spinlock_types.h. We could 
> also include initializers.

yes, that's what i'm working towards - separating type from 
implementation on the arch level was the first step needed. I already 
had it at such a state yesterday (complete separation of type 
definitions, API definitions and asm implementation - it needed the 
initializers in the asm/spinlock_types.h file, but otherwise it was 
straightforward), but undid it in the last minute because sched.c and 
kernel_lock.c used some intermediate/raw primitives, leading to ugly 
dependencies. I'll re-try this angle today and repost the patch.

	Ingo
