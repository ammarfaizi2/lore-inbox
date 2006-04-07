Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWDGN4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWDGN4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 09:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWDGN4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 09:56:43 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:53707 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932229AbWDGN4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 09:56:42 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Fri, 7 Apr 2006 23:56:02 +1000
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <1144402690.7857.31.camel@homer> <200604072256.27665.kernel@kolivas.org> <1144417064.8114.26.camel@homer>
In-Reply-To: <1144417064.8114.26.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072356.03580.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 23:37, Mike Galbraith wrote:
> On Fri, 2006-04-07 at 22:56 +1000, Con Kolivas wrote:
> > This mechanism is designed to convert on-runqueue waiting time into
> > sleep. The basic reason is that when the system is loaded, every task is
> > fighting for cpu even if they only want say 1% cpu which means they never
> > sleep and are waiting on a runqueue instead of sleeping 99% of the time.
> > What you're doing is exactly biasing against what this mechanism is in
> > place for. You'll get the same effect by bypassing or removing it
> > entirely. Should we do that instead?
>
> Heck no.  That mechanism is just as much about fairness as it is about
> intertactivity, and as such is just fine and dandy in my book... once
> it's toned down a bit^H^H^Htruckload.  What I'm doing isn't biasing
> against the intent, I'm merely straightening the huge bend in favor of
> interactive tasks who get this added boost over and over again, and
> restricting the general effect to something practical.

Have you actually tried without that mechanism? No compromise will be correct 
there for fairness one way or the other. There simply is no way to tell if a 
task is really sleeping or really just waiting on a runqueue. That's why Ingo 
weighted the tasks waking from interrupts more because of their likely 
intent. It's still a best guess scenario (which I'm sure you know). Wouldn't 
it be lovely to have a system that didn't guess and had simple sleep/wake cpu 
usage based heuristics? Oh well.

> Just look at what that mechanism does now with a 10 deep queue.  Every
> dinky sleep can have an absolutely huge gob added to it, the exact worst
> case number depends on how many cpus you have and whatnot.  Start a slew
> of tasks, and you are doomed to have every task that sleeps for the
> tiniest bit pegged at max interactive.

I'm quite aware of the effect it has :)

> Maybe what I did isn't the best that can be done, but something has to
> be done about that.  It is very b0rken under heavy load.

Your compromise is as good as any.

-- 
-ck
