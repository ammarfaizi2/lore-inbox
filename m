Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132520AbRDDXXa>; Wed, 4 Apr 2001 19:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132526AbRDDXXU>; Wed, 4 Apr 2001 19:23:20 -0400
Received: from platan.vc.cvut.cz ([147.32.240.81]:40967 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S132520AbRDDXXI>; Wed, 4 Apr 2001 19:23:08 -0400
Message-ID: <3ACBACA5.889ECF7E@vc.cvut.cz>
Date: Wed, 04 Apr 2001 16:22:14 -0700
From: Petr Vandrovec <vandrove@vc.cvut.cz>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac28-4g i686)
X-Accept-Language: cz, cs, en
MIME-Version: 1.0
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: Wade Hampton <whampton@staffnet.com>,
        Carsten Langgaard <carstenl@mips.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pcnet32 (maybe more) hosed in 2.4.3
In-Reply-To: <20010330190137.A426@indiana.edu> <Pine.LNX.4.30.0103311541300.406-100000@fs131-224.f-secure.com> <20010403202127.A316@bacchus.dhis.org> <3ACB2323.C1653236@mips.com> <3ACB3CA5.D978EF41@staffnet.com> <3ACB8098.DFEC12D7@vc.cvut.cz> <20010404235124.B3102@alpha.franken.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Bogendoerfer wrote:
> 
> On Wed, Apr 04, 2001 at 01:14:16PM -0700, Petr Vandrovec wrote:
> > VMware is working on implementation PCnet 32bit mode in emulation (there
> > is no such thing now because of no OS except FreeBSD needs it). But
> > my question is - is there some real benefit in running chip in
> > 32bit mode?
> 
> probably not.
> 
> > so is 32bit mode needed for bigendian ports, or what's reasoning
> > behind it?
> 
> I've added 32bit mode for some IBM PowerPC machines. The firmware
> on this machines setup the chip to DWIO and I haven't found a way
> to switch it back to WIO.

Current Linux driver switches them to 16bit mode in pcnet_probe1:

pcnet_dwio_reset(); // reset to 16bit mode when in 32bit, ignore in
16bit mode
pcnet_wio_reset();  // device is for sure in 16bit mode, but reset it
again to 
                    // get it into known state if we were in 16bit mode
already

So you should find hardware always in 16bit mode at this point. If it
does not work, maybe you need to xor PCNET32_WIO_* values with 2 on
PowerPC...
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
