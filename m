Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267098AbSKST2N>; Tue, 19 Nov 2002 14:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbSKST2M>; Tue, 19 Nov 2002 14:28:12 -0500
Received: from ifup.net ([217.160.130.191]:11171 "HELO sit0.ifup.net")
	by vger.kernel.org with SMTP id <S267098AbSKST2I>;
	Tue, 19 Nov 2002 14:28:08 -0500
Date: Tue, 19 Nov 2002 20:35:30 +0100
From: Karsten Desler <soohrt@soohrt.org>
To: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1-ac4 HPT374 doesn't find connected ide drives
Message-ID: <20021119193530.GA915@sit0.ifup.net>
References: <20021119105955.A23008@pc9391.uni-regensburg.de> <20021119102338.GA24510@sit0.ifup.net> <20021119113300.C23008@pc9391.uni-regensburg.de> <20021119152244.GA26989@sit0.ifup.net> <20021119180317.A2597@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119180317.A2597@pc9391.uni-regensburg.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> okay, my brain really shrinks; with only one hdd attached, you can't create an 
> array. So here it seems to work out of the box. I just tried 2.4.20-rc-ac1, 
> which detects my drive connected to that hpt374 (hde).
> 
> Maybe you can give this one a try?

It's partially working with 2.4.20-rc2-ac1. Linux detects the HPT 372
controllers /from time to time/.

First (re)boot:
---
Linux version 2.4.20-rc2-ac1 (root@pikelot) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Tue Nov 19 20:19:24 CET 2002
[..]
PCI: PCI BIOS revision 2.10 entry at 0xfb3d0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1106/3099] 000600 00
Found 00:08 [1106/b099] 000604 01
Found 00:40 [5333/8811] 000300 00
Found 00:60 [10ec/8139] 000200 00
Found 00:70 [1103/0008] 000104 00
Found 00:71 [1103/0008] 000104 00
Found 00:88 [1106/3177] 000601 00
Found 00:89 [1106/0571] 000101 00
Found 00:8d [1106/3059] 000401 00
Found 00:90 [1106/3065] 000200 00
Fixups for bus 00
Scanning behind PCI bridge 00:01.0, config 010100, pass 0
Scanning bus 01
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:01.0, config 010100, pass 1
Bus scan for 00 returning with max=01
[..]
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT374: IDE controller at PCI slot 00:0e.0
PCI: Found IRQ 10 for device 00:0e.0
PCI: Sharing IRQ 10 with 00:0e.1
HPT374: chipset revision 7
HPT374: not 100%% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:DMA, hdh:DMA
PCI: Found IRQ 10 for device 00:0e.1
PCI: Sharing IRQ 10 with 00:0e.0
[..]
---

So he did find the first two controllers.
I rebooted the machine after about 3 minutes to attach the drives to
ide2, but Linux didn't find the controllers.

---
Linux version 2.4.20-rc2-ac1 (root@pikelot) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Tue Nov 19 20:19:24 CET 2002
PCI: PCI BIOS revision 2.10 entry at 0xfb3d0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1106/3099] 000600 00
Found 00:08 [1106/b099] 000604 01
Found 00:40 [5333/8811] 000300 00
Found 00:60 [10ec/8139] 000200 00
Found 00:70 [1103/0008] 000104 00
Found 00:71 [1103/0008] 000104 00
Found 00:88 [1106/3177] 000601 00
Found 00:89 [1106/0571] 000101 00
Found 00:8d [1106/3059] 000401 00
Found 00:90 [1106/3065] 000200 00
Fixups for bus 00
Scanning behind PCI bridge 00:01.0, config 010100, pass 0
Scanning bus 01
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:01.0, config 010100, pass 1
Bus scan for 00 returning with max=01
PCI: Using IRQ router VIA [1106/3177] at 00:11.0
PCI: Found IRQ 11 for device 00:08.0
PCI: Sharing IRQ 11 with 00:12.0
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
HPT374: IDE controller at PCI slot 00:0e.0
PCI: Found IRQ 10 for device 00:0e.0
PCI: Sharing IRQ 10 with 00:0e.1
HPT374: chipset revision 7
HPT374: not 100%% native mode: will probe irqs later
PCI: Found IRQ 10 for device 00:0e.1
PCI: Sharing IRQ 10 with 00:0e.0
---

So I removed the drives again, but the controllers are still undetected.
(Same dmesg excerpt as above)

I'm confused :-/

  Karsten
