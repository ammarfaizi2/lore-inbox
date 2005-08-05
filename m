Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262997AbVHEM16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbVHEM16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 08:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbVHEM16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 08:27:58 -0400
Received: from styx.suse.cz ([82.119.242.94]:45760 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262997AbVHEM15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 08:27:57 -0400
Date: Fri, 5 Aug 2005 14:27:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sonny Rao <sonny@burdell.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: amd74xx (nforce) driver problem ?
Message-ID: <20050805122756.GE2484@ucw.cz>
References: <20050801090633.GA12320@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801090633.GA12320@kevlar.burdell.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 05:06:33AM -0400, Sonny Rao wrote:
> Hi,
> 
> I have a system based on the Nforce2 chipset which uses the amd7xx
> driver for it's IDE support, and I noticed that one of the drives was
> performing very slowly.  I looked into it a bit more and it seems the
> drive was operating as UDMA33 instead of UDMA100 for some reason.
> 
> The affected drive was getting about 20-25Mb/sec sequential read (dumb
> hdparm test) while a similar drive on the other channel was getting
> about 45-50 Mb/sec.  The drive on the other channel was operating at
> UDMA100.  Both drives are attached using the proper 80-wire cable.
> 
> Kernel is 2.6.13-rc4 
> 
> If I go into the bios and twiddle an "IDE Master" setting from the
> "none" to the "auto" setting then the driver operates at the expected
> speed. 
> 
> 
> I'm confused though why the driver never correctly set up that IDE
> channel?  It claims in the kernel log that it detected the BIOS
> borkage: 
> 
> NFORCE2: IDE controller at PCI slot 0000:00:09.0
> NFORCE2: chipset revision 162
> NFORCE2: not 100% native mode: will probe irqs later
> NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
> NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> 
> 
> Shouldn't the driver set the channel to UDMA100 after it detects the BIOS
> set up the chip improperly, or am I mistaken about this behavior?  Isn't
> that the "workaround" or does that mean something else?
 
The driver simply takes the information from another register, also
supplied by the BIOS. If you set the drive to 'none', it doesn't have
anywhere to look, since the primary location is borked because of bad BIOS.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
