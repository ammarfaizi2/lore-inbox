Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284334AbRLGSqt>; Fri, 7 Dec 2001 13:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285412AbRLGSqe>; Fri, 7 Dec 2001 13:46:34 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:39329 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S284330AbRLGSp1> convert rfc822-to-8bit;
	Fri, 7 Dec 2001 13:45:27 -0500
Date: Fri, 7 Dec 2001 13:45:26 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Martin Eriksson <nitrax@giron.wox.org>
Cc: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][highly-experimental] via-mwq (Was: Re: VIA acknowledges
 North Bridge bug...)
In-Reply-To: <006d01c17f09$f4d61ab0$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.30.0112071344331.8001-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I wrote a patch as well.. and tested it.. It works fine.  I would
recommend not writing an entirely new function.  It's a bit more efficient
just to overload the athlon bug stomper function and register it for a few
extra chipsets.

I will post my patch tha tbasically works just like your patch but has a
smaller footprint..  :)

-Calin


On Fri, 7
Dec 2001, Martin Eriksson wrote:

> ----- Original Message -----
> From: "Calin A. Culianu" <calin@ajvar.org>
> To: "Petri Kaukasoina" <kaukasoi@elektroni.ee.tut.fi>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Thursday, December 06, 2001 11:09 PM
> Subject: Re: VIA acknowledges North Bridge bug (AKA Linux Kernel with Athlon
>
> > Here is the webpage:
> >
> > This patch detects the 0305, 3099, 3102, and 3112 (KT133x, KT266x, VT8662,
> > and KLE133) *only*. On these chipsets, it will patch register 55 in the
> > Northbridge, which will supposedly switch off a Memory Write Queue timer.
> > In the KT133A datasheet, register 55 is "reserved". But - yikes! - in the
> > KT266, the documented MWQ register is register 95, not 55. Register 55
> > contains unrelated DDR timing adjustments and could actually be dangerous
> > to program. For this reason, I do not recommend installing this driver on
> > the KT266x chipsets until VIA examines this issue. For now, use WPCREDIT
> > and set bits 5, 6, and 7 to zero in register 95 instead."
> >
> > ----
> >
> > Clearly, we need to modify the via workaround patches to take into account
> > the other via device id's (namely 3099, 3102, and 3112), and for each one
> > change the appropriate register.  Either register 55 or in the case of the
> > kt266x, register 95.  I am grepping through quirks.c right now and it
> > seems this would be the correct file to modify.. any other suggestions on
> > what file to modify?
>
> I've (hastily) put these changes into "arch/i386/kernel/pci-pc.c" and had to
> modify "include/linux/pci_ids.h" too.
>
> The patch is included, but a warning: I have no VIA based computer that I
> can test this on myself...
>
> _____________________________________________________
> |  Martin Eriksson <nitrax@giron.wox.org>
> |  MSc CSE student, department of Computing Science
> |  Umeå University, Sweden
>
>

