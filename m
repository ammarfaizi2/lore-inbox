Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263262AbVCKKZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbVCKKZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263261AbVCKKZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:25:03 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:25766 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263260AbVCKKYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:24:41 -0500
Date: Fri, 11 Mar 2005 05:24:32 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <20050311101740.GA23120@elte.hu>
Message-ID: <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net>
 <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain>
 <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> <20050311095747.GA21820@elte.hu>
 <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain> <20050311101740.GA23120@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Mar 2005, Ingo Molnar wrote:
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:

> > I've tried making two global spinlocks, one for the state bit and one
> > for the journal head bit use.  But this deadlocks with j_state_lock.
> > The journal head lock seems to be ok to be global, but the state lock
> > needs to have one for every buffer head.  I'm now hacking away to do
> > this without touching the actual buffer head. But I'm not sure what
> > some of the side effects this is having.  I'll keep you posted when I
> > get something working.  I'm now having a crash course in how kjournal
> > and friends work.
>
> did you try the canonical way of putting a spinlock into every
> buffer_head?
>

No, I'll try that now. I just didn't want to modify the buffer head struct
just for journaling.  But if it is the quickest and easiest fix, then I'll
submit it and we can change it later.

-- Steve
