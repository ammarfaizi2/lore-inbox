Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289073AbSANVSd>; Mon, 14 Jan 2002 16:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289077AbSANVS2>; Mon, 14 Jan 2002 16:18:28 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:41736 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289073AbSANVRQ>; Mon, 14 Jan 2002 16:17:16 -0500
Message-ID: <3C43497C.2609D55@zip.com.au>
Date: Mon, 14 Jan 2002 13:11:24 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Roman Zippel <zippel@linux-m68k.org>, yodaiken@fsmlabs.com,
        Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C43394D.412C7ECC@zip.com.au> from "Andrew Morton" at Jan 14, 2002 12:02:21 PM <E16QEVS-0002yh-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I have all along assumed that a well-designed RT application would delegate
> > all these operations to SCHED_OTHER worker processes, probably via shared
> > memory/shared mappings.  So in the simplest case, you'd have a SCHED_FIFO
> > task which talks to the hardware, and which has a helper task which reads
> > and writes stuff from and to disk.  With sufficient buffering and readahead
> > to cover the worst case IO latencies.
> 
> A real RT task has hard guarantees and to all intents and purposes you may
> deem the system failed if it ever misses one (arguably if you cannot verify
> it will never miss one).

We know that :)  Here, "RT" means "Linux-RT": something which is non-SCHED_OTHER,
and which we'd prefer didn't completely suck.

> The stuff we care about is things like DVD players which tangle with
> sockets, pipes, X11, memory allocation, and synchronization between multiple
> hardware devices all running at slightly incorrect clocks.

Well, that's my point.  A well-designed DVD player would have two processes.
One which tangles with the sockets, pipes, disks, etc, and which feeds data into
and out of the SCHED_FIFO task via a shared, mlocked memory region.

What I'm trying to develop here is a set of guidelines which will allow
application developers to design these programs with a reasonable
degree of success.

-
