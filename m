Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbRFBEJS>; Sat, 2 Jun 2001 00:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbRFBEJI>; Sat, 2 Jun 2001 00:09:08 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:15048 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S261410AbRFBEIv>;
	Sat, 2 Jun 2001 00:08:51 -0400
Date: Sat, 2 Jun 2001 00:08:03 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
X-X-Sender: <fxian@tiger>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: APIC problem or 3com 3c590 driver problem in smp kernel 2.4.x
In-Reply-To: <20010601114243.G754@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.33.0106020005170.4773-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's our own's card. so it could be the card's problem. does the pci
device have to do some special thing to support APIC? my card won't work
properly on uni-processor with APIC enable kernel or smp kernel when the
card is sharing IRQ with some other pci devices.


Alex

On Fri, 1 Jun 2001, Ingo Oeser wrote:

> On Thu, May 31, 2001 at 12:27:07PM -0400, Feng Xian wrote:
> > The driver for my pci device, I have the SA_SHIRQ set.
>
> What kind of PCI device do you have? I had this problem once with
> an PCI-Matchmaker[1] based board (for which we still have the wrong
> PCI-ID btw, but my patch was rejected twice...).
>
> > Actually what I am thinking it may be APIC support problem. I rebuild my
> > kernel to use single cpu without APIC support, my device and 3c905 both
> > work fine. they don't work for SMP kernel (APIC is by default enabled)
> > Then I configured my uni-processor kernel to enable the APIC support, my
> > device won't work with the 3c905, just exactly same as it behaves in the
> > SMP kernel.
>
> With 2.2 I also had this without APIC.
>
> I have been flooded with interrupts which have been intended for
> the Cyclone card (3c905B 100BaseTX), and exited the ISR quickly
> after querying the interrupt register of my Matchmaker board
> without any ACKing, but the Cyclone never got these interrupts
> anymore.
>
> But is doesn't seem to be a 3c905 based problem, as I have
>
>  11:   95772726          XT-PIC  es1371, eth0, eth1
>
> in /proc/interrupts where eth0 and eth1 are both Cyclones.
> Even the vga card has IRQ 11 assigned.
>
> So this is not really unknown ;-)
>
> Regards
>
> Ingo Oeser
>
> [1] class 0b40, vendor id: 10e8, device id: 807d
>

-- 
        Feng Xian
   _o)     .~.      (o_
   /\\     /V\      //\
  _\_V    // \\     V_/_
         /(   )\
          ^^-^^
           ALEX

