Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbUKWGKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbUKWGKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbUKWGKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:10:50 -0500
Received: from fmr99.intel.com ([192.55.52.32]:37815 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262199AbUKWGJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:09:35 -0500
Subject: Re: Fw: ACPI bug causes cd-rom lock-ups (2.6.10-rc2)
From: Len Brown <len.brown@intel.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <41990138.7080008@aknet.ru>
References: <41990138.7080008@aknet.ru>
Content-Type: text/plain
Organization: 
Message-Id: <1101190148.19999.394.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Nov 2004 01:09:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *9

This is a common BIOS bug.  It advertises that LNK1 is presently set
to IRQ9, but tells us that IRQ9 is actually illegal for that link;
so Linus has to choose a legal one. (no, we can't just leave it there,
as that breaks other systems).  But apparently we choose poorly.

> Probing IDE interface ide1...
> hdc: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15

IDE probes out and grabs its hard-coded IRQ15.

> ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 15
> PCI: setting IRQ 15 as level-triggered
> ACPI: PCI interrupt 0000:00:1f.4[C] -> GSI 15 (level, low) -> IRQ 15
> uhci_hcd 0000:00:1f.4: Intel Corp. 82801BA/BAM USB (Hub #2)

Here we assign LNK1 to IRQ15 for the benefit of USB,
which, of course, kills your IDE on IRQ 15.  This
is a Linux bug -- but one I thought we fixed some time back.

> hdc: lost interrupt

----------
I'm surprised that you're just seeing this now in 2.6.10.
Did 2.6.9 work correctly?  If so, can you send me the
2.6.9 dmesg?

Any difference with CONFIG_PNP=n?

thanks,
-Len



