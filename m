Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132568AbRDEH3w>; Thu, 5 Apr 2001 03:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132571AbRDEH3m>; Thu, 5 Apr 2001 03:29:42 -0400
Received: from mx.mips.com ([206.31.31.226]:29871 "EHLO mx.mips.com")
	by vger.kernel.org with ESMTP id <S132568AbRDEH30>;
	Thu, 5 Apr 2001 03:29:26 -0400
Message-ID: <3ACC1E35.4D2F7506@mips.com>
Date: Thu, 05 Apr 2001 09:26:45 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Wade Hampton <whampton@staffnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pcnet32 (maybe more) hosed in 2.4.3
In-Reply-To: <20010330190137.A426@indiana.edu> <Pine.LNX.4.30.0103311541300.406-100000@fs131-224.f-secure.com> <20010403202127.A316@bacchus.dhis.org> <3ACB2323.C1653236@mips.com> <3ACB3CA5.D978EF41@staffnet.com> <3ACB8098.DFEC12D7@vc.cvut.cz> <20010404235124.B3102@alpha.franken.de> <3ACBACA5.889ECF7E@vc.cvut.cz>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> Thomas Bogendoerfer wrote:
> >
> > On Wed, Apr 04, 2001 at 01:14:16PM -0700, Petr Vandrovec wrote:
> > > VMware is working on implementation PCnet 32bit mode in emulation (there
> > > is no such thing now because of no OS except FreeBSD needs it). But
> > > my question is - is there some real benefit in running chip in
> > > 32bit mode?
> >
> > probably not.
> >
> > > so is 32bit mode needed for bigendian ports, or what's reasoning
> > > behind it?
> >
> > I've added 32bit mode for some IBM PowerPC machines. The firmware
> > on this machines setup the chip to DWIO and I haven't found a way
> > to switch it back to WIO.
>
> Current Linux driver switches them to 16bit mode in pcnet_probe1:
>
> pcnet_dwio_reset(); // reset to 16bit mode when in 32bit, ignore in
> 16bit mode
> pcnet_wio_reset();  // device is for sure in 16bit mode, but reset it
> again to
>                     // get it into known state if we were in 16bit mode
> already
>
> So you should find hardware always in 16bit mode at this point. If it
> does not work, maybe you need to xor PCNET32_WIO_* values with 2 on
> PowerPC...

I'm afraid that's not true.
The above only do a software reset and that doesn't effect the I/O mode.
Only a hardware reset effects the I/O mode.
An because any firmware might changes to 32bit mode after reset (of the whole
system), we need to support both modes.

>
>                                                 Best regards,
>                                                         Petr Vandrovec
>                                                         vandrove@vc.cvut.cz

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



