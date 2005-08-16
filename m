Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbVHPPhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbVHPPhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 11:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbVHPPhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 11:37:05 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38069 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030184AbVHPPhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 11:37:04 -0400
Date: Tue, 16 Aug 2005 11:37:03 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
cc: acpi-devel <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] PCI quirks not handled and config space
 differences on resume from S3
In-Reply-To: <4301DF63.1020605@gmx.net>
Message-ID: <Pine.LNX.4.44L0.0508161131240.18233-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005, Carl-Daniel Hailfinger wrote:

> Hi,
> 
> it seems that PCI quirks are not handled on resume which results
> in all kinds of strange effects, like disappeared PCI devices.

> Besides that, a number of drivers do not restore the pci config
> space of their associated devices properly on resume from S3.
> 
> These drivers (and associated devices) are:
> - intel_agp (Host bridge: Intel Corp. 82855PM Processor to I/O Controller)
> - ? (PCI bridge: Intel Corp. 82855PM Processor to AGP Controller)
> - uhci_hcd (USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller)
> - ? (PCI bridge: Intel Corp. 82801 PCI Bridge)
> - ? (ISA bridge: Intel Corp. 82801DBM LPC Interface Controller)
> - piix_ide (IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller)
> 
> Diff between "lspci -vvvxxx" before and after resume for all
> problematic devices on my machine is attached.
> 
> Are there any patches I can try?

The uhci-hcd driver _does_ restore the config space for its devices 
properly.


> USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
>         Subsystem: Samsung Electronics Co Ltd: Unknown device c00c
>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-<TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 5
>         Region 4: I/O ports at 1800 [size=32]
>  00: 86 80 c2 24 05 00 80 02 03 00 03 0c 00 00 80 00
>  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  20: 01 18 00 00 00 00 00 00 00 00 00 00 4d 14 0c c0
>  30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 00
>  40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -c0: 00 25 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +c0: 00 2f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Just because the before and after values are different doesn't mean 
anything is wrong.  Those particular bits are set by the hardware in 
response to various events.  They are used only by the BIOS, to provide 
USB keyboard and mouse services.  They don't affect the device's function 
or the Linux driver at all.

Alan Stern

