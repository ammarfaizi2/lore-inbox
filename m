Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbVITKCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVITKCd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 06:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbVITKCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 06:02:33 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:34944
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S964957AbVITKCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 06:02:31 -0400
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Continuing PCI and Yenta troubles in 2.6.13.1 and 2.6.14-rc1
Date: Tue, 20 Sep 2005 12:02:23 +0200
User-Agent: KMail/1.8.1
References: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de> <20050913063053.GA24158@suse.de> <20050913154529.C15709@jurassic.park.msu.ru>
In-Reply-To: <20050913154529.C15709@jurassic.park.msu.ru>
Organization: Embedded Systems and Applications Group, Tech. Univ. Darmstadt, Germany
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1908
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_w49LDR2AmqTrDKB"
Message-Id: <200509201202.24318.koch@esa.informatik.tu-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_w49LDR2AmqTrDKB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ivan,

I backported your Yenta fix into 2.6.13.1 (that's what I am currently using on 
my production machine). However, the reliability of this setup is 
significantly decreased over my previous 2.6.12-rc6+your PCI patches 
configuration.

Specifically, the machine (Acer TM8104 notebook+ezDock docking station) now 
often hangs (without an oops), sometimes during startup, sometimes a bit 
later during use.

I have attached a console log of a successful start (ok26131.log), where the 
machine lost access to the USB ports on the docking station (behind the PCI 
Express/PCI bridge) later during normal use. I note that there are quite a 
few more errors concerning the bridge initialization (compared to 
2.6.12-rc6).

I attach a second log (stop26131.log) where the machine hangs during booting 
in Yenta initialization.

I have also made an attempt to use 2.6.14-rc1 with your fix. However, two 
things occur here: First, the machine is extremely unresponsive right after 
booting (console input echoed with the speed of a 75 baud terminal [at 
best ...]). Second, after some time, the USB ports in the docking station 
disappear (with a message indicating PCI problems).

Thus, I believe there is still something rotten in the PCI code since the 
2.6.12-rc6 days. Again, if you'd like me to run specific tests, please let me 
know.

Andreas


--Boundary-00=_w49LDR2AmqTrDKB
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="ok26131.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ok26131.log"

Linux version 2.6.13.1 (root@meneldor) (gcc version 3.3.6 (Gentoo 3.3.6, ssp-3.3.6-1.0, pie-8.7.8)) #2 Sat Sep 17 00:09:25 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fe80000 (usable)
 BIOS-e820: 000000007fe80000 - 000000007fe89000 (ACPI data)
 BIOS-e820: 000000007fe89000 - 000000007ff00000 (ACPI NVS)
 BIOS-e820: 000000007ff00000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
1150MB HIGHMEM available.
896MB LOWMEM available.
DMI present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfec20000] gsi_base[24])
IOAPIC[1]: apic_id 2, version 32, address 0xfec20000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 2 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0x0
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:60000000)
Built 1 zonelists
Kernel command line: root=/dev/ram0 lvm2root=/dev/vg0/root console=ttyS0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1995.189 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2069032k/2095616k available (3582k kernel code, 25336k reserved, 1602k data, 216k init, 1178112k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3997.36 BogoMIPS (lpj=7994736)
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 2107k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd6ce, last bus=8
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050408
    ACPI-0362: *** Error: Looking up [Z00G] in namespace, AE_NOT_FOUND
search_node dfdc7140 start_node dfdc7140 return_node 00000000
    ACPI-0362: *** Error: Looking up [Z00G] in namespace, AE_NOT_FOUND
search_node dfdc7d80 start_node dfdc7d80 return_node 00000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 7 of bridge 0000:02:00.0
PCI: Cannot allocate resource region 8 of bridge 0000:02:00.0
PCI: Cannot allocate resource region 4 of device 0000:03:02.0
PCI: Cannot allocate resource region 4 of device 0000:03:02.1
PCI: Cannot allocate resource region 0 of device 0000:03:02.2
PCI: Cannot allocate resource region 4 of device 0000:03:03.0
PCI: Cannot allocate resource region 4 of device 0000:03:03.1
PCI: Cannot allocate resource region 0 of device 0000:03:03.2
PCI: Cannot allocate resource region 0 of device 0000:03:04.0
PCI: Cannot allocate resource region 1 of device 0000:03:04.0
PCI: Cannot allocate resource region 0 of device 0000:03:05.0
PCI: Cannot allocate resource region 0 of device 0000:03:06.0
PCI: Device 0000:02:00.0 not found by BIOS
PCI: BIOS reporting unknown device 03:10
PCI: Device 0000:03:02.1 not found by BIOS
PCI: Device 0000:03:02.2 not found by BIOS
PCI: BIOS reporting unknown device 03:10
PCI: Device 0000:03:03.1 not found by BIOS
PCI: Device 0000:03:03.2 not found by BIOS
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: c8100000-c81fffff
  PREFETCH window: d0000000-d7ffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Error while updating region 0000:03:04.0/1 (86000000 != ffffffff)
PCI: Error while updating region 0000:03:05.0/0 (86004000 != 86000000)
PCI: Error while updating region 0000:03:04.0/0 (86005000 != 86004000)
PCI: Error while updating region 0000:03:02.2/0 (86005800 != 86005000)
PCI: Error while updating region 0000:03:03.2/0 (86005900 != 86005800)
PCI: Error while updating region 0000:03:06.0/0 (00005001 != 86005900)
PCI: Error while updating region 0000:03:02.0/4 (00005041 != 00005001)
PCI: Error while updating region 0000:03:02.1/4 (00005061 != 00005041)
PCI: Error while updating region 0000:03:03.0/4 (00005081 != 00005061)
PCI: Error while updating region 0000:03:03.1/4 (000050a1 != 00005081)
PCI: Bus 4, cardbus bridge: 0000:03:05.0
  IO window: 00003000-00003fff
  IO window: 00004000-00004fff
  PREFETCH window: 80000000-81ffffff
  MEM window: 84000000-85ffffff
PCI: Bridge: 0000:02:00.0
  IO window: 3000-5fff
  MEM window: 84000000-86ffffff
  PREFETCH window: 80000000-81ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 3000-5fff
  MEM window: 84000000-86ffffff
  PREFETCH window: 80000000-81ffffff
PCI: Bus 7, cardbus bridge: 0000:06:09.0
  IO window: 00006000-00006fff
  IO window: 00007000-00007fff
  PREFETCH window: 82000000-83ffffff
  MEM window: 88000000-89ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 6000-7fff
  MEM window: c8400000-c84fffff
  PREFETCH window: 82000000-83ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Device 0000:00:1c.0 not available because of resource collisions
PCI: Device 0000:00:1c.1 not available because of resource collisions
PCI: Enabling device 0000:00:1c.2 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Enabling device 0000:02:00.0 (0044 -> 0047)
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 17
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1126918658.388:1): initialized
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.23 [Flags: R/O].
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
assign_interrupt_mode Found MSI capability
PCI: Device 0000:00:1c.0 not available because of resource collisions
PCI: Device 0000:00:1c.1 not available because of resource collisions
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 17
assign_interrupt_mode Found MSI capability
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (57 C)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
tg3.c:v3.37 (August 25, 2005)
ACPI: PCI Interrupt 0000:06:06.0[A] -> GSI 16 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:c0:9f:75:57:33
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
eth0: dma_rwctrl[763f0000]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6M: IDE controller at PCI slot 0000:00:1f.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 18
ICH6M: chipset revision 4
ICH6M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x18a0-0x18a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x18a8-0x18af, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK1032GAX, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST DVDRAM GMA-4080N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 195371568 sectors (100030 MB), CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0000:03:04.0 (0044 -> 0046)
ohci1394: Failed to allocate shared interrupt 255
ohci1394: probe of 0000:03:04.0 failed with error -12
ACPI: PCI Interrupt 0000:06:07.0[A] -> GSI 19 (level, low) -> IRQ 18
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[c8415000-c84157ff]  Max Packet=[2048]
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0000:03:05.0 (00a0 -> 00a3)
Yenta: CardBus bridge found at 0000:03:05.0 [104c:ac50]
Yenta: adjusting diagnostic: 03 -> 63
Yenta: Enabling burst memory read transactions
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to ISA
Yenta TI: socket 0000:03:05.0, mfunc 0x636602c0, devctl 0x52
Yenta: request_irq() in yenta_probe_cb_irq() failed!
Yenta TI: socket 0000:03:05.0 no PCI interrupts. Fish. Please report.
Yenta: no PCI IRQ, CardBus support disabled for this socket.
Yenta: check your BIOS CardBus, BIOS IRQ or ACPI settings.
Yenta: ISA IRQ mask 0x0000, PCI irq 0
Socket status: ffffffff
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x5fff
pcmcia: parent PCI bridge Memory window: 0x84000000 - 0x86ffffff
pcmcia: parent PCI bridge Memory window: 0x80000000 - 0x81ffffff
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 17
Yenta: CardBus bridge found at 0000:06:09.0 [1025:0070]
Yenta O2: res at 0x94/0xD4: ff/ea
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0438, PCI irq 17
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x6000 - 0x7fff
pcmcia: parent PCI bridge Memory window: 0xc8400000 - 0xc84fffff
pcmcia: parent PCI bridge Memory window: 0x82000000 - 0x83ffffff
Yenta: no bus associated with 0000:06:09.1!
Yenta: no bus associated with 0000:06:09.3!
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 19
ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 19, io mem 0xc8004000
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
PCI: Enabling device 0000:03:02.2 (0080 -> 0082)
PCI: Via IRQ fixup for 0000:03:02.2, from 255 to 15
ehci_hcd 0000:03:02.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:03:02.2: illegal capability!
ehci_hcd 0000:03:02.2: new USB bus registered, assigned bus number 2
ehci_hcd 0000:03:02.2: request interrupt 255 failed
ehci_hcd 0000:03:02.2: USB bus 2 deregistered
ehci_hcd 0000:03:02.2: init 0000:03:02.2 fail, -22
ehci_hcd: probe of 0000:03:02.2 failed with error -22
PCI: Via IRQ fixup for 0000:03:03.2, from 255 to 15
ehci_hcd 0000:03:03.2: VIA Technologies, Inc. USB 2.0 (#2)
ehci_hcd 0000:03:03.2: illegal capability!
ehci_hcd 0000:03:03.2: new USB bus registered, assigned bus number 2
ehci_hcd 0000:03:03.2: request interrupt 255 failed
ehci_hcd 0000:03:03.2: USB bus 2 deregistered
ehci_hcd 0000:03:03.2: init 0000:03:03.2 fail, -22
ehci_hcd: probe of 0000:03:03.2 failed with error -22
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 19, io base 0x00001800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 18, io base 0x00001820
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 17, io base 0x00001840
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
PCI: Via IRQ fixup for 0000:03:02.0, from 255 to 15
uhci_hcd 0000:03:02.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:03:02.0: HCRESET not completed yet!
uhci_hcd 0000:03:02.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:03:02.0: request interrupt 255 failed
uhci_hcd 0000:03:02.0: USB bus 6 deregistered
uhci_hcd 0000:03:02.0: init 0000:03:02.0 fail, -22
uhci_hcd: probe of 0000:03:02.0 failed with error -22
PCI: Via IRQ fixup for 0000:03:02.1, from 255 to 15
uhci_hcd 0000:03:02.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:03:02.1: HCRESET not completed yet!
uhci_hcd 0000:03:02.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:03:02.1: request interrupt 255 failed
uhci_hcd 0000:03:02.1: USB bus 6 deregistered
uhci_hcd 0000:03:02.1: init 0000:03:02.1 fail, -22
uhci_hcd: probe of 0000:03:02.1 failed with error -22
PCI: Via IRQ fixup for 0000:03:03.0, from 255 to 15
uhci_hcd 0000:03:03.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:03:03.0: HCRESET not completed yet!
uhci_hcd 0000:03:03.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:03:03.0: request interrupt 255 failed
uhci_hcd 0000:03:03.0: USB bus 6 deregistered
uhci_hcd 0000:03:03.0: init 0000:03:03.0 fail, -22
uhci_hcd: probe of 0000:03:03.0 failed with error -22
PCI: Via IRQ fixup for 0000:03:03.1, from 255 to 15
uhci_hcd 0000:03:03.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:03:03.1: HCRESET not completed yet!
uhci_hcd 0000:03:03.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:03:03.1: request interrupt 255 failed
uhci_hcd 0000:03:03.1: USB bus 6 deregistered
uhci_hcd 0000:03:03.1: init 0000:03:03.1 fail, -22
uhci_hcd: probe of 0000:03:03.1 failed with error -22
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
usbcore: registered new driver auerswald
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 212 bytes per conntrack
input: AT Translated Set 2 keyboard on isa0060/serio0
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
AZAL RP01 RP02 RP04 USB1 USB2 USB3 USB4 USB7 LANC 
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
initrd: Remounting / read/write
mount: /etc/mtab: No such file Synaptics Touchpad, model: 1, fw: 5.9, id: 0x126eb1, caps: 0xa04713/0x4000
or directory
ininput: SynPS/2 Synaptics TouchPad on isa0060/serio4
itrd: Mounting /proc
initrd: Finding device mapper major and minor numbers (10,62)
initrd: Activating LVM2 volumes
  4 logical volume(s) in volume group "vg0" now active
initrd: Checking root filesystem /dev/vg0/root
WARNING: couldn't open /etc/fstab: No such file or directory
Reiserfs super block in block 16 on 0xfd00 of format 3.6 with standard journal
Blocks (total/free): 5367808/1513945 by 4096 bytes
Filesystem is NOT clean
Replaying journal..
Trans replayed: mountid 299, transid 265186, desc 610, len 28, commit 639, next trans offset 622
Trans replayed: mountid 299, transid 265187, desc 640, len 28, commit 669, next trans offset 652
Trans replayed: mountid 299, transid 265188, desc 670, len 30, commit 701, next trans offset 684
Reiserfs journal '/dev/vg0/root' in blocks [18..8211]: 3 transactions replayed
Checking internal tree..finished
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
initrd: MountingReiserFS: dm-0: using ordered data mode
 root filesystemReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
 /dev/vg0/root rReiserFS: dm-0: checking transaction log (dm-0)
w
ReiserFS: dm-0: Using r5 hash to sort names
initrd: Copying node for device mapper (/dev/mapper/control)
initrd: Moving /proc to /rootvol/proc
initrd: Changing roots
initrd: Making device nodes in lvm root fs
initrd: Unmounting /proc
initrd: Remounting lvm root fs readonly
initrd: Proceeding with boot...
INIT: version 2.86 booting

Gentoo Linux; http://www.gentoo.org/
 Copyright 1999-2005 Gentoo Foundation; Distributed under the GPLv2

--Boundary-00=_w49LDR2AmqTrDKB
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="stop26131.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="stop26131.log"

Linux version 2.6.13.1 (root@meneldor) (gcc version 3.3.6 (Gentoo 3.3.6, ssp-3.3.6-1.0, pie-8.7.8)) #2 Sat Sep 17 00:09:25 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fe80000 (usable)
 BIOS-e820: 000000007fe80000 - 000000007fe89000 (ACPI data)
 BIOS-e820: 000000007fe89000 - 000000007ff00000 (ACPI NVS)
 BIOS-e820: 000000007ff00000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
1150MB HIGHMEM available.
896MB LOWMEM available.
DMI present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfec20000] gsi_base[24])
IOAPIC[1]: apic_id 2, version 32, address 0xfec20000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 2 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0x0
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:60000000)
Built 1 zonelists
Kernel command line: root=/dev/ram0 lvm2root=/dev/vg0/root console=ttyS0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1995.367 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2069032k/2095616k available (3582k kernel code, 25336k reserved, 1602k data, 216k init, 1178112k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3997.42 BogoMIPS (lpj=7994840)
Mount-cache hash table entries: 512
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 2107k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd6ce, last bus=8
PCI: Using MMCONFIG
ACPI: Subsystem revision 20050408
    ACPI-0362: *** Error: Looking up [Z00G] in namespace, AE_NOT_FOUND
search_node dfdc7140 start_node dfdc7140 return_node 00000000
    ACPI-0362: *** Error: Looking up [Z00G] in namespace, AE_NOT_FOUND
search_node dfdc7d80 start_node dfdc7d80 return_node 00000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 29)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.2
PCI: Cannot allocate resource region 7 of bridge 0000:02:00.0
PCI: Cannot allocate resource region 8 of bridge 0000:02:00.0
PCI: Cannot allocate resource region 4 of device 0000:03:02.0
PCI: Cannot allocate resource region 4 of device 0000:03:02.1
PCI: Cannot allocate resource region 0 of device 0000:03:02.2
PCI: Cannot allocate resource region 4 of device 0000:03:03.0
PCI: Cannot allocate resource region 4 of device 0000:03:03.1
PCI: Cannot allocate resource region 0 of device 0000:03:03.2
PCI: Cannot allocate resource region 0 of device 0000:03:04.0
PCI: Cannot allocate resource region 1 of device 0000:03:04.0
PCI: Cannot allocate resource region 0 of device 0000:03:05.0
PCI: Cannot allocate resource region 0 of device 0000:03:06.0
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: c8100000-c81fffff
  PREFETCH window: d0000000-d7ffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 4, cardbus bridge: 0000:03:05.0
  IO window: 00003000-00003fff
  IO window: 00004000-00004fff
  PREFETCH window: 80000000-81ffffff
  MEM window: 84000000-85ffffff
PCI: Bridge: 0000:02:00.0
  IO window: 3000-5fff
  MEM window: 84000000-86ffffff
  PREFETCH window: 80000000-81ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 3000-5fff
  MEM window: 84000000-86ffffff
  PREFETCH window: 80000000-81ffffff
PCI: Bus 7, cardbus bridge: 0000:06:09.0
  IO window: 00006000-00006fff
  IO window: 00007000-00007fff
  PREFETCH window: 82000000-83ffffff
  MEM window: 88000000-89ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 6000-7fff
  MEM window: c8400000-c84fffff
  PREFETCH window: 82000000-83ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Device 0000:00:1c.0 not available because of resource collisions
PCI: Device 0000:00:1c.1 not available because of resource collisions
PCI: Enabling device 0000:00:1c.2 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 31 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 17
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1126916686.848:1): initialized
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.23 [Flags: R/O].
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
assign_interrupt_mode Found MSI capability
PCI: Device 0000:00:1c.0 not available because of resource collisions
PCI: Device 0000:00:1c.1 not available because of resource collisions
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 17
assign_interrupt_mode Found MSI capability
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (57 C)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 32 (level, low) -> IRQ 19
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
tg3.c:v3.37 (August 25, 2005)
ACPI: PCI Interrupt 0000:06:06.0[A] -> GSI 16 (level, low) -> IRQ 16
eth0: Tigon3 [partno(BCM95788A50) rev 3003 PHY(5705)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:c0:9f:75:57:33
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[0] TSOcap[1] 
eth0: dma_rwctrl[763f0000]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6M: IDE controller at PCI slot 0000:00:1f.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 20
ICH6M: chipset revision 4
ICH6M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x18a0-0x18a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x18a8-0x18af, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK1032GAX, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST DVDRAM GMA-4080N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 195371568 sectors (100030 MB), CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 30 (level, low) -> IRQ 21
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[86005000-860057ff]  Max Packet=[2048]
ACPI: PCI Interrupt 0000:06:07.0[A] -> GSI 19 (level, low) -> IRQ 20
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=[c8415000-c84157ff]  Max Packet=[2048]
ieee1394: raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 31 (level, low) -> IRQ 18
Yenta: CardBus bridge found at 0000:03:05.0 [104c:ac50]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:03:05.0, mfunc 0x00521d22, devctl 0x66
Yenta: ISA IRQ mask 0x0000, PCI irq 18
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x3000 - 0x5fff
pcmcia: parent PCI bridge Memory window: 0x84000000 - 0x86ffffff
pcmcia: parent PCI bridge Memory window: 0x80000000 - 0x81ffffff
ACPI: PCI Interrupt 0000:06:09.0[A] -> GSI 18 (level, low) -> IRQ 17
Yenta: CardBus bridge found at 0000:06:09.0 [1025:0070]
Yenta O2: res at 0x94/0xD4: ff/00
Yenta O2: enabling read prefetch/write burst
Yenta: ISA IRQ mask 0x0438, PCI irq 17
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x6000 - 0x7fff
pcmcia: parent PCI bridge Memory window: 0xc8400000 - 0xc84fffff
pcmcia: parent PCI bridge Memory window: 0x82000000 - 0x83ffffff

--Boundary-00=_w49LDR2AmqTrDKB
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="slow2614rc1.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="slow2614rc1.log"

AExpbnV4IHZlcnNpb24gMi42LjE0LXJjMSAocm9vdEBtZW5lbGRvcikgKGdjYyB2ZXJzaW9uIDMu
My42IChHZW50b28gMy4zLjYsIHNzcC0zLjMuNi0xLjAsIHBpZS04LjcuOCkpICMxIFNhdCBTZXAg
MTcgMDE6MzA6MDMgQ0VTVCAyMDA1CkJJT1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1hcDoKIEJJ
T1MtZTgyMDogMDAwMDAwMDAwMDAwMDAwMCAtIDAwMDAwMDAwMDAwOWY4MDAgKHVzYWJsZSkKIEJJ
T1MtZTgyMDogMDAwMDAwMDAwMDA5ZjgwMCAtIDAwMDAwMDAwMDAwYTAwMDAgKHJlc2VydmVkKQog
QklPUy1lODIwOiAwMDAwMDAwMDAwMGNlMDAwIC0gMDAwMDAwMDAwMDBkMDAwMCAocmVzZXJ2ZWQp
CiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAwZTAwMDAgLSAwMDAwMDAwMDAwMTAwMDAwIChyZXNlcnZl
ZCkKIEJJT1MtZTgyMDogMDAwMDAwMDAwMDEwMDAwMCAtIDAwMDAwMDAwN2ZlODAwMDAgKHVzYWJs
ZSkKIEJJT1MtZTgyMDogMDAwMDAwMDA3ZmU4MDAwMCAtIDAwMDAwMDAwN2ZlODkwMDAgKEFDUEkg
ZGF0YSkKIEJJT1MtZTgyMDogMDAwMDAwMDA3ZmU4OTAwMCAtIDAwMDAwMDAwN2ZmMDAwMDAgKEFD
UEkgTlZTKQogQklPUy1lODIwOiAwMDAwMDAwMDdmZjAwMDAwIC0gMDAwMDAwMDA4MDAwMDAwMCAo
cmVzZXJ2ZWQpCiBCSU9TLWU4MjA6IDAwMDAwMDAwZTAwMDAwMDAgLSAwMDAwMDAwMGYwMDA2MDAw
IChyZXNlcnZlZCkKIEJJT1MtZTgyMDogMDAwMDAwMDBmMDAwODAwMCAtIDAwMDAwMDAwZjAwMGMw
MDAgKHJlc2VydmVkKQogQklPUy1lODIwOiAwMDAwMDAwMGZlZDIwMDAwIC0gMDAwMDAwMDBmZWQ5
MDAwMCAocmVzZXJ2ZWQpCiBCSU9TLWU4MjA6IDAwMDAwMDAwZmYwMDAwMDAgLSAwMDAwMDAwMTAw
MDAwMDAwIChyZXNlcnZlZCkKMTE1ME1CIEhJR0hNRU0gYXZhaWxhYmxlLgo4OTZNQiBMT1dNRU0g
YXZhaWxhYmxlLgpETUkgcHJlc2VudC4KQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwMF0gbGFwaWNf
aWRbMHgwMF0gZW5hYmxlZCkKUHJvY2Vzc29yICMwIDY6MTMgQVBJQyB2ZXJzaW9uIDIwCkFDUEk6
IExBUElDX05NSSAoYWNwaV9pZFsweDAwXSBoaWdoIGVkZ2UgbGludFsweDFdKQpBQ1BJOiBJT0FQ
SUMgKGlkWzB4MDFdIGFkZHJlc3NbMHhmZWMwMDAwMF0gZ3NpX2Jhc2VbMF0pCklPQVBJQ1swXTog
YXBpY19pZCAxLCB2ZXJzaW9uIDMyLCBhZGRyZXNzIDB4ZmVjMDAwMDAsIEdTSSAwLTIzCkFDUEk6
IElPQVBJQyAoaWRbMHgwMl0gYWRkcmVzc1sweGZlYzIwMDAwXSBnc2lfYmFzZVsyNF0pCklPQVBJ
Q1sxXTogYXBpY19pZCAyLCB2ZXJzaW9uIDMyLCBhZGRyZXNzIDB4ZmVjMjAwMDAsIEdTSSAyNC00
NwpBQ1BJOiBJTlRfU1JDX09WUiAoYnVzIDAgYnVzX2lycSAwIGdsb2JhbF9pcnEgMiBkZmwgZGZs
KQpBQ1BJOiBJTlRfU1JDX09WUiAoYnVzIDAgYnVzX2lycSA5IGdsb2JhbF9pcnEgOSBoaWdoIGxl
dmVsKQpFbmFibGluZyBBUElDIG1vZGU6ICBGbGF0LiAgVXNpbmcgMiBJL08gQVBJQ3MKQUNQSTog
SFBFVCBpZDogMHg4MDg2YTIwMSBiYXNlOiAweDAKVXNpbmcgQUNQSSAoTUFEVCkgZm9yIFNNUCBj
b25maWd1cmF0aW9uIGluZm9ybWF0aW9uCkFsbG9jYXRpbmcgUENJIHJlc291cmNlcyBzdGFydGlu
ZyBhdCA4ODAwMDAwMCAoZ2FwOiA4MDAwMDAwMDo2MDAwMDAwMCkKQnVpbHQgMSB6b25lbGlzdHMK
S2VybmVsIGNvbW1hbmQgbGluZTogcm9vdD0vZGV2L3JhbTAgbHZtMnJvb3Q9L2Rldi92ZzAvcm9v
dCBjb25zb2xlPXR0eVMwCkluaXRpYWxpemluZyBDUFUjMApQSUQgaGFzaCB0YWJsZSBlbnRyaWVz
OiA0MDk2IChvcmRlcjogMTIsIDY1NTM2IGJ5dGVzKQpEZXRlY3RlZCAxOTk1LjM2NiBNSHogcHJv
Y2Vzc29yLgpVc2luZyB0c2MgZm9yIGhpZ2gtcmVzIHRpbWVzb3VyY2UKQ29uc29sZTogY29sb3Vy
IFZHQSsgODB4MjUKRGVudHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTMxMDcyIChvcmRl
cjogNywgNTI0Mjg4IGJ5dGVzKQpJbm9kZS1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2
IChvcmRlcjogNiwgMjYyMTQ0IGJ5dGVzKQpNZW1vcnk6IDIwNjkyOTJrLzIwOTU2MTZrIGF2YWls
YWJsZSAoMzYwOGsga2VybmVsIGNvZGUsIDI1MDc2ayByZXNlcnZlZCwgMTM4MmsgZGF0YSwgMjIw
ayBpbml0LCAxMTc4MTEyayBoaWdobWVtKQpDaGVja2luZyBpZiB0aGlzIHByb2Nlc3NvciBob25v
dXJzIHRoZSBXUCBiaXQgZXZlbiBpbiBzdXBlcnZpc29yIG1vZGUuLi4gT2suCkNhbGlicmF0aW5n
IGRlbGF5IHVzaW5nIHRpbWVyIHNwZWNpZmljIHJvdXRpbmUuLiAzOTk3LjQzIEJvZ29NSVBTIChs
cGo9Nzk5NDg2MSkKTW91bnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIKQ1BVOiBMMSBJ
IGNhY2hlOiAzMkssIEwxIEQgY2FjaGU6IDMySwpDUFU6IEwyIGNhY2hlOiAyMDQ4SwpJbnRlbCBt
YWNoaW5lIGNoZWNrIGFyY2hpdGVjdHVyZSBzdXBwb3J0ZWQuCkludGVsIG1hY2hpbmUgY2hlY2sg
cmVwb3J0aW5nIGVuYWJsZWQgb24gQ1BVIzAuCm10cnI6IHYyLjAgKDIwMDIwNTE5KQpDUFU6IElu
dGVsKFIpIFBlbnRpdW0oUikgTSBwcm9jZXNzb3IgMi4wMEdIeiBzdGVwcGluZyAwOApFbmFibGlu
ZyBmYXN0IEZQVSBzYXZlIGFuZCByZXN0b3JlLi4uIGRvbmUuCkVuYWJsaW5nIHVubWFza2VkIFNJ
TUQgRlBVIGV4Y2VwdGlvbiBzdXBwb3J0Li4uIGRvbmUuCkNoZWNraW5nICdobHQnIGluc3RydWN0
aW9uLi4uIE9LLgpFTkFCTElORyBJTy1BUElDIElSUXMKLi5USU1FUjogdmVjdG9yPTB4MzEgcGlu
MT0yIHBpbjI9LTEKY2hlY2tpbmcgaWYgaW1hZ2UgaXMgaW5pdHJhbWZzLi4uc29mdGxvY2t1cCB0
aHJlYWQgMCBzdGFydGVkIHVwLgppdCBpc24ndCAobm8gY3BpbyBtYWdpYyk7IGxvb2tzIGxpa2Ug
YW4gaW5pdHJkCkZyZWVpbmcgaW5pdHJkIG1lbW9yeTogMjEwN2sgZnJlZWQKTkVUOiBSZWdpc3Rl
cmVkIHByb3RvY29sIGZhbWlseSAxNgpBQ1BJOiBidXMgdHlwZSBwY2kgcmVnaXN0ZXJlZApQQ0k6
IFBDSSBCSU9TIHJldmlzaW9uIDIuMTAgZW50cnkgYXQgMHhmZDZjZSwgbGFzdCBidXM9OApQQ0k6
IFVzaW5nIE1NQ09ORklHCkFDUEk6IFN1YnN5c3RlbSByZXZpc2lvbiAyMDA1MDkwMgogICAgQUNQ
SS0wMzM5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW1owMEddIGluIG5hbWVzcGFjZSwgQUVfTk9U
X0ZPVU5ECnNlYXJjaF9ub2RlIGRmZGNhYTgwIHN0YXJ0X25vZGUgZGZkY2FhODAgcmV0dXJuX25v
ZGUgMDAwMDAwMDAKICAgIEFDUEktMDMzOTogKioqIEVycm9yOiBMb29raW5nIHVwIFtaMDBHXSBp
biBuYW1lc3BhY2UsIEFFX05PVF9GT1VORApzZWFyY2hfbm9kZSBkZmRjYjdlMCBzdGFydF9ub2Rl
IGRmZGNiN2UwIHJldHVybl9ub2RlIDAwMDAwMDAwCkFDUEk6IEludGVycHJldGVyIGVuYWJsZWQK
QUNQSTogVXNpbmcgSU9BUElDIGZvciBpbnRlcnJ1cHQgcm91dGluZwpBQ1BJOiBQQ0kgUm9vdCBC
cmlkZ2UgW1BDSTBdICgwMDAwOjAwKQpQQ0k6IFByb2JpbmcgUENJIGhhcmR3YXJlIChidXMgMDAp
ClBDSTogSWdub3JpbmcgQkFSMC0zIG9mIElERSBjb250cm9sbGVyIDAwMDA6MDA6MWYuMgpQQ0k6
IFBYSCBxdWlyayBkZXRlY3RlZCwgZGlzYWJsaW5nIE1TSSBmb3IgU0hQQyBkZXZpY2UKUENJOiBU
cmFuc3BhcmVudCBicmlkZ2UgLSAwMDAwOjAwOjFlLjAKQUNQSTogUENJIEludGVycnVwdCBMaW5r
IFtMTktBXSAoSVJRcyAxIDMgNCA1IDYgNyAqMTAgMTIgMTQgMTUpCkFDUEk6IFBDSSBJbnRlcnJ1
cHQgTGluayBbTE5LQl0gKElSUXMgMSAzIDQgNSA2IDcgMTEgMTIgMTQgMTUpICoxMApBQ1BJOiBQ
Q0kgSW50ZXJydXB0IExpbmsgW0xOS0NdIChJUlFzIDEgMyA0IDUgNiA3IDEwIDEyIDE0IDE1KSAq
MTEKQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktEXSAoSVJRcyAxIDMgNCA1IDYgNyAqMTEg
MTIgMTQgMTUpCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LRV0gKElSUXMgMSAzIDQgNSA2
IDcgMTAgMTIgMTQgMTUpICoxMQpBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0ZdIChJUlFz
IDEgMyA0IDUgNiA3IDExIDEyIDE0IDE1KSAqMCwgZGlzYWJsZWQuCkFDUEk6IFBDSSBJbnRlcnJ1
cHQgTGluayBbTE5LR10gKElSUXMgMSAzIDQgNSA2IDcgMTAgMTIgMTQgMTUpICowLCBkaXNhYmxl
ZC4KQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktIXSAoSVJRcyAxIDMgNCA1IDYgNyAqMTEg
MTIgMTQgMTUpCkFDUEk6IEVtYmVkZGVkIENvbnRyb2xsZXIgW0VDMF0gKGdwZSAyOSkKTGludXgg
UGx1ZyBhbmQgUGxheSBTdXBwb3J0IHYwLjk3IChjKSBBZGFtIEJlbGF5CnBucDogUG5QIEFDUEkg
aW5pdApwbnA6IFBuUCBBQ1BJOiBmb3VuZCAxMiBkZXZpY2VzClNDU0kgc3Vic3lzdGVtIGluaXRp
YWxpemVkCnVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGRyaXZlciB1c2Jmcwp1c2Jjb3JlOiByZWdp
c3RlcmVkIG5ldyBkcml2ZXIgaHViClBDSTogVXNpbmcgQUNQSSBmb3IgSVJRIHJvdXRpbmcKUENJ
OiBJZiBhIGRldmljZSBkb2Vzbid0IHdvcmssIHRyeSAicGNpPXJvdXRlaXJxIi4gIElmIGl0IGhl
bHBzLCBwb3N0IGEgcmVwb3J0ClBDSTogQ2Fubm90IGFsbG9jYXRlIHJlc291cmNlIHJlZ2lvbiA3
IG9mIGJyaWRnZSAwMDAwOjAwOjFjLjAKUENJOiBDYW5ub3QgYWxsb2NhdGUgcmVzb3VyY2UgcmVn
aW9uIDggb2YgYnJpZGdlIDAwMDA6MDA6MWMuMApQQ0k6IENhbm5vdCBhbGxvY2F0ZSByZXNvdXJj
ZSByZWdpb24gOSBvZiBicmlkZ2UgMDAwMDowMDoxYy4wClBDSTogQ2Fubm90IGFsbG9jYXRlIHJl
c291cmNlIHJlZ2lvbiA3IG9mIGJyaWRnZSAwMDAwOjAwOjFjLjEKUENJOiBDYW5ub3QgYWxsb2Nh
dGUgcmVzb3VyY2UgcmVnaW9uIDggb2YgYnJpZGdlIDAwMDA6MDA6MWMuMQpQQ0k6IENhbm5vdCBh
bGxvY2F0ZSByZXNvdXJjZSByZWdpb24gOSBvZiBicmlkZ2UgMDAwMDowMDoxYy4xClBDSTogQ2Fu
bm90IGFsbG9jYXRlIHJlc291cmNlIHJlZ2lvbiA3IG9mIGJyaWRnZSAwMDAwOjAwOjFjLjIKUENJ
OiBDYW5ub3QgYWxsb2NhdGUgcmVzb3VyY2UgcmVnaW9uIDggb2YgYnJpZGdlIDAwMDA6MDA6MWMu
MgpQQ0k6IENhbm5vdCBhbGxvY2F0ZSByZXNvdXJjZSByZWdpb24gOSBvZiBicmlkZ2UgMDAwMDow
MDoxYy4yClBDSTogQ2Fubm90IGFsbG9jYXRlIHJlc291cmNlIHJlZ2lvbiA3IG9mIGJyaWRnZSAw
MDAwOjAyOjAwLjAKUENJOiBDYW5ub3QgYWxsb2NhdGUgcmVzb3VyY2UgcmVnaW9uIDggb2YgYnJp
ZGdlIDAwMDA6MDI6MDAuMApQQ0k6IENhbm5vdCBhbGxvY2F0ZSByZXNvdXJjZSByZWdpb24gNCBv
ZiBkZXZpY2UgMDAwMDowMzowMi4wClBDSTogQ2Fubm90IGFsbG9jYXRlIHJlc291cmNlIHJlZ2lv
biA0IG9mIGRldmljZSAwMDAwOjAzOjAyLjEKUENJOiBDYW5ub3QgYWxsb2NhdGUgcmVzb3VyY2Ug
cmVnaW9uIDAgb2YgZGV2aWNlIDAwMDA6MDM6MDIuMgpQQ0k6IENhbm5vdCBhbGxvY2F0ZSByZXNv
dXJjZSByZWdpb24gNCBvZiBkZXZpY2UgMDAwMDowMzowMy4wClBDSTogQ2Fubm90IGFsbG9jYXRl
IHJlc291cmNlIHJlZ2lvbiA0IG9mIGRldmljZSAwMDAwOjAzOjAzLjEKUENJOiBDYW5ub3QgYWxs
b2NhdGUgcmVzb3VyY2UgcmVnaW9uIDAgb2YgZGV2aWNlIDAwMDA6MDM6MDMuMgpQQ0k6IENhbm5v
dCBhbGxvY2F0ZSByZXNvdXJjZSByZWdpb24gMCBvZiBkZXZpY2UgMDAwMDowMzowNC4wClBDSTog
Q2Fubm90IGFsbG9jYXRlIHJlc291cmNlIHJlZ2lvbiAxIG9mIGRldmljZSAwMDAwOjAzOjA0LjAK
UENJOiBDYW5ub3QgYWxsb2NhdGUgcmVzb3VyY2UgcmVnaW9uIDAgb2YgZGV2aWNlIDAwMDA6MDM6
MDUuMApQQ0k6IENhbm5vdCBhbGxvY2F0ZSByZXNvdXJjZSByZWdpb24gMCBvZiBkZXZpY2UgMDAw
MDowMzowNi4wClBDSTogQnJpZGdlOiAwMDAwOjAwOjAxLjAKICBJTyB3aW5kb3c6IDIwMDAtMmZm
ZgogIE1FTSB3aW5kb3c6IGM4MTAwMDAwLWM4MWZmZmZmCiAgUFJFRkVUQ0ggd2luZG93OiBkMDAw
MDAwMC1kN2ZmZmZmZgpQQ0k6IEJyaWRnZTogMDAwMDowMDoxYy4wCiAgSU8gd2luZG93OiBkaXNh
YmxlZC4KICBNRU0gd2luZG93OiBkaXNhYmxlZC4KICBQUkVGRVRDSCB3aW5kb3c6IGRpc2FibGVk
LgpQQ0k6IEJyaWRnZTogMDAwMDowMDoxYy4xCiAgSU8gd2luZG93OiBkaXNhYmxlZC4KICBNRU0g
d2luZG93OiBkaXNhYmxlZC4KICBQUkVGRVRDSCB3aW5kb3c6IGRpc2FibGVkLgpQQ0k6IEJ1cyA0
LCBjYXJkYnVzIGJyaWRnZTogMDAwMDowMzowNS4wCiAgSU8gd2luZG93OiAwMDAwMzAwMC0wMDAw
M2ZmZgogIElPIHdpbmRvdzogMDAwMDQwMDAtMDAwMDRmZmYKICBQUkVGRVRDSCB3aW5kb3c6IDg4
MDAwMDAwLTg5ZmZmZmZmCiAgTUVNIHdpbmRvdzogOGMwMDAwMDAtOGRmZmZmZmYKUENJOiBCcmlk
Z2U6IDAwMDA6MDI6MDAuMAogIElPIHdpbmRvdzogMzAwMC01ZmZmCiAgTUVNIHdpbmRvdzogOGMw
MDAwMDAtOGVmZmZmZmYKICBQUkVGRVRDSCB3aW5kb3c6IDg4MDAwMDAwLTg5ZmZmZmZmClBDSTog
QnJpZGdlOiAwMDAwOjAwOjFjLjIKICBJTyB3aW5kb3c6IDMwMDAtNWZmZgogIE1FTSB3aW5kb3c6
IDhjMDAwMDAwLThlZmZmZmZmCiAgUFJFRkVUQ0ggd2luZG93OiA4ODAwMDAwMC04OWZmZmZmZgpQ
Q0k6IEJ1cyA3LCBjYXJkYnVzIGJyaWRnZTogMDAwMDowNjowOS4wCiAgSU8gd2luZG93OiAwMDAw
NjAwMC0wMDAwNmZmZgogIElPIHdpbmRvdzogMDAwMDcwMDAtMDAwMDdmZmYKICBQUkVGRVRDSCB3
aW5kb3c6IDhhMDAwMDAwLThiZmZmZmZmCiAgTUVNIHdpbmRvdzogOTAwMDAwMDAtOTFmZmZmZmYK
UENJOiBCcmlkZ2U6IDAwMDA6MDA6MWUuMAogIElPIHdpbmRvdzogNjAwMC03ZmZmCiAgTUVNIHdp
bmRvdzogYzg0MDAwMDAtYzg0ZmZmZmYKICBQUkVGRVRDSCB3aW5kb3c6IDhhMDAwMDAwLThiZmZm
ZmZmCkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDowMS4wW0FdIC0+IEdTSSAxNiAobGV2ZWws
IGxvdykgLT4gSVJRIDE2ClBDSTogRGV2aWNlIDAwMDA6MDA6MWMuMCBub3QgYXZhaWxhYmxlIGJl
Y2F1c2Ugb2YgcmVzb3VyY2UgY29sbGlzaW9ucwpQQ0k6IERldmljZSAwMDAwOjAwOjFjLjEgbm90
IGF2YWlsYWJsZSBiZWNhdXNlIG9mIHJlc291cmNlIGNvbGxpc2lvbnMKUENJOiBFbmFibGluZyBk
ZXZpY2UgMDAwMDowMDoxYy4yICgwMDAwIC0+IDAwMDMpCkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAw
MDowMDoxYy4yW0NdIC0+IEdTSSAxOCAobGV2ZWwsIGxvdykgLT4gSVJRIDE3CkFDUEk6IFBDSSBJ
bnRlcnJ1cHQgMDAwMDowMzowNS4wW0FdIC0+IEdTSSAzMSAobGV2ZWwsIGxvdykgLT4gSVJRIDE4
CkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowNjowOS4wW0FdIC0+IEdTSSAxOCAobGV2ZWwsIGxv
dykgLT4gSVJRIDE3ClNpbXBsZSBCb290IEZsYWcgYXQgMHgzNiBzZXQgdG8gMHgxCk1hY2hpbmUg
Y2hlY2sgZXhjZXB0aW9uIHBvbGxpbmcgdGltZXIgc3RhcnRlZC4KYXVkaXQ6IGluaXRpYWxpemlu
ZyBuZXRsaW5rIHNvY2tldCAoZGlzYWJsZWQpCmF1ZGl0KDExMjY5MjA3MTcuNDQ4OjEpOiBpbml0
aWFsaXplZApoaWdobWVtIGJvdW5jZSBwb29sIHNpemU6IDY0IHBhZ2VzCkluc3RhbGxpbmcga25m
c2QgKGNvcHlyaWdodCAoQykgMTk5NiBva2lyQG1vbmFkLnN3Yi5kZSkuCk5URlMgZHJpdmVyIDIu
MS4yNCBbRmxhZ3M6IFIvT10uCkluaXRpYWxpemluZyBDcnlwdG9ncmFwaGljIEFQSQpwY2lfaG90
cGx1ZzogUENJIEhvdCBQbHVnIFBDSSBDb3JlIHZlcnNpb246IDAuNQphY3BpcGhwOiBBQ1BJIEhv
dCBQbHVnIFBDSSBDb250cm9sbGVyIERyaXZlciB2ZXJzaW9uOiAwLjUKcGNpZWhwOiBhZGRfaG9z
dF9icmlkZ2U6IHN0YXR1cyA1CnBjaWVocDogRmFpbHMgdG8gZ2FpbiBjb250cm9sIG9mIG5hdGl2
ZSBob3QtcGx1ZwpzaHBjaHA6IHNocGNfaW5pdCA6IHNocGNfY2FwX29mZnNldCA9PSAwCnNocGNo
cDogc2hwY19pbml0IDogc2hwY19jYXBfb2Zmc2V0ID09IDAKc2hwY2hwOiBzaHBjX2luaXQgOiBz
aHBjX2NhcF9vZmZzZXQgPT0gMApzaHBjaHA6IHNocGNfaW5pdCA6IHNocGNfY2FwX29mZnNldCA9
PSAwCnNocGNocDogc2hwY19pbml0IDogc2hwY19jYXBfb2Zmc2V0ID09IDAKc2hwY2hwOiBTdGFu
ZGFyZCBIb3QgUGx1ZyBQQ0kgQ29udHJvbGxlciBEcml2ZXIgdmVyc2lvbjogMC40CkFDUEk6IFBD
SSBJbnRlcnJ1cHQgMDAwMDowMDowMS4wW0FdIC0+IEdTSSAxNiAobGV2ZWwsIGxvdykgLT4gSVJR
IDE2CmFzc2lnbl9pbnRlcnJ1cHRfbW9kZSBGb3VuZCBNU0kgY2FwYWJpbGl0eQpQQ0k6IERldmlj
ZSAwMDAwOjAwOjFjLjAgbm90IGF2YWlsYWJsZSBiZWNhdXNlIG9mIHJlc291cmNlIGNvbGxpc2lv
bnMKUENJOiBEZXZpY2UgMDAwMDowMDoxYy4xIG5vdCBhdmFpbGFibGUgYmVjYXVzZSBvZiByZXNv
dXJjZSBjb2xsaXNpb25zCkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDoxYy4yW0NdIC0+IEdT
SSAxOCAobGV2ZWwsIGxvdykgLT4gSVJRIDE3CmFzc2lnbl9pbnRlcnJ1cHRfbW9kZSBGb3VuZCBN
U0kgY2FwYWJpbGl0eQpBQ1BJOiBBQyBBZGFwdGVyIFtBQ0FEXSAob24tbGluZSkKQUNQSTogQmF0
dGVyeSBTbG90IFtCQVQxXSAoYmF0dGVyeSBhYnNlbnQpCkFDUEk6IEJhdHRlcnkgU2xvdCBbQkFU
Ml0gKGJhdHRlcnkgYWJzZW50KQpBQ1BJOiBQb3dlciBCdXR0b24gKEZGKSBbUFdSRl0KQUNQSTog
TGlkIFN3aXRjaCBbTElEXQpBQ1BJOiBQb3dlciBCdXR0b24gKENNKSBbUFdSQl0KQUNQSTogU2xl
ZXAgQnV0dG9uIChDTSkgW1NMUEJdCkFDUEk6IFZpZGVvIERldmljZSBbVkdBXSAobXVsdGktaGVh
ZDogeWVzICByb206IG5vICBwb3N0OiBubykKQUNQSTogQ1BVMCAocG93ZXIgc3RhdGVzOiBDMVtD
MV0gQzJbQzJdKQpBQ1BJOiBQcm9jZXNzb3IgW0NQVTBdIChzdXBwb3J0cyA4IHRocm90dGxpbmcg
c3RhdGVzKQpBQ1BJOiBUaGVybWFsIFpvbmUgW1RIUk1dICg2MCBDKQpscDogZHJpdmVyIGxvYWRl
ZCBidXQgbm8gZGV2aWNlcyBmb3VuZApSZWFsIFRpbWUgQ2xvY2sgRHJpdmVyIHYxLjEyCkxpbnV4
IGFncGdhcnQgaW50ZXJmYWNlIHYwLjEwMSAoYykgRGF2ZSBKb25lcwpQTlA6IFBTLzIgQ29udHJv
bGxlciBbUE5QMDMwMzpQUzJLLFBOUDBmMTM6UFMyTV0gYXQgMHg2MCwweDY0IGlycSAxLDEyCmk4
MDQyLmM6IERldGVjdGVkIGFjdGl2ZSBtdWx0aXBsZXhpbmcgY29udHJvbGxlciwgcmV2IDEuMS4K
c2VyaW86IGk4MDQyIEFVWDAgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEyCnNlcmlvOiBpODA0MiBB
VVgxIHBvcnQgYXQgMHg2MCwweDY0IGlycSAxMgpzZXJpbzogaTgwNDIgQVVYMiBwb3J0IGF0IDB4
NjAsMHg2NCBpcnEgMTIKc2VyaW86IGk4MDQyIEFVWDMgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEy
CnNlcmlvOiBpODA0MiBLQkQgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEKU2VyaWFsOiA4MjUwLzE2
NTUwIGRyaXZlciAkUmV2aXNpb246IDEuOTAgJCA0IHBvcnRzLCBJUlEgc2hhcmluZyBkaXNhYmxl
ZAp0dHlTMCBhdCBJL08gMHgzZjggKGlycSA9IDQpIGlzIGEgMTY1NTBBCnR0eVMxIGF0IEkvTyAw
eDJmOCAoaXJxID0gMykgaXMgYSBOUzE2NTUwQQp0dHlTMCBhdCBJL08gMHgzZjggKGlycSA9IDQp
IGlzIGEgMTY1NTBBCkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMzowNi4wW0FdIC0+IEdTSSAz
MiAobGV2ZWwsIGxvdykgLT4gSVJRIDE5CnBhcnBvcnQ6IFBuUEJJT1MgcGFycG9ydCBkZXRlY3Rl
ZC4KcGFycG9ydDA6IFBDLXN0eWxlIGF0IDB4Mzc4ICgweDc3OCksIGlycSA3IFtQQ1NQUCgsLi4u
KV0KbHAwOiB1c2luZyBwYXJwb3J0MCAoaW50ZXJydXB0LWRyaXZlbikuCmlvIHNjaGVkdWxlciBu
b29wIHJlZ2lzdGVyZWQKaW8gc2NoZWR1bGVyIGFudGljaXBhdG9yeSByZWdpc3RlcmVkCmlvIHNj
aGVkdWxlciBkZWFkbGluZSByZWdpc3RlcmVkCmlvIHNjaGVkdWxlciBjZnEgcmVnaXN0ZXJlZApS
QU1ESVNLIGRyaXZlciBpbml0aWFsaXplZDogMTYgUkFNIGRpc2tzIG9mIDgxOTJLIHNpemUgMTAy
NCBibG9ja3NpemUKbG9vcDogbG9hZGVkIChtYXggOCBkZXZpY2VzKQpwa3RjZHZkOiB2MC4yLjBh
IDIwMDQtMDctMTQgSmVucyBBeGJvZSAoYXhib2VAc3VzZS5kZSkgYW5kIHBldGVybzJAdGVsaWEu
Y29tCnRnMy5jOnYzLjM5IChTZXB0ZW1iZXIgNSwgMjAwNSkKQUNQSTogUENJIEludGVycnVwdCAw
MDAwOjA2OjA2LjBbQV0gLT4gR1NJIDE2IChsZXZlbCwgbG93KSAtPiBJUlEgMTYKZXRoMDogVGln
b24zIFtwYXJ0bm8oQkNNOTU3ODhBNTApIHJldiAzMDAzIFBIWSg1NzA1KV0gKFBDSTozM01Iejoz
Mi1iaXQpIDEwLzEwMC8xMDAwQmFzZVQgRXRoZXJuZXQgMDA6YzA6OWY6NzU6NTc6MzMKZXRoMDog
Ulhjc3Vtc1sxXSBMaW5rQ2hnUkVHWzBdIE1JaXJxWzBdIEFTRlswXSBTcGxpdFswXSBXaXJlU3Bl
ZWRbMF0gVFNPY2FwWzFdIApldGgwOiBkbWFfcndjdHJsWzc2M2YwMDAwXQpVbmlmb3JtIE11bHRp
LVBsYXRmb3JtIEUtSURFIGRyaXZlciBSZXZpc2lvbjogNy4wMGFscGhhMgppZGU6IEFzc3VtaW5n
IDMzTUh6IHN5c3RlbSBidXMgc3BlZWQgZm9yIFBJTyBtb2Rlczsgb3ZlcnJpZGUgd2l0aCBpZGVi
dXM9eHgKSUNINk06IElERSBjb250cm9sbGVyIGF0IFBDSSBzbG90IDAwMDA6MDA6MWYuMgpBQ1BJ
OiBQQ0kgSW50ZXJydXB0IDAwMDA6MDA6MWYuMltCXSAtPiBHU0kgMTkgKGxldmVsLCBsb3cpIC0+
IElSUSAyMApJQ0g2TTogY2hpcHNldCByZXZpc2lvbiA0CklDSDZNOiBub3QgMTAwJSBuYXRpdmUg
bW9kZTogd2lsbCBwcm9iZSBpcnFzIGxhdGVyCiAgICBpZGUwOiBCTS1ETUEgYXQgMHgxOGEwLTB4
MThhNywgQklPUyBzZXR0aW5nczogaGRhOkRNQSwgaGRiOnBpbwogICAgaWRlMTogQk0tRE1BIGF0
IDB4MThhOC0weDE4YWYsIEJJT1Mgc2V0dGluZ3M6IGhkYzpETUEsIGhkZDpwaW8KaGRhOiBUT1NI
SUJBIE1LMTAzMkdBWCwgQVRBIERJU0sgZHJpdmUKaWRlMCBhdCAweDFmMC0weDFmNywweDNmNiBv
biBpcnEgMTQKaGRjOiBITC1EVC1TVCBEVkRSQU0gR01BLTQwODBOLCBBVEFQSSBDRC9EVkQtUk9N
IGRyaXZlCmlkZTEgYXQgMHgxNzAtMHgxNzcsMHgzNzYgb24gaXJxIDE1CmhkYTogbWF4IHJlcXVl
c3Qgc2l6ZTogMTAyNEtpQgpoZGE6IDE5NTM3MTU2OCBzZWN0b3JzICgxMDAwMzAgTUIpLCBDSFM9
MTYzODMvMjU1LzYzLCBVRE1BKDEwMCkKaGRhOiBjYWNoZSBmbHVzaGVzIHN1cHBvcnRlZAogaGRh
OiBoZGExIGhkYTIgaGRhMwpoZGM6IEFUQVBJIDI0WCBEVkQtUk9NIERWRC1SLVJBTSBDRC1SL1JX
IGRyaXZlLCAyMDQ4a0IgQ2FjaGUsIFVETUEoMzMpClVuaWZvcm0gQ0QtUk9NIGRyaXZlciBSZXZp
c2lvbjogMy4yMApvaGNpMTM5NDogJFJldjogMTI5OSAkIEJlbiBDb2xsaW5zIDxiY29sbGluc0Bk
ZWJpYW4ub3JnPgpBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDM6MDQuMFtBXSAtPiBHU0kgMzAg
KGxldmVsLCBsb3cpIC0+IElSUSAyMQpvaGNpMTM5NDogZnctaG9zdDA6IE9IQ0ktMTM5NCAxLjEg
KFBDSSk6IElSUT1bMjFdICBNTUlPPVs4ZTAwNTAwMC04ZTAwNTdmZl0gIE1heCBQYWNrZXQ9WzIw
NDhdCkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowNjowNy4wW0FdIC0+IEdTSSAxOSAobGV2ZWws
IGxvdykgLT4gSVJRIDIwCm9oY2kxMzk0OiBmdy1ob3N0MTogT0hDSS0xMzk0IDEuMSAoUENJKTog
SVJRPVsyMF0gIE1NSU89W2M4NDE1MDAwLWM4NDE1N2ZmXSAgTWF4IFBhY2tldD1bMjA0OF0KaWVl
ZTEzOTQ6IHJhdzEzOTQ6IC9kZXYvcmF3MTM5NCBkZXZpY2UgaW5pdGlhbGl6ZWQKc2JwMjogJFJl
djogMTMwNiAkIEJlbiBDb2xsaW5zIDxiY29sbGluc0BkZWJpYW4ub3JnPgpBQ1BJOiBQQ0kgSW50
ZXJydXB0IDAwMDA6MDM6MDUuMFtBXSAtPiBHU0kgMzEgKGxldmVsLCBsb3cpIC0+IElSUSAxOApZ
ZW50YTogQ2FyZEJ1cyBicmlkZ2UgZm91bmQgYXQgMDAwMDowMzowNS4wIFsxMDRjOmFjNTBdClll
bnRhOiBVc2luZyBDU0NJTlQgdG8gcm91dGUgQ1NDIGludGVycnVwdHMgdG8gUENJClllbnRhOiBS
b3V0aW5nIENhcmRCdXMgaW50ZXJydXB0cyB0byBQQ0kKWWVudGEgVEk6IHNvY2tldCAwMDAwOjAz
OjA1LjAsIG1mdW5jIDB4MDA1MjFkMjIsIGRldmN0bCAweDY2ClllbnRhOiBJU0EgSVJRIG1hc2sg
MHgwMDAwLCBQQ0kgaXJxIDE4ClNvY2tldCBzdGF0dXM6IDMwMDAwMDA2CnBjbWNpYTogcGFyZW50
IFBDSSBicmlkZ2UgSS9PIHdpbmRvdzogMHgzMDAwIC0gMHg1ZmZmCnBjbWNpYTogcGFyZW50IFBD
SSBicmlkZ2UgTWVtb3J5IHdpbmRvdzogMHg4YzAwMDAwMCAtIDB4OGVmZmZmZmYKcGNtY2lhOiBw
YXJlbnQgUENJIGJyaWRnZSBNZW1vcnkgd2luZG93OiAweDg4MDAwMDAwIC0gMHg4OWZmZmZmZgpB
Q1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDY6MDkuMFtBXSAtPiBHU0kgMTggKGxldmVsLCBsb3cp
IC0+IElSUSAxNwpZZW50YTogQ2FyZEJ1cyBicmlkZ2UgZm91bmQgYXQgMDAwMDowNjowOS4wIFsx
MDI1OjAwNzBdClllbnRhIE8yOiByZXMgYXQgMHg5NC8weEQ0OiBlYS8wMApZZW50YSBPMjogZW5h
YmxpbmcgcmVhZCBwcmVmZXRjaC93cml0ZSBidXJzdApZZW50YTogSVNBIElSUSBtYXNrIDB4MGMz
OCwgUENJIGlycSAxNwpTb2NrZXQgc3RhdHVzOiAzMDAwMDAwNgpwY21jaWE6IHBhcmVudCBQQ0kg
YnJpZGdlIEkvTyB3aW5kb3c6IDB4NjAwMCAtIDB4N2ZmZgpwY21jaWE6IHBhcmVudCBQQ0kgYnJp
ZGdlIE1lbW9yeSB3aW5kb3c6IDB4Yzg0MDAwMDAgLSAweGM4NGZmZmZmCnBjbWNpYTogcGFyZW50
IFBDSSBicmlkZ2UgTWVtb3J5IHdpbmRvdzogMHg4YTAwMDAwMCAtIDB4OGJmZmZmZmYKWWVudGE6
IG5vIGJ1cyBhc3NvY2lhdGVkIHdpdGggMDAwMDowNjowOS4xIQpZZW50YTogbm8gYnVzIGFzc29j
aWF0ZWQgd2l0aCAwMDAwOjA2OjA5LjMhCkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDoxZC43
W0FdIC0+IEdTSSAyMyAobGV2ZWwsIGxvdykgLT4gSVJRIDIyCmVoY2lfaGNkIDAwMDA6MDA6MWQu
NzogRUhDSSBIb3N0IENvbnRyb2xsZXIKZWhjaV9oY2QgMDAwMDowMDoxZC43OiBkZWJ1ZyBwb3J0
IDEKZWhjaV9oY2QgMDAwMDowMDoxZC43OiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25l
ZCBidXMgbnVtYmVyIDEKZWhjaV9oY2QgMDAwMDowMDoxZC43OiBpcnEgMjIsIGlvIG1lbSAweGM4
MDA0MDAwCmVoY2lfaGNkIDAwMDA6MDA6MWQuNzogVVNCIDIuMCBpbml0aWFsaXplZCwgRUhDSSAx
LjAwLCBkcml2ZXIgMTAgRGVjIDIwMDQKaHViIDEtMDoxLjA6IFVTQiBodWIgZm91bmQKaHViIDEt
MDoxLjA6IDggcG9ydHMgZGV0ZWN0ZWQKQUNQSTogUENJIEludGVycnVwdCAwMDAwOjAzOjAyLjJb
Q10gLT4gR1NJIDI2IChsZXZlbCwgbG93KSAtPiBJUlEgMjMKUENJOiBWaWEgSVJRIGZpeHVwIGZv
ciAwMDAwOjAzOjAyLjIsIGZyb20gMjU1IHRvIDcKZWhjaV9oY2QgMDAwMDowMzowMi4yOiBFSENJ
IEhvc3QgQ29udHJvbGxlcgplaGNpX2hjZCAwMDAwOjAzOjAyLjI6IG5ldyBVU0IgYnVzIHJlZ2lz
dGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1iZXIgMgplaGNpX2hjZCAwMDAwOjAzOjAyLjI6IGlycSAy
MywgaW8gbWVtIDB4OGUwMDU4MDAKZWhjaV9oY2QgMDAwMDowMzowMi4yOiBVU0IgMi4wIGluaXRp
YWxpemVkLCBFSENJIDEuMDAsIGRyaXZlciAxMCBEZWMgMjAwNApodWIgMi0wOjEuMDogVVNCIGh1
YiBmb3VuZApodWIgMi0wOjEuMDogNCBwb3J0cyBkZXRlY3RlZApBQ1BJOiBQQ0kgSW50ZXJydXB0
IDAwMDA6MDM6MDMuMltDXSAtPiBHU0kgMjkgKGxldmVsLCBsb3cpIC0+IElSUSAyNApQQ0k6IFZp
YSBJUlEgZml4dXAgZm9yIDAwMDA6MDM6MDMuMiwgZnJvbSAyNTUgdG8gOAplaGNpX2hjZCAwMDAw
OjAzOjAzLjI6IEVIQ0kgSG9zdCBDb250cm9sbGVyCmVoY2lfaGNkIDAwMDA6MDM6MDMuMjogbmV3
IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciAzCmVoY2lfaGNkIDAwMDA6
MDM6MDMuMjogaXJxIDI0LCBpbyBtZW0gMHg4ZTAwNTkwMAplaGNpX2hjZCAwMDAwOjAzOjAzLjI6
IFVTQiAyLjAgaW5pdGlhbGl6ZWQsIEVIQ0kgMS4wMCwgZHJpdmVyIDEwIERlYyAyMDA0Cmh1YiAz
LTA6MS4wOiBVU0IgaHViIGZvdW5kCmh1YiAzLTA6MS4wOiA0IHBvcnRzIGRldGVjdGVkClVTQiBV
bml2ZXJzYWwgSG9zdCBDb250cm9sbGVyIEludGVyZmFjZSBkcml2ZXIgdjIuMwpBQ1BJOiBQQ0kg
SW50ZXJydXB0IDAwMDA6MDA6MWQuMFtBXSAtPiBHU0kgMjMgKGxldmVsLCBsb3cpIC0+IElSUSAy
Mgp1aGNpX2hjZCAwMDAwOjAwOjFkLjA6IFVIQ0kgSG9zdCBDb250cm9sbGVyCnVoY2lfaGNkIDAw
MDA6MDA6MWQuMDogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciA0
CnVoY2lfaGNkIDAwMDA6MDA6MWQuMDogaXJxIDIyLCBpbyBiYXNlIDB4MDAwMDE4MDAKaHViIDQt
MDoxLjA6IFVTQiBodWIgZm91bmQKaHViIDQtMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQKQUNQSTog
UENJIEludGVycnVwdCAwMDAwOjAwOjFkLjFbQl0gLT4gR1NJIDE5IChsZXZlbCwgbG93KSAtPiBJ
UlEgMjAKdWhjaV9oY2QgMDAwMDowMDoxZC4xOiBVSENJIEhvc3QgQ29udHJvbGxlcgp1aGNpX2hj
ZCAwMDAwOjAwOjFkLjE6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1cyBudW1i
ZXIgNQp1aGNpX2hjZCAwMDAwOjAwOjFkLjE6IGlycSAyMCwgaW8gYmFzZSAweDAwMDAxODIwCmh1
YiA1LTA6MS4wOiBVU0IgaHViIGZvdW5kCmh1YiA1LTA6MS4wOiAyIHBvcnRzIGRldGVjdGVkCkFD
UEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMDoxZC4yW0NdIC0+IEdTSSAxOCAobGV2ZWwsIGxvdykg
LT4gSVJRIDE3CnVoY2lfaGNkIDAwMDA6MDA6MWQuMjogVUhDSSBIb3N0IENvbnRyb2xsZXIKdWhj
aV9oY2QgMDAwMDowMDoxZC4yOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMg
bnVtYmVyIDYKdWhjaV9oY2QgMDAwMDowMDoxZC4yOiBpcnEgMTcsIGlvIGJhc2UgMHgwMDAwMTg0
MApodWIgNi0wOjEuMDogVVNCIGh1YiBmb3VuZApodWIgNi0wOjEuMDogMiBwb3J0cyBkZXRlY3Rl
ZApBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDA6MWQuM1tEXSAtPiBHU0kgMTYgKGxldmVsLCBs
b3cpIC0+IElSUSAxNgp1aGNpX2hjZCAwMDAwOjAwOjFkLjM6IFVIQ0kgSG9zdCBDb250cm9sbGVy
CnVoY2lfaGNkIDAwMDA6MDA6MWQuMzogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQg
YnVzIG51bWJlciA3CnVoY2lfaGNkIDAwMDA6MDA6MWQuMzogaXJxIDE2LCBpbyBiYXNlIDB4MDAw
MDE4NjAKaHViIDctMDoxLjA6IFVTQiBodWIgZm91bmQKaHViIDctMDoxLjA6IDIgcG9ydHMgZGV0
ZWN0ZWQKQUNQSTogUENJIEludGVycnVwdCAwMDAwOjAzOjAyLjBbQV0gLT4gR1NJIDI0IChsZXZl
bCwgbG93KSAtPiBJUlEgMjUKUENJOiBWaWEgSVJRIGZpeHVwIGZvciAwMDAwOjAzOjAyLjAsIGZy
b20gMjU1IHRvIDkKdWhjaV9oY2QgMDAwMDowMzowMi4wOiBVSENJIEhvc3QgQ29udHJvbGxlcgp1
aGNpX2hjZCAwMDAwOjAzOjAyLjA6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1
cyBudW1iZXIgOAp1aGNpX2hjZCAwMDAwOjAzOjAyLjA6IGlycSAyNSwgaW8gYmFzZSAweDAwMDA1
MDQwCmh1YiA4LTA6MS4wOiBVU0IgaHViIGZvdW5kCmh1YiA4LTA6MS4wOiAyIHBvcnRzIGRldGVj
dGVkCkFDUEk6IFBDSSBJbnRlcnJ1cHQgMDAwMDowMzowMi4xW0JdIC0+IEdTSSAyNSAobGV2ZWws
IGxvdykgLT4gSVJRIDI2ClBDSTogVmlhIElSUSBmaXh1cCBmb3IgMDAwMDowMzowMi4xLCBmcm9t
IDI1NSB0byAxMAp1aGNpX2hjZCAwMDAwOjAzOjAyLjE6IFVIQ0kgSG9zdCBDb250cm9sbGVyCnVo
Y2lfaGNkIDAwMDA6MDM6MDIuMTogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNzaWduZWQgYnVz
IG51bWJlciA5CnVoY2lfaGNkIDAwMDA6MDM6MDIuMTogaXJxIDI2LCBpbyBiYXNlIDB4MDAwMDUw
NjAKaHViIDktMDoxLjA6IFVTQiBodWIgZm91bmQKaHViIDktMDoxLjA6IDIgcG9ydHMgZGV0ZWN0
ZWQKQUNQSTogUENJIEludGVycnVwdCAwMDAwOjAzOjAzLjBbQV0gLT4gR1NJIDI3IChsZXZlbCwg
bG93KSAtPiBJUlEgMjcKUENJOiBWaWEgSVJRIGZpeHVwIGZvciAwMDAwOjAzOjAzLjAsIGZyb20g
MjU1IHRvIDExCnVoY2lfaGNkIDAwMDA6MDM6MDMuMDogVUhDSSBIb3N0IENvbnRyb2xsZXIKdWhj
aV9oY2QgMDAwMDowMzowMy4wOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMg
bnVtYmVyIDEwCnVoY2lfaGNkIDAwMDA6MDM6MDMuMDogaXJxIDI3LCBpbyBiYXNlIDB4MDAwMDUw
ODAKaHViIDEwLTA6MS4wOiBVU0IgaHViIGZvdW5kCmh1YiAxMC0wOjEuMDogMiBwb3J0cyBkZXRl
Y3RlZApBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6MDM6MDMuMVtCXSAtPiBHU0kgMjggKGxldmVs
LCBsb3cpIC0+IElSUSAyOApQQ0k6IFZpYSBJUlEgZml4dXAgZm9yIDAwMDA6MDM6MDMuMSwgZnJv
bSAyNTUgdG8gMTIKdWhjaV9oY2QgMDAwMDowMzowMy4xOiBVSENJIEhvc3QgQ29udHJvbGxlcgp1
aGNpX2hjZCAwMDAwOjAzOjAzLjE6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1
cyBudW1iZXIgMTEKdXNiIDktMjogbmV3IGxvdyBzcGVlZCBVU0IgZGV2aWNlIHVzaW5nIHVoY2lf
aGNkIGFuZCBhZGRyZXNzIDIKdWhjaV9oY2QgMDAwMDowMzowMy4xOiBpcnEgMjgsIGlvIGJhc2Ug
MHgwMDAwNTBhMApodWIgMTEtMDoxLjA6IFVTQiBodWIgZm91bmQKaHViIDExLTA6MS4wOiAyIHBv
cnRzIGRldGVjdGVkCkluaXRpYWxpemluZyBVU0IgTWFzcyBTdG9yYWdlIGRyaXZlci4uLgp1c2Jj
b3JlOiByZWdpc3RlcmVkIG5ldyBkcml2ZXIgdXNiLXN0b3JhZ2UKVVNCIE1hc3MgU3RvcmFnZSBz
dXBwb3J0IHJlZ2lzdGVyZWQuCnVzYiAxMC0yOiBuZXcgZnVsbCBzcGVlZCBVU0IgZGV2aWNlIHVz
aW5nIHVoY2lfaGNkIGFuZCBhZGRyZXNzIDIKaW5wdXQ6IFVTQiBISUQgdjEuMTAgTW91c2UgW0xv
Z2l0ZWNoIFRyYWNrYmFsbF0gb24gdXNiLTAwMDA6MDM6MDIuMS0yCmlucHV0OiBVU0IgSElEIHYx
LjAwIERldmljZSBbVVNCIEF1ZGlvXSBvbiB1c2ItMDAwMDowMzowMy4wLTIKdXNiY29yZTogcmVn
aXN0ZXJlZCBuZXcgZHJpdmVyIHVzYmhpZApkcml2ZXJzL3VzYi9pbnB1dC9oaWQtY29yZS5jOiB2
Mi42OlVTQiBISUQgY29yZSBkcml2ZXIKdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgZHJpdmVyIGF1
ZXJzd2FsZAptaWNlOiBQUy8yIG1vdXNlIGRldmljZSBjb21tb24gZm9yIGFsbCBtaWNlCmkyYyAv
ZGV2IGVudHJpZXMgZHJpdmVyCmRldmljZS1tYXBwZXI6IDQuNC4wLWlvY3RsICgyMDA1LTAxLTEy
KSBpbml0aWFsaXNlZDogZG0tZGV2ZWxAcmVkaGF0LmNvbQpORVQ6IFJlZ2lzdGVyZWQgcHJvdG9j
b2wgZmFtaWx5IDIKSVAgcm91dGUgY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3Jk
ZXI6IDYsIDI2MjE0NCBieXRlcykKVENQIGVzdGFibGlzaGVkIGhhc2ggdGFibGUgZW50cmllczog
MjYyMTQ0IChvcmRlcjogOSwgMjA5NzE1MiBieXRlcykKVENQIGJpbmQgaGFzaCB0YWJsZSBlbnRy
aWVzOiA2NTUzNiAob3JkZXI6IDYsIDI2MjE0NCBieXRlcykKVENQOiBIYXNoIHRhYmxlcyBjb25m
aWd1cmVkIChlc3RhYmxpc2hlZCAyNjIxNDQgYmluZCA2NTUzNikKVENQIHJlbm8gcmVnaXN0ZXJl
ZAppcF9jb25udHJhY2sgdmVyc2lvbiAyLjMgKDgxOTIgYnVja2V0cywgNjU1MzYgbWF4KSAtIDIx
NiBieXRlcyBwZXIgY29ubnRyYWNrCmlucHV0OiBBVCBUcmFuc2xhdGVkIFNldCAyIGtleWJvYXJk
IG9uIGlzYTAwNjAvc2VyaW8wCmlwX3RhYmxlczogKEMpIDIwMDAtMjAwMiBOZXRmaWx0ZXIgY29y
ZSB0ZWFtCmlwdF9yZWNlbnQgdjAuMy4xOiBTdGVwaGVuIEZyb3N0IDxzZnJvc3RAc25vd21hbi5u
ZXQ+LiAgaHR0cDovL3Nub3dtYW4ubmV0L3Byb2plY3RzL2lwdF9yZWNlbnQvCmFycF90YWJsZXM6
IChDKSAyMDAyIERhdmlkIFMuIE1pbGxlcgpUQ1AgYmljIHJlZ2lzdGVyZWQKTkVUOiBSZWdpc3Rl
cmVkIHByb3RvY29sIGZhbWlseSAxCk5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTcK
VXNpbmcgSVBJIFNob3J0Y3V0IG1vZGUKQUNQSSB3YWtldXAgZGV2aWNlczogCkFaQUwgUlAwMSBS
UDAyIFJQMDQgVVNCMSBVU0IyIFVTQjMgVVNCNCBVU0I3IExBTkMgCkFDUEk6IChzdXBwb3J0cyBT
MCBTMyBTNCBTNSkKUkFNRElTSzogQ29tcHJlc3NlZCBpbWFnZSBmb3VuZCBhdCBibG9jayAwClZG
UzogTW91bnRlZCByb290IChleHQyIGZpbGVzeXN0ZW0pIHJlYWRvbmx5LgpGcmVlaW5nIHVudXNl
ZCBrZXJuZWwgbWVtb3J5OiAyMjBrIGZyZWVkCmluaXRyZDogUmVtb3VudGluZyAvIHJlYWQvd3Jp
dGUKbW91bnQ6IC9ldGMvbXRhYjogTm8gc3VjaCBmaWxlIFN5bmFwdGljcyBUb3VjaHBhZCwgbW9k
ZWw6IDEsIGZ3OiA1LjksIGlkOiAweDEyNmViMSwgY2FwczogMHhhMDQ3MTMvMHg0MDAwCm9yIGRp
cmVjdG9yeQppbmlucHV0OiBTeW5QUy8yIFN5bmFwdGljcyBUb3VjaFBhZCBvbiBpc2EwMDYwL3Nl
cmlvNAppdHJkOiBNb3VudGluZyAvcHJvYwppbml0cmQ6IEZpbmRpbmcgZGV2aWNlIG1hcHBlciBt
YWpvciBhbmQgbWlub3IgbnVtYmVycyAoMTAsNjIpCmluaXRyZDogQWN0aXZhdGluZyBMVk0yIHZv
bHVtZXMKICA0IGxvZ2ljYWwgdm9sdW1lKHMpIGluIHZvbHVtZSBncm91cCAidmcwIiBub3cgYWN0
aXZlCmluaXRyZDogQ2hlY2tpbmcgcm9vdCBmaWxlc3lzdGVtIC9kZXYvdmcwL3Jvb3QKV0FSTklO
RzogY291bGRuJ3Qgb3BlbiAvZXRjL2ZzdGFiOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5ClJl
aXNlcmZzIHN1cGVyIGJsb2NrIGluIGJsb2NrIDE2IG9uIDB4ZmQwMCBvZiBmb3JtYXQgMy42IHdp
dGggc3RhbmRhcmQgam91cm5hbApCbG9ja3MgKHRvdGFsL2ZyZWUpOiA1MzY3ODA4LzE0MjU4ODQg
YnkgNDA5NiBieXRlcwpGaWxlc3lzdGVtIGlzIGNsZWFuClJlcGxheWluZyBqb3VybmFsLi4KUmVp
c2VyZnMgam91cm5hbCAnL2Rldi92ZzAvcm9vdCcgaW4gYmxvY2tzIFsxOC4uODIxMV06IDAgdHJh
bnNhY3Rpb25zIHJlcGxheWVkCkNoZWNraW5nIGludGVybmFsIHRyZWUuLmZpbmlzaGVkClJlaXNl
ckZTOiBkbS0wOiBmb3VuZCByZWlzZXJmcyBmb3JtYXQgIjMuNiIgd2l0aCBzdGFuZGFyZCBqb3Vy
bmFsCmluaXRyZDogTW91bnRpbmdSZWlzZXJGUzogZG0tMDogdXNpbmcgb3JkZXJlZCBkYXRhIG1v
ZGUKIHJvb3QgZmlsZXN5c3RlbVJlaXNlckZTOiBkbS0wOiBqb3VybmFsIHBhcmFtczogZGV2aWNl
IGRtLTAsIHNpemUgODE5Miwgam91cm5hbCBmaXJzdCBibG9jayAxOCwgbWF4IHRyYW5zIGxlbiAx
MDI0LCBtYXggYmF0Y2ggOTAwLCBtYXggY29tbWl0IGFnZSAzMCwgbWF4IHRyYW5zIGFnZSAzMAog
L2Rldi92ZzAvcm9vdCByUmVpc2VyRlM6IGRtLTA6IGNoZWNraW5nIHRyYW5zYWN0aW9uIGxvZyAo
ZG0tMCkKdwpSZWlzZXJGUzogZG0tMDogVXNpbmcgcjUgaGFzaCB0byBzb3J0IG5hbWVzCmluaXRy
ZDogQ29weWluZyBub2RlIGZvciBkZXZpY2UgbWFwcGVyICgvZGV2L21hcHBlci9jb250cm9sKQpp
bml0cmQ6IE1vdmluZyAvcHJvYyB0byAvcm9vdHZvbC9wcm9jCmluaXRyZDogQ2hhbmdpbmcgcm9v
dHMKaW5pdHJkOiBNYWtpbmcgZGV2aWNlIG5vZGVzIGluIGx2bSByb290IGZzCmluaXRyZDogVW5t
b3VudGluZyAvcHJvYwppbml0cmQ6IFJlbW91bnRpbmcgbHZtIHJvb3QgZnMgcmVhZG9ubHkKaW5p
dHJkOiBQcm9jZWVkaW5nIHdpdGggYm9vdC4uLgpJTklUOiB2ZXJzaW9uIDIuODYgYm9vdGluZwoK
R2VudG9vIExpbnV4OyBodHRwOi8vd3d3LmdlbnRvby5vcmcvCiBDb3B5cmlnaHQgMTk5OS0yMDA1
IEdlbnRvbyBGb3VuZGF0aW9uOyBEaXN0cmlidXRlZCB1bmRlciB0aGUgR1BMdjI=

--Boundary-00=_w49LDR2AmqTrDKB--
