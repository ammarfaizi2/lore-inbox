Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbRLRQT0>; Tue, 18 Dec 2001 11:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284177AbRLRQTQ>; Tue, 18 Dec 2001 11:19:16 -0500
Received: from copper.ftech.net ([212.32.16.118]:50188 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S284176AbRLRQTA>;
	Tue, 18 Dec 2001 11:19:00 -0500
Message-ID: <7C078C66B7752B438B88E11E5E20E72E41A4@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'Kai Germaschewski'" <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: pci_enable_device reports IRQ routing conflict
Date: Tue, 18 Dec 2001 16:16:16 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	thanks for your advice.  Adding debug produced one other message in
the Kernel log:

IRQ for 00:0a.0:0 -> PIRQ 03, mask deb8, excl 0e20 -> newirq=9 -> got IRQ 10
IRQ routing conflict for 00:0a.0, have irq 9, want irq 10

I think my testing shows that actual irq's assigned are as indicated by the
"have irq" field.  And that as far as I can tell at the moment everything
seems to work OK.

Regards

Kevin

-----Original Message-----
From: Kai Germaschewski [mailto:kai@tp1.ruhr-uni-bochum.de]
Sent: 17 December 2001 22:13
To: Kevin Curtis
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_enable_device reports IRQ routing conflict


On Mon, 17 Dec 2001, Kevin Curtis wrote:

> However when I call pci_enable_device for the second card I get the
> following kernel log message:
> 
> Dec 17 15:06:37 minion kernel: IRQ routing conflict for 00:0b.0, have irq
9,
> want irq 5

This means that config space (supposedly set up by the BIOS) reports IRQ 9 
for the device, but the IRQ router really routes it to IRQ 5.

> The call didn't return an error, so I assume this was a non-fatal.  

Well, the kernel currently ignores its knowledge about the router and 
trusts the BIOS. Which most likely means that the IRQ won't work.

(Note that in general you should access dev->irq only after calling 
pci_enable_device())

> Has anyone got any ideas where to look to debug this?

#define DEBUG

in arch/i386/kernel/pci-i386.h will give some debugging output on the next 
boot, which should help.

--Kai


