Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280114AbRKNE47>; Tue, 13 Nov 2001 23:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280118AbRKNE4t>; Tue, 13 Nov 2001 23:56:49 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:47314 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280114AbRKNE4g>; Tue, 13 Nov 2001 23:56:36 -0500
Date: Tue, 13 Nov 2001 20:56:13 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
Message-ID: <20011113205613.A1070@w-mikek2.sequent.com>
In-Reply-To: <Pine.LNX.4.33.0111081341400.8863-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111081341400.8863-200000@localhost.localdomain>; from mingo@elte.hu on Thu, Nov 08, 2001 at 03:30:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 03:30:11PM +0100, Ingo Molnar wrote:
> 
> i've attached a patch that fixes a long-time performance problem in the
> Linux scheduler.

Just got back from holiday and saw this patch.  I like the idea
slowing down task dynamic priority modifications (the counter
field).  My only thought/concern would be in the case where a
task with maximum dynamic priority (counter value) decides to
use 'all' of its timeslice.  In such a case, the task can not
be preempted by another task (with the same static priority)
until its entire timeslice is expired.  In the current scheduler,
I believe the task can be preempted after 1 timer tick.  In
practice, this shouldn't be an issue.  However, it is something
we may want to think about.  One simple solution would be to
update a tasks dynamic priority (counter value) more frequently
it it is above its NICE_TO_TICKS value.

> (it would be nice if those people who suspect scalability problems in
> their workloads, could further test/verify the effects this patch.)

I'll try to run it on my 'CPU intensive' version of the TPC-H
behcnmark.

In addition, I have noted that this patch applies with minor
modification to our MultiQueue scheduler, and should be a win
in this environment also.

-- 
Mike
