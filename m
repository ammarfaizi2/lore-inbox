Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWDAR7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWDAR7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 12:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWDAR7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 12:59:53 -0500
Received: from mail.gmx.de ([213.165.64.20]:21419 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751582AbWDAR7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 12:59:52 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-mm2 5/9] sched throttle tree extract - correct
	idle sleep logic
From: Mike Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143910416.2885.17.camel@mindpipe>
References: <1143880124.7617.5.camel@homer> <1143880397.7617.10.camel@homer>
	 <1143880683.7617.16.camel@homer>  <1143881058.7617.24.camel@homer>
	 <1143881494.7617.32.camel@homer>  <1143881983.7617.41.camel@homer>
	 <1143910416.2885.17.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 20:00:27 +0200
Message-Id: <1143914427.7518.24.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-01 at 11:53 -0500, Lee Revell wrote:
> On Sat, 2006-04-01 at 10:59 +0200, Mike Galbraith wrote:
> > This patch corrects the idle sleep logic to place a long sleeping task
> > into the runqueue at a barely interactive priority such that it can
> > not destroy interactivity should it immediately begin consuming
> > massive cpu. 
> 
> Did you test this extensively with bloated apps like Evolution and
> Firefox that need to be scheduled as interactive tasks even though they
> often peg the CPU?

I use both Evolution and Firefox with no problems.  Well, no problems
isn't quite true, Evolution slogs along terribly when IO is going on,
but that isn't a scheduler issue.  My desktop experience has zero
problems with these patches, but YMMV.

These patches are much more about anti-starvation than interactive task
selection.  Tasks which were scheduled as interactive before should
remain so, but that's not to say that they won't ever be throttled.
There is no way to differentiate between nice cpu hog and evil cpu hog,
and these patches do no even attempt to do so.  These patches simply
enforce a set of rules.  There is no doubt in my mind that these rules
will not be favorable to every interactive task situation.

I can give you one right off the top of my head.  A visualization for
your mp3 player is a pure cpu hog right from the start, and will be
throttled.  If you test this, you'll see that despite that, it does a
pretty darn good job with the problem.

	-Mike

