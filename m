Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbVI0W7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbVI0W7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbVI0W7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:59:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6104 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965224AbVI0W7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:59:15 -0400
Date: Tue, 27 Sep 2005 15:58:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stian Jordet <liste@jordet.nu>
cc: Olaf Hering <olh@suse.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bogus VIA IRQ fixup in drivers/pci/quirks.c
In-Reply-To: <1127857716.4339be34f239f@webmail.jordet.nu>
Message-ID: <Pine.LNX.4.58.0509271556211.3308@g5.osdl.org>
References: <20050926184451.GB11752@suse.de> <Pine.LNX.4.58.0509261446590.3308@g5.osdl.org>
 <1127831274.433956ea35992@webmail.jordet.nu> <Pine.LNX.4.58.0509270734340.3308@g5.osdl.org>
 <1127855989.4339b77537987@webmail.jordet.nu> <Pine.LNX.4.58.0509271432490.3308@g5.osdl.org>
 <1127857716.4339be34f239f@webmail.jordet.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Sep 2005, Stian Jordet wrote:
> 
> I have no idea. But I'll attach dmesg from the same kernel with your patch, so
> you'll see the differences yourself. I also see that initialization of
> everything have changed. Now scsi is almost the last thing in the dmesg, it
> used to be about the first.  Weird.

That's not my patch. Something else has changed.

Anyway, this dmesg you posted still says

	...
	USB Universal Host Controller Interface driver v2.3
	ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
	ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
**	PCI: Via IRQ fixup for 0000:00:11.2, from 9 to 11
	uhci_hcd 0000:00:11.2: UHCI Host Controller
	uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
	uhci_hcd 0000:00:11.2: irq 11, io base 0x00009800
	hub 1-0:1.0: USB hub found
	hub 1-0:1.0: 2 ports detected
	ACPI: PCI Interrupt 0000:00:11.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
**	PCI: Via IRQ fixup for 0000:00:11.3, from 9 to 11
	uhci_hcd 0000:00:11.3: UHCI Host Controller
	uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
	uhci_hcd 0000:00:11.3: irq 11, io base 0x00009400
	hub 2-0:1.0: USB hub found
	hub 2-0:1.0: 2 ports detected
	ACPI: PCI Interrupt 0000:00:11.4[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
**	PCI: Via IRQ fixup for 0000:00:11.4, from 9 to 11
	...

so my patch didn't change anything at all for you (which is correct - it 
was designed not to ;)

So if you have trouble with it, it's something else.

		Linus
