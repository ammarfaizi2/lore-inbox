Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261435AbREOUTs>; Tue, 15 May 2001 16:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261436AbREOUTk>; Tue, 15 May 2001 16:19:40 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:35847 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261435AbREOUT1>; Tue, 15 May 2001 16:19:27 -0400
Date: Tue, 15 May 2001 13:18:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jonathan Lundell <jlundell@pobox.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <p05100316b7272cdfd50c@[207.213.214.37]>
Message-ID: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Jonathan Lundell wrote:
> >
> >Keep it informational. And NEVER EVER make it part of the design.
> 
> What about:
> 
> 1 (network domain). I have two network interfaces that I connect to 
> two different network segments, eth0 & eth1;

So?

Informational. You can always ask what "eth0" and "eth1" are.

There's another side to this: repeatability. A setup should be
_repeatable_.

This is what we have now. Network devices are called "eth0..N", and nobody
is complaining about the fact that the numbering is basically random. It
is _repeatable_ as long as you don't change your hardware setup, and the
numbering has effectively _nothing_ to do with "location".

You don't say "oh, I have my network card in PCI bus #2, slot #3,
subfunction #1, so I should do 'ifconfig netp2s3f1'". Right?

The location of the device is _meaningless_. 

Linux gets this right. We don't give 100Mbps cards different names from
10Mbps cards - and pcmcia cards show up in the same namespace as cardbus,
which is the same namespace as ISA. And it doesn't matter what _driver_ we
use.

The "eth0..N" naming is done RIGHT!

> 2 (disk domain). I have multiple spindles on multiple SCSI adapters. 

So? Same deal. You don't have eth0..N, you have disk0..N. 

What's the problem? It's _repeatable_, in that as long as you don't change
your disks, they'll show up the same way. But the 0..N doesn't imply that
the disks are anywhere special.

Linux gets this _somewhat_ right. The /dev/sdxxx naming is correct (or, if
you look at only IDE devices, /dev/hdxxx). The problem is that we don't
have a unified namespace, so unlike eth0..N we do _not_ have a unified
namespace for disks.

Your argument that names change if you add disks etc is complete crap. OF
COURSE they change. You cannot avoid it. Whatever scheme you use will
cause name-changes. The location-based one causes exactly the same kinds
of problems, except they are even worse - now you have to care which ID
your disk has etc. 

The argument that "if you use numbering based on where in the SCSI chain
the disk is, disks don't pop in and out" is absolute crap. It's not true
even for SCSI any more (there are devices that will aquire their location
dynamically), and it has never been true anywhere else. Give it up.

		Linus

