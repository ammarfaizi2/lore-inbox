Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276891AbRJHWPZ>; Mon, 8 Oct 2001 18:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276884AbRJHWPP>; Mon, 8 Oct 2001 18:15:15 -0400
Received: from uucp.cistron.nl ([195.64.68.38]:23044 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S276882AbRJHWPJ>;
	Mon, 8 Oct 2001 18:15:09 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: [PATCH] Provide system call to get task id
Date: Mon, 8 Oct 2001 22:15:39 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9pt8ib$b1j$1@ncc1701.cistron.net>
In-Reply-To: <E15qeaA-0001IU-00@the-village.bc.nu> <Pine.LNX.4.33.0110081110130.8212-100000@penguin.transmeta.com>
X-Trace: ncc1701.cistron.net 1002579339 11315 195.64.65.67 (8 Oct 2001 22:15:39 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110081110130.8212-100000@penguin.transmeta.com>,
Linus Torvalds  <torvalds@transmeta.com> wrote:
>Now, I actually seriously doubt either of those are real issues, and it
>probably doesn't matter what we do. But I'd ratehr have a system call
>called "getpid()" do what POSIX threads have traditionally done, namely
>give the ID of the process group ("tpid" in linux kernel-speak), and have
>"gettid()" give the thread ID ("pid" in linux kernel-speak).

The kernel doesn't have pthread support - glibc emulates it using clone().
Shouldn't glibc then not also be the one to do the getpid() / gettid()
switching internally only for applications linked agains libpthread ?

If you want to have thread IDs I think you should go all the way
and make thread groups a real entity like sessions and process groups.
Setsid() would reset the thread group ID like it now also resets
the process group ID. Ditto for setpgrp() I think. A session can
contain several process groups which can contain several thread groups.

There should be a way to signal all processes in a thread group-
perhaps that should even be the default, a signal to any process
in the group should be delivered to all of them. Or perhaps only
for SIGSTOP and SIGKILL, all other signals could be delivered
to the thread group leader.

Anyway, food for thought.

Mike.
-- 
Move sig.

