Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285469AbRLGTEF>; Fri, 7 Dec 2001 14:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285450AbRLGTDr>; Fri, 7 Dec 2001 14:03:47 -0500
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:59145 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S285438AbRLGTDg>; Fri, 7 Dec 2001 14:03:36 -0500
Date: Fri, 7 Dec 2001 13:50:31 -0500
From: Jay Estabrook <Jay.Estabrook@compaq.com>
To: Kurt Garloff <garloff@suse.de>, rth@twiddle.net,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linux kernel list <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org
Subject: Re: IDE DMA on AXP & barriers
Message-ID: <20011207135031.A9962@linux04.mro.cpqcorp.net>
In-Reply-To: <20011206061315.J13427@garloff.etpnet.phys.tue.nl> <20011206125935.A3930@jurassic.park.msu.ru> <20011207132505.B4229@garloff.etpnet.phys.tue.nl> <20011207170341.A9959@jurassic.park.msu.ru> <20011207154815.A14011@garloff.etpnet.phys.tue.nl> <20011207194347.A2718@jurassic.park.msu.ru> <20011207180214.D14011@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207180214.D14011@garloff.etpnet.phys.tue.nl>; from garloff@suse.de on Fri, Dec 07, 2001 at 06:02:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 06:02:14PM +0100, Kurt Garloff wrote:
>
> > > How do I recognize the broken PYXIS in software? (Except for waiting for
> > > your hard disk to be corrupted?)
> > 
> > Put the chip into PCI loopback mode, read some memory (crossing the
> > page boundary) via direct PCI window and check for corruption -
> > perhaps this will work.
> 
> I guess the manual will tell me how to do that ...

You might be able to adapt/add to Richard's code that probes CIA/PYXIS
to determine if workarounds (for other things :-) are needed.

> That's why I'm looking for something better ...
> But on a generic kernel, we have to do a number of things, then:
> * Detect PYXIS
> * Set into PCI loopback
> * Do the cross 8k DMA read
> * Set flag if corruption
> 
> (And even this test is not completely perfect, as only devices on the
>  primary PCI bus seem to be affected.)

Correct; if you put the problematic card/driver behind the bridge on
MIATA (ie one of the 32-bit slots), the problems go away. No such luck
on LX/SX, but they may have HW workarounds already implemented.

> > Jay, your opinion? Perhaps you have the info which systems are affected?
> 
> ... and how they can be identified.

"Identification" may need to be done via "probe and see"... :-\

IIRC, there was only ever one rev of PYXIS, which has a number of
problems.

The first MIATAs went out with (nearly) no fixes, except for the
console cruft to prevent "unknown" cards from being placed in the
64-bit slots (unkown cards == unknown drivers == possibly susceptible
to the 8K boundary DMA error).

LX and SX introduced off-chip PYXIS fixes, which fixed at least the
8K boundary DMA problem, and some others, but NOT all, most notably
the PCI READ prefetch.

Late MIATAs, aka MIATA-GL, have off-chip logic that fix ALL the PYXIS
problems, AFAIK. These are distinguished from the earlier model by the
presence of a QLogic ISP-1040C(?) SCSI chip built into the motherboard.

--Jay++

-----------------------------------------------------------------------------
Jay A Estabrook                            Alpha Engineering - LINUX Project
Compaq Computer Corp. - MRO1-2/K15         (508) 467-2080
200 Forest Street, Marlboro MA 01752       Jay.Estabrook@compaq.com
-----------------------------------------------------------------------------
