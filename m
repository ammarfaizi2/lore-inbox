Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUA0Sgs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUA0Sgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:36:48 -0500
Received: from ns.suse.de ([195.135.220.2]:17044 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262123AbUA0Sgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:36:46 -0500
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP AMD64 (Tyan S2882) problems.
References: <20040127190911.B13769@fi.muni.cz.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Jan 2004 19:31:55 +0100
In-Reply-To: <20040127190911.B13769@fi.muni.cz.suse.lists.linux.kernel>
Message-ID: <p73fze1fdk4.fsf@nielsen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@informatics.muni.cz> writes:

You don't say if you run a 32bit or a 64bit kernel. I will assume 64bit.
 
> Is it normal? How can I set up some IRQ balancing (or at least hard-wire
> 3ware for CPU1 and eth0 for CPU0)?

Run irqbalanced
 
> Problem 2: the 3ware controller does not work correctly on the first
> PCI bus (slot 1 and 2) - in slot 1 it hangs under bigger load (e.g.
> an array rebuild), in slot 2 it hangs during boot in 3ware BIOS.
> It is probably not Linux-specific, but has anyone seen the same problem?

I haven't seen it.

You can try if it goes away when you disable ACPI PCI routing
(pci=noacpi) 

> Problem 3:
> What the "PCI-DMA: Disabling IOMMU." message in dmesg output means?

Ok you run a 64bit kernel. You don't have enough memory to require
the IOMMU. That's fine.
 
> Problem 4:
> Does Linux support the hardware sensors on this board? The i2c driver
> AMD8111 seems to be working, but what sensors driver should I use?

Most likely the Winbond W83627HF

iirc it's not possible in 2.6.1 to enable it. You have to drop the
ISA dependency for "I2C_ISA" in drivers/i2c/busses/Kconfig

> Problem 5:
> Is there a 3ware configuration program (tw_cli), which works on AMD64?

You can try if the 32bit program works. If not ask 3ware.

-Andi
