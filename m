Return-Path: <linux-kernel-owner+willy=40w.ods.org-S281303AbUKARvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S281303AbUKARvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 12:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273204AbUKARvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:51:52 -0500
Received: from mail.vc-graz.ac.at ([193.171.121.30]:3548 "EHLO
	proxy.vc-graz.ac.at") by vger.kernel.org with ESMTP id S283144AbUKARu4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:50:56 -0500
From: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 USB storage problems
Date: Mon, 1 Nov 2004 18:50:47 +0100
User-Agent: KMail/1.7
References: <200410121424.59584.worf@sbox.tu-graz.ac.at> <20041012175117.GA11113@outpost.ds9a.nl>
In-Reply-To: <20041012175117.GA11113@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411011850.47870.worf@sbox.tu-graz.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 12. Oktober 2004 19:51 schrieb bert hubert:
> On Tue, Oct 12, 2004 at 02:24:59PM +0200, Wolfgang Scheicher wrote:
>> if i mount my usb-stick ( Sandisk Micro 256MB, USB2.0, FAT ), write a
>> file (for example 4MB) to it and unmount or sync, then there is a lot of
>> activity on the stick, but the unmount or sync doesn't finish ( waited >
>> 10 Minutes - should not take more than 1-2 sec ).
>
> Can you run vmstat 1 during this process - so start vmstat 1 before umount,
> and then umount but leave it running.
>
>> any hints? any patches i shall try?
>
> Please provide dmesg output, and vmstat 1.

sorry for not responding earlier.

what exactely of dmesg?
i think this is the usb stick related part in dmesg:
[...]
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 5, pci mem e0c22000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 11, pci mem e0c34000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 3 (level, low) -> IRQ 3
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 3, pci mem e0c36000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.29.
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:04.0 to 64
ohci_hcd 0000:00:02.1: wakeup

[...]

usb 3-2: new high speed USB device using address 4
ub: sizeof ub_scsi_cmd 60 ub_dev 924
uba: device 4 capacity nsec 512000 bsize 512
uba: was not changed
 /dev/ub/a: p1
usbcore: registered new driver ub
uba: was not changed


vmstat 1 looks like:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0  69388  47636 197444    0    0     0     0 1426  1449 13  7 80  0
 0  0      0  69388  47636 197448    0    0     0   148 1430  1311 10  4 86  0
 0  0      0  69388  47636 197448    0    0     0     0 1428  1426 11  4 85  0
[now umount starts]
 0  1      0  69132  47636 197448    0    0     0    80 1392  1869 16  3 19 62
 0  1      0  69132  47636 197448    0    0     0     0 1410  1119  8  1  0 91
 0  1      0  69132  47636 197448    0    0     0     0 1413  1103  6  3  0 91
[...this was a 200kb test file, skipping ca. 30 similar lines...]
 0  1      0  69164  47636 197448    0    0     0     0 1409  1130  7  2  0 91
 0  1      0  69164  47636 197448    0    0     0     0 1421  1088  8  2  0 90
 0  0      0  70716  47468 197240    0    0     0     0 1394  1206 11  1 12 76
[now umount finished]
 0  0      0  70716  47508 197240    0    0     0   112 1366  1033  8  2 90  0
 0  0      0  70716  47508 197240    0    0     0    84 1387  1047  6  5 89  0
 0  0      0  70716  47508 197240    0    0     0     0 1365  1134  6  2 92  0

i tested with 100kb, 200kb and 400kb (which takes long, but not too long to 
wait) and i wonder if time actually grows linear with bigger files, or if 
it's eaven worse.

reading is at ca. 500kb/sec

btw - i compared several kernel versions in the meantime.
2.6.8 doesn't show the issue, 2.6.9-rc2 up to 2.6.9 does...

Worf
