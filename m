Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbTBUO6f>; Fri, 21 Feb 2003 09:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbTBUO6f>; Fri, 21 Feb 2003 09:58:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11528 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267467AbTBUO6e>; Fri, 21 Feb 2003 09:58:34 -0500
Date: Fri, 21 Feb 2003 07:05:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302210758290.1701-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302210702320.7573-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Feb 2003, Ingo Molnar wrote:
> > 
> > This is a single non-serializing bit test, and if it means that the task
> > counters are _right_, that's definitely the right thing to do.
> 
> ok. Plus the wait_task_inactive() stuff was always a bit volatile. Now we
> could in fact remove it from release_task(), right?

Yes, except for the same concerns I had about your patch moving it.

That part could be cleanly solvged by just moving a lot of the tear-down
of the "struct task_struct" entirely into "__put_task_struct()" (which now
can never be called with "current == tsk"), ie if we do the "free_user()"
_there_, then I think we can remove the wait_task_inactive() entirely from 
the wait path.

		Linus

