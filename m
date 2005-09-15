Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVIOATW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVIOATW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOATW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:19:22 -0400
Received: from juno.lps.ele.puc-rio.br ([139.82.40.34]:44454 "EHLO
	juno.lps.ele.puc-rio.br") by vger.kernel.org with ESMTP
	id S932495AbVIOATV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:19:21 -0400
Message-ID: <61337.200.141.106.169.1126743555.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <20050914164637.01f0fff5.akpm@osdl.org>
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br><60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br><60703.200.141.106.169.1126730160.squirrel@correio.lps.ele.puc-rio.br>
    <20050914164637.01f0fff5.akpm@osdl.org>
Date: Wed, 14 Sep 2005 21:19:15 -0300 (BRT)
Subject: Re: libata sata_sil broken on 2.6.13.1
From: izvekov@lps.ele.puc-rio.br
To: "Andrew Morton" <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-6.FC2
X-Mailer: SquirrelMail/1.4.3a-6.FC2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If i use the irqpoll boot option, then it is fine, it boots with no
>> errors
>> at all, and i can even mount a filesystem on that PATA hd.
>>
>
> Good.  Now can you please generate the output from `dmesg -s 1000000' for
> both good and bad kernels, then do
>
> 	diff -u dmesg.good dmesg.bad
>
> and send the result?  Make sure to identify both kernel versions.
>
> Thanks.

No need to CC me anymore, i subscribed, thanks.

Assuming bad is 2.6.13.1 with irqpoll, and good is 2.6.12.6 without irqpoll
Here is the unified diff:

--- dmesg.good	2005-09-14 18:05:06.000000000 -0300
+++ dmesg.bad	2005-09-14 18:04:28.000000000 -0300
@@ -15,19 +15,30 @@
 pnp: 00:00: ioport range 0x4280-0x42ff has been reserved
 pnp: 00:01: ioport range 0x5000-0x503f has been reserved
 pnp: 00:01: ioport range 0x5100-0x513f has been reserved
+PCI: Bridge: 0000:00:08.0
+  IO window: 9000-afff
+  MEM window: dc000000-dfffffff
+  PREFETCH window: d0000000-d7ffffff
+PCI: Bridge: 0000:00:1e.0
+  IO window: disabled.
+  MEM window: da000000-dbffffff
+  PREFETCH window: c0000000-cfffffff
+PCI: Setting latency timer of device 0000:00:08.0 to 64
 Machine check exception polling timer started.
 audit: initializing netlink socket (disabled)
-audit(1126731608.537:0): initialized
+audit(1126731295.846:1): initialized
 VFS: Disk quotas dquot_6.5.1
 Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
 Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
-NTFS driver 2.1.22 [Flags: R/W].
+NTFS driver 2.1.23 [Flags: R/W].
 Initializing Cryptographic API
 pci_hotplug: PCI Hot Plug PCI Core version: 0.5
 fakephp: Fake PCI Hot Plug Controller Driver
 ACPI: Power Button (FF) [PWRF]
+ACPI: Power Button (CM) [PWRB]
 ACPI: Fan [FAN] (on)
-ACPI: Thermal Zone [THRM] (44 C)
+ACPI: CPU0 (power states: C1[C1])
+ACPI: Thermal Zone [THRM] (45 C)
 isapnp: Scanning for PnP cards...
 isapnp: No Plug & Play device found
 Real Time Clock Driver v1.12
@@ -38,7 +49,7 @@
 PNP: No PS/2 controller found. Probing ports directly.
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
-Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
+Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
@@ -46,7 +57,7 @@
 ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 10
 PCI: setting IRQ 10 as level-triggered
 ACPI: PCI Interrupt 0000:01:09.0[A] -> Link [LNK2] -> GSI 10 (level, low)
-> IRQ 10
-ttyS4 at I/O 0x9800 (irq = 10) is a 16550A
+ttyS2 at I/O 0x9800 (irq = 10) is a 16550A
 io scheduler noop registered
 io scheduler anticipatory registered
 io scheduler deadline registered
@@ -54,7 +65,8 @@
 RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
 loop: loaded (max 8 devices)
 pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
-forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.32.
+forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.35.
+acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
 ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 10
 ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LMAC] -> GSI 10 (level, low)
-> IRQ 10
 PCI: Setting latency timer of device 0000:00:04.0 to 64
@@ -67,6 +79,7 @@
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 NFORCE2: IDE controller at PCI slot 0000:00:09.0
+acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
 NFORCE2: chipset revision 162
 NFORCE2: not 100% native mode: will probe irqs later
 NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
@@ -81,7 +94,7 @@
 hda: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
 Uniform CD-ROM driver Revision: 3.20
 hdc: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
-libata version 1.11 loaded.
+libata version 1.12 loaded.
 sata_sil version 0.9
 ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
 PCI: setting IRQ 11 as level-triggered
@@ -93,9 +106,36 @@
 ata1(0): applying Seagate errata fix
 ata1: dev 0 configured for UDMA/100
 scsi0 : sata_sil
-spurious 8259A interrupt: IRQ7.
+irq 11: nobody cared (try booting with the "irqpoll" option)
+ [<c01421fa>] __report_bad_irq+0x2a/0x90
+ [<c0142320>] note_interrupt+0xa0/0x100
+ [<c0141b28>] __do_IRQ+0x128/0x140
+ [<c010506e>] do_IRQ+0x3e/0x60
+ =======================
+ [<c01034b2>] common_interrupt+0x1a/0x20
+ [<c0122950>] __do_softirq+0x30/0x90
+ [<c0105181>] do_softirq+0x41/0x50
+ =======================
+ [<c0122a65>] irq_exit+0x35/0x40
+ [<c0105075>] do_IRQ+0x45/0x60
+ [<c01034b2>] common_interrupt+0x1a/0x20
+ [<c010f544>] delay_tsc+0x14/0x20
+ [<c039fa6f>] ata_pio_complete+0x15f/0x220
+ [<c03a02c0>] ata_pio_task+0x50/0x80
+ [<c012e2a0>] worker_thread+0x200/0x2f0
+ [<c03a0270>] ata_pio_task+0x0/0x80
+ [<c0119960>] default_wake_function+0x0/0x20
+ [<c0119960>] default_wake_function+0x0/0x20
+ [<c012e0a0>] worker_thread+0x0/0x2f0
+ [<c0132948>] kthread+0xa8/0xe0
+ [<c01328a0>] kthread+0x0/0xe0
+ [<c0101395>] kernel_thread_helper+0x5/0x10
+handlers:
+[<c03a0cc0>] (ata_interrupt+0x0/0x120)
+Disabling IRQ #11
 ata2: dev 0 cfg 49:2f00 82:346b 83:4b09 84:4003 85:3469 86:0a09 87:4003
88:203f
 ata2: dev 0 ATA, max UDMA/100, 39102336 sectors:
+ata2(0): applying bridge limits
 ata2: dev 0 configured for UDMA/100
 scsi1 : sata_sil
   Vendor: ATA       Model: ST3120026AS       Rev: 3.18
@@ -116,7 +156,8 @@
 Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
 Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
 Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
-usbmon: debugs is not available
+usbmon: debugfs is not available
+acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
 ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 11
 ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUB2] -> GSI 11 (level, low)
-> IRQ 11
 PCI: Setting latency timer of device 0000:00:02.2 to 64
@@ -135,7 +176,8 @@
 ehci_hcd 0000:01:08.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 4 ports detected
-ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
+ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
+acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
 ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 12
 PCI: setting IRQ 12 as level-triggered
 ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUBA] -> GSI 12 (level, low)
-> IRQ 12
@@ -145,6 +187,7 @@
 ohci_hcd 0000:00:02.0: irq 12, io mem 0xe0087000
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 3 ports detected
+acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
 ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 10
 ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUBB] -> GSI 10 (level, low)
-> IRQ 10
 PCI: Setting latency timer of device 0000:00:02.1 to 64
@@ -153,7 +196,7 @@
 ohci_hcd 0000:00:02.1: irq 10, io mem 0xe0082000
 hub 4-0:1.0: USB hub found
 hub 4-0:1.0: 3 ports detected
-USB Universal Host Controller Interface driver v2.2
+USB Universal Host Controller Interface driver v2.3
 ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
 PCI: setting IRQ 5 as level-triggered
 ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNK1] -> GSI 5 (level, low)
-> IRQ 5
@@ -171,32 +214,34 @@
 usbcore: registered new driver usblp
 drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
 Initializing USB Mass Storage driver...
-usbcore: registered new driver usb-storage
-USB Mass Storage support registered.
 usb 3-1: new low speed USB device using ohci_hcd and address 2
 usb 3-2: new low speed USB device using ohci_hcd and address 3
+usbcore: registered new driver usb-storage
+USB Mass Storage support registered.
 input: USB HID v1.00 Keyboard [NOVATEK USB Keyboard] on usb-0000:00:02.0-1
 input: USB HID v1.00 Device [NOVATEK USB Keyboard] on usb-0000:00:02.0-1
 input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with
IntelliEye(TM)] on usb-0000:00:02.0-2
 usbcore: registered new driver usbhid
 drivers/usb/input/hid-core.c: v2.01:USB HID core driver
 mice: PS/2 mouse device common for all mice
-I2O subsystem v$Rev$
+I2O subsystem v1.288
 i2o: max drivers = 8
-I2O Configuration OSM v$Rev$
-I2O Block Device OSM v$Rev$
-I2O SCSI Peripheral OSM v$Rev$
-I2O ProcFS OSM v$Rev$
+I2O Configuration OSM v1.248
+I2O Bus Adapter OSM v$Rev$
+I2O Block Device OSM v1.287
+I2O SCSI Peripheral OSM v1.282
+I2O ProcFS OSM v1.145
 i2c /dev entries driver
 i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5000
 i2c_adapter i2c-2: nForce2 SMBus adapter at 0x5100
 device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
-Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24
10:33:39 2005 UTC).
+Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28
12:20:13 2005 UTC).
+acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
 ACPI: PCI Interrupt Link [LACI] enabled at IRQ 5
 ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 5 (level, low)
-> IRQ 5
 PCI: Setting latency timer of device 0000:00:06.0 to 64
-intel8x0_measure_ac97_clock: measured 49759 usecs
-intel8x0: clocking to 47452
+intel8x0_measure_ac97_clock: measured 50339 usecs
+intel8x0: clocking to 47378
 ALSA device list:
   #0: NVidia nForce2 with ALC650F at 0xe0080000, irq 5
 oprofile: using timer interrupt.
@@ -205,18 +250,21 @@
 u32 classifier
     Actions configured
 NET: Registered protocol family 2
-IP: routing cache hash table of 8192 buckets, 64Kbytes
+IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
 TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
 TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
 TCP: Hash tables configured (established 131072 bind 65536)
+TCP reno registered
 IPv4 over IPv4 tunneling driver
 GRE over IPv4 tunneling driver
 ip_conntrack version 2.1 (7168 buckets, 57344 max) - 248 bytes per conntrack
 ip_tables: (C) 2000-2002 Netfilter core team
 ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
 arp_tables: (C) 2002 David S. Miller
+TCP bic registered
 NET: Registered protocol family 1
 NET: Registered protocol family 17
+Using IPI Shortcut mode
 ACPI wakeup devices:
 HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1
 ACPI: (supports S0 S1 S4 S5)
@@ -226,18 +274,21 @@
 ReiserFS: sda3: checking transaction log (sda3)
 ReiserFS: sda3: Using r5 hash to sort names
 VFS: Mounted root (reiserfs filesystem) readonly.
-Freeing unused kernel memory: 204k freed
+Freeing unused kernel memory: 200k freed
 eql: remember to turn off Van-Jacobson compression on your slave devices.
 Linux video capture interface: v1.00
-cx2388x v4l2 driver version 0.0.4 loaded
+cx2388x v4l2 driver version 0.0.5 loaded
 ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 12
 ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [LNK4] -> GSI 12 (level, low)
-> IRQ 12
 cx88[0]: subsystem: 0000:0000, board: Prolink PlayTV PVR [card=11,insmod
option]
+TV tuner 43 at 0x1fe, Radio tuner -1 at 0x1fe
 tveeprom(cx88xx internal): Huh, no eeprom present (err=-121)?
 cx88[0]/0: found at 0000:01:07.0, rev: 3, irq: 12, latency: 32, mmio:
0xdc000000
-tuner 3-0060: chip found @ 0xc0 (cx88[0])
+ : chip found @ 0xc0 (cx88[0])
+ : All bytes are equal. It is not a TEA5767
 tuner 3-0060: type set to 43 (Philips NTSC MK3 (FM1236MK3 or FM1236/F))
 tda9885/6/7: chip found @ 0x86
 cx88[0]/0: registered device video0 [v4l2]
 cx88[0]/0: registered device vbi0
 cx88[0]/0: registered device radio0
+hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
