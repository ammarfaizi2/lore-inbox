Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318401AbSHEKbA>; Mon, 5 Aug 2002 06:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318404AbSHEKa7>; Mon, 5 Aug 2002 06:30:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37475 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S318401AbSHEKa4>; Mon, 5 Aug 2002 06:30:56 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniela Engert <dani@ngrt.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-ac2
References: <200208041939.VAA15993@myway.myway.de>
	<1028494876.15495.17.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Aug 2002 04:21:41 -0600
In-Reply-To: <1028494876.15495.17.camel@irongate.swansea.linux.org.uk>
Message-ID: <m11y9dsj0q.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sun, 2002-08-04 at 20:39, Daniela Engert wrote:
> > On 04 Aug 2002 21:27:19 +0100, Alan Cox wrote:
> > 
> > > 	if((r9 & 0x0A) != 0x0A)		/* Legacy only */
> > > 	/* Request programmability */
> > > 	pci_write_config_byte(dev, PCI_CLASS_PROG, r9|0x05);
> > 
> > There is no guarantee that this will succeed. Quite some PCI IDE
> > controller chips (f.e. ALi, SiS) may have config register 9 r/o locked
> > by some other means.
> 
> If its locked read only then that is fine. The read back will see the
> old value not 0x05 bits set. In which case it'll leave it alone 
> 
> 	pci_write_config_byte(dev, PCI_CLASS_PROG, r9|0x05);
>         pci_read_config_byte(dev, PCI_CLASS_PROG, &r9);
> 
> 	if((r9 & 0x05) == 0x05)		/* Reprogrammable */
> 		return 1;
> 
> 	/* Refused */
> 	return 0;
> 
> I'm just trying to get this right so we can do a sensible quick fix for
> 2.4.19. Its relatively easy to add pci_assign_device(dev) functionality
> and make the IDE drivers do the right thing when they kick the devices
> out of legacy mode. Thats the longer term right answer.

Why are we kicking IDE devices out of ``legacy'' mode?

Last I checked that was a very sensible mode for IDE devices to operate in.
The IRQ and pio resources are where a lot of software expects them,
and by using an isa-irq there are fewer shared interrupts.

Plus on the few motherboards I tried it on, the pci-irq line didn't
even appear to be hooked up.  In these cases I'm thinking of the
on-board IDE controller.

Eric

