Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265342AbRFVF7J>; Fri, 22 Jun 2001 01:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265343AbRFVF6t>; Fri, 22 Jun 2001 01:58:49 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13249 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265342AbRFVF6n>;
	Fri, 22 Jun 2001 01:58:43 -0400
Message-ID: <3B32DE8D.72C1CFF9@mandrakesoft.com>
Date: Fri, 22 Jun 2001 01:58:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>
Subject: Re: PATCH: ethtool MII helpers
In-Reply-To: <3B23AFC3.71CE2FD2@mandrakesoft.com> <20010622171037.D2576@metastasis.f00f.org> <3B32D694.CACF46D0@mandrakesoft.com> <20010622173459.D2642@metastasis.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
