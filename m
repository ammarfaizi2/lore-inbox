Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbSLJFw1>; Tue, 10 Dec 2002 00:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266584AbSLJFw1>; Tue, 10 Dec 2002 00:52:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44149 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266578AbSLJFwZ>; Tue, 10 Dec 2002 00:52:25 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>, Patrick Mochel <mochel@osdl.org>,
       Willy Tarreau <willy@w.ods.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Subject: Re: /proc/pci deprecation?
References: <Pine.LNX.4.44.0212090854510.3397-100000@home.transmeta.com>
	<1039458577.10470.49.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Dec 2002 22:57:26 -0700
In-Reply-To: <1039458577.10470.49.camel@irongate.swansea.linux.org.uk>
Message-ID: <m13cp6wh4p.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Mon, 2002-12-09 at 17:00, Linus Torvalds wrote:
> > On 9 Dec 2002, Alan Cox wrote:
> > > I wonder if this is why we have all these problems with VIA chipset
> > > interrupt handling. According to VIA docs they _do_ use
> > > PCI_INTERRUPT_LINE on integrated devices to select the IRQ routing
> > > between APIC and PCI/ISA etc, as well as 0 meaning "IRQ disabled"
> > 
> > Whee.. That sounds like a load of crock in the first place, since the
> > PCI_INTERRUPT_LINE thing should be just a scratch register as far as I
> > know. However, it doesn't really matter - we definitely should never write
> > to it anyway, so the VIA behaviour while strange should still be
> > acceptable.
> 
> Tested and verified. If I leave it alone non apic mode works. To use
> APIC mode I have to write the new IRQ value into that register. I've
> shoved that into the driver for now, since its a demented chip specific
> horror.

Think you can put in a reboot notifier/device shutdown method to restore
it to it's old value, so kexec has a chance of working correctly with
this hardware.


Eric
