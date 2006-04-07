Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWDGOOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWDGOOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWDGOOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:14:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:48788 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932322AbWDGOOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:14:22 -0400
X-Authenticated: #14349625
Subject: Re: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <200604072356.03580.kernel@kolivas.org>
References: <1144402690.7857.31.camel@homer>
	 <200604072256.27665.kernel@kolivas.org> <1144417064.8114.26.camel@homer>
	 <200604072356.03580.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 16:14:54 +0200
Message-Id: <1144419294.14231.7.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 23:56 +1000, Con Kolivas wrote:
> On Friday 07 April 2006 23:37, Mike Galbraith wrote:
> > On Fri, 2006-04-07 at 22:56 +1000, Con Kolivas wrote:
> > > This mechanism is designed to convert on-runqueue waiting time into
> > > sleep. The basic reason is that when the system is loaded, every task is
> > > fighting for cpu even if they only want say 1% cpu which means they never
> > > sleep and are waiting on a runqueue instead of sleeping 99% of the time.
> > > What you're doing is exactly biasing against what this mechanism is in
> > > place for. You'll get the same effect by bypassing or removing it
> > > entirely. Should we do that instead?
> >
> > Heck no.  That mechanism is just as much about fairness as it is about
> > intertactivity, and as such is just fine and dandy in my book... once
> > it's toned down a bit^H^H^Htruckload.  What I'm doing isn't biasing
> > against the intent, I'm merely straightening the huge bend in favor of
> > interactive tasks who get this added boost over and over again, and
> > restricting the general effect to something practical.
> 
> Have you actually tried without that mechanism?

Yes.  We're better off with it than without.

> > Just look at what that mechanism does now with a 10 deep queue.  Every
> > dinky sleep can have an absolutely huge gob added to it, the exact worst
> > case number depends on how many cpus you have and whatnot.  Start a slew
> > of tasks, and you are doomed to have every task that sleeps for the
> > tiniest bit pegged at max interactive.
> 
> I'm quite aware of the effect it has :)

Ok.  Do we then agree that it makes 2.6 unusable for small servers, and
that this constitutes a serious problem? :)

> > Maybe what I did isn't the best that can be done, but something has to
> > be done about that.  It is very b0rken under heavy load.
> 
> Your compromise is as good as any.

Ok.

	-Mike

