Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWCNLyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWCNLyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 06:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWCNLyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 06:54:52 -0500
Received: from mail.gmx.de ([213.165.64.20]:57570 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751815AbWCNLyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 06:54:51 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-rc6 patch] remove sleep_avg multiplier
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200603142110.37017.kernel@kolivas.org>
References: <1142329861.9710.16.camel@homer> <20060314095654.GA8756@elte.hu>
	 <200603142105.38225.kernel@kolivas.org>
	 <200603142110.37017.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 12:56:03 +0100
Message-Id: <1142337363.9710.29.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 21:10 +1100, Con Kolivas wrote:
> On Tuesday 14 March 2006 21:05, Con Kolivas wrote:
> > On Tuesday 14 March 2006 20:56, Ingo Molnar wrote:
> > > * Mike Galbraith <efault@gmx.de> wrote:
> > > > Greetings,
> > > >
> > > > The patchlet below removes the sleep_avg multiplier.  This multiplier
> > > > was necessary back when we had 10 seconds of dynamic range in
> > > > sleep_avg, but now that we only have one second, it causes that one
> > > > second to be compressed down to 100ms in some cases.  This is
> > > > particularly noticeable when compiling a kernel in a slow NFS mount,
> > > > and I believe it to be a very likely candidate for other recently
> > > > reported network related interactivity problems.
> > > >
> > > > In testing, I can detect no negative impact of this removal.  IMHO,
> > > > this constitutes a bug-fix, and as such is suitable for 2.6.16.
> > >
> > > looks good to me. The biggest complaint against the current scheduler is
> > > over-eager interactivity boosting - this patch moderates that in a
> > > smooth way.
> >
> > I actually think Mike is right about the change, but has anyone else tested
> > this patch to also confirm "it has no negative impact" warranting it's
> > rapid inclusion in 2.6.16?
> 
> /me smacks himself for misusing "it's"
> 
> How about an interbench run before and after Mike?

Nothing against interbench, but how about something more concrete...
like a very modest parallel kernel compile in a slow NFS mount.  No need
to interpret results, it pokes you dead in the eye.

With my full change set, you _will_ see differences with interbench.
Interbench will say you're better off without my changes in fact.  Run
any of the known scheduler exploits without my changes, and then with,
and you'll likely consider revising interbench a little methinks ;-)

	-Mike

