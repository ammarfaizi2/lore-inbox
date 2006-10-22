Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422942AbWJVDvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422942AbWJVDvS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 23:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422951AbWJVDvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 23:51:18 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:18810 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1422942AbWJVDvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 23:51:16 -0400
Date: Sun, 22 Oct 2006 05:51:09 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Message-ID: <20061022035109.GM5211@rhun.haifa.ibm.com>
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610212100.k9LL0GtC018787@hera.kernel.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 09:00:17PM +0000, Linux Kernel Mailing List wrote:

> commit 45edfd1db02f818b3dc7e4743ee8585af6b78f78
> tree cc7a524069ee23c49237c417299e5aa2f93205e0
> parent 926fafebc48a3218fac675f12974f9a46473bd40
> author Yinghai Lu <yinghai.lu@amd.com> 1161448621 +0200
> committer Andi Kleen <andi@basil.nowhere.org> 1161448621 +0200
> 
> [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
> 
> typo with cpu instead of new_cpu

This patch breaks my x366 machine:
 
aic94xx: device 0000:01:02.0: SAS addr 5005076a0112df00, PCBA SN , 8 phys, 8 enabled phys, flash present, BIOS build 1323
aic94xx: couldn't get irq 25 for 0000:01:02.0
ACPI: PCI interrupt for device 0000:01:02.0 disabled
aic94xx: probe of 0000:01:02.0 failed with error -38

Reverting it allows it to boot again. Since the patch is "obviously
correct", it must be uncovering some other problem with the genirq
code.

Cheers,
Muli

kernel (hd0,1)/boot/calgary/bzImage root=/dev/sda2 console=tty0 console=ttyS1,1
9200    [Linux-bzImage, setup=0x1c00, size=0x2bd61b]
initrd (hd0,1)/boot/calgary/aic94xxfw.initramfs.gz
   [Linux-initrd @ 0x37071000, 0xf7ea24 bytes]
savedefault
                                                                                
Linux version 2.6.19-rc2mx (muli@cluwyn) (gcc version 4.0.3) #11 SMP Sun Oct 22 04:25:51 IST 2006
Command line: root=/dev/sda2 console=tty0 console=ttyS1,19200
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000099000 (usable)
 BIOS-e820: 0000000000099000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000e7f9c640 (usable)
 BIOS-e820: 00000000e7f9c640 - 00000000e7fa6a40 (ACPI data)
 BIOS-e820: 00000000e7fa6a40 - 00000000e8000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000198000000 (usable)
end_pfn_map = 1671168
DMI 2.3 present.
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1671168
early_node_map[3] active PFN ranges
    0:        0 ->      153
    0:      20x06] enabled)
Processor #6
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0f] address[0xfec0_OVR (bus 0 bus_irq 8 global_irq 8 low edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 low edge)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 0000000000099000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e0000
Nosave address range: 00000000000e0000 - 0000000000100000
Nosave address range: 00000000e7f9c000 - 00000000e7f9d000
Nosave address range: 00000000e7f9d000 - 00000000e7fa6000
Nosave address range: 00000000e7fa6000 - 00000000e7fa7000
Nosave address range: 00000000e7fa7000 - 00000000e8000000
Nosave address range: 00000000e8000000 - 00000000fec00000
Nosave address range: 00000000fec00000 - 0000000100000000
Allocating PCI resources starting at ea000000 (gap: e8000000:16c00000)
PERCPU: Allocating 34048 bytes of per cpu data
Built 1 zonelists.  Total pages: 1534074
Kernel command line: root=/dev/sda2 console=tty0 console=ttyS1,19200
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Re       4096
 memory used by lock dependency info: 1328 kB
 per task-struct memory footprint: 1680 bytes
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Checking aperture...
PCI-DMA: Calgary IOMMU detected.
PCI-DMA: Calgary TCE table spec is 7, CONFIG_IOMMU_DEBUG is enabled.
Memory: 6082452k/6684672k available (3735k kernel code, 207748k reserved, 2686k data, 276k init)
Calibrating delay using timer specific routine.. 6346.24 BogoMIPS (lpj=12692491)Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
Freeing SMP alternatives: 32k freed
ACPI: Core revision 20060707
..MP-BIOS bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
result 10425644
Detected 10.425 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6339.07 BogoMIPS (lpj=12678150)CPU: Trace cache: 12K uops, L1 D cache: Initializing CPU#2
Calibrating delay using timer specific routine.. 6339.11 BogoMIPS (lpj=12678228)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU2: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
lockdep: not fixing up alternatives.
Booting processor 3/4 APIC 0x7
Initializing CPU#3
Calibrating delay using timer specific routine.. 6339.20 BogoMIPS (lpj=12678401)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU3: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) 4 CPU 3.16GHz stepping 09
Brought up 4 CPUs
testing NMI watchdog ... OK.
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 3169.440 MHz processor.
migration_cost=12,795
checking if image is initramfs... it is
Freeing initrd memory: 15866k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [VP00] (0000:00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Root Bridge [VP01] (0000:01)
ACPI: PCI Root Bridge [VP02] (0000:02)
ACPI: PCI Root Bridge [VP03] (0000:04)
ACPI: PCI Root Bridge [VP04] (0000:06)
ACPI: PCI Root Bridge [VP05] (0000:08)
ACPI: PCI Root Bridge [VP06] (0000:0a)
ACPI: PCI Root Bridge [VP07] (0000:0c)
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Using Calgary IOMMU
Calgary: enabling translation on PHB 0x0
Calgary: errant DMAs will now be prevented on this bus.
Calgary: enabling translation on PHB 0x1
Calgary: errant DMAs will now be prevented on this bus.
Calgary: enabling translation on PHB 0x2
Calgary: errant DMAs will now be prevented on this bus.
PCI-GART: No AMD northbridge found.
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 65536 bind 32768)
TCP reno registered
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=143.00 Mhz, System=143.00 MHz
radeonfb: PLL min 12000 max 35000
i2c_adapter i2c-1: unable to read EDID block.
i2c_adapter i2c-1: unable to read EDID block.
i2c_adapter i2c-1: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type CRT found
Console: switching to colour frame buffer device 128x48
radeonfb (0000:00:01.0): ATI Radeon QY
tridentfb: Trident framebuffer 0.7.8-NEWAPI initializing
hgafb: HGA card not detected.
hgafb: probe of hgafb.0 failed with error -22
vga16fb: mapped to 0xffff8100000a0000
fb1: VGA16 VGA frame buffer device
fb2: Virtual frame buffer device, using 1024K of video memory
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
Linux agpgart interface v0.101 (c) Dave Jones
ipmi message handler version 39.0
ipmi device interface
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
ibmasm: IBM ASM Service Processor Driver version 1.0 loaded
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:01.0: 3Com PCI 3c905C Tornado at ffffc20000042000.
tg3.c:v3.67 (October 18, 2006)
ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 24 (level, low) -> IRQ 24
eth1: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:22
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0]
eth1: dma_rwctrl[769f0000] dma_mask[64-bit]
ACPI: PCI Interrupt 0000:01:01.1[B] -> GSI 28 (level, low) -> IRQ 28
eth2: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0d:60:98:74:23
eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
eth2: dma_rwctrl[769f0000] dma_mask[64-bit]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB6: IDE controller at PCI slot 0000:00:0f.1
SvrWks CSB6: chipset revision 160
SvrWks CSB6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
SvrWks CSB6: simplex device: DMA disabled
ide1: SvrWks CSB6 Bus-Master DMA disabled (BIOS)
hda: HL-DT-STDVD-ROM GDR8082N, ATAPI CD/DVD-ROM<7>Losing some ticks... checking if CPU frequency changed.
 drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.20
usbmon: debugfs is not available
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:03.0: irq 20, io mem 0xf2c10000
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.19-rc2mx ohci_hcd
usb usb1: SerialNumber: 0000:00:03.0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.1: irq 20, io mem 0xf2c11000
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.19-rc2mx ohci_hcd
usb usb2: SerialNumber: 0000:00:03.1
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v3.0
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
i2c /dev entries driver
i2c-parport: adapter type unspecified
md: linear personality registered for level -1
IBM TrackPoint firmware: 0x0b, buttons: 3/3
md: raid0 personality registered for level 0
input: TPPS/2 IBM TrackPoint as /class/input/input2
md: raid1 personality registered for level 1
md: multipath personality registered for level -4
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.comdevice-mapper: multipath: version 1.0.5 loaded
device-mapper: multipath round-robin: version 1.0.0 loaded
device-mapper: multipath emc: version 0.0.3 loaded
EDAC MC: Ver: 2.0.1 Oct 22 2006
pktgen v2.68: Packet Generator for packet performance testing.
u32 classifier
    OLD policer on
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
SCTP: Hash tables configured (established 37449 bind 37449)
Freeing unused kernel memory: 276k freed
 running (1:0) /init
hello worlaic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.2 loaded
d from the initrACPI: PCI Interrupt 0000:01:02.0[A] -> d1!
 
 
hello wGSI 25 (level, low) -> IRQ 25
orld from the inaic94xx: found Adaptec AIC-9410W SAS/SATA Host Adapter, device 0000:01:02.0
itrd 2!
 
helloscsi0 : aic94xx
 world from the aic94xx: BIOS present (1,1), 1323
initrd 3!
 
Loading kernel/drivers/scsi/aic94xxaic94xx: ue num:2, ue size:88
/aic94xx.ko
aic94xx: manuf sect SAS_ADDR 5005076a0112df00
aic94xx: manuf sect PCBA SN
aic94xx: ms: num_phy_desc: 8
aic94xx: ms: phy0: ENEBLEABLE
aic94xx: ms: phy1: ENEBLEABLE
aic94xx: ms: phy2: ENEBLEABLE
aic94xx: ms: phy3: ENEBLEABLE
aic94xx: ms: phy4: ENEBLEABLE
aic94xx: ms: phy5: ENEBLEABLE
aic94xx: ms: phy6: ENEBLEABLE
aic94xx: ms: phy7: ENEBLEABLE
aic94xx: ms: max_phys:0x8, num_phys:0x8
aic94xx: ms: enabled_phys:0xff
aic94xx: ctrla: phy0: sas_ flags:0x0
aic94xx: ctrla: phy3: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: ctrla: phy4: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: ctrla: phy5: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: ctrla: phy6: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: ctrla: phy7: sas_addr: 5005076a0112df00, sas rate:0x9-0x8, sata rate:0x0-0x0, flags:0x0
aic94xx: max_scbs:512, max_ddbs:128
aic94xx: setting phy0 addr to 5005076a0112df00
aic94xx: setting phy1 addr to 5005076a0112df00
aic94xx: setting phy2 addr to 5005076a0112df00
aic94xx: setting phy3 addr to 5005076a0112df00
aic94xx: setting phy4 addr to 5005076a0112df00
aic94xx: setting phy5 addr to 5005076a0112df00
aic94xx: setting phy6 addr to 5005076a0112df00
aic94xx: setting phy7 addr to 5005076a0112df00
aic94xx: num_edbs:21
aic94xx: num_escbs:3
aic94xx: using sequencer Razor_10a1
aic94xx: downloading CSEQ...
aic94xx: dma-ing 8192 bytes
aic94xx: verified 8192 bytes, passed
aic94xx: downloading LSEQs...
aic94xx: dma-ing 14336 bytes
aic94xx: LSEQ0 verified 14336 bytes, passed
aic94xx: LSEQ1 verified 14336 bytes, passed
aic94xx: LSEQ2 verified 14336 bytes, passed
aic94xx: LSEQ3 verified 14336 bytes, passed
aic94xx: LSEQ4 verified 14336 bytes, passed
aic94xx: LSEQ5 verified 14336 bytes, passed
aic94xx: LSEQ6 verified 14336 bytes, passed
aic94xx: LSEQ7 verified 14336 bytes, passed
aic94xx: max_scbs:446
aic94xx: first_scb_site_no:0x20
aic94xx: last_scb_site_no:0x1fe
aic94xx: First SCB dma_handle: 0xd000
aic94xx: device 0000:01:02.0: SAS addr 5005076a0112df00, PCBA SN , 8 phys, 8 enabled phys, flash present, BIOS build 1323
aic94xx: couldn't get irq 25 for 0000:01:02.0
ACPI: PCI interrupt for device 0000:01:02.0 disabled
aic94xx: probe of 0000:01:02.0 failed with error -38
hello world from the initrd 4!
 
creating device nodes ...
waiting for block device node: /dev/sda2
........................
mount  -o ro /dev/sda2
mount: special device /dev/sda2 does not exist
unable to mount root filesystem on /dev/sda2
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 42 seconds..
