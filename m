Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289024AbSA1NUn>; Mon, 28 Jan 2002 08:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288302AbSA1NUd>; Mon, 28 Jan 2002 08:20:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37124 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289213AbSA1NUW>; Mon, 28 Jan 2002 08:20:22 -0500
Subject: Re: [PATCH] remove a wrong release_region in eexpress.c
To: g.anzolin@inwind.it (Gianluca Anzolin)
Date: Mon, 28 Jan 2002 13:33:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, g.anzolin@inwind.it
In-Reply-To: <20020128130619.GA652@fourier.home.intranet> from "Gianluca Anzolin" at Jan 28, 2002 02:06:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VBuK-0000bM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> edition) and he writes that irq and regions should be registered when
> the device is open (and not in the hw-probe function). Why network
> drivers should register the resources they use only on open and not on
> probe (like other drivers do) ? 

In the general case you want to claim resources when the hardware is using 
them. For most things that means at module load time. However many ISA
devices you can avoid the IRQ and DMA channels unless the device is active.
By deferring that you can allow people to use one or other of two clashing
devices in awkward cases.

For PCI devices the problem really doesn't arise since the resource allocations
are done for you when you use pci_enable_device, or by the pci hot plug layer
and/or BIOS as appropriate
