Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSLZSrF>; Thu, 26 Dec 2002 13:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSLZSrF>; Thu, 26 Dec 2002 13:47:05 -0500
Received: from cpe-66-1-165-152.az.sprintbbd.net ([66.1.165.152]:13046 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261568AbSLZSrD>; Thu, 26 Dec 2002 13:47:03 -0500
Subject: Re: nforce2 and agpgart
From: "Carl D. Blake" <carl@boeckeler.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1040685553.2739.30.camel@localhost.localdomain>
References: <1040669417.4563.24.camel@vulcan>
	<1040678186.2237.4.camel@localhost.localdomain>
	<1040683214.4447.7.camel@vulcan> 
	<1040685553.2739.30.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Dec 2002 11:55:16 -0700
Message-Id: <1040928916.6372.32.camel@vulcan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-23 at 16:19, Bongani Hlope wrote:
...snip...
> 
> It was once posted on this list that the NForce is similar to some
> existing hardware. hence the sound driver uses the Intel i810 audio
> driver. I guess if you can search through the archive you might find
> that discussion. If you do find it and _are_ clued-up enough, then you
> can look at drivers/char/agp/agpgart_be.c approximately line 3900 they
> start defining which drivers to use for which bus.
> 
This sounds like a possibility.  However, I cannot find any discussion
about what hardware the nforce2 chipset is similar to.  I just need to
know if the agp portion of the chipset is similar to something else. 
Can anybody point to that information?  From what I can determine the
device that is used is the host bridge.

> So you need to
> 1. Find the id for the AGP bus for the NForce and define it in agp.h
> (lspci should do the trick IIRC on my PC 00:01.0 is the agp bus)
> 2. Find out which hardware the bus is similar to, then add the support
> for the NForce using the setup for that driver
> e.g.
> 
> agp.h
> 
> add
> #ifndef PCI_DEVICE_ID_NVIDIA_NFORCORCE_2   //I'm not sure about the
> naming standard
> #define PCI_DEVICE_ID_NVIDIA_NFORCORCE_2	0x(Hex value from lspci)
> #endif
> 
> the in agpgart_be.c
> 
> add (for example lets say the bus is similar to Intel's i860 agp bus
> then)
> 
> #ifdef CONFIG_AGP_INTEL
> ...
> 
> { PCI_DEVICE_ID_NVIDIA_NFORCORCE_2,
>                 PCI_VENDOR_ID_NVIDIA,
>                 INTEL_I860,
>                 "NVidia",
>                 "NForce2",
>                 intel_860_setup },
> 
> ....
> #endif /* CONFIG_AGP_INTEL */
> 
> DISCLAIMER : I do not know anything about the agp code, except for what
> I have read when trying to find a solution for you. The examples above
> are from what my eyes came across at 1:00 am without prio knowledge to
> the agp code. So if you implement these examples you do it at you own
> (and maybe your pets) risk. The examples come with.... you should now
> how the rest goes ;) 
> 
> -- 
> For future reference - don't anybody else try to send patches as vi
> scripts, please. Yes, it's manly, but let's face it, so is
> bungee-jumping with the cord tied to your testicles.
> 
>                 -- Linus
-- 
Carl D. Blake
Director of Engineering
Boeckeler Instruments, Inc.
4650 S. Butterfield Dr.
Tucson, AZ  85714

Phone: 520-745-0001
FAX: 520-745-0004
email: carl@boeckeler.com

.com

