Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSFMWME>; Thu, 13 Jun 2002 18:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317890AbSFMWL7>; Thu, 13 Jun 2002 18:11:59 -0400
Received: from ns0.seaman.net ([168.215.64.186]:19189 "EHLO ns0.seaman.net")
	by vger.kernel.org with ESMTP id <S317887AbSFMWLR>;
	Thu, 13 Jun 2002 18:11:17 -0400
Date: Thu, 13 Jun 2002 17:11:01 -0500
From: "Richard Seaman, Jr." <dick@seaman.org>
To: "Bhavesh P. Davda" <bhavesh@avaya.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.4.18
Message-ID: <20020613171101.A20472@seaman.org>
Mail-Followup-To: "Richard Seaman, Jr." <dick@seaman.org>,
	"Bhavesh P. Davda" <bhavesh@avaya.com>, mingo@elte.hu,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0206132007010.8525-100000@elte.hu> <3D090B4D.4060104@avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 03:14:53PM -0600, Bhavesh P. Davda wrote:

> I would think that the logical place to add any process to the runqueue 
> would be the back of the runqueue. If all processes are ALWAYS added to 
> the back of the runqueue, then every process is GUARANTEED to eventually 
> be scheduled. No process will be starved indefinitely.

FYI, from SuSv3:

"Under the SCHED_FIFO policy, the modification of the definitional
thread lists is as follows:

1. When a running thread becomes a preempted thread, it becomes
the head of the thread list for its priority.

2. When a blocked thread becomes a runnable thread, it becomes
the tail of the thread list for its priority.

....

7. If a thread whose policy or priority has been modified other
than by pthread_setschedprio() is a running thread or is runnable,
it then becomes the tail of the thread list for its new priority.

8. If a thread whose policy or priority has been modified by
pthread_setschedprio() is a running thread or is runnable, the
effect on its position in the thread list depends on the direction
of the modification, as follows:

   1. If the priority is raised, the thread becomes the tail of
      the thread list.
   2. If the priority is unchanged, the thread does not change
      position in the thread list.
   3. If the priority is lowered, the thread becomes the head
      of the thread list.

9. When a running thread issues the sched_yield() function, the
thread becomes the tail of the thread list for its priority.

...."

Also, regarding SCHED_RR:

"...This policy shall be identical to the SCHED_FIFO policy with the
additional condition that when the implementation detects that a
running thread has been executing as a running thread for a time
period of the length returned by the sched_rr_get_interval() function
or longer, the thread shall become the tail of its thread list and
the head of that thread list shall be removed and made a running
thread......"

I'm not suggesting Linux HAS to comply with these requirements,
but its worth consideration.

-- 
Richard Seaman, Jr.        email:    dick@seaman.org
5182 N. Maple Lane         phone:    262-367-5450
Nashotah WI 53058            fax:    262-367-5852
