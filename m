Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270535AbTGNFqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 01:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270538AbTGNFqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 01:46:30 -0400
Received: from [213.171.53.133] ([213.171.53.133]:7434 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id S270535AbTGNFq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 01:46:27 -0400
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.5.75] USB missing hotplug events?
From: Samium Gromoff <deepfire@ibe.miee.ru>
Date: Mon, 14 Jul 2003 09:01:54 +0400
Message-ID: <87el0tvgzh.fsf@drakkar.ibe.miee.ru>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the chip is VIA VT6202.
Linux betelheise 2.5.75 #1 Fri Jul 11 21:05:08 MSD 2003 i686 GNU/Linux

the USB controller doesn`t even generate interrupts when i insert
various USB devices, and hence no device gets detected...

Once i`ve even managed to deadlock the box to the point of no reaction,
just by plugging/unplugging my USB flash storage.


00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:09.0 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:09.1 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
00:0a.0 RAID bus controller: Mylex Corporation DAC960P (rev 02)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01)

	CPU0       
  0:  133263206          XT-PIC  timer
  1:     180474          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  SoundBlaster
  8:          4          XT-PIC  rtc
 10:      16300          XT-PIC  ehci_hcd, eth0
 11:          0          XT-PIC  uhci-hcd
 12:      99186          XT-PIC  i8042
 14:          0          XT-PIC  uhci-hcd, uhci-hcd
 15:     758963          XT-PIC  Mylex DAC960PL
NMI:          0 
LOC:  133268394 
ERR:          0
MIS:          0

this happens when i start the hotplug service, and the respective
usb modules get loaded:

Jul 13 13:15:17 betelheise kernel: ehci_hcd: block sizes: qh 128 qtd 96 itd 128 sitd 64
Jul 13 13:15:17 betelheise kernel: ehci_hcd 0000:00:09.2: ehci_start hcs_params 0x2204 dbg=0 cc=2 pcc=2 ordered !ppc ports=4
Jul 13 13:15:17 betelheise kernel: ehci_hcd 0000:00:09.2: ehci_start hcc_params 0002 thresh 0 uframes 256/512/1024
Jul 13 13:15:17 betelheise kernel: ehci_hcd 0000:00:09.2: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
Jul 13 13:15:17 betelheise kernel: ehci_hcd 0000:00:09.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
Jul 13 13:15:17 betelheise kernel: ehci_hcd 0000:00:09.2: root hub device address 1
Jul 13 13:15:17 betelheise kernel: usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
Jul 13 13:15:17 betelheise kernel: drivers/usb/core/usb.c: usb_hotplug
Jul 13 13:15:17 betelheise kernel: usb usb1: usb_new_device - registering interface 1-0:0
Jul 13 13:15:17 betelheise kernel: drivers/usb/core/usb.c: usb_hotplug
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: usb_device_probe
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: usb_device_probe - got id
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: standalone hub
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: ganged power switching
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: individual port over-current protection
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: Single TT
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: TT requires at most 8 FS bit times
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: Port indicators are not supported
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: power on to power good time: 0ms
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: hub controller current requirement: 0mA
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: local power source is good
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: no over-current condition exists
Jul 13 13:15:17 betelheise kernel: hub 1-0:0: enabling power on all ports
Jul 13 13:15:17 betelheise kernel: uhci-hcd 0000:00:04.2: root hub device address 1
Jul 13 13:15:17 betelheise kernel: usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
Jul 13 13:15:17 betelheise kernel: drivers/usb/core/usb.c: usb_hotplug
Jul 13 13:15:17 betelheise kernel: usb usb2: usb_new_device - registering interface 2-0:0
Jul 13 13:15:17 betelheise kernel: drivers/usb/core/usb.c: usb_hotplug
Jul 13 13:15:17 betelheise kernel: hub 2-0:0: usb_device_probe
Jul 13 13:15:17 betelheise kernel: hub 2-0:0: usb_device_probe - got id
Jul 13 13:15:17 betelheise kernel: hub 2-0:0: standalone hub
Jul 13 13:15:17 betelheise kernel: hub 2-0:0: ganged power switching
Jul 13 13:15:17 betelheise kernel: hub 2-0:0: global over-current protection
Jul 13 13:15:17 betelheise kernel: hub 2-0:0: Port indicators are not supported
Jul 13 13:15:17 betelheise kernel: hub 2-0:0: power on to power good time: 2ms
Jul 13 13:15:17 betelheise kernel: hub 2-0:0: hub controller current requirement: 0mA
Jul 13 13:15:17 betelheise kernel: hub 2-0:0: local power source is good
Jul 13 13:15:17 betelheise kernel: hub 2-0:0: no over-current condition exists
Jul 13 13:15:17 betelheise kernel: hub 2-0:0: enabling power on all ports
Jul 13 13:15:17 betelheise kernel: uhci-hcd 0000:00:09.0: root hub device address 1
Jul 13 13:15:17 betelheise kernel: usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
Jul 13 13:15:17 betelheise kernel: drivers/usb/core/usb.c: usb_hotplug
Jul 13 13:15:17 betelheise kernel: usb usb3: usb_new_device - registering interface 3-0:0
Jul 13 13:15:17 betelheise kernel: drivers/usb/core/usb.c: usb_hotplug
Jul 13 13:15:17 betelheise kernel: hub 3-0:0: usb_device_probe
Jul 13 13:15:17 betelheise kernel: hub 3-0:0: usb_device_probe - got id
Jul 13 13:15:17 betelheise kernel: hub 3-0:0: standalone hub
Jul 13 13:15:17 betelheise kernel: hub 3-0:0: ganged power switching
Jul 13 13:15:17 betelheise kernel: hub 3-0:0: global over-current protection
Jul 13 13:15:17 betelheise kernel: hub 3-0:0: Port indicators are not supported
Jul 13 13:15:17 betelheise kernel: hub 3-0:0: power on to power good time: 2ms
Jul 13 13:15:17 betelheise kernel: hub 3-0:0: hub controller current requirement: 0mA
Jul 13 13:15:17 betelheise kernel: hub 3-0:0: local power source is good
Jul 13 13:15:17 betelheise kernel: hub 3-0:0: no over-current condition exists
Jul 13 13:15:17 betelheise kernel: hub 3-0:0: enabling power on all ports
Jul 13 13:15:18 betelheise kernel: uhci-hcd 0000:00:09.1: root hub device address 1
Jul 13 13:15:18 betelheise kernel: usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
Jul 13 13:15:18 betelheise kernel: drivers/usb/core/usb.c: usb_hotplug
Jul 13 13:15:18 betelheise kernel: usb usb4: usb_new_device - registering interface 4-0:0
Jul 13 13:15:18 betelheise kernel: drivers/usb/core/usb.c: usb_hotplug
Jul 13 13:15:18 betelheise kernel: hub 3-0:0: port 1, status 100, change 3, 12 Mb/s
Jul 13 13:15:18 betelheise kernel: hub 3-0:0: port 2, status 100, change 3, 12 Mb/s
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: usb_device_probe
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: usb_device_probe - got id
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: standalone hub
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: ganged power switching
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: global over-current protection
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: Port indicators are not supported
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: power on to power good time: 2ms
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: hub controller current requirement: 0mA
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: local power source is good
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: no over-current condition exists
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: enabling power on all ports
Jul 13 13:15:18 betelheise kernel: hub 3-0:0: port 1 enable change, status 100
Jul 13 13:15:18 betelheise kernel: hub 3-0:0: port 2 enable change, status 100
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: port 1, status 100, change 3, 12 Mb/s
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: port 2, status 100, change 3, 12 Mb/s
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: port 1 enable change, status 100
Jul 13 13:15:18 betelheise kernel: hub 4-0:0: port 2 enable change, status 100
Jul 13 13:15:19 betelheise kernel: drivers/usb/host/uhci-hcd.c: b400: suspend_hc
Jul 13 13:15:19 betelheise kernel: drivers/usb/host/uhci-hcd.c: b000: suspend_hc
Jul 13 13:15:20 betelheise kernel: drivers/usb/host/uhci-hcd.c: a800: suspend_hc

regards, Samium Gromoff
