Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVCONzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVCONzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVCONzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:55:51 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:16319 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261245AbVCONzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:55:35 -0500
Date: Tue, 15 Mar 2005 08:55:23 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <20050315133540.GB4686@elte.hu>
Message-ID: <Pine.LNX.4.58.0503150843410.6456@localhost.localdomain>
References: <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
 <1110574019.19093.23.camel@mindpipe> <1110578809.19661.2.camel@mindpipe>
 <Pine.LNX.4.58.0503140214360.697@localhost.localdomain>
 <Pine.LNX.4.58.0503140427560.697@localhost.localdomain>
 <Pine.LNX.4.58.0503140509170.697@localhost.localdomain>
 <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu>
 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Mar 2005, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> > What should we use instead of #ifdef PREEMPT_RT? Or should we just
> > keep it the same for both.  Since this fix is only to fix spinlocks
> > that schedule, I figured that it would be better not to waste the
> > memory of those not using PREEMPT_RT.  Should I use the opposite
> > PREEMPT_DESKTOP?
>
> i'd go for removing bit-spinlocks altogether, in the upstream kernel. It
> would simplify things, besides making PREEMPT_RT simpler as well. The
> memory overhead is not a big issue i believe. (8 more bytes per ext3 bh,
> on x86)
>

The problem here is that it's not ext3 bh's only. They're still the normal
buffer head.  The problem arrises because the ext3 "journal head" is
allocated within these bit spin locks. I tried to monkey with putting the
locks in the journal heads and have checks to see when to free them, but
it wasn't that simple. I started having problems with some of the freeing
transactions, I might have assumed too much.

I'll give it one more try to get it into the journal heads, but after
that, (if I fail) I'll let someone who understands the ext3 system better
handle this.

-- Steve

