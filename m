Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267785AbTBRMPi>; Tue, 18 Feb 2003 07:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267786AbTBRMPi>; Tue, 18 Feb 2003 07:15:38 -0500
Received: from radium.jvb.tudelft.nl ([130.161.82.13]:44738 "EHLO
	radium.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S267785AbTBRMPg>; Tue, 18 Feb 2003 07:15:36 -0500
Date: Tue, 18 Feb 2003 13:25:40 +0100 (CET)
From: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>
To: sim@netnation.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-pre4] IDE hangs box after timeout
Message-ID: <Pine.LNX.4.44.0302181257260.16107-100000@radium.jvb.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Razor-id: 11abbec2dad9fbe60580e158a4580e2768df271d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Simon Kirby wrote:

> I don't think this happened on older kernels (< 2.4.18ish), but it may
> have happened on 2.4.20 (though I have other problems with 2.4.20 on
> this box that makes testing more difficult -- it tends to Oops fairly
> often).

I encountered the same problem on a system with just one PDC20269, 2
drives attached to it, and 2 drives attached onboard. This system has an
Enermax 430W power supply, and I would think this was enough for a pentium
3, 3 PCI cards and 4 disks.

Kernels older than 2.4.18 don't have LBA48 support, so would restrict the
20269 in its use. I also encountered the problem with kernel 2.4.17 +
Andre Hedrick's IDE patch, though. Also with 2.4.18/19 and various 2.4.20
-pre and -ac versions upto 2.4.20-rc1-ac4. Testing 2.4.21-pre4-ac4 now.

> I had to use a number of power splitters which are, of course, cheap
> and thus unreliable, and occasionally a few drives will fall off of
> the bus.

I don't use power splitters as this power supply has enough connectors.

> hda: dma_timer_expiry: dma status == 0x21
> hda: timeout waiting for DMA
> hda: timeout waiting for DMA
> hda: (__ide_dma_test_irq) called while not waiting

I see the exact same message.

> ...followed by a complete lockup where sysreq does not appear to work.

For me, the system also locks up completely when there's two disks
connected to the 20269, one on each channel (Note it's always a drive on
the 20269 which drops dead). When you make sure there's only *one* disk
connected to the 20269 (one disk in total, not one on each channel), and
this disk drops dead, then it's just the disk and controller being dead,
and the system continues to run. I imagine the 20269 will lock up the PCI
bus when >1 drives connected to it and one of the drives drops dead.

I'm not sure if we should call this a kernel bug though.

> ( Yes, a new power supply is on order. :) )

I hope this will solve the problem for you. For me it didn't :(

Regards,
- Robbert Kouprie

