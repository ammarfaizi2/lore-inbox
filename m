Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRCTJ6W>; Tue, 20 Mar 2001 04:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbRCTJ6M>; Tue, 20 Mar 2001 04:58:12 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:14311 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129466AbRCTJ54>; Tue, 20 Mar 2001 04:57:56 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200103200956.KAA21611@sunrise.pg.gda.pl>
Subject: Re: standard_io_resources[]
To: smoku@jaszczur.org (Tomasz Sterna)
Date: Tue, 20 Mar 2001 10:56:47 +0100 (MET)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010320101636.A4226@plwawtl0.pl.ccbeverages.com> from "Tomasz Sterna" at Mar 20, 2001 10:16:36 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tomasz Sterna wrote:"
> I couldn't find a maintainer of the code, so I'm writing here.
> 
> In kernel 2.4.1 in arch/i386/kernel/setup.c there is:
> 
> --- arch/i386/kernel/setup.c
> struct resource standard_io_resources[] = {
>         { "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
>         { "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
>         { "timer", 0x40, 0x5f, IORESOURCE_BUSY },
>         { "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
>         { "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
>         { "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },
>         { "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
>         { "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
> };
> ---
> 
> which fix-allocate some io-resources.
> What is the reason for that?
> Isn't that a job of the device drivers?
> 
> In KGI we have our own keyboard driver which tries to allocate the 
> kayboard I/O range for itself, and when it does io_check_region() it 
> fails. What should I do?

There are more problems. Eg. ali14xx (old IDE interface, mostly used on
i486-bazed systems) sometimes uses 0x074, 0x0f4 or 0x034 ports for IDE
configuration. It cannot be evidenced as all the ports mentioned here are
claimed to be used by other subsystem.

But there's another problem here: probing port 0x34 on Intel VX/HX/TX/LX/BX
chipset based systems causes system hang (interrupts are masked) as these
chipsets do not completely decode 0x34 I/O address (ie. 0x34 == 0x20 for
them)

So, the ports are used in some hardware configurations, are not used (some
of them) in others. But there is no simple way to distinguish these cases.
:(

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
