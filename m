Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbTBTTrB>; Thu, 20 Feb 2003 14:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTBTTrB>; Thu, 20 Feb 2003 14:47:01 -0500
Received: from mx1.elte.hu ([157.181.1.137]:48795 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266908AbTBTTrA>;
	Thu, 20 Feb 2003 14:47:00 -0500
Date: Thu, 20 Feb 2003 20:53:48 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302202034270.2013-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302202053170.2164-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Ingo Molnar wrote:

> hm, i think i can see the SMP race.
> 
> the last put_task_struct() can also be done by procfs - and nothing
> keeps it from freeing the task in __put_task_struct(), while the task
> struct is after its final put_task_struct(), but before the switch_to().

this race is correctly solved by moving the wait_task_inactive() from
release_task() into the tsk != current branch of __free_task_struct().

	Ingo

