Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbQLHDs1>; Thu, 7 Dec 2000 22:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbQLHDsR>; Thu, 7 Dec 2000 22:48:17 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:28420 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129455AbQLHDsG>; Thu, 7 Dec 2000 22:48:06 -0500
Message-ID: <3A3051C0.F3F909C1@timpanogas.org>
Date: Thu, 07 Dec 2000 20:13:04 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de
CC: Rainer Mager <rmager@vgkk.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11
In-Reply-To: <Pine.LNX.4.21.0012080217400.12383-100000@neo.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave,

I think there may be a case when a process forks, that the MMU or some
other subsystem is either not setting the page bits correctly, or
mapping in a bad page.  It's a LEVEL I bug in 2.4 is this is the case,
BTW.  In core dumps (I've looked at 2 of them from SSH) it barfs right
after executing fork() or one of the exec functions and at some places
in the code where there's not any obvious coding bugs.  Looks like some
type of mapping problem.  I reported it three months ago, but it was
pretty much ignored.

Linus needs to add this one to the pre-12 list -- looks like some type
of mapping bug.

Jeff

davej@suse.de wrote:
> 
> On Thu, 7 Dec 2000, Jeff V. Merkey wrote:
> 
> > It's related to some change in 2.4 vs. 2.2.  There are other programs
> > affected other than X, SSH also get's spurious signal 11's now and again
> > with 2.4 and glibc <= 2.1 and it does not occur on 2.2.
> 
> <AOL>
> 
> I've begun to get a bit paranoid about my K6-2 500 box.
> 
> Various processes have been getting random signals after heavy CPU usage.
> Playing an MPEG movie, kernel compile, or even just some small apps
> compiling sometimes. Just for the record, this isn't an OOM situation,
> I've watched this box with half its memory free or in buffers left
> unattended, and suddenly a compile will just die.
> 
> I replaced the CPU with a brand new K6-2. Problem remained.
> Next suspect was faulty RAM. Despite having passed a memtest, I
> swapped out the DIMMs for some known good ones.
> Suspecting cooling problems, I added some case fans.
> Next came a bigger power supply. Still the problems.
> The latest last ditch attempt to make this box stable has been
> to attach the biggest fan I could find that would fit a socket 7 CPU.
> 
> And still the problems are there.
> The only remaining suspect would be a flaky motherboard.
> But then comes the real killer : This box is rock solid under 2.2
> 
> *boggle*
> 
> I'm not sure exactly when this started, but I think I first noticed
> it around test5 or so, but didn't suspect the kernel at the time.
> 
> I've tried kernels compiled with everything from 2.91.66 when this
> was a Redhat box, to gcc 2.95.2 (from Debian woody) when I installed
> debian on it.  If this is a compiler bug, it's one that no compiler
> I've tried seems to be immune from.
> 
> regards,
> 
> Davej.
> 
> --
> | Dave Jones <davej@suse.de>  http://www.suse.de/~davej
> | SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
