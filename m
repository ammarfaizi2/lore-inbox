Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751891AbWCNMHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbWCNMHc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWCNMHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:07:32 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:47516 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751891AbWCNMHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:07:32 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.16-rc6 patch] remove sleep_avg multiplier
Date: Tue, 14 Mar 2006 23:07:01 +1100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1142329861.9710.16.camel@homer> <200603142110.37017.kernel@kolivas.org> <1142337363.9710.29.camel@homer>
In-Reply-To: <1142337363.9710.29.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603142307.01682.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 22:56, Mike Galbraith wrote:
> On Tue, 2006-03-14 at 21:10 +1100, Con Kolivas wrote:
> > On Tuesday 14 March 2006 21:05, Con Kolivas wrote:
> > > On Tuesday 14 March 2006 20:56, Ingo Molnar wrote:
> > > > * Mike Galbraith <efault@gmx.de> wrote:
> > > > > Greetings,
> > > > >
> > > > > The patchlet below removes the sleep_avg multiplier.  This
> > > > > multiplier was necessary back when we had 10 seconds of dynamic
> > > > > range in sleep_avg, but now that we only have one second, it causes
> > > > > that one second to be compressed down to 100ms in some cases.  This
> > > > > is particularly noticeable when compiling a kernel in a slow NFS
> > > > > mount, and I believe it to be a very likely candidate for other
> > > > > recently reported network related interactivity problems.
> > > > >
> > > > > In testing, I can detect no negative impact of this removal.  IMHO,
> > > > > this constitutes a bug-fix, and as such is suitable for 2.6.16.
> > > >
> > > > looks good to me. The biggest complaint against the current scheduler
> > > > is over-eager interactivity boosting - this patch moderates that in a
> > > > smooth way.
> > >
> > > I actually think Mike is right about the change, but has anyone else
> > > tested this patch to also confirm "it has no negative impact"
> > > warranting it's rapid inclusion in 2.6.16?
> >
> > /me smacks himself for misusing "it's"
> >
> > How about an interbench run before and after Mike?
>
> Nothing against interbench, but how about something more concrete...
> like a very modest parallel kernel compile in a slow NFS mount.  No need
> to interpret results, it pokes you dead in the eye.

I have no nfs to test it, nor do I have a network where I could set it up. I 
was simply suggesting if there is negligible difference on interbench on 
common workloads it strengthens your statement of "no negative impact" with 
some harder evidence. If others are willing to run with your change without 
any further testing then so be it; I think they're likely to be a net 
positive outcome. It's just unusual to be guided without anyone else testing 
it.

> With my full change set, you _will_ see differences with interbench.
> Interbench will say you're better off without my changes in fact.  Run
> any of the known scheduler exploits without my changes, and then with,
> and you'll likely consider revising interbench a little methinks ;-)

Not really; interbench is after interactivity, and exploit prone designs don't 
necessarily have bad interactivity. If you can reproduce the nfs case as an 
extra load for interbench I'd love to include it.

Cheers,
Con
