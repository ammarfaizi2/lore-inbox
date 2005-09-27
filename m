Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbVI0Vhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVI0Vhl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbVI0Vhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:37:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965157AbVI0Vhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:37:40 -0400
Date: Tue, 27 Sep 2005 14:36:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stian Jordet <liste@jordet.nu>
cc: Olaf Hering <olh@suse.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bogus VIA IRQ fixup in drivers/pci/quirks.c
In-Reply-To: <1127855989.4339b77537987@webmail.jordet.nu>
Message-ID: <Pine.LNX.4.58.0509271432490.3308@g5.osdl.org>
References: <20050926184451.GB11752@suse.de> <Pine.LNX.4.58.0509261446590.3308@g5.osdl.org>
 <1127831274.433956ea35992@webmail.jordet.nu> <Pine.LNX.4.58.0509270734340.3308@g5.osdl.org>
 <1127855989.4339b77537987@webmail.jordet.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Sep 2005, Stian Jordet wrote:
> 
> No dice. My irq's beyond 15 are changed. What used to be 19 became 17, 18 became
> 16, 17 became 18 and 16 became 19. The others are normal, and while looking at
> dmesg, the fixup is still happening. While it boots, and at first glance seems
> to work, it hangs hard when I try to use usb. At least the bluetooth dongle,
> haven't tried with anything else, but I suppose that'd do the same.

Your dmesg you sent only had

	PCI: Via IRQ fixup for 0000:00:11.2, from 9 to 11
	PCI: Via IRQ fixup for 0000:00:11.3, from 9 to 11
	PCI: Via IRQ fixup for 0000:00:11.4, from 9 to 11

for the Via IRQ fixup, so I assumed that you only had regular ones.

No irq's over 15 according to that (and no, it's not because of the 
masking: you also had

	ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
	ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
	ACPI: PCI Interrupt 0000:00:11.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
	ACPI: PCI Interrupt 0000:00:11.4[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11

in there.

So the patch I sent should in fact have made zero difference at all for
you.  What's up?

		Linus
