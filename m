Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286336AbSAEXFs>; Sat, 5 Jan 2002 18:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286331AbSAEXFj>; Sat, 5 Jan 2002 18:05:39 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:53511 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286336AbSAEXF0>; Sat, 5 Jan 2002 18:05:26 -0500
Date: Sat, 5 Jan 2002 15:10:12 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Matthias Hanisch <mjh@vr-web.de>
cc: Mikael Pettersson <mikpe@csd.uu.se>, <axboe@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre performance degradation on an old 486
In-Reply-To: <Pine.LNX.4.10.10201050904070.1001-100000@pingu.franken.de>
Message-ID: <Pine.LNX.4.40.0201051506170.1607-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002, Matthias Hanisch wrote:

> On Sat, 5 Jan 2002, Mikael Pettersson wrote:
>
> > When running 2.5.2-pre7 on my old for-testing-only 486(*),
> > file-system accesses seem to come in distinct bursts preceded
> > by lengthy pauses. Overall performance is down quite significantly
> > compared to 2.4.18pre1 and 2.2.20pre2. To measure it I ran two
> > simple tests:
> >
> > Test 1: time to boot the kernel, from hitting enter at the LILO
> > prompt to getting a login prompt
> > Test 2: time to "rm -rf" a clean linux-2.4.17 source tree, using
> > the newly booted kernel (no other access to the tree before that,
> > so it wasn't cached in any way, and the machine was otherwise idle)
> >
> > 		Test 1		Test 2
> > 2.2.21pre2:	71 sec		 75 sec
> > 2.4.18pre1:	64 sec		 72 sec
> > 2.5.2-pre7:	97 sec		251 sec
> >
> > I haven't noticed any slowdowns on my other boxes, so I didn't
> > do any measurements on them. On the 486 it's very very obvious.
>
> This is exactly, what I see with my old 486 box. It started with
> 2.5.2-pre3, which contained two major items:
>
> - bio changes from Jens
> - scheduler changes from Davide
>
> Surprisingly, backing out the bio changes didn't help. Backing out the
> scheduler changes from Davide did!!
>
> Maybe the problem lies somewhere in between, because it is often I/O
> related, e.g. first call of ldconfig is horrible slow, as is e2fsck.
>
> But I also see system hiccups from time to time, where console switching
> does not work for 1 second on an idle box.
>
>
> > (*) 100MHz 486DX4, 28MB ram, no L2 cache, two old and slow IDE disks,
> > small custom no-nonsense RedHat 7.2, kernels compiled with gcc 2.95.3.
>
> Is this ISA (maybe it has something to do with ISA bouncing)? Mine is:
>
> 486 DX/2 ISA, Adaptec 1542, two slow scsi disks and a self-made
> slackware-based system.
>
> Can you also backout the scheduler changes to verify this? I have a
> backout patch for 2.5.2-pre6, if you don't want to do this for yourself.

There should be some part of the kernel that assume a certain scheduler
behavior. There was a guy that reported a bad  hdparm  performance and i
tried it. By running  hdparm -t  my system has a context switch of 20-30
and an irq load of about 100-110.
The scheduler itself, even if you code it in visual basic, cannot make
this with such loads.
Did you try to profile the kernel ?




- Davide


