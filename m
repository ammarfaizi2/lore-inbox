Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289020AbSANUZc>; Mon, 14 Jan 2002 15:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSANUX6>; Mon, 14 Jan 2002 15:23:58 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:53664 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288992AbSANUXa>; Mon, 14 Jan 2002 15:23:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 21:22:32 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Momchil Velikov <velco@fadata.bg>, yodaiken@fsmlabs.com,
        Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <16QBTc-1er7D6C@fwd03.sul.t-online.com> <1011039031.4603.15.camel@phantasy>
In-Reply-To: <1011039031.4603.15.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16QDdD-1EqtSyC@fwd03.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2002 21:09, Robert Love wrote:
> On Mon, 2002-01-14 at 13:04, Oliver Neukum wrote:
> > It can happen if you sleep with a lock held.
> > It can not happen at random points in the code.
> > Thus there is a relation to preemption in kernel mode.
> >
> > To cure that problem tasks holding a lock would have to be given
> > the highest priority of all tasks blocking on that lock. The semaphore
> > code would get much more complex, even in the succesful code path,
> > which would hurt a lot.
>
> No, this isn't needed.  This same problem would occur without
> preemption.  Our semaphores now have locking rules such that we aren't
> going to have blatant priority inversion like this (1 holds A needs B, 2
> holds B needs A).

No this is a good old deadlock.
The problem with preemption and SCHED_FIFO is, that due to SCHED_FIFO
you have no guarantee that any task will make any progress at all.
Thus a semaphore could basically be held forever.
That can happen without preemption only if you do something that
might block.

	Regards
		Oliver
