Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263435AbRFAJm6>; Fri, 1 Jun 2001 05:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263439AbRFAJms>; Fri, 1 Jun 2001 05:42:48 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:14467 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S263435AbRFAJmh>; Fri, 1 Jun 2001 05:42:37 -0400
Date: Fri, 1 Jun 2001 11:42:43 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Feng Xian <fxian@fxian.jukie.net>
Cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: APIC problem or 3com 3c590 driver problem in smp kernel 2.4.x
Message-ID: <20010601114243.G754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.33.0105311810490.12907-100000@kenzo.iwr.uni-heidelberg.de> <Pine.LNX.4.33.0105311223410.785-100000@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0105311223410.785-100000@tiger>; from fxian@fxian.jukie.net on Thu, May 31, 2001 at 12:27:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2001 at 12:27:07PM -0400, Feng Xian wrote:
> The driver for my pci device, I have the SA_SHIRQ set.

What kind of PCI device do you have? I had this problem once with
an PCI-Matchmaker[1] based board (for which we still have the wrong
PCI-ID btw, but my patch was rejected twice...).

> Actually what I am thinking it may be APIC support problem. I rebuild my
> kernel to use single cpu without APIC support, my device and 3c905 both
> work fine. they don't work for SMP kernel (APIC is by default enabled)
> Then I configured my uni-processor kernel to enable the APIC support, my
> device won't work with the 3c905, just exactly same as it behaves in the
> SMP kernel.

With 2.2 I also had this without APIC. 

I have been flooded with interrupts which have been intended for
the Cyclone card (3c905B 100BaseTX), and exited the ISR quickly
after querying the interrupt register of my Matchmaker board
without any ACKing, but the Cyclone never got these interrupts
anymore.

But is doesn't seem to be a 3c905 based problem, as I have 

 11:   95772726          XT-PIC  es1371, eth0, eth1
 
in /proc/interrupts where eth0 and eth1 are both Cyclones.
Even the vga card has IRQ 11 assigned.

So this is not really unknown ;-)

Regards

Ingo Oeser

[1] class 0b40, vendor id: 10e8, device id: 807d
-- 
To the systems programmer,
users and applications serve only to provide a test load.
