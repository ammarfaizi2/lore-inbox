Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVKERbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVKERbM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbVKERbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:31:12 -0500
Received: from soundwarez.org ([217.160.171.123]:28356 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750834AbVKERbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:31:12 -0500
Date: Sat, 5 Nov 2005 18:31:04 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14, udev: unknown symbols for ehci_hcd
Message-ID: <20051105173104.GA31048@vrfy.org>
References: <436CD1BC.8020102@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436CD1BC.8020102@t-online.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 04:37:32PM +0100, Harald Dunkel wrote:
> I can't say since when this problem is in, but currently
> I get error messages about unknown symbols at boot time
> (after mounting the root disk, as it seems):
> :
> scsi0 : sata_sil
> ata2: no device found (phy stat 00000000)
> scsi1 : sata_sil
>   Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> SCSI device sda: drive cache: write back
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3 sda4
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> ReiserFS: sda1: found reiserfs format "3.6" with standard journal
> ReiserFS: sda1: using ordered data mode
> ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
> ReiserFS: sda1: checking transaction log (sda1)
> ReiserFS: sda1: Using r5 hash to sort names
> NET: Registered protocol family 1
> parport: PnPBIOS parport detected.
> parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> ehci_hcd: Unknown symbol usb_hcd_pci_suspend
> ehci_hcd: Unknown symbol usb_free_urb
> ehci_hcd: Unknown symbol usb_hub_tt_clear_buffer
> ehci_hcd: Unknown symbol usb_hcd_pci_probe
> ehci_hcd: Unknown symbol usb_disabled
> ehci_hcd: Unknown symbol usb_unlock_device
> ehci_hcd: Unknown symbol usb_put_dev
> ehci_hcd: Unknown symbol usb_get_dev
> :
> 
> If I modprobe ehci_hcd later, then there is no error message.
> It is loaded as expected.
> 
> uname -a:
> Linux pluto 2.6.14 #1 PREEMPT Sat Nov 5 08:47:20 CET 2005 x86_64 GNU/Linux
> udev is version 0.071-1.

We (Debian and SUSE udev) are currently doing "coldplug" with udev,
sysfs and the kernel exported $MODALIAS value instead of the old
hotplug rc-scripts. Sysfs is scanned for all devices and hotplug
events are synthesized, or with kernel 2.6.14+ are just triggered
by a "uevent" file in sysfs. These events look like the same hotplug
event as it happened (but was lost in initramfs) at device creation
time. This approach does a heavy parallel module loading, which
may nobody have ever tried before and seen this "bug" ...

I've got these messages several times on the experimental SUSE too,
but can't reproduce it so far, even without Rusty's patch to modprobe
they have disappeared. See here for the details:
  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=333052

Thanks,
Kay
