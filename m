Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275250AbTHGJ1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275251AbTHGJ1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:27:30 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:64014 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S275250AbTHGJ11
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:27:27 -0400
Message-ID: <3F321D2B.4090702@aitel.hist.no>
Date: Thu, 07 Aug 2003 11:34:35 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: rob@landley.net
CC: Daniel Phillips <phillips@arcor.de>, Ed Sweetman <ed.sweetman@wmich.edu>,
       Eugene Teo <eugene.teo@eugeneteo.net>,
       LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <3F2264DF.7060306@wmich.edu> <200307271046.30318.phillips@arcor.de> <200308061728.04447.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
[...]
> 
> Thinking out loud for a bit, please tell me if I'm wrong about SCHED_SOFTRR...
> 
> Whatever the policy is, there's only so many ticks to go around and there is 
> an overload for which it will fail.  No resource allocation scheme can 
> prevent starvation if there simply isn't enough of the resource to go around.
> 
> So, how does SCHED_SOFTRR fail?  Theoretically there is a minimum timeslice 
> you can hand out, yes?  And an upper bound on scheduling latency.  So 
> logically, there is some maximum number "N" of SCHED_SOFTRR tasks running at 
> once where you wind up round-robining with minimal timeslices and the system 
> is saturated.  At N+1, you fall over.  (And in reality, there are interrupts 
> and kernel threads and other things going on that get kind of cramped 
> somewhere below N.)


I don't know how this particular scheduler fail, but the problem
exists for any real-time system.  Nobody can run "N+1" guaranteed 
low-latency
tasks where N is the max, that is obvious.

A generic os scheduler can run almost any amount of tasks, with latencies
proportional to the amount of tasks.

A good RT scheduler won't even _try_ to run "N+1" RT tasks.  The
last task will either fail to start, or fail the attempt to
increase its priority into RT.  You may then kill (or un-prioritize)
some other RT task and try again.

Helge Hafting

