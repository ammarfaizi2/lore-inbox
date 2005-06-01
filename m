Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVFAIYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVFAIYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 04:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVFAIYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 04:24:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42426 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261246AbVFAIX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 04:23:58 -0400
Date: Wed, 1 Jun 2005 10:18:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: External USB2 HDD affects speed hda
Message-ID: <20050601081810.GA23114@elf.ucw.cz>
References: <429BA001.2030405@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429BA001.2030405@keyaccess.nl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 31-05-05 01:21:37, Rene Herman wrote:
> Hi Bartlomiej.
> 
> My Maxtor 6Y120P0 on AMD756 (UDMA66) normally gives me 50 MB/s according 
> to hdparm -t:
> 
> ===
> # hdparm -t /dev/hda
> 
> /dev/hda:
>  Timing buffered disk reads:  152 MB in  3.01 seconds =  50.57 MB/sec
> ===
> 
> However, the second I switch on my external USB2 drive (Western Digital 
> Essential 160G, connected via a PCI card USB2 controller, on a private IRQ):
> 
> ===
> usb 1-3: new high speed USB device using ehci_hcd and address 3
> scsi0 : SCSI emulation for USB Mass Storage devices
> usb-storage: device found at 3
> usb-storage: waiting for device to settle before scanning
>   Vendor: WD        Model: 1600BB External   Rev: 0412
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: assuming drive cache: write through
> SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: assuming drive cache: write through
>  sda: sda1 sda2
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> usb-storage: device scan complete
> ===
> 
> the hdparm -t result drops down to 42MB/s:
> 
> ===
> # hdparm -t /dev/hda
> 
> /dev/hda:
>  Timing buffered disk reads:  130 MB in  3.04 seconds =  42.77 MB/sec
> ===
> 
> Switching the USB2 HDD off again does not work to bring back the 50 MB/s:
> 
> ===
> # eject sda
> # hdparm -t /dev/hda
> 
> /dev/hda:
>  Timing buffered disk reads:  128 MB in  3.01 seconds =  42.57 MB/sec
> 
> [ push button ]
> 
> usb 1-3: USB disconnect, address 3
> 
> # hdparm -t /dev/hda
> 
> /dev/hda:
>  Timing buffered disk reads:  130 MB in  3.04 seconds =  42.73 MB/sec
> ===
> 
> After a reboot, it's 50 MB/s again. Any idea what this is?
> 
> The USB HDD is not firing interrupts or anything. It just sits idle. 
> Fully repeatable on 2.6.11.11 and 2.6.12-rc5.

USB controller generating extra DMA load? Try rmmoding usb to see if
it goes away.
								Pavel
