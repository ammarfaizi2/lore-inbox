Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290634AbSAYKtG>; Fri, 25 Jan 2002 05:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290635AbSAYKs5>; Fri, 25 Jan 2002 05:48:57 -0500
Received: from mx2.elte.hu ([157.181.151.9]:3730 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290634AbSAYKsk>;
	Fri, 25 Jan 2002 05:48:40 -0500
Date: Fri, 25 Jan 2002 13:46:11 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <jfv@Bluesong.NET>
Cc: jfv <jfv@us.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        jstultz <jstultz@us.ibm.com>
Subject: Re: [PATCH]: O(1) 2.4.17-J6 tuneable parameters
In-Reply-To: <200201250518.g0P5IrR13332@Bluesong.NET>
Message-ID: <Pine.LNX.4.33.0201251336130.3371-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jack,

On Thu, 24 Jan 2002, Jack F. Vogel wrote:

> Hi Ingo,
>
> 	Have been watching and testing your changes as they have
> evolved. Our group has a customer request for a scheduler that will
> give them some tuneable parameters, and your changes have actually had
> some parameters change thru the deltas you've made. It seemed like it
> might be useful to take them and make them tweakable on a running
> system. I am not 100% convinced of the goodness of this, but I wanted
> to submit it for your consideration.  The current code performs great
> btw, thanks for all your hard work.

i think we could use your patch for development purposes as well, lets
merge the two efforts?

i'd suggest to name the /proc/sys/sched/ values the same way the constants
are called. Eg. /proc/sys/sched/CHILD_FORK_PENALTY. This makes it easier
to communicate suggested parameter changes.

i have a script that dumps the current sched-parameters state:

 [root@mars root]# ./getsched
 echo 95 > /proc/sys/kernel/CHILD_FORK_PENALTY
 echo 3 > /proc/sys/kernel/EXIT_WEIGHT
 echo 3 > /proc/sys/kernel/INTERACTIVE_DELTA
 echo 200 > /proc/sys/kernel/MAX_SLEEP_AVG
 echo 30 > /proc/sys/kernel/MAX_TIMESLICE
 echo 100 > /proc/sys/kernel/PARENT_FORK_PENALTY
 echo 70 > /proc/sys/kernel/PRIO_BONUS_RATIO
 echo 60 > /proc/sys/kernel/PRIO_CPU_HOG_RATIO
 echo 20 > /proc/sys/kernel/PRIO_INTERACTIVE_RATIO
 echo 200 > /proc/sys/kernel/STARVATION_LIMIT

the script is very simple:

 cd /proc/sys/kernel

 for N in *[A-Z]*; do echo "echo "`cat $N`" > /proc/sys/kernel/$N"; done

otherwise our approach is identical. This patch would always stay
separate, but could be readily applied by people who want more control
over the scheduler for development or whatever other reasons.

	Ingo

