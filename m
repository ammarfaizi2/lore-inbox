Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289163AbSANWsG>; Mon, 14 Jan 2002 17:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289156AbSANWsA>; Mon, 14 Jan 2002 17:48:00 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:15001 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289149AbSANWre>; Mon, 14 Jan 2002 17:47:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 23:46:45 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Momchil Velikov <velco@fadata.bg>, yodaiken@fsmlabs.com,
        Daniel Phillips <phillips@bonn-fries.net>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <16QDdD-1EqtSyC@fwd03.sul.t-online.com> <1011040605.4604.26.camel@phantasy>
In-Reply-To: <1011040605.4604.26.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16QFsj-206pZgC@fwd03.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, semaphores block.  And we have these races right now with
> SCHED_FIFO tasks.  I still contend preempt does not change the nature of
> the problem and it certainly doesn't introduce a new one.

But it does:

down(&sem);
do_something_that_cannot_block();
up(&sem);

Will stop a SCHED_FIFO task for a definite amount of time. Only
until it returns from the kernel to user space at worst.

If do_something_that_cannot_block() can be preempted, a SCHED_FIFO
task can block indefinitely long on the semaphore, because you have
no guarantee that the scheduler will ever again select the the preempted task.
In fact it must never again select the preempted task as long as there's
another runnable SCHED_FIFO task.

	Regards
		Oliver


