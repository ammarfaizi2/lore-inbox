Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318062AbSFSXra>; Wed, 19 Jun 2002 19:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318063AbSFSXr3>; Wed, 19 Jun 2002 19:47:29 -0400
Received: from ns.suse.de ([213.95.15.193]:29702 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318062AbSFSXr2>;
	Wed, 19 Jun 2002 19:47:28 -0400
Date: Thu, 20 Jun 2002 01:47:29 +0200
From: Dave Jones <davej@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>, wli@holomorphy.com
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
Message-ID: <20020620014729.X29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Ingo Molnar <mingo@elte.hu>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linus Torvalds <torvalds@transmeta.com>, wli@holomorphy.com
References: <20020619112308.GA11631@suse.de> <Pine.LNX.4.44.0206200123470.25434-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0206200123470.25434-100000@e2>; from mingo@elte.hu on Thu, Jun 20, 2002 at 01:35:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 01:35:35AM +0200, Ingo Molnar wrote:

Hi Ingo,

 > the scheduler optimisation in 2.5.23-dj1, from James Bottomley, look fine
 > to me. I did some modifications:

Thanks for taking time out to look them over..
The bulk of the UP optimisation was by Mikael Petterson, James just
fixed up something I goofed in an earlier patchset.


 >  - there is no need for the #if CONFIG_SMP, gcc is good at optimizing away
 >    a branch if it has a (0 != 0) condition on UP :-)

*nod*, I had intended to clean this up, but there's only so many hours
in a day.. 8-)

 > another change in 2.5.23-dj1 is the initialization of the pidhash in
 > sched_init(). It does not belong there - please create a new init function
 > within fork.c if needed. The pidhash init used to be in sched_init(), but
 > this doesnt make it right.

Agreed.

 > And i'm not quite sure whether it's needed to expose the pidhash to the
 > rest of the kernel - it would be much simpler to have it in kernel/fork.c
 > locally, and find_task_by_pid() would be a function instead of an inline.
 > (it has a ~49 bytes footprint on x86, it's rather heavy i think.)

I'll take a look at this tomorrow, unless William "no sleep `til 2.6" Irwin
beats me to it 8-)  (he did this part of the patch iirc).

 > my current scheduler patchset (against 2.5.23, tested) is attached.

Thanks again.
 
    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
