Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVATSJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVATSJD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVATSFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:05:34 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:35050 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S261380AbVATSEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:04:54 -0500
Message-ID: <41EFF2BD.7040107@qualcomm.com>
Date: Thu, 20 Jan 2005 10:04:45 -0800
From: Max Krasnyansky <maxk@qualcomm.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CD/DVD drive access hangs when media is not inserted
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

I've got ASUS DVD-E616P2 drive and it seems that media detection is broken with it.
Processes that try to access the drive when cd or dvd is not inserted simply
hang until the machine is rebooted.

So for example if I do 'cat /dev/cdrom'. First few attempts fail with 'No medium found'
error and dmesg shows 'cdrom: open failed'. But then it hangs in ide_do_drive_cmd

4435 D+   cat /dev/cdrom   ide_do_drive_cmd

 From then on drive is dead. Inserting cd does not help. Reboot is the only way to bring
it back to life.
Everything else works just fine. Actually almost everything. Another annoying problem is
if I pause DVD playback for too long (let's say 10-15 minutes) and then hit play again dvd
access hangs just like in 'no medium' case.

Any ideas ?

I tried a bunch of kernels 2.6.8.1  2.6.9  2.6.10

Here is how the drive is recognized at boot.

ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP1614N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ASUS DVD-E616P2, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15

And this is what lspci has to say about my system

00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller
(rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1)
02:04.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
02:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
02:07.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788 Gigabit Ethernet (rev 03)
02:0d.0 FireWire (IEEE 1394): Agere Systems (former Lucent Microelectronics) FW323 (rev 61)

Max
