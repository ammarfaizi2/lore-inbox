Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316915AbSFFK6y>; Thu, 6 Jun 2002 06:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316919AbSFFK6x>; Thu, 6 Jun 2002 06:58:53 -0400
Received: from dsl-213-023-038-060.arcor-ip.net ([213.23.38.60]:23241 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316915AbSFFK6w>;
	Thu, 6 Jun 2002 06:58:52 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Thu, 6 Jun 2002 12:58:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Xymoron <oxymoron@waste.org>, Mark Mielke <mark@mark.mielke.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206051612170.2614-100000@waste.org> <E17FikY-0001fL-00@starship> <3CFF22B2.5050004@loewe-komp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E17Fuy2-0002Fa-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 June 2002 10:52, Peter Wächtler wrote:
> Daniel Phillips wrote:
> > Our current block queue design would benefit a lot from the kind of
> > thinking that would be required to make it realtime.
> 
> You know that spinning disks do some recalibrations?
>
> Whatever marketing tries to imply with "realtime volumes" - the
> technology only tries to make better promises (think of AV disks
> for better sustained rate).

It's my impression that some do thermal recalibration and some don't:

   http://www.pctechguide.com/04disks.htm
   "recalibration"

This article indicates that disks with servo information encoded on
the platter don't need to do thermal recalibration, thus being better
suited to multimedia playback.  Which makes sense to me.

Typically, hard disk specs include 'full stroke seek, maximum', for
which 28 ms seems to be a typical number for 7200 RPM drives.  If a
particular drive ever performs outside the claimed maximum then
it's performing out of spec.  I suppose that we would need to qualify
disks, to see which fail to perform to spec, and I am sure there are
some that do fail.  That's the first thing I'd do if developing a
realtime block driver: run random seeks on typical disks for a few
days at a time and see what the maximum latency really is.

The need to turn in reliable performance for multimedia apps seems
to have made thermal calibration a thing of the past, but thanks for
raising the issue.

> LynxOS (now LynuxWorks) has some patents for priority based IO.

Oh, more of those one-click realtime patents ;-)  Do you have any
pointers?

> And yes, I know about "resource kernels" and alike.
> But that does not count for spinning disks: they are *not* predictable.

The disk doesn't have to turn in 100% rock solid performance, it just
has to perform within an envelope of latency and throughput.  Again, I'm
sure that some do and some don't, so it's a blacklist/whitelist problem.

> And think about the shared bus like PCI - out of *hard realtime* when
> not talking about worst cases in ranges of seconds.

>From what I've heard, you can forget about hard realtime with some
video cards, which lock the bus for extended periods in order to turn
in better benchmark numbers.  This is another blacklist/whitelist
problem.  In general, the jitter introduced by the pci bus is going
to be far below the 10 usec range or so required for very high
performance realtime work, and way, way below what would be required
for a realtime block driver.

-- 
Daniel
