Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTIFM1S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 08:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbTIFM1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 08:27:18 -0400
Received: from lidskialf.net ([62.3.233.115]:38861 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S261162AbTIFM1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 08:27:17 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [ACPI] Re: [PATCH] 2.6.0-test4 ACPI fixes series (4/4)
Date: Sat, 6 Sep 2003 13:27:16 +0100
User-Agent: KMail/1.5.3
Cc: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, linux-acpi@intel.com,
       Mikael Pettersson <mikpe@csd.uu.se>
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060157.47121.adq_dvb@lidskialf.net> <3F5936D2.3060502@pobox.com>
In-Reply-To: <3F5936D2.3060502@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309061327.16347.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 September 2003 02:22, Jeff Garzik wrote:
> Andrew de Quincey wrote:
> > This patch removes some erroneous code from mpparse which breaks IO-APIC
> > programming
> >
> >
> > --- linux-2.6.0-test4.null_crs/arch/i386/kernel/mpparse.c	2003-09-06
> > 00:23:10.000000000 +0100 +++
> > linux-2.6.0-test4.duffmpparse/arch/i386/kernel/mpparse.c	2003-09-06
> > 00:28:23.788124872 +0100 @@ -1129,9 +1129,6 @@
> >  			continue;
> >  		ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
> >
> > -		if (!ioapic && (irq < 16))
> > -			irq += 16;
> > -
>
> Even though I've been digging through stuff off and on, I consider
> myself pretty darn IOAPIC-clueless.  Mikael, does this look sane to you?

Really breaks on TX150 servers... All IRQs < 16 get +16 added onto them, which 
breaks all IRQ routing. It's also already been removed from 2.4.23-pre3

