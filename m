Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288113AbSAMU0R>; Sun, 13 Jan 2002 15:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288083AbSAMU0O>; Sun, 13 Jan 2002 15:26:14 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:10253 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288113AbSAMU0D>; Sun, 13 Jan 2002 15:26:03 -0500
Message-ID: <3C41ED4E.4D3F2D2C@linux-m68k.org>
Date: Sun, 13 Jan 2002 21:25:50 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Robert Love <rml@tech9.net>, Kenneth Johansson <ken@canit.se>,
        arjan@fenrus.demon.nl, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16Pmok-0007GD-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Cox wrote:

> > What somehow got lost in this discussion, that both patches don't
> > necessarily conflict with each other, they both attack the same problem
> > with different approaches, which complement each other. I prefer to get
> > the best of both patches.
> 
> When you look at the benchmark there is no difference between ll and
> ll+pre-empt. ll alone takes you to the 1ms point.

I don't doubt that, but would you seriously consider the ll patch for
inclusion into the main kernel?
It's a useful patch for anyone, who needs good latencies now, but it's
still a quick&dirty solution. Preempt offers a clean solution for a
certain part of the problem, as it's possible to cleanly localize the
needed changes for preemption (at least for UP). That means the ll patch
becomes smaller and future work on ll becomes simpler, since a certain
type of latency problems is handled automatically (and transparently),
so you do gain something by it.
The remaining places pointed out in the ll patch are worth a closer look
as well, as mostly now we hold a spinlock for too long. These should be
fixed as well, as they mean possible contention problems on SMP.

> pre-empt takes you no
> further and to get much out of pre-emption requires you go and do all the
> hideously slow and complex priority inversion stuff.

The possibility of priority inversion problems are not new, it was
already discussed before. It was considered not a serious problem, since
all processes will still make progress. Preempt now increases the
likeliness such a situation occurs, but nonetheless the processes will
still make progress. In the past I can't remember any report that
indicated a problem caused by priority inversion and so I simply can't
believe it should become a massive problem now with preempt.

> > exactly that reason. I don't think we need to work around broken
> > hardware, but halfway decent hardware should not be a problem to get
> > decent latency.
> 
> We have to work around common hardware not designed for SMP - the 8390 isnt
> a broken chip in that sense, its just from a different era, and there are a
> lot of them.

Please let me rephrase, I just don't expect terrible good latency
numbers with non dma hardware.

bye, Roman
