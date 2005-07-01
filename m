Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263393AbVGAQHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbVGAQHD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 12:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbVGAQGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 12:06:55 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:31653 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S263378AbVGAQCv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 12:02:51 -0400
Date: Fri, 1 Jul 2005 12:02:50 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Rene Rebe <rene@exactcode.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] irq XX: nobody cared! and uhci_hcd
In-Reply-To: <42C55E66.2010400@exactcode.de>
Message-ID: <Pine.LNX.4.44L0.0507011141130.5086-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2005, Rene Rebe wrote:

> Hi all,
> 
> I have a tiny Sumicom box with Intel (ICH5/ICH5R) w/ Celeron CPU in 
> front of me, that expose quite some bugs in recent Linux kernels. I 
> tested with 2.6.8 (Debian) 2.6.11 and 2.6.12. .12 output attached below.
> 
> First if of all I have to use acpi=noirq or pci=noacpi to get the e100 
> interrupt routed at all. Otherwise no network packet will go on the wire 
> or is received.
> 
> But even with this workaround USB 1.x devices are not functional due to 
> the IRQ for those devices is disabled because nobody cared:

> Of course USB 1.x transfers stall due to no IRQ gets received anymore.
> 
> Full logs:
> 
> version:
> 
> Linux version 2.6.12 (root@archivista) (gcc-Version 3.3.5 (Debian 
> 1:3.3.5-13)) #2 Fri Jul 1 19:58:08 CEST 2005
> 
> lspci:
> 
> 0000:00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated 
> Graphics Device (rev 02)
> 0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
> UHCI #1 (rev 02)
> 0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
> UHCI #3 (rev 02)
> 0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra 
> ATA 100 Storage Controller (rev 02)

<snip>

> interrupts:
>             CPU0
>    0:     161507          XT-PIC  timer
>    1:        354          XT-PIC  i8042
>    2:          0          XT-PIC  cascade
>    5:          0          XT-PIC  Intel ICH5
>    7:          0          XT-PIC  parport0
>    9:          0          XT-PIC  acpi, ohci1394, uhci_hcd:usb2
>   10:     100000          XT-PIC  uhci_hcd:usb1, uhci_hcd:usb3, 
> uhci_hcd:usb4
>   11:        273          XT-PIC  ehci_hcd:usb5, eth0
>   12:         97          XT-PIC  i8042
>   14:       5695          XT-PIC  ide0
>   15:         24          XT-PIC  ide1
> NMI:          0
> LOC:     161465
> ERR:          0
> MIS:          0
> 
> dmesg:
> 
> Linux version 2.6.12 (root@archivista) (gcc-Version 3.3.5 (Debian 
> 1:3.3.5-13)) #2 Fri Jul 1 19:58:08 CEST 2005

> PCI: Probing PCI hardware (bus 00)
> Boot video device is 0000:00:02.0

> ICH5: IDE controller at PCI slot 0000:00:1f.1
> PCI: Found IRQ 10 for device 0000:00:1f.1
> PCI: Sharing IRQ 10 with 0000:00:1d.2

Why doesn't this also list 1d.0, 1d.3, and 02.0?

> USB Universal Host Controller Interface driver v2.2
> PCI: Found IRQ 10 for device 0000:00:1d.0
> PCI: Sharing IRQ 10 with 0000:00:02.0
> PCI: Sharing IRQ 10 with 0000:00:1d.3

Why doesn't this also list 1d.2 and 1f.1?

> PCI: Setting latency timer of device 0000:00:1d.0 to 64
> uhci_hcd 0000:00:1d.0: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
> UHCI Controller #1
> uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
> irq 10: nobody cared!

> PCI: Found IRQ 10 for device 0000:00:1d.2
> PCI: Sharing IRQ 10 with 0000:00:1f.1
> PCI: Setting latency timer of device 0000:00:1d.2 to 64
> uhci_hcd 0000:00:1d.2: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
> UHCI #3

Why doesn't this also list 1d.0, 1d.3, and 02.0?

> PCI: Found IRQ 10 for device 0000:00:1d.3
> PCI: Sharing IRQ 10 with 0000:00:02.0
> PCI: Sharing IRQ 10 with 0000:00:1d.0
> PCI: Setting latency timer of device 0000:00:1d.3 to 64
> uhci_hcd 0000:00:1d.3: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
> UHCI Controller #4

Why doesn't this also list 1d.2 and 1f.1?

I get the feeling that somehow the devices using IRQ 10 have been divided 
into two sets: {02.0, 1d.0, 1d.3} and {1d.2, 1f.1}.  It's not clear 
whether this is related to your problem.

It's tempting to think this has something to do with the UHCI driver, 
since that's where the bad irq showed up.  But in fact it's unrelated.  
Some other device is generated interrupts on the same IRQ line, and the 
problem showed up the first time a driver (which just happened to be 
uhci-hcd) enabled that line.

The device generating the unwanted interrupts could be any of the other
ones connected to that IRQ line.  It's hard to say which, but maybe you
can find out by playing with BIOS settings.  For instance, you should make
sure that Legacy USB Support is disabled in the BIOS.  A BIOS update might
also help.

Another thing you can try is to boot with the "usb-handoff" boot 
parameter.

Alan Stern

