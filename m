Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270212AbTHGPpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269736AbTHGPn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:43:57 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:16018 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S270326AbTHGPkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:40:12 -0400
From: Daniel Phillips <phillips@arcor.de>
To: rob@landley.net, Ed Sweetman <ed.sweetman@wmich.edu>,
       Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Thu, 7 Aug 2003 16:42:55 +0100
User-Agent: KMail/1.5.3
Cc: LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org,
       Davide Libenzi <davidel@xmailserver.org>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271046.30318.phillips@arcor.de> <200308061728.04447.rob@landley.net>
In-Reply-To: <200308061728.04447.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308071642.55517.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 August 2003 22:28, Rob Landley wrote:
> So, how does SCHED_SOFTRR fail?  Theoretically there is a minimum timeslice
> you can hand out, yes?  And an upper bound on scheduling latency.  So
> logically, there is some maximum number "N" of SCHED_SOFTRR tasks running
> at once where you wind up round-robining with minimal timeslices and the
> system is saturated.  At N+1, you fall over.  (And in reality, there are
> interrupts and kernel threads and other things going on that get kind of
> cramped somewhere below N.)

The upper bound for softrr realtime scheduling isn't based on number of tasks, 
it's a global slice of cpu time: so long as the sum of running times of all 
softrr tasks in the system lies below limit, softrr tasks will be scheduled 
as SCHED_RR, otherwise they will be SCHED_NORMAL.

> In theory, the real benefit of SCHED_SOFTRR is that an attempt to switch to
> it can fail with -EMYBRAINISMELTING up front, so you know when it won't
> work at the start, rather than having it glitch halfway through the run. 

Not as implemented.  Anyway, from the user's point of view, that would be an 
unpleasant way for a sound player to fail.  What we want is something more 
like a little red light that comes on (in the form of error statistics, say) 
any time a softrr process gets demoted.  Granted, there may be situations 
where what you want is the right behavior, but it's (as you say) a separate 
issue of resource allocation.

Regards,

Daniel

