Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136184AbRD0T1L>; Fri, 27 Apr 2001 15:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136186AbRD0T1A>; Fri, 27 Apr 2001 15:27:00 -0400
Received: from nrg.org ([216.101.165.106]:28214 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S136184AbRD0T04>;
	Fri, 27 Apr 2001 15:26:56 -0400
Date: Fri, 27 Apr 2001 12:26:55 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Mike Galbraith <mikeg@wen-online.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: #define HZ 1024 -- negative effects?
In-Reply-To: <Pine.LNX.4.33.0104270848530.425-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.05.10104271221540.3283-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, Mike Galbraith wrote:
> > Rubbish.  Whenever a higher-priority thread than the current
> > thread becomes runnable the current thread will get preempted,
> > regardless of whether its timeslices is over or not.
> 
> What about SCHED_YIELD and allocating during vm stress times?
> 
> Say you have only two tasks.  One is the gui and is allocating,
> the other is a pure compute task.  The compute task doesn't do
> anything which will cause preemtion except use up it's slice.
> The gui may yield the cpu but the compute job never will.
> 
> (The gui won't _become_ runnable if that matters.  It's marked
> as running, has yielded it's remaining slice and went to sleep..
> with it's eyes open;)

A well-written GUI should not be using SCHED_YIELD.  If it is
"allocating", anything, it won't be using SCHED_YIELD or be marked
runnable, it will be blocked, waiting until the resource becomes
available.  When that happens, it will preempt the compute task (if its
priority is high enough, which is very likely - and can be assured if
it's running at a real-time priority as I suggested earlier).

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

