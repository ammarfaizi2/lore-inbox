Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVCKKSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVCKKSy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbVCKKSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:18:54 -0500
Received: from mx1.elte.hu ([157.181.1.137]:19681 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262659AbVCKKRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:17:54 -0500
Date: Fri, 11 Mar 2005 11:17:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050311101740.GA23120@elte.hu>
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net> <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain> <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> <20050311095747.GA21820@elte.hu> <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > > Doing a quick search on the kernel, it looks like only kjournald uses
> > > the bit_spin_locks. I'll start converting them to spinlocks. The use
> > > seems to be more of a hack, since it is using bits in the state field
> > > for locking, and these bits aren't used for anything else.
> >
> > yeah. bit-spinlocks are really a hack.
> 
> And this really sucks too!  I've been looking into a fix for this and
> have yet to get something stable.  As you probably already know, you
> can't just put back the preempt_disable since your spinlocks now
> schedule. So I've been looking into finding a way to get rid of these.
> 
> I've tried making two global spinlocks, one for the state bit and one
> for the journal head bit use.  But this deadlocks with j_state_lock.
> The journal head lock seems to be ok to be global, but the state lock
> needs to have one for every buffer head.  I'm now hacking away to do
> this without touching the actual buffer head. But I'm not sure what
> some of the side effects this is having.  I'll keep you posted when I
> get something working.  I'm now having a crash course in how kjournal
> and friends work.

did you try the canonical way of putting a spinlock into every
buffer_head?

	Ingo
