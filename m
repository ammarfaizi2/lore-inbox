Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbVIHTmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVIHTmQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVIHTmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:42:16 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:17330 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S964966AbVIHTmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:42:15 -0400
Subject: Re: 8250_hp300: initialisation ordering bug
From: Kars de Jong <jongk@linux-m68k.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050907213316.G19199@flint.arm.linux.org.uk>
References: <20050904111901.A30509@flint.arm.linux.org.uk>
	 <1126124269.3968.5.camel@kars.perseus.home>
	 <20050907213316.G19199@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 21:42:12 +0200
Message-Id: <1126208533.9535.8.camel@kars.perseus.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On wo, 2005-09-07 at 21:33 +0100, Russell King wrote:
> On Wed, Sep 07, 2005 at 10:17:49PM +0200, Kars de Jong wrote:
> > On a related note: can I use the "serial8250" platform driver also for
> > non-ISA devices (like my APCI platform device)? The comments in
> > drivers/serial/8250.c suggest it's for ISA devices only, but I don't see
> > a particular reason for not using it for my APCI devices.
> 
> The legacy platform device (serial8250_isa_devs) is for the old
> legacy ISA tables, found in include/asm-*/serial.h.

Right. My machine has an ISA bus too, but no support for it yet :)

> Other serial8250 platform devices can be used to register other
> devices - preferably groups of platform specific serial ports.
> 
> However, if you're talking about registering a set of devices
> found on a different bus type (eg, PCI) then look at how 8250_pci
> handles that.  I'd prefer bus-specific device registration to be
> done in a similar way to 8250_pci rather than creating extra
> platform devices.

Yes, I do this for the DCA ports (which are on the DIO bus).

However, that doesn't seem to be appropriate for the APCI devices which
are on the motherboard. So I'll use the platform driver for those. Do
you have any suggestion for the id value I should use in my platform
device? I looked in the existing drivers and ids -1 and 1-5 are taken,
any reason id 0 was not used?


Kind regards,

Kars.


