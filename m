Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267593AbUHWUQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267593AbUHWUQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUHWUNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:13:24 -0400
Received: from proxy.hsp-law.de ([62.48.88.110]:14310 "EHLO gjba.hsp-law.de")
	by vger.kernel.org with ESMTP id S267404AbUHWTBu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:01:50 -0400
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ralf Gerbig <rge-news@quengel.org>,
       linux-dvb-maintainer@linuxtv.org
Subject: ACPI interrupt routing
From: Ralf Gerbig <rge@hsp-law.de>
Date: Mon, 23 Aug 2004 21:01:45 +0200
Message-ID: <m0isb9ispy.fsf@test3.hsp-law.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moins,

starting with 2.6.8.1-mm4, I get the following with my DVB card:

modprobe bttv 
modprobe dvb-bt8xx
modprobe dst

bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 18 (level, high) -> IRQ 18
bttv0: Bt878 (rev 17) at 0000:01:06.0, irq: 18, latency: 32, mmio: 0xe4000000
bttv0: detected: Twinhan VisionPlus DVB-T [card=113], PCI subsystem IDis 1822:0001
bttv0: using: Twinhan DST + clones [card=113,autodetected]
bttv0: using tuner=4
tuner: Ignoring new-style parameters in presence of obsolete ones
bttv0: add subdevice "dvb0"
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI interrupt 0000:01:06.1[A] -> GSI 18 (level, high) -> IRQ 18
bt878(0): Bt878 (rev 17) at 01:06.1, irq: 10, <====================================
latency: 32, memory: 0xe4001000 
attach: checking "bt878 #0 [hw]"
find by pci: checking "bt878 #0 [hw]"
attach: "bt878 #0 [hw]", to card 0
DVB: registering new adapter (DST).
bt878 find by dvb adap: checking "DST"
irq 18: nobody cared!
 [<c01066b4>] __report_bad_irq+0x24/0x80
 [<c01067ab>] note_interrupt+0x7b/0xa0
 [<c0106660>] handle_IRQ_event+0x30/0x60
 [<c0106a51>] do_IRQ+0x101/0x140
 [<c01049e8>] common_interrupt+0x18/0x20
 [<c0102053>] default_idle+0x23/0x30
 [<c01020cd>] cpu_idle+0x2d/0x40
 [<c03f278a>] start_kernel+0x14a/0x170
 [<c03f2390>] unknown_bootoption+0x0/0x170
handlers:
[<e0b5e580>] (bttv_irq+0x0/0x3a0 [bttv])
Disabling IRQ #18


after 

rmmod -f dst
rmmod  dvb_bt8xx dvb_core bt878 tuner bttv  video_buf i2c_algo_bit
v4l2_common  btcx_risc i2c_core videodev

find by i2c adap: checking "bt878 #0 [hw]" 
detach: "bt878 #0 [hw]", for card 0 removed 
bt878(0): unloading 
bttv0: unloading 

and

modprobe bttv  
modprobe dvb-bt8xx 
modprobe dst 
 
find by i2c adap: checking "bt878 #0 [hw]"
detach: "bt878 #0 [hw]", for card 0 removed
bt878(0): unloading
bttv0: unloading
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 18 (level, high) -> IRQ 18
bttv0: Bt878 (rev 17) at 0000:01:06.0, irq: 18, <==================================
latency: 32, mmio: 0xe4000000
bttv0: detected: Twinhan VisionPlus DVB-T [card=113], PCI subsystem IDis 1822:0001
bttv0: using: Twinhan DST + clones [card=113,autodetected]
bttv0: using tuner=4
tuner: Ignoring new-style parameters in presence of obsolete ones
bttv0: add subdevice "dvb0"
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI interrupt 0000:01:06.1[A] -> GSI 18 (level, high) -> IRQ 18
bt878(0): Bt878 (rev 17) at 01:06.1, irq: 18, latency: 32, memory:
0xe4001000
attach: checking "bt878 #0 [hw]"
find by pci: checking "bt878 #0 [hw]"
attach: "bt878 #0 [hw]", to card 0
DVB: registering new adapter (DST).
bt878 find by dvb adap: checking "DST"
dst_check_ci: recognize DTTDIG
DST type : terrestial TV
DST type flags :
DVB: registering frontend 0:0 (DST TERR)...

and it works!

with pci=routeirq it works the first time around:

Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 18 (level, high) -> IRQ 18
bttv0: Bt878 (rev 17) at 0000:01:06.0, irq: 18, latency: 32, mmio:
0xe4000000
bttv0: detected: Twinhan VisionPlus DVB-T [card=113], PCI subsystem ID
is 1822:0001
bttv0: using: Twinhan DST + clones [card=113,autodetected]
bttv0: using tuner=4
tuner: Ignoring new-style parameters in presence of obsolete ones
bttv0: add subdevice "dvb0"
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI interrupt 0000:01:06.1[A] -> GSI 18 (level, high) -> IRQ 18
bt878(0): Bt878 (rev 17) at 01:06.1, irq: 18, latency: 32, memory:
0xe4001000
attach: checking "bt878 #0 [hw]"
find by pci: checking "bt878 #0 [hw]"
attach: "bt878 #0 [hw]", to card 0
DVB: registering new adapter (DST).
bt878 find by dvb adap: checking "DST"
dst_check_ci: recognize DTTDIG
DST type : terrestial TV
DST type flags :
DVB: registering frontend 0:0 (DST TERR)...


lspci:

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller(rev a4)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller(rev a4)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller(rev a4)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2AC97 Audio Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:01:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:01:07.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH Fritz!PCI v2.0 ISDN (rev 01)
0000:01:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:01:09.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
0000:01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:01:0c.0 RAID bus controller: CMD Technology Inc Silicon Image SiI3112 SATARaid Controller (rev 02)
0000:01:0d.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev61)
0000:02:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV280 [Radeon 9200] (rev 01)

diff of boot messages:

--- boot5.log	2004-08-23 19:51:45.187502000 +0200
+++ boot6-routeirg.log	2004-08-23 19:58:50.057502000 +0200
@@ -29,9 +29,9 @@
 Using ACPI (MADT) for SMP configuration information
 Built 1 zonelists
 Initializing CPU#0
-Kernel command line: root=/dev/hde2 acpi_skip_timer_override console=ttyS1,9600 console=tty0 3
+Kernel command line: root=/dev/hde2 acpi_skip_timer_override console=ttyS1,9600 console=tty0 pci=routeirq 3
 PID hash table entries: 2048 (order: 11, 32768 bytes)
-Detected 2091.010 MHz processor.
+Detected 2091.400 MHz processor.
 Using pmtmr for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
@@ -112,13 +112,35 @@
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 PCI: Using ACPI for IRQ routing
-** PCI interrupts are no longer routed automatically.  If this
-** causes a device to stop working, it is probably because the
-** driver failed to call pci_enable_device().  As a temporary
-** workaround, the "pci=routeirq" argument restores the old
-** behavior.  If this argument makes the device work again,
+** Routing PCI interrupts for all devices because "pci=routeirq"
+** was specified.  If this was required to make a driver work,
 ** please email the output of "lspci" to bjorn.helgaas@hp.com
 ** so I can fix the driver.
+ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
+ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 23 (level, high) -> IRQ 23
+ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
+ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 22 (level, high) -> IRQ 22
+ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
+ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 21 (level, high) -> IRQ 21
+ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
+ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 20 (level, high) -> IRQ 20
+ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
+ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, high) -> IRQ 22
+ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
+ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21
+ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
+ACPI: PCI interrupt 0000:01:06.0[A] -> GSI 18 (level, high) -> IRQ 18
+ACPI: PCI interrupt 0000:01:06.1[A] -> GSI 18 (level, high) -> IRQ 18
+ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
+ACPI: PCI interrupt 0000:01:07.0[A] -> GSI 19 (level, high) -> IRQ 19
+ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
+ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 16 (level, high) -> IRQ 16
+ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
+ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, high) -> IRQ 17
+ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 19 (level, high) -> IRQ 19
+ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 16 (level, high) -> IRQ 16
+ACPI: PCI interrupt 0000:01:0d.0[A] -> GSI 17 (level, high) -> IRQ 17
+ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, high) -> IRQ 19
 vesafb: probe of vesafb0 failed with error -6
 Machine check exception polling timer started.
 cpufreq: Detected nForce2 chipset revision C1
@@ -158,7 +180,6 @@
 hdd: SAMSUNG DVD-ROM SD-616E, ATAPI CD/DVD-ROM drive
 ide1 at 0x170-0x177,0x376 on irq 15
 PDC20268: IDE controller at PCI slot 0000:01:09.0
-ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
 ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, high) -> IRQ 17
 PDC20268: chipset revision 2
 PDC20268: 100% native mode on irq 17
@@ -186,7 +207,6 @@
 hde: 78242976 sectors (40060 MB) w/1945KiB Cache, CHS=65535/16/63, UDMA(100)
 hde: cache flushes supported
  hde: hde1 hde2
-ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
 ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 16 (level, high) -> IRQ 16
 ata1: SATA max UDMA/100 cmd 0xE0802080 ctl 0xE080208A bmdma 0xE0802000 irq 16
 ata2: SATA max UDMA/100 cmd 0xE08020C0 ctl 0xE08020CA bmdma 0xE0802008 irq 16
@@ -215,8 +235,6 @@
 EXT3-fs: INFO: recovery required on readonly filesystem.
 EXT3-fs: write access will be enabled during recovery.
 kjournald starting.  Commit interval 5 seconds
-EXT3-fs: hde2: orphan cleanup on readonly fs
-EXT3-fs: hde2: 1 orphan inode deleted
 EXT3-fs: recovery complete.
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
@@ -258,38 +276,36 @@
 HiSax: DSS1 Rev. 2.32.2.3
 HiSax: 2 channels added
 HiSax: MAX_WAITING_CALLS added
-ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
 ACPI: PCI interrupt 0000:01:07.0[A] -> GSI 19 (level, high) -> IRQ 19
 hisax_fcpcipnp: found adapter Fritz!Card PCI v2 at 0000:01:07.0
 forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.28.
-ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
 ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, high) -> IRQ 22
 eth0: forcedeth.c: subsystem: 01695:1000 bound to 0000:00:04.0
+eth0: no link during initialization.
 8139too Fast Ethernet driver 0.9.27
 ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 16 (level, high) -> IRQ 16
 eth1: RealTek RTL8139 at 0xe08ea000, 00:00:1c:d7:58:77, IRQ 16
 ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 19 (level, high) -> IRQ 19
 eth1: link up, 10Mbps, full-duplex, lpa 0x4061
 eth2: RealTek RTL8139 at 0xe090e000, 00:04:61:4a:11:a5, IRQ 19
+PPP generic driver version 2.4.2
+NET: Registered protocol family 24
 Linux agpgart interface v0.100 (c) Dave Jones
-ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
-ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 21 (level, high) -> IRQ 21
+ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 22 (level, high) -> IRQ 22
 ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
-ohci_hcd 0000:00:02.0: irq 21, pci mem e0912000
+ohci_hcd 0000:00:02.0: irq 22, pci mem e0934000
 ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 3 ports detected
-ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
-ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 20 (level, high) -> IRQ 20
+ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 21 (level, high) -> IRQ 21
 ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
-ohci_hcd 0000:00:02.1: irq 20, pci mem e0926000
+ohci_hcd 0000:00:02.1: irq 21, pci mem e0936000
 ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 3 ports detected
-ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
-ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 22 (level, high) -> IRQ 22
+ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 20 (level, high) -> IRQ 20
 ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
-ehci_hcd 0000:00:02.2: irq 22, pci mem e0910000
+ehci_hcd 0000:00:02.2: irq 20, pci mem e0938000
 ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
 ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
 hub 3-0:1.0: USB hub found
@@ -301,16 +317,13 @@
 agpgart: Detected NVIDIA nForce2 chipset
 agpgart: Maximum main memory to use for agp memory: 439M
 agpgart: AGP aperture is 64M @ 0xe0000000
-PPP generic driver version 2.4.2
-NET: Registered protocol family 24
 snd_intel8x0: Unknown parameter `joystick'
-ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
 ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21
 NET: Registered protocol family 10
 Disabled Privacy Extensions on device c037a160(lo)
-intel8x0_measure_ac97_clock: measured 80423 usecs
 IPv6 over IPv4 tunneling driver
-Disabled Privacy Extensions on device dc16fc00(sit0)
+Disabled Privacy Extensions on device de51e800(sit0)
+intel8x0_measure_ac97_clock: measured 55135 usecs
 intel8x0: clocking to 48000
 parport: PnPBIOS parport detected.
 parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]

-- 
Ralf Gerbig			// P:     Linus Torvalds
Dr. Heinz Schäfer & Partner	//-S:     Buried alive in diapers
				//+S:     Buried alive in reporters
				   patch-2.2.4
