Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287865AbSANSFm>; Mon, 14 Jan 2002 13:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287866AbSANSFc>; Mon, 14 Jan 2002 13:05:32 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:60625 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287865AbSANSFS>; Mon, 14 Jan 2002 13:05:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: Momchil Velikov <velco@fadata.bg>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 19:04:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <16Q6V6-207eimC@fwd06.sul.t-online.com> <87d70c51wk.fsf@fadata.bg>
In-Reply-To: <87d70c51wk.fsf@fadata.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16QBTc-1er7D6C@fwd03.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> How so ? The POSIX specification is not clear enough or it is not to be
> >> followed ?
>
> Oliver> You can have an rt task block on a lock held by a normal task that
> was Oliver> preempted by a rt task of lower priority. The same problem as
> with the Oliver> sched_idle patches.
>
> This can happen with a non-preemptible kernel too. And it has nothing to
> do with scheduling policy.

It can happen if you sleep with a lock held.
It can not happen at random points in the code.
Thus there is a relation to preemption in kernel mode.

To cure that problem tasks holding a lock would have to be given
the highest priority of all tasks blocking on that lock. The semaphore
code would get much more complex, even in the succesful code path,
which would hurt a lot.

If on the other hand sleeping in kernel mode is explicit, you can simply
give any task being woken up a timeslice and the scheduling requirements
are met. If that should be a problem.

	Regards
		Oliver
