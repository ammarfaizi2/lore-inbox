Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265747AbRFXMMG>; Sun, 24 Jun 2001 08:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265745AbRFXML5>; Sun, 24 Jun 2001 08:11:57 -0400
Received: from scfdns02.sc.intel.com ([143.183.152.26]:33257 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S265744AbRFXMLi>; Sun, 24 Jun 2001 08:11:38 -0400
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27266@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>, netdev@oss.sgi.com
Subject: [OT] ethtool MII helpers (actually two OT's)
Date: Sun, 24 Jun 2001 15:11:23 +0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MII
---
Is there any support in the MII standard for 1000Mbps (GbE Fiber/Copper) ?
Perhaps an extension to the standard ?
I could see that some of the Gigabit adapters supported by the kernel
provide the MII IOCTLs
interface, but couldn't figure out how to extract the correct speed
information from the registers
I can read. I know it's a bit of a hassle and I have to get the local
capabilities and match them against the partner's capabilities and find the
highest common speed etc. etc. but I'm sure that if the driver can do it I
can reproduce it in userland too.

EthTool
-------
Is there a way that I can extract the link status information out of the
ethtool struct ?
I could see that at least one Gigabit adapter driver (bcm5700.c), provides
the EthTool interface
and reports the correct speed and duplex mode but not the link status.
Is there a place that defines how a driver is supposed to implement the
support for EthTool ?
I figured that since there is no separate field for link status (at least in
version 1.2), a driver is supposed to report speed=0 or something like that
when the link is down. I know this driver detects link status changes for
sure because it prints messages every time, but the speed and duplex are
always reported the same.


	Thanks,
	Shmulik Hen      
      Software Engineer
	Linux Advanced Networking Services
	Intel Network Communications Group
	Jerusalem, Israel

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
Sent: Friday, June 22, 2001 8:59 AM
To: Chris Wedgwood
Cc: Linux Kernel Mailing List; netdev@oss.sgi.com; David S. Miller
Subject: Re: PATCH: ethtool MII helpers


Chris Wedgwood wrote:
> 
> On Fri, Jun 22, 2001 at 01:24:36AM -0400, Jeff Garzik wrote:
> 
>     Sure, and that's planned.  Wanna send me a patch for it?  :)
> 
> Possibly, but I wonder if this is a kernel-space problem or not. Why
> not put all the smarts into userland for it?

I meant, send me a patch for userland ethtool, to do exactly what you
described.


>     It will definitely fall back on the MII ioctls if ethtool media
>     support for the desired command doesn't exist.
> 
> Well, that is more or less as much as needs to be done. That, and
> some kind of super-set API to be defined for all new stuff, having
> two slightly different APIs for the same things sucks.

Both APIs do different things but have a common subset, yes.

The MII ioctls only do their thing for MII-like hardware.  ethtool can
be applied to any hardware.  Old ISA drivers that don't do MII, or do it
in a really nonstandard way.  For example I have ethtool code locally
which allows ne2k-pci to do media selection via ioctl, for two popular
ne2k cards, something its never been able to do before.  Emulating media
selection support for things like 10base2<->10baseT<->AUI just isn't
possible with the MII ioctls.

MII is a standard and incredibly popular, thus mii-tool works most
popular PCI NICs, for the most popular media types.  But it's still
basically a hardware interface.  I am not convinced its a good idea for
make the [G]MII ioctls the Linux software media interface for all
network hardware.

I see ethtool as the interface for tuning your NIC, that works across
all hardware.
I see mii-diag as the way to do advance MII-specific hardware stuff,
like next page or HA monitoring or whatever.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
