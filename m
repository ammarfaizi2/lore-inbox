Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282920AbRLQWN0>; Mon, 17 Dec 2001 17:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282919AbRLQWNR>; Mon, 17 Dec 2001 17:13:17 -0500
Received: from d-dialin-1078.addcom.de ([62.96.163.118]:25582 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S282920AbRLQWNM>; Mon, 17 Dec 2001 17:13:12 -0500
Date: Mon, 17 Dec 2001 23:13:21 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Kevin Curtis <kevin.curtis@farsite.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: pci_enable_device reports IRQ routing conflict
In-Reply-To: <7C078C66B7752B438B88E11E5E20E72E41A1@GENERAL.farsite.co.uk>
Message-ID: <Pine.LNX.4.33.0112172228350.1088-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Kevin Curtis wrote:

> However when I call pci_enable_device for the second card I get the
> following kernel log message:
> 
> Dec 17 15:06:37 minion kernel: IRQ routing conflict for 00:0b.0, have irq 9,
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



