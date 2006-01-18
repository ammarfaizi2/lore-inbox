Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWARKi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWARKi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWARKi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:38:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:19363 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932426AbWARKi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:38:28 -0500
Date: Wed, 18 Jan 2006 11:38:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>,
       Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
Message-ID: <20060118103839.GA7885@elte.hu>
References: <Pine.LNX.4.44L0.0601111816360.16743-201000@lifa03.phys.au.dk> <Pine.LNX.4.44L0.0601181120100.1993-201000@lifa02.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601181120100.1993-201000@lifa02.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Hi,
>  I have updated it:
> 
> 1) Now ALL_TASKS_PI is 0 again. Only RT tasks will be added to
> task->pi_waiters. Therefore we avoid taking the owner->pi_lock when the
> waiter isn't RT.
> 2) Merged into 2.6.15-rt6.
> 3) Updated the tester to test the hand over of BKL, which was mentioned
> as a potential issue by Bill Huey. Also added/adjusted the tests for the
> ALL_TASKS_PI==0 setup.
> (I really like unittesting: If someone points out an issue or finds a bug,
> make a test first demonstrating the problem. Then fixing the code is a lot
> easier - especially in this case where I run rt.c in userspace where I can
> easily use gdb.)

looks really nice to me. In particular i like the cleanup effect:

 5 files changed, 490 insertions(+), 744 deletions(-)

right now Thomas is merging hrtimer-latest to -rt, which temporarily 
blocks merging of intrusive patches - but i'll try to merge your patch 
after Thomas is done. (hopefully later today)

	Ingo
