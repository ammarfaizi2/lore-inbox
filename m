Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267739AbUHRVDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267739AbUHRVDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267764AbUHRVDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:03:17 -0400
Received: from 227.80-203-45.nextgentel.com ([80.203.45.227]:37942 "EHLO
	home.gnome.no") by vger.kernel.org with ESMTP id S267739AbUHRVAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:00:54 -0400
Subject: Oops on suspend/resume
From: Kjartan Maraas <kmaraas@broadpark.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Aug 2004 21:00:50 +0000
Message-Id: <1092862850.7890.3.camel@home.gnome.no>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I got this when trying out suspend/resume on a HP NC8000 laptop. The
kernel is one of the latest from fedora development, 2.6.8-rc4-bk4 or
something based.

Aug 18 22:24:50 home kernel: Stopping tasks:
=======================================================================
====================|
Aug 18 22:24:50 home kernel: Could not suspend device 0000:00:1d.7:
error -5
Aug 18 22:24:50 home kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI
10 (level, low) -> IRQ 10
Aug 18 22:24:50 home kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI
11 (level, low) -> IRQ 11
Aug 18 22:24:50 home kernel: ACPI: PCI interrupt 0000:02:0d.0[A] -> GSI
10 (level, low) -> IRQ 10
Aug 18 22:24:50 home kernel: tg3: eth0: Link is down.
Aug 18 22:24:50 home kernel: Badness in ide_wait_not_busy at
drivers/ide/ide-iops.c:1278
Aug 18 22:24:50 home kernel:  [<02251a02>] ide_wait_not_busy+0x4b/0x7d
Aug 18 22:24:50 home kernel:  [<0224f500>] start_request+0xb8/0x1b9
Aug 18 22:24:50 home kernel:  [<0224f8c2>] ide_do_request+0x2a7/0x36a
Aug 18 22:24:50 home kernel:  [<02250273>] ide_intr+0x3c2/0x450
Aug 18 22:24:50 home kernel:  [<022557bb>] ide_dma_intr+0x0/0x7a
Aug 18 22:24:50 home kernel:  [<0210782f>] handle_IRQ_event+0x21/0x41
Aug 18 22:24:51 home kernel:  [<02107d2e>] do_IRQ+0x1be/0x303
Aug 18 22:24:51 home kernel:  =======================
Aug 18 22:24:51 home kernel:  [<021fc4c1>] acpi_processor_idle
+0xd3/0x1c5
Aug 18 22:24:51 home kernel:  [<0210408c>] cpu_idle+0x1f/0x34
Aug 18 22:24:51 home kernel:  [<0239b6ae>] start_kernel+0x221/0x224
Aug 18 22:24:51 home kernel: Restarting tasks... done
Aug 18 22:24:51 home kernel: tg3: eth0: Link is up at 100 Mbps, full
duplex.
Aug 18 22:24:51 home kernel: tg3: eth0: Flow control is on for TX and on
for RX.

lspci says:

[root@home kmaraas]# lspci
00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller
(rev 03)
00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev
03)
00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #2 (rev 03)
00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #3 (rev 03)
00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0
EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev
03)
00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage
Controller (rev 03)
00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
Controller (rev 03)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97
Modem Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility
Radeon 9600 M10]
02:04.0 Ethernet controller: Atheros Communications, Inc. AR5212
802.11abg NIC (rev 01)
02:06.0 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus
MultiMediaBay Controller
02:06.1 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus
MultiMediaBay Controller
02:06.2 System peripheral: O2 Micro, Inc. OZ711Mx MultiMediaBay
Accelerator
02:06.3 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus
MultiMediaBay Controller
02:0d.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
IEEE-1394a-2000 Controller (PHY/Link)
02:0e.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705M_2
Gigabit Ethernet (rev 03)

