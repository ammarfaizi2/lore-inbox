Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267105AbRGOWbr>; Sun, 15 Jul 2001 18:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbRGOWbj>; Sun, 15 Jul 2001 18:31:39 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:60422 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S267105AbRGOWb0>; Sun, 15 Jul 2001 18:31:26 -0400
Date: Mon, 16 Jul 2001 00:31:08 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Michael Stiller <michael@toyland.ping.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cardbus Bridge no IRQ in 2.4.6
Message-ID: <20010716003107.I13239@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010715125830.9309.qmail@toyland.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010715125830.9309.qmail@toyland.ping.de>; from michael@toyland.ping.de on Sun, Jul 15, 2001 at 02:58:30PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 02:58:30PM +0200, Michael Stiller wrote:
> i have a PCI Cardbus Bridge which is getting no interrupt from
> the bios and during kernel boot. Is it possible to use the card anyway ?
> Maybe assign an interrupt manually ?
> 
> The details:
> 
> kernel 2.4.6 smp machine
> 
> device in question:
> 
> 00:0e.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
> (rev 01)
>         Subsystem: SCM Microsystems: Unknown device 3000
>         Flags: bus master, medium devsel, latency 168
>         Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
>         Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
>         Memory window 0: 20400000-207ff000 (prefetchable)
>         Memory window 1: 20800000-20bff000
>         I/O window 0: 00001000-000010ff
>         I/O window 1: 00001400-000014ff
>         16-bit legacy interface ports at 0001

Let me guess: a Lucent Orinico PCI adapter, right? It should work with
linux-2.4.6, I submitted a patch for 2.4.6-pre8 (or so) and it is
included in linux-2.4.6. I currently have it working on two non-SMP
systems (ALi 1541 and Intel 440FX chipsets).

> I enabled DEBUG in pci-i386.h and get the following messages:

[snip spooky PCI debug I don't understand anyway]

> Any clues ? Should i send more details ? If yes, which ones ?

Make sure that the Cardbus driver is not a module. IOW: your kernel
configuration should have these lines:

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
