Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318626AbSIKKEZ>; Wed, 11 Sep 2002 06:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318627AbSIKKEZ>; Wed, 11 Sep 2002 06:04:25 -0400
Received: from mail.medav.de ([213.95.12.190]:39686 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S318626AbSIKKEY> convert rfc822-to-8bit;
	Wed, 11 Sep 2002 06:04:24 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "Zwane Mwaikambo" <zwane@mwaikambo.name>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Andre Hedrick" <andre@linux-ide.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Date: Wed, 11 Sep 2002 12:09:36 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <Pine.LNX.4.44.0209102026270.1100-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH]][2.4-ac] opti621 can't do dma
Message-Id: <20020911095828.ABC056EE9@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002 20:28:00 +0200 (SAST), Zwane Mwaikambo wrote:

>> The Compaq Armada 1530 Notebook has a Opti FireStar chipset with an IDE

Actually, it's an 1575D.

>> controller which is Ultra DMA capable (but stable only up to MW-DMA
>> mode 2). This one *should* be handled by the Linux opti621 driver (I
>> don't know if it is).
>
>I'd be interested to see an lspci, I'd be mortified if the opti621 
>driver really drives that controller ;)

No Linux on that machine, thus no lspci but something similar:

 Vendor 1045h OPTi Inc
 Device C701h 82C701 FireStar Plus CPU to PCI Bridge
 Subsystem ID 0E1103F4h Compaq Armarda

 Vendor 1045h OPTi Inc
 Device C700h 82C700 FireStar PCI to ISA Bridge
 Subsystem ID 0E1103F4h Compaq Armarda

 Vendor 1045h OPTi Inc
 Device D568h 82C825 FireBridge II PCI EIDE Controller
 Subsystem ID 0E1103F4h Compaq Armada

This should be supported by the opti621 driver.

With these devices

disk :IBM-DKLA-23240  (primary master) running at MWord DMA2/PIO4 
cdrom:UJDA120         (primary slave)  running at PIO4

the chipset shuld be programmed like this:

PCI BIOS V2.10 detected, 1 PCI bus present.
Found embedded Opti FireStar on 0:20.0
00:  45 10 68 D5  05 00 80 02  30 80 01 01  00 00 00 00
10:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00
20:  01 10 00 00  00 00 00 00  00 00 00 00  F4 03 11 0E
30:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00
40:  2B 00 16 0A  00 00 00 FA  00 00 00 00  00 00 00 00
BusMaster Registers:
00:  08 00 24 00  00 18 EF 00  00 00 04 00  00 00 00 00

VendorID 1045, DeviceID D568, Subsystem VendorID 03F4, DeviceID 0E11
IOBase	    1000h (Len 10h)

Control 0: r0 20, w0 20, r1 20, w1 20, c 95, s EE, m 40
Control 1: r0 FF, w0 FF, r1 FF, w1 FF, c FF, s FF, m FF

South bridge (1045/C700 rev 31) on 0:1.0

If you like to run the disk at ultra DMA mode 0, then it looks like
this:

PCI BIOS V2.10 detected, 1 PCI bus present.
Found embedded Opti FireStar on 0:20.0
00:  45 10 68 D5  05 00 80 02  30 80 01 01  00 00 00 00
10:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00
20:  01 10 00 00  00 00 00 00  00 00 00 00  F4 03 11 0E
30:  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00
40:  2B 00 16 0A  01 00 00 FA  00 00 00 00  00 00 00 00
BusMaster Registers:
00:  08 00 A4 00  00 18 EF 00  00 00 84 00  00 00 00 00

VendorID 1045, DeviceID D568, Subsystem VendorID 03F4, DeviceID 0E11
IOBase	    1000h (Len 10h)

Control 0: r0 20, w0 20, r1 20, w1 20, c 95, s EE, m 40
Control 1: r0 FF, w0 FF, r1 FF, w1 FF, c FF, s FF, m FF

South bridge (1045/C700 rev 31) on 0:1.0


Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 32-34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


