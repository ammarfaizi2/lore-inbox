Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272593AbRJHSRu>; Mon, 8 Oct 2001 14:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276231AbRJHSRb>; Mon, 8 Oct 2001 14:17:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42247 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275963AbRJHSR1>; Mon, 8 Oct 2001 14:17:27 -0400
Date: Mon, 8 Oct 2001 11:17:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dave McCracken <dmccr@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Provide system call to get task id
In-Reply-To: <E15qeaA-0001IU-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110081110130.8212-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Oct 2001, Alan Cox wrote:
>
> Would it make more sense to add a getpid() and make the existing one
> gettid() to keep compatibility at its sanest ?

I don't think compatibility is an issue: programs that are (a) threaded
and (b) use the new thread group interface and (c) care about tid simply
do not exist. For the simple reason that they cannot exist - getpid() was
changed at the same time CLONE_THREAD was added.

So the only compatibility worry would be

 - people using non-thread-aware libraries together with a CLONE_THREAD
   core thing - which is possible especially if they have thread wrappers.
   But if those libraries care about "pid/tid" issues, there's no way that
   can have well-defined behaviour anyway ;)

 - people who have been playing with CLONE_THREAD, and have apps that
   depend on the "pid is the 'classical' pid, not the thread ID"
   behaviour. In which case adding a new gettid() is the right thing to
   do.

Now, I actually seriously doubt either of those are real issues, and it
probably doesn't matter what we do. But I'd ratehr have a system call
called "getpid()" do what POSIX threads have traditionally done, namely
give the ID of the process group ("tpid" in linux kernel-speak), and have
"gettid()" give the thread ID ("pid" in linux kernel-speak).

		Linus

