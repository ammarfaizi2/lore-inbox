Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVGFOpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVGFOpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 10:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVGFOo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 10:44:59 -0400
Received: from main.gmane.org ([80.91.229.2]:7110 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262311AbVGFKUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:20:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <fieroch@web.de>
Subject: Re: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
Date: Wed, 06 Jul 2005 12:19:44 +0200
Message-ID: <dagb80$bbd$1@sea.gmane.org>
References: <d6gf8j$jnb$1@sea.gmane.org>	 <20050527171613.5f949683.akpm@osdl.org> <429A2397.6090609@web.de>	 <58cb370e05061401041a67cfa7@mail.gmail.com> <42B091EE.4020802@web.de>	 <20050615143039.24132251.akpm@osdl.org>	 <1118960606.24646.58.camel@localhost.localdomain>	 <42B2AACC.7070908@web.de>	 <1119011887.24646.84.camel@localhost.localdomain>	 <42B302C2.9030009@web.de> <9a874849050617101712b80b15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030507070408060706020609"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Debian Thunderbird 1.0.2 (X11/20050611)
X-Accept-Language: de-de, en-us, en
In-Reply-To: <9a874849050617101712b80b15@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030507070408060706020609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hm, I did not get any answer to my last report last week. Didn't you get it?

There are still the same errors in kernel 2.6.13rc2 as in 2.6.13rc1. So
I've attached an up to date syslog and the last error report below.

Copying files from the iteraid is possible now for a few seconds. I just
get the message:

warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip __do_softirq+0x50/0xe8

But after some time copying files from dvd (iteraid) the kernel hangs
and repeats the following messages:

Jul  6 11:29:39 orclex kernel: hde: media error (bad sector):
status=0x51 { DriveReady SeekComplete Error }
Jul  6 11:29:39 orclex kernel: hde: media error (bad sector): error=0x30
{ LastFailedSense=0x03 }
Jul  6 11:29:39 orclex kernel: ide: failed opcode was: unknown
Jul  6 11:29:39 orclex kernel: end_request: I/O error, dev hde, sector 8360
Jul  6 11:29:39 orclex kernel: Buffer I/O error on device hde, logical
block 2090
...
Jul  6 11:29:43 orclex kernel: hde: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Jul  6 11:29:43 orclex kernel: hde: cdrom_decode_status: error=0x40 {
LastFailedSense=0x04 }
Jul  6 11:29:43 orclex kernel: ide: failed opcode was: unknown
Jul  6 11:29:43 orclex kernel: hde: ide_intr: huh? expected NULL handler
on exit
Jul  6 11:29:43 orclex kernel: hde: ATAPI reset complete
...


Ok, here is the last report:


Protasevich, Natalie wrote:
  >>>Running the mm2 kernel with "ITE IT8212 RAID CARD support"
  >>enabled and
  >>>compiled into the kernel I get a kernel panic:
  >>
  >>That driver fakes your IDE controller as scsi so it moved your rootfs.

arg...with -mm2 sda3 is sdb3. Using an other kernel rootfs is still sda3
and I have to change /etc/fstab each time for each test.

Kernel 2.6.13rc1 makes it better and does not move my rootfs but it is
still not working. I can see all ide devices (hda and hdb on ICH6 and
hde instead of sda on ITE8212) but I can't read or copy any file.

Accessing a file on dvdrom (on ITE8212) it get following error
in syslog:

hde: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hde: media error (bad sector): error=0x30 { LastFailedSense=0x03 }
ide: failed opcode was: unknown
end_request: I/O error, dev hde, sector 1305136
Buffer I/O error on device hde, logical block 326284

Mounting hdb (cdrom) I get the "drive appears confused" error message
and linux hangs.
Mounting hda (disk, fat32) I takes a long time to copy a small file.
Also every minute I get the error "irq 201: nobody cared".

Syslog with kernel parameters pci=routeirq and apic=debug is attached.

  > Maybe it's worth trying disabling IDE or taking it out of configuration
  > and see if the system boots. Could be that something is not right with
  > ACPI...

When I disable idedisk, idecd and ide-generic I don't get any of the
errors but I also do not have any ide device (hda, hdb, hde) in /dev.

  >Then I would try forth-feeding IRQ 14 to the IDE.

I don't know how to do that.

Regards,
Alexander




--------------030507070408060706020609
Content-Type: text/plain;
 name="syslog2613rc2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="syslog2613rc2"

Jul  6 11:40:33 orclex syslog-ng[4255]: syslog-ng version 1.6.8 starting
Jul  6 11:40:33 orclex syslog-ng[4255]: Changing permissions on special file /dev/xconsole
Jul  6 11:40:33 orclex kernel: Bootdata ok (command line is root=/dev/sda3 ro vga=792 pci=routeirq apic=debug)
Jul  6 11:40:33 orclex kernel: Linux version 2.6.13-rc2 (root@orclex) (gcc version 3.3.6 (Debian 1:3.3.6-7)) #1 SMP Wed Jul 6 11:18:24 CEST 2005
Jul  6 11:40:33 orclex kernel: BIOS-provided physical RAM map:
Jul  6 11:40:33 orclex kernel: BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jul  6 11:40:33 orclex kernel: BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jul  6 11:40:33 orclex kernel: BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
Jul  6 11:40:33 orclex kernel: BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
Jul  6 11:40:33 orclex kernel: BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
Jul  6 11:40:33 orclex kernel: BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
Jul  6 11:40:33 orclex kernel: BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
Jul  6 11:40:33 orclex kernel: BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Jul  6 11:40:33 orclex kernel: ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fb040
Jul  6 11:40:33 orclex kernel: ACPI: XSDT (v001 A M I  OEMXSDT  0x05000529 MSFT 0x00000097) @ 0x000000003ffb0100
Jul  6 11:40:33 orclex kernel: ACPI: FADT (v003 A M I  OEMFACP  0x05000529 MSFT 0x00000097) @ 0x000000003ffb0290
Jul  6 11:40:33 orclex kernel: ACPI: MADT (v001 A M I  OEMAPIC  0x05000529 MSFT 0x00000097) @ 0x000000003ffb0390
Jul  6 11:40:33 orclex kernel: ACPI: OEMB (v001 A M I  AMI_OEM  0x05000529 MSFT 0x00000097) @ 0x000000003ffbe040
Jul  6 11:40:33 orclex kernel: ACPI: MCFG (v001 A M I  OEMMCFG  0x05000529 MSFT 0x00000097) @ 0x000000003ffb6c80
Jul  6 11:40:33 orclex kernel: ACPI: DSDT (v001  A0086 A0086003 0x00000003 INTL 0x02002026) @ 0x0000000000000000
Jul  6 11:40:33 orclex kernel: On node 0 totalpages: 262064
Jul  6 11:40:33 orclex kernel: DMA zone: 4096 pages, LIFO batch:1
Jul  6 11:40:33 orclex kernel: Normal zone: 257968 pages, LIFO batch:31
Jul  6 11:40:33 orclex kernel: HighMem zone: 0 pages, LIFO batch:1
Jul  6 11:40:33 orclex kernel: ACPI: PM-Timer IO Port: 0x808
Jul  6 11:40:33 orclex kernel: ACPI: Local APIC address 0xfee00000
Jul  6 11:40:33 orclex kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Jul  6 11:40:33 orclex kernel: Processor #0 15:4 APIC version 16
Jul  6 11:40:33 orclex kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Jul  6 11:40:33 orclex kernel: Processor #1 15:4 APIC version 16
Jul  6 11:40:33 orclex kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Jul  6 11:40:33 orclex kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Jul  6 11:40:33 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jul  6 11:40:33 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jul  6 11:40:33 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jul  6 11:40:34 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jul  6 11:40:34 orclex kernel: ACPI: IRQ0 used by override.
Jul  6 11:40:34 orclex kernel: ACPI: IRQ2 used by override.
Jul  6 11:40:34 orclex kernel: ACPI: IRQ9 used by override.
Jul  6 11:40:34 orclex kernel: Setting APIC routing to flat
Jul  6 11:40:34 orclex kernel: Using ACPI (MADT) for SMP configuration information
Jul  6 11:40:34 orclex kernel: Allocating PCI resources starting at 40000000 (gap: 40000000:bfb00000)
Jul  6 11:40:34 orclex kernel: Built 1 zonelists
Jul  6 11:40:34 orclex kernel: Kernel command line: root=/dev/sda3 ro vga=792 pci=routeirq apic=debug
Jul  6 11:40:34 orclex kernel: Initializing CPU#0
Jul  6 11:40:34 orclex kernel: PID hash table entries: 4096 (order: 12, 131072 bytes)
Jul  6 11:40:34 orclex kernel: time.c: Using 3.579545 MHz PM timer.
Jul  6 11:40:34 orclex kernel: time.c: Detected 3010.829 MHz processor.
Jul  6 11:40:34 orclex kernel: Console: colour dummy device 80x25
Jul  6 11:40:34 orclex kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jul  6 11:40:34 orclex kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Jul  6 11:40:34 orclex kernel: Memory: 1023752k/1048256k available (3356k kernel code, 23816k reserved, 1777k data, 228k init)
Jul  6 11:40:34 orclex kernel: Calibrating delay using timer specific routine.. 6030.87 BogoMIPS (lpj=12061746)
Jul  6 11:40:34 orclex kernel: Security Framework v1.0.0 initialized
Jul  6 11:40:34 orclex kernel: Capability LSM initialized
Jul  6 11:40:34 orclex kernel: Mount-cache hash table entries: 256
Jul  6 11:40:34 orclex kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jul  6 11:40:34 orclex kernel: CPU: L2 cache: 2048K
Jul  6 11:40:34 orclex kernel: using mwait in idle threads.
Jul  6 11:40:34 orclex kernel: CPU: Physical Processor ID: 0
Jul  6 11:40:34 orclex kernel: CPU0: Thermal monitoring enabled (TM1)
Jul  6 11:40:34 orclex kernel: enabled ExtINT on CPU#0
Jul  6 11:40:34 orclex kernel: ENABLING IO-APIC IRQs
Jul  6 11:40:34 orclex kernel: init IO_APIC IRQs
Jul  6 11:40:34 orclex kernel: IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Jul  6 11:40:34 orclex kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jul  6 11:40:34 orclex kernel: Using local APIC timer interrupts.
Jul  6 11:40:34 orclex kernel: Detected 12.545 MHz APIC timer.
Jul  6 11:40:34 orclex kernel: Booting processor 1/1 rip 6000 rsp ffff810002191f58
Jul  6 11:40:34 orclex kernel: Initializing CPU#1
Jul  6 11:40:34 orclex kernel: masked ExtINT on CPU#1
Jul  6 11:40:34 orclex kernel: Calibrating delay using timer specific routine.. 6021.77 BogoMIPS (lpj=12043550)
Jul  6 11:40:34 orclex kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Jul  6 11:40:34 orclex kernel: CPU: L2 cache: 2048K
Jul  6 11:40:34 orclex kernel: CPU: Physical Processor ID: 0
Jul  6 11:40:34 orclex kernel: CPU1: Thermal monitoring enabled (TM1)
Jul  6 11:40:34 orclex kernel: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Jul  6 11:40:34 orclex kernel: APIC error on CPU1: 00(40)
Jul  6 11:40:34 orclex kernel: CPU 1: Syncing TSC to CPU 0.
Jul  6 11:40:34 orclex kernel: CPU 1: synchronized TSC with CPU 0 (last diff -130 cycles, maxerr 930 cycles)
Jul  6 11:40:34 orclex kernel: Brought up 2 CPUs
Jul  6 11:40:34 orclex kernel: time.c: Using PIT/TSC based timekeeping.
Jul  6 11:40:34 orclex kernel: testing NMI watchdog ... CPU#1: NMI appears to be stuck (1->1)!
Jul  6 11:40:34 orclex kernel: NET: Registered protocol family 16
Jul  6 11:40:34 orclex kernel: PCI: Using configuration type 1
Jul  6 11:40:34 orclex kernel: PCI: Using MMCONFIG at e0000000
Jul  6 11:40:34 orclex kernel: mtrr: v2.0 (20020519)
Jul  6 11:40:34 orclex kernel: ACPI: Subsystem revision 20050309
Jul  6 11:40:34 orclex kernel: ACPI: Interpreter enabled
Jul  6 11:40:34 orclex kernel: ACPI: Using IOAPIC for interrupt routing
Jul  6 11:40:34 orclex kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Jul  6 11:40:34 orclex kernel: PCI: Probing PCI hardware (bus 00)
Jul  6 11:40:34 orclex kernel: Boot video device is 0000:04:00.0
Jul  6 11:40:34 orclex kernel: PCI: Transparent bridge - 0000:00:1e.0
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 *14 15)
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 *15)
Jul  6 11:40:34 orclex kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Jul  6 11:40:34 orclex kernel: pnp: PnP ACPI init
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-8 -> 0x69 -> IRQ 8 Mode:0 Active:0)
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-13 -> 0x91 -> IRQ 13 Mode:0 Active:0)
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-6 -> 0x59 -> IRQ 6 Mode:0 Active:0)
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-7 -> 0x61 -> IRQ 7 Mode:0 Active:0)
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-1 -> 0x39 -> IRQ 1 Mode:0 Active:0)
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-10 -> 0x79 -> IRQ 10 Mode:0 Active:0)
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-4 -> 0x49 -> IRQ 4 Mode:0 Active:0)
Jul  6 11:40:34 orclex kernel: pnp: PnP ACPI: found 19 devices
Jul  6 11:40:34 orclex kernel: SCSI subsystem initialized
Jul  6 11:40:34 orclex kernel: usbcore: registered new driver usbfs
Jul  6 11:40:34 orclex kernel: usbcore: registered new driver hub
Jul  6 11:40:34 orclex kernel: PCI: Using ACPI for IRQ routing
Jul  6 11:40:34 orclex kernel: PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-23 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 185
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 20 Mode:1 Active:1)
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 201
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 185
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 201
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 193
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 177
Jul  6 11:40:34 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 209
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 23 (level, low) -> IRQ 185
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:01:09.0[A] -> GSI 17 (level, low) -> IRQ 177
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:01:09.1[A] -> GSI 17 (level, low) -> IRQ 177
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 21 (level, low) -> IRQ 209
Jul  6 11:40:34 orclex kernel: number of MP IRQ sources: 17.
Jul  6 11:40:34 orclex kernel: number of IO-APIC #2 registers: 24.
Jul  6 11:40:34 orclex kernel: testing the IO APIC.......................
Jul  6 11:40:34 orclex kernel: 
Jul  6 11:40:34 orclex kernel: IO APIC #2......
Jul  6 11:40:34 orclex kernel: .... register #00: 02000000
Jul  6 11:40:34 orclex kernel: .......    : physical APIC id: 02
Jul  6 11:40:34 orclex kernel: .... register #01: 00170020
Jul  6 11:40:34 orclex kernel: .......     : max redirection entries: 0017
Jul  6 11:40:34 orclex kernel: .......     : PRQ implemented: 0
Jul  6 11:40:34 orclex kernel: .......     : IO APIC version: 0020
Jul  6 11:40:34 orclex kernel: .... register #02: 00170020
Jul  6 11:40:34 orclex kernel: .......     : arbitration: 00
Jul  6 11:40:34 orclex kernel: .... IRQ redirection table:
Jul  6 11:40:34 orclex kernel: NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Jul  6 11:40:34 orclex kernel: 00 000 00  1    0    0   0   0    0    0    00
Jul  6 11:40:34 orclex kernel: 01 003 03  1    0    0   0   0    1    1    39
Jul  6 11:40:34 orclex kernel: 02 003 03  0    0    0   0   0    1    1    31
Jul  6 11:40:34 orclex kernel: 03 003 03  0    0    0   0   0    1    1    41
Jul  6 11:40:34 orclex kernel: 04 003 03  1    0    0   0   0    1    1    49
Jul  6 11:40:34 orclex kernel: 05 003 03  0    0    0   0   0    1    1    51
Jul  6 11:40:34 orclex kernel: 06 003 03  1    0    0   0   0    1    1    59
Jul  6 11:40:34 orclex kernel: 07 003 03  1    0    0   0   0    1    1    61
Jul  6 11:40:34 orclex kernel: 08 003 03  1    0    0   0   0    1    1    69
Jul  6 11:40:34 orclex kernel: 09 003 03  0    1    0   0   0    1    1    71
Jul  6 11:40:34 orclex kernel: 0a 003 03  1    0    0   0   0    1    1    79
Jul  6 11:40:34 orclex kernel: 0b 003 03  0    0    0   0   0    1    1    81
Jul  6 11:40:34 orclex kernel: 0c 003 03  0    0    0   0   0    1    1    89
Jul  6 11:40:34 orclex kernel: 0d 003 03  1    0    0   0   0    1    1    91
Jul  6 11:40:34 orclex kernel: 0e 003 03  0    0    0   0   0    1    1    99
Jul  6 11:40:34 orclex kernel: 0f 003 03  0    0    0   0   0    1    1    A1
Jul  6 11:40:34 orclex kernel: 10 003 03  1    1    0   1   0    1    1    A9
Jul  6 11:40:34 orclex kernel: 11 003 03  1    1    0   1   0    1    1    B1
Jul  6 11:40:34 orclex kernel: 12 003 03  1    1    0   1   0    1    1    C9
Jul  6 11:40:34 orclex kernel: 13 003 03  1    1    0   1   0    1    1    C1
Jul  6 11:40:34 orclex kernel: 14 000 00  1    0    0   0   0    0    0    00
Jul  6 11:40:34 orclex kernel: 15 003 03  1    1    0   1   0    1    1    D1
Jul  6 11:40:34 orclex kernel: 16 000 00  1    0    0   0   0    0    0    00
Jul  6 11:40:34 orclex kernel: 17 003 03  1    1    0   1   0    1    1    B9
Jul  6 11:40:34 orclex kernel: Using vector-based indexing
Jul  6 11:40:34 orclex kernel: IRQ to pin mappings:
Jul  6 11:40:34 orclex kernel: IRQ0 -> 0:2
Jul  6 11:40:34 orclex kernel: IRQ1 -> 0:1
Jul  6 11:40:34 orclex kernel: IRQ3 -> 0:3
Jul  6 11:40:34 orclex kernel: IRQ4 -> 0:4
Jul  6 11:40:34 orclex kernel: IRQ5 -> 0:5
Jul  6 11:40:34 orclex kernel: IRQ6 -> 0:6
Jul  6 11:40:34 orclex kernel: IRQ7 -> 0:7
Jul  6 11:40:34 orclex kernel: IRQ8 -> 0:8
Jul  6 11:40:34 orclex kernel: IRQ9 -> 0:9
Jul  6 11:40:34 orclex kernel: IRQ10 -> 0:10
Jul  6 11:40:34 orclex kernel: IRQ11 -> 0:11
Jul  6 11:40:34 orclex kernel: IRQ12 -> 0:12
Jul  6 11:40:34 orclex kernel: IRQ13 -> 0:13
Jul  6 11:40:34 orclex kernel: IRQ14 -> 0:14
Jul  6 11:40:34 orclex kernel: IRQ15 -> 0:15
Jul  6 11:40:34 orclex kernel: IRQ169 -> 0:16
Jul  6 11:40:34 orclex kernel: IRQ177 -> 0:17
Jul  6 11:40:34 orclex kernel: IRQ185 -> 0:23
Jul  6 11:40:34 orclex kernel: IRQ193 -> 0:19
Jul  6 11:40:34 orclex kernel: IRQ201 -> 0:18
Jul  6 11:40:34 orclex kernel: IRQ209 -> 0:21
Jul  6 11:40:34 orclex kernel: .................................... done.
Jul  6 11:40:34 orclex kernel: PCI: Bridge: 0000:00:01.0
Jul  6 11:40:34 orclex kernel: IO window: e000-efff
Jul  6 11:40:34 orclex kernel: MEM window: d0000000-d6ffffff
Jul  6 11:40:34 orclex kernel: PREFETCH window: d8000000-dfffffff
Jul  6 11:40:34 orclex kernel: PCI: Bridge: 0000:00:1c.0
Jul  6 11:40:34 orclex kernel: IO window: d000-dfff
Jul  6 11:40:34 orclex kernel: MEM window: disabled.
Jul  6 11:40:34 orclex kernel: PREFETCH window: disabled.
Jul  6 11:40:34 orclex kernel: PCI: Bridge: 0000:00:1c.1
Jul  6 11:40:34 orclex kernel: IO window: c000-cfff
Jul  6 11:40:34 orclex kernel: MEM window: cff00000-cfffffff
Jul  6 11:40:34 orclex kernel: PREFETCH window: 40000000-400fffff
Jul  6 11:40:34 orclex kernel: PCI: Bridge: 0000:00:1e.0
Jul  6 11:40:34 orclex kernel: IO window: 9000-bfff
Jul  6 11:40:34 orclex kernel: MEM window: cfe00000-cfefffff
Jul  6 11:40:34 orclex kernel: PREFETCH window: d7f00000-d7ffffff
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:1c.1 to 64
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:1e.0 to 64
Jul  6 11:40:34 orclex kernel: TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
Jul  6 11:40:34 orclex kernel: pnp: 00:07: ioport range 0x290-0x297 has been reserved
Jul  6 11:40:34 orclex kernel: pnp: 00:09: ioport range 0x3f6-0x3f6 has been reserved
Jul  6 11:40:34 orclex kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Jul  6 11:40:34 orclex kernel: IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Jul  6 11:40:34 orclex kernel: NTFS driver 2.1.22 [Flags: R/O].
Jul  6 11:40:34 orclex kernel: Initializing Cryptographic API
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Jul  6 11:40:34 orclex kernel: assign_interrupt_mode Found MSI capability
Jul  6 11:40:34 orclex kernel: Allocate Port Service[pcie00]
Jul  6 11:40:34 orclex kernel: Allocate Port Service[pcie03]
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
Jul  6 11:40:34 orclex kernel: assign_interrupt_mode Found MSI capability
Jul  6 11:40:34 orclex kernel: Allocate Port Service[pcie00]
Jul  6 11:40:34 orclex kernel: Allocate Port Service[pcie02]
Jul  6 11:40:34 orclex kernel: Allocate Port Service[pcie03]
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:1c.1 to 64
Jul  6 11:40:34 orclex kernel: assign_interrupt_mode Found MSI capability
Jul  6 11:40:34 orclex kernel: Allocate Port Service[pcie00]
Jul  6 11:40:34 orclex kernel: Allocate Port Service[pcie02]
Jul  6 11:40:34 orclex kernel: Allocate Port Service[pcie03]
Jul  6 11:40:34 orclex kernel: vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20010100000, using 6144k, total 131072k
Jul  6 11:40:34 orclex kernel: vesafb: mode is 1024x768x32, linelength=4096, pages=1
Jul  6 11:40:34 orclex kernel: vesafb: scrolling: redraw
Jul  6 11:40:34 orclex kernel: vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Jul  6 11:40:34 orclex kernel: Console: switching to colour frame buffer device 128x48
Jul  6 11:40:34 orclex kernel: fb0: VESA VGA frame buffer device
Jul  6 11:40:34 orclex kernel: vga16fb: initializing
Jul  6 11:40:34 orclex kernel: vga16fb: mapped to 0xffff8100000a0000
Jul  6 11:40:34 orclex kernel: fb1: VGA16 VGA frame buffer device
Jul  6 11:40:34 orclex kernel: ACPI: Power Button (FF) [PWRF]
Jul  6 11:40:34 orclex kernel: ACPI: Processor [CPU1] (supports 8 throttling states)
Jul  6 11:40:34 orclex kernel: Real Time Clock Driver v1.12
Jul  6 11:40:34 orclex kernel: Linux agpgart interface v0.101 (c) Dave Jones
Jul  6 11:40:34 orclex kernel: [drm] Initialized drm 1.0.0 20040925
Jul  6 11:40:34 orclex kernel: Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Jul  6 11:40:34 orclex kernel: Hangcheck: Using monotonic_clock().
Jul  6 11:40:34 orclex kernel: PNP: PS/2 controller doesn't have AUX irq; using default 0xc
Jul  6 11:40:34 orclex kernel: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 112
Jul  6 11:40:34 orclex kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul  6 11:40:34 orclex kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul  6 11:40:34 orclex kernel: io scheduler noop registered
Jul  6 11:40:34 orclex kernel: io scheduler anticipatory registered
Jul  6 11:40:34 orclex kernel: io scheduler deadline registered
Jul  6 11:40:34 orclex kernel: io scheduler cfq registered
Jul  6 11:40:34 orclex kernel: Floppy drive(s): fd0 is 1.44M
Jul  6 11:40:34 orclex kernel: FDC 0 is a post-1991 82077
Jul  6 11:40:34 orclex kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Jul  6 11:40:34 orclex kernel: loop: loaded (max 8 devices)
Jul  6 11:40:34 orclex kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: skge addr 0xcfefc000 irq 169 chip Yukon-Lite rev 7
Jul  6 11:40:34 orclex kernel: skge eth0: addr 00:11:2f:1c:f0:91
Jul  6 11:40:34 orclex kernel: PPP generic driver version 2.4.2
Jul  6 11:40:34 orclex kernel: PPP Deflate Compression module registered
Jul  6 11:40:34 orclex kernel: NET: Registered protocol family 24
Jul  6 11:40:34 orclex kernel: dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
Jul  6 11:40:34 orclex kernel: netconsole: not configured, aborting
Jul  6 11:40:34 orclex kernel: Linux video capture interface: v1.00
Jul  6 11:40:34 orclex kernel: bttv: driver version 0.9.15 loaded
Jul  6 11:40:34 orclex kernel: bttv: using 8 buffers with 2080k (520 pages) each for capture
Jul  6 11:40:34 orclex kernel: bttv: Bt8xx card found (0).
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:01:09.0[A] -> GSI 17 (level, low) -> IRQ 177
Jul  6 11:40:34 orclex kernel: bttv0: Bt878 (rev 2) at 0000:01:09.0, irq: 177, latency: 64, mmio: 0xd7ffe000
Jul  6 11:40:34 orclex kernel: bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
Jul  6 11:40:34 orclex kernel: bttv0: using: Hauppauge (bt878) [card=10,autodetected]
Jul  6 11:40:34 orclex kernel: bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
Jul  6 11:40:34 orclex kernel: bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
Jul  6 11:40:34 orclex kernel: tveeprom: Hauppauge: model = 61334, rev = B   , serial# = 3026517
Jul  6 11:40:34 orclex kernel: tveeprom: tuner = Philips FM1216 (idx = 21, type = 5)
Jul  6 11:40:34 orclex kernel: tveeprom: tuner fmt = PAL(B/G) (eeprom = 0x04, v4l2 = 0x00000007)
Jul  6 11:40:34 orclex kernel: tveeprom: audio_processor = MSP3415 (type = 6)
Jul  6 11:40:34 orclex kernel: bttv0: using tuner=5
Jul  6 11:40:34 orclex kernel: bttv0: registered device video0
Jul  6 11:40:34 orclex kernel: bttv0: registered device vbi0
Jul  6 11:40:34 orclex kernel: bttv0: registered device radio0
Jul  6 11:40:34 orclex kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Jul  6 11:40:34 orclex kernel: msp34xx: init: chip=MSP3410D-B4 +nicam +simple mode=simple
Jul  6 11:40:34 orclex kernel: msp3410: daemon started
Jul  6 11:40:34 orclex kernel: tvaudio: TV audio decoder + audio/video mux driver
Jul  6 11:40:34 orclex kernel: tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 (PV951),ta8874z
Jul  6 11:40:34 orclex kernel: SAA5246A (or compatible) Teletext decoder driver version 1.8
Jul  6 11:40:34 orclex kernel: SAA5249 driver (SAA5249 interface) for VideoText version 1.8
Jul  6 11:40:34 orclex kernel: tuner 0-0061: chip found @ 0xc2 (bt878 #0 [sw])
Jul  6 11:40:34 orclex kernel: tuner 0-0061: All bytes are equal. It is not a TEA5767
Jul  6 11:40:34 orclex kernel: tuner 0-0061: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
Jul  6 11:40:34 orclex kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Jul  6 11:40:34 orclex kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jul  6 11:40:34 orclex kernel: ICH6: IDE controller at PCI slot 0000:00:1f.1
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 201
Jul  6 11:40:34 orclex kernel: ICH6: chipset revision 3
Jul  6 11:40:34 orclex kernel: ICH6: 100% native mode on irq 201
Jul  6 11:40:34 orclex kernel: ide0: BM-DMA at 0x5800-0x5807, BIOS settings: hda:DMA, hdb:DMA
Jul  6 11:40:34 orclex kernel: ide1: BM-DMA at 0x5808-0x580f, BIOS settings: hdc:pio, hdd:pio
Jul  6 11:40:34 orclex kernel: Probing IDE interface ide0...
Jul  6 11:40:34 orclex kernel: hda: IC35L060AVV207-0, ATA DISK drive
Jul  6 11:40:34 orclex kernel: hdb: SONY CD-RW CRX210E1, ATAPI CD/DVD-ROM drive
Jul  6 11:40:34 orclex kernel: ide0 at 0x7000-0x7007,0x6802 on irq 201
Jul  6 11:40:34 orclex kernel: Probing IDE interface ide1...
Jul  6 11:40:34 orclex kernel: IT8212: IDE controller at PCI slot 0000:01:04.0
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 23 (level, low) -> IRQ 185
Jul  6 11:40:34 orclex kernel: IT8212: chipset revision 19
Jul  6 11:40:34 orclex kernel: it821x: controller in pass through mode.
Jul  6 11:40:34 orclex kernel: IT8212: 100% native mode on irq 185
Jul  6 11:40:34 orclex kernel: ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:pio, hdf:pio
Jul  6 11:40:34 orclex kernel: ide3: BM-DMA at 0x9808-0x980f, BIOS settings: hdg:pio, hdh:pio
Jul  6 11:40:34 orclex kernel: Probing IDE interface ide2...
Jul  6 11:40:34 orclex kernel: hde: Pioneer DVD-ROM ATAPIModel DVD-104S 012, ATAPI CD/DVD-ROM drive
Jul  6 11:40:34 orclex kernel: ide2 at 0xb000-0xb007,0xa802 on irq 185
Jul  6 11:40:34 orclex kernel: Probing IDE interface ide3...
Jul  6 11:40:34 orclex kernel: Probing IDE interface ide1...
Jul  6 11:40:34 orclex kernel: Probing IDE interface ide3...
Jul  6 11:40:34 orclex kernel: hda: max request size: 1024KiB
Jul  6 11:40:34 orclex kernel: hda: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
Jul  6 11:40:34 orclex kernel: hda: cache flushes supported
Jul  6 11:40:34 orclex kernel: hda: hda1 hda2
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: irq 201: nobody cared (try booting with the "irqpoll" option)
Jul  6 11:40:34 orclex kernel: 
Jul  6 11:40:34 orclex kernel: Call Trace: <IRQ> <ffffffff801551ef>{__report_bad_irq+48} <ffffffff801552e8>{note_interrupt+144}
Jul  6 11:40:34 orclex kernel: <ffffffff80154b13>{__do_IRQ+237} <ffffffff80110715>{do_IRQ+67}
Jul  6 11:40:34 orclex kernel: <ffffffff8010e051>{ret_from_intr+0}  <EOI> <ffffffff8010e181>{retint_kernel+38}
Jul  6 11:40:34 orclex kernel: <ffffffff8010bcf4>{mwait_idle+94} <ffffffff8010bc78>{cpu_idle+79}
Jul  6 11:40:34 orclex kernel: <ffffffff80696876>{start_kernel+445} <ffffffff8069622c>{x86_64_start_kernel+320}
Jul  6 11:40:34 orclex kernel: 
Jul  6 11:40:34 orclex kernel: handlers:
Jul  6 11:40:34 orclex kernel: [<ffffffff80317ef5>] (ide_intr+0x0/0x17a)
Jul  6 11:40:34 orclex kernel: Disabling IRQ #201
Jul  6 11:40:34 orclex kernel: ide-cd: cmd 0x5a timed out
Jul  6 11:40:34 orclex kernel: hdb: lost interrupt
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: Uniform CD-ROM driver Revision: 3.20
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:34 orclex kernel: hde: ATAPI DVD-ROM drive, 512kB Cache
Jul  6 11:40:34 orclex kernel: libata version 1.11 loaded.
Jul  6 11:40:34 orclex kernel: ahci version 1.01
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
Jul  6 11:40:34 orclex kernel: irq 201: nobody cared (try booting with the "irqpoll" option)
Jul  6 11:40:34 orclex kernel: 
Jul  6 11:40:34 orclex kernel: Call Trace: <IRQ> <ffffffff801551ef>{__report_bad_irq+48} <ffffffff801552e8>{note_interrupt+144}
Jul  6 11:40:34 orclex kernel: <ffffffff80154b13>{__do_IRQ+237} <ffffffff80110715>{do_IRQ+67}
Jul  6 11:40:34 orclex kernel: <ffffffff8010e051>{ret_from_intr+0}  <EOI> <ffffffff8010e181>{retint_kernel+38}
Jul  6 11:40:34 orclex kernel: <ffffffff8010bcf4>{mwait_idle+94} <ffffffff8010bc78>{cpu_idle+79}
Jul  6 11:40:34 orclex kernel: <ffffffff80696876>{start_kernel+445} <ffffffff8069622c>{x86_64_start_kernel+320}
Jul  6 11:40:34 orclex kernel: 
Jul  6 11:40:34 orclex kernel: handlers:
Jul  6 11:40:34 orclex kernel: [<ffffffff80317ef5>] (ide_intr+0x0/0x17a)
Jul  6 11:40:34 orclex kernel: Disabling IRQ #201
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
Jul  6 11:40:34 orclex kernel: ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
Jul  6 11:40:34 orclex kernel: ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part 
Jul  6 11:40:34 orclex kernel: ata1: SATA max UDMA/133 cmd 0xFFFFC20000026D00 ctl 0x0 bmdma 0x0 irq 193
Jul  6 11:40:34 orclex kernel: ata2: SATA max UDMA/133 cmd 0xFFFFC20000026D80 ctl 0x0 bmdma 0x0 irq 193
Jul  6 11:40:34 orclex kernel: ata3: SATA max UDMA/133 cmd 0xFFFFC20000026E00 ctl 0x0 bmdma 0x0 irq 193
Jul  6 11:40:34 orclex kernel: ata4: SATA max UDMA/133 cmd 0xFFFFC20000026E80 ctl 0x0 bmdma 0x0 irq 193
Jul  6 11:40:34 orclex kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
Jul  6 11:40:34 orclex kernel: ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
Jul  6 11:40:34 orclex kernel: ata1: dev 0 configured for UDMA/133
Jul  6 11:40:34 orclex kernel: scsi0 : ahci
Jul  6 11:40:34 orclex kernel: ata2: no device found (phy stat 00000000)
Jul  6 11:40:34 orclex kernel: scsi1 : ahci
Jul  6 11:40:34 orclex kernel: ata3: no device found (phy stat 00000000)
Jul  6 11:40:34 orclex kernel: scsi2 : ahci
Jul  6 11:40:34 orclex kernel: ata4: no device found (phy stat 00000000)
Jul  6 11:40:34 orclex kernel: scsi3 : ahci
Jul  6 11:40:34 orclex kernel: Vendor: ATA       Model: ST3250823AS       Rev: 3.02
Jul  6 11:40:34 orclex kernel: Type:   Direct-Access                      ANSI SCSI revision: 05
Jul  6 11:40:34 orclex kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Jul  6 11:40:34 orclex kernel: SCSI device sda: drive cache: write back
Jul  6 11:40:34 orclex kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Jul  6 11:40:34 orclex kernel: SCSI device sda: drive cache: write back
Jul  6 11:40:34 orclex kernel: sda: sda1 sda2 < sda5 > sda3
Jul  6 11:40:34 orclex kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Jul  6 11:40:34 orclex kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Jul  6 11:40:34 orclex kernel: ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 209
Jul  6 11:40:34 orclex kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[209]  MMIO=[cfefb800-cfefbfff]  Max Packet=[4096]
Jul  6 11:40:34 orclex kernel: ieee1394: raw1394: /dev/raw1394 device initialized
Jul  6 11:40:34 orclex kernel: usbmon: debugs is not available
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 185
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Jul  6 11:40:34 orclex kernel: ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
Jul  6 11:40:34 orclex kernel: ehci_hcd 0000:00:1d.7: debug port 1
Jul  6 11:40:34 orclex kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Jul  6 11:40:34 orclex kernel: ehci_hcd 0000:00:1d.7: irq 185, io mem 0xcfdff800
Jul  6 11:40:34 orclex kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Jul  6 11:40:34 orclex kernel: ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Jul  6 11:40:34 orclex kernel: hub 1-0:1.0: USB hub found
Jul  6 11:40:34 orclex kernel: hub 1-0:1.0: 8 ports detected
Jul  6 11:40:34 orclex kernel: ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Jul  6 11:40:34 orclex kernel: USB Universal Host Controller Interface driver v2.3
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 185
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Jul  6 11:40:34 orclex kernel: uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
Jul  6 11:40:34 orclex kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Jul  6 11:40:34 orclex kernel: uhci_hcd 0000:00:1d.0: irq 185, io base 0x00004400
Jul  6 11:40:34 orclex kernel: hub 2-0:1.0: USB hub found
Jul  6 11:40:34 orclex kernel: hub 2-0:1.0: 2 ports detected
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Jul  6 11:40:34 orclex kernel: uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
Jul  6 11:40:34 orclex kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Jul  6 11:40:34 orclex kernel: uhci_hcd 0000:00:1d.1: irq 193, io base 0x00004800
Jul  6 11:40:34 orclex kernel: hub 3-0:1.0: USB hub found
Jul  6 11:40:34 orclex kernel: hub 3-0:1.0: 2 ports detected
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 201
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Jul  6 11:40:34 orclex kernel: uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
Jul  6 11:40:34 orclex kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Jul  6 11:40:34 orclex kernel: uhci_hcd 0000:00:1d.2: irq 201, io base 0x00005000
Jul  6 11:40:34 orclex kernel: hub 4-0:1.0: USB hub found
Jul  6 11:40:34 orclex kernel: hub 4-0:1.0: 2 ports detected
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Jul  6 11:40:34 orclex kernel: uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
Jul  6 11:40:34 orclex kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Jul  6 11:40:34 orclex kernel: uhci_hcd 0000:00:1d.3: irq 169, io base 0x00005400
Jul  6 11:40:34 orclex kernel: hub 5-0:1.0: USB hub found
Jul  6 11:40:34 orclex kernel: hub 5-0:1.0: 2 ports detected
Jul  6 11:40:34 orclex kernel: Initializing USB Mass Storage driver...
Jul  6 11:40:34 orclex kernel: usbcore: registered new driver usb-storage
Jul  6 11:40:34 orclex kernel: USB Mass Storage support registered.
Jul  6 11:40:34 orclex kernel: usb 2-1: new low speed USB device using uhci_hcd and address 2
Jul  6 11:40:34 orclex kernel: usbcore: registered new driver hiddev
Jul  6 11:40:34 orclex kernel: usb 3-1: new low speed USB device using uhci_hcd and address 2
Jul  6 11:40:34 orclex kernel: input: USB HID v1.00 Joystick [Microsoft Microsoft SideWinder game controller] on usb-0000:00:1d.0-1
Jul  6 11:40:34 orclex kernel: input: USB HID v1.00 Mouse [Microsoft Microsoft Wheel Mouse Optical®] on usb-0000:00:1d.1-1
Jul  6 11:40:34 orclex kernel: usbcore: registered new driver usbhid
Jul  6 11:40:34 orclex kernel: drivers/usb/input/hid-core.c: v2.01:USB HID core driver
Jul  6 11:40:34 orclex kernel: mice: PS/2 mouse device common for all mice
Jul  6 11:40:34 orclex kernel: input: PC Speaker
Jul  6 11:40:34 orclex kernel: md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
Jul  6 11:40:34 orclex kernel: md: bitmap version 3.38
Jul  6 11:40:34 orclex kernel: device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Jul  6 11:40:34 orclex kernel: GACT probability on
Jul  6 11:40:34 orclex kernel: Mirror/redirect action on
Jul  6 11:40:34 orclex kernel: u32 classifier
Jul  6 11:40:34 orclex kernel: Perfomance counters on
Jul  6 11:40:34 orclex kernel: input device check on 
Jul  6 11:40:34 orclex kernel: Actions configured 
Jul  6 11:40:34 orclex kernel: NET: Registered protocol family 2
Jul  6 11:40:34 orclex kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Jul  6 11:40:34 orclex kernel: IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
Jul  6 11:40:34 orclex kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Jul  6 11:40:34 orclex kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Jul  6 11:40:34 orclex kernel: TCP: Hash tables configured (established 262144 bind 65536)
Jul  6 11:40:34 orclex kernel: TCP reno registered
Jul  6 11:40:34 orclex kernel: IPv4 over IPv4 tunneling driver
Jul  6 11:40:34 orclex kernel: ip_conntrack version 2.1 (4094 buckets, 32752 max) - 296 bytes per conntrack
Jul  6 11:40:34 orclex kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800007ef52b]
Jul  6 11:40:34 orclex kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jul  6 11:40:34 orclex kernel: ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Jul  6 11:40:34 orclex kernel: TCP bic registered
Jul  6 11:40:34 orclex kernel: Initializing IPsec netlink socket
Jul  6 11:40:34 orclex kernel: NET: Registered protocol family 1
Jul  6 11:40:34 orclex kernel: NET: Registered protocol family 17
Jul  6 11:40:34 orclex kernel: NET: Registered protocol family 15
Jul  6 11:40:34 orclex kernel: Using IPI Shortcut mode
Jul  6 11:40:34 orclex kernel: swsusp: Suspend partition has wrong signature?
Jul  6 11:40:34 orclex kernel: md: Autodetecting RAID arrays.
Jul  6 11:40:34 orclex kernel: md: autorun ...
Jul  6 11:40:34 orclex kernel: md: ... autorun DONE.
Jul  6 11:40:34 orclex kernel: kjournald starting.  Commit interval 5 seconds
Jul  6 11:40:34 orclex kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul  6 11:40:34 orclex kernel: VFS: Mounted root (ext3 filesystem) readonly.
Jul  6 11:40:34 orclex kernel: Freeing unused kernel memory: 228k freed
Jul  6 11:40:34 orclex kernel: Adding 2658716k swap on /dev/sda5.  Priority:-1 extents:1
Jul  6 11:40:34 orclex kernel: EXT3 FS on sda3, internal journal
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 21 (level, low) -> IRQ 209
Jul  6 11:40:34 orclex kernel: hda: dma_timer_expiry: dma status == 0x64
Jul  6 11:40:34 orclex kernel: hda: DMA interrupt recovery
Jul  6 11:40:34 orclex kernel: hda: lost interrupt
Jul  6 11:40:34 orclex kernel: kjournald starting.  Commit interval 5 seconds
Jul  6 11:40:34 orclex kernel: EXT3 FS on sda1, internal journal
Jul  6 11:40:34 orclex kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul  6 11:40:34 orclex kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
Jul  6 11:40:34 orclex kernel: PCI: Setting latency timer of device 0000:00:1b.0 to 64
Jul  6 11:40:34 orclex kernel: parport: PnPBIOS parport detected.
Jul  6 11:40:34 orclex kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
Jul  6 11:40:34 orclex kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Jul  6 11:40:34 orclex kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul  6 11:40:34 orclex kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Jul  6 11:40:34 orclex kernel: skge eth0: enabling interface
Jul  6 11:40:34 orclex kernel: skge eth0: Link is up at 100 Mbps, full duplex, flow control none
Jul  6 11:40:35 orclex cpufreqd: libsys_init() - no batteries found, not a laptop?
Jul  6 11:40:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:36 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: lp0: using parport0 (interrupt-driven).
Jul  6 11:40:37 orclex udev[4342]: creating device node '/dev/lp0'
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:37 orclex kernel: hdb: packet command error: status=0xd0 { Busy }
Jul  6 11:40:37 orclex kernel: ide: failed opcode was: unknown
Jul  6 11:40:37 orclex kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Jul  6 11:40:37 orclex kernel: ide: failed opcode was: unknown
Jul  6 11:40:37 orclex kernel: hdb: drive not ready for command
Jul  6 11:40:37 orclex kernel: hdb: packet command error: status=0xd0 { Busy }
Jul  6 11:40:37 orclex kernel: ide: failed opcode was: unknown
Jul  6 11:40:38 orclex kernel: irq 201: nobody cared (try booting with the "irqpoll" option)
Jul  6 11:40:38 orclex kernel: 
Jul  6 11:40:38 orclex kernel: Call Trace: <IRQ> <ffffffff801551ef>{__report_bad_irq+48} <ffffffff801552e8>{note_interrupt+144}
Jul  6 11:40:38 orclex kernel: <ffffffff80154b13>{__do_IRQ+237} <ffffffff80110715>{do_IRQ+67}
Jul  6 11:40:38 orclex kernel: <ffffffff8010e051>{ret_from_intr+0}  <EOI> <ffffffff8010e181>{retint_kernel+38}
Jul  6 11:40:38 orclex kernel: <ffffffff8010bcf4>{mwait_idle+94} <ffffffff8010bc78>{cpu_idle+79}
Jul  6 11:40:38 orclex kernel: <ffffffff80696876>{start_kernel+445} <ffffffff8069622c>{x86_64_start_kernel+320}
Jul  6 11:40:38 orclex kernel: 
Jul  6 11:40:38 orclex kernel: handlers:
Jul  6 11:40:38 orclex kernel: [<ffffffff80317ef5>] (ide_intr+0x0/0x17a)
Jul  6 11:40:38 orclex kernel: [<ffffffff8035cc15>] (usb_hcd_irq+0x0/0x68)
Jul  6 11:40:38 orclex kernel: Disabling IRQ #201
Jul  6 11:40:42 orclex kernel: hdb: status timeout: status=0xd0 { Busy }
Jul  6 11:40:42 orclex kernel: ide: failed opcode was: unknown
Jul  6 11:40:42 orclex kernel: hdb: DMA disabled
Jul  6 11:40:42 orclex kernel: hdb: drive not ready for command
Jul  6 11:40:42 orclex kernel: hdb: ATAPI reset complete
Jul  6 11:40:42 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:40:43 orclex kernel: irq 201: nobody cared (try booting with the "irqpoll" option)
Jul  6 11:40:43 orclex kernel: 
Jul  6 11:40:43 orclex kernel: Call Trace: <IRQ> <ffffffff801551ef>{__report_bad_irq+48} <ffffffff801552e8>{note_interrupt+144}
Jul  6 11:40:43 orclex kernel: <ffffffff80154b13>{__do_IRQ+237} <ffffffff80110715>{do_IRQ+67}
Jul  6 11:40:43 orclex kernel: <ffffffff8010e051>{ret_from_intr+0}  <EOI> <ffffffff8010e181>{retint_kernel+38}
Jul  6 11:40:43 orclex kernel: <ffffffff8010bcf4>{mwait_idle+94} <ffffffff8010bc78>{cpu_idle+79}
Jul  6 11:40:43 orclex kernel: <ffffffff80696876>{start_kernel+445} <ffffffff8069622c>{x86_64_start_kernel+320}
Jul  6 11:40:43 orclex kernel: 
Jul  6 11:40:43 orclex kernel: handlers:
Jul  6 11:40:43 orclex kernel: [<ffffffff80317ef5>] (ide_intr+0x0/0x17a)
Jul  6 11:40:43 orclex kernel: [<ffffffff8035cc15>] (usb_hcd_irq+0x0/0x68)
Jul  6 11:40:43 orclex kernel: Disabling IRQ #201
Jul  6 11:40:43 orclex /usr/sbin/gpm[4374]: Detected EXPS/2 protocol mouse.
Jul  6 11:41:42 orclex kernel: hdb: irq timeout: status=0xd0 { Busy }
Jul  6 11:41:42 orclex kernel: ide: failed opcode was: unknown
Jul  6 11:41:42 orclex kernel: hdb: ATAPI reset complete
Jul  6 11:41:43 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:41:43 orclex kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Jul  6 11:41:43 orclex kernel: ide: failed opcode was: unknown
Jul  6 11:41:43 orclex kernel: hdb: drive not ready for command
Jul  6 11:41:43 orclex kernel: irq 201: nobody cared (try booting with the "irqpoll" option)
Jul  6 11:41:43 orclex kernel: 
Jul  6 11:41:43 orclex kernel: Call Trace: <IRQ> <ffffffff801551ef>{__report_bad_irq+48} <ffffffff801552e8>{note_interrupt+144}
Jul  6 11:41:43 orclex kernel: <ffffffff80154b13>{__do_IRQ+237} <ffffffff80110715>{do_IRQ+67}
Jul  6 11:41:43 orclex kernel: <ffffffff8010e051>{ret_from_intr+0}  <EOI> <ffffffff8010e181>{retint_kernel+38}
Jul  6 11:41:43 orclex kernel: <ffffffff8010bcf4>{mwait_idle+94} <ffffffff8010bc78>{cpu_idle+79}
Jul  6 11:41:43 orclex kernel: <ffffffff80696876>{start_kernel+445} <ffffffff8069622c>{x86_64_start_kernel+320}
Jul  6 11:41:43 orclex kernel: 
Jul  6 11:41:43 orclex kernel: handlers:
Jul  6 11:41:43 orclex kernel: [<ffffffff80317ef5>] (ide_intr+0x0/0x17a)
Jul  6 11:41:43 orclex kernel: [<ffffffff8035cc15>] (usb_hcd_irq+0x0/0x68)
Jul  6 11:41:43 orclex kernel: Disabling IRQ #201
Jul  6 11:41:48 orclex kernel: hdb: status timeout: status=0xd0 { Busy }
Jul  6 11:41:48 orclex kernel: ide: failed opcode was: unknown
Jul  6 11:41:48 orclex kernel: hdb: drive not ready for command
Jul  6 11:41:48 orclex kernel: scsi: unknown opcode 0x85
Jul  6 11:41:48 orclex kernel: hdb: ATAPI reset complete
Jul  6 11:41:48 orclex lpd[4413]: restarted
Jul  6 11:41:48 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:41:48 orclex hddtemp[4404]: /dev/hda: IC35L060AVV207-0: 29 C
Jul  6 11:41:48 orclex kernel: hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Jul  6 11:41:48 orclex kernel: ide: failed opcode was: unknown
Jul  6 11:41:48 orclex kernel: hdb: drive not ready for command
Jul  6 11:41:49 orclex nmbd[4423]: [2005/07/06 11:41:49, 0, pid=4423] nmbd/asyncdns.c:start_async_dns(149)
Jul  6 11:41:49 orclex nmbd[4423]:   started asyncdns process 4424
Jul  6 11:41:49 orclex kernel: irq 201: nobody cared (try booting with the "irqpoll" option)
Jul  6 11:41:49 orclex kernel: 
Jul  6 11:41:49 orclex kernel: Call Trace: <IRQ> <ffffffff801551ef>{__report_bad_irq+48} <ffffffff801552e8>{note_interrupt+144}
Jul  6 11:41:49 orclex kernel: <ffffffff80154b13>{__do_IRQ+237} <ffffffff80110715>{do_IRQ+67}
Jul  6 11:41:49 orclex kernel: <ffffffff8010e051>{ret_from_intr+0}  <EOI> 
Jul  6 11:41:49 orclex kernel: handlers:
Jul  6 11:41:49 orclex kernel: [<ffffffff80317ef5>] (ide_intr+0x0/0x17a)
Jul  6 11:41:49 orclex kernel: [<ffffffff8035cc15>] (usb_hcd_irq+0x0/0x68)
Jul  6 11:41:49 orclex kernel: Disabling IRQ #201
Jul  6 11:41:49 orclex smartd[4430]: smartd version 5.32 Copyright (C) 2002-4 Bruce Allen
Jul  6 11:41:49 orclex smartd[4430]: Home page is http://smartmontools.sourceforge.net/
Jul  6 11:41:49 orclex smartd[4430]: Opened configuration file /etc/smartd.conf
Jul  6 11:41:49 orclex smartd[4430]: Drive: DEVICESCAN, implied '-a' Directive on line 23 of file /etc/smartd.conf
Jul  6 11:41:49 orclex smartd[4430]: Configuration file /etc/smartd.conf was parsed, found DEVICESCAN, scanning devices
Jul  6 11:41:49 orclex smartd[4430]: Device: /dev/hda, opened
Jul  6 11:42:48 orclex kernel: hdb: irq timeout: status=0xd0 { Busy }
Jul  6 11:42:48 orclex kernel: ide: failed opcode was: unknown
Jul  6 11:42:48 orclex kernel: hdb: ATAPI reset complete
Jul  6 11:42:49 orclex smartd[4430]: Device: /dev/hda, found in smartd database.
Jul  6 11:42:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:42:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:42:50 orclex kernel: irq 201: nobody cared (try booting with the "irqpoll" option)
Jul  6 11:42:50 orclex kernel: 
Jul  6 11:42:50 orclex kernel: Call Trace: <IRQ> <ffffffff801551ef>{__report_bad_irq+48} <ffffffff801552e8>{note_interrupt+144}
Jul  6 11:42:50 orclex kernel: <ffffffff80154b13>{__do_IRQ+237} <ffffffff80110715>{do_IRQ+67}
Jul  6 11:42:50 orclex kernel: <ffffffff8010e051>{ret_from_intr+0}  <EOI> <ffffffff8010e181>{retint_kernel+38}
Jul  6 11:42:50 orclex kernel: <ffffffff8010bcf4>{mwait_idle+94} <ffffffff8010bc78>{cpu_idle+79}
Jul  6 11:42:50 orclex kernel: <ffffffff80696876>{start_kernel+445} <ffffffff8069622c>{x86_64_start_kernel+320}
Jul  6 11:42:50 orclex kernel: 
Jul  6 11:42:50 orclex kernel: handlers:
Jul  6 11:42:50 orclex kernel: [<ffffffff80317ef5>] (ide_intr+0x0/0x17a)
Jul  6 11:42:50 orclex kernel: [<ffffffff8035cc15>] (usb_hcd_irq+0x0/0x68)
Jul  6 11:42:50 orclex kernel: Disabling IRQ #201
Jul  6 11:43:00 orclex kernel: hda: lost interrupt
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex smartd[4430]: Device: /dev/hda, is SMART capable. Adding to "monitor" list.
Jul  6 11:43:00 orclex smartd[4430]: Device: /dev/hdb, opened
Jul  6 11:43:00 orclex smartd[4430]: Device: /dev/hdb, packet devices [this device CD/DVD] not SMART capable
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:00 orclex smartd[4430]: Unable to register ATA device /dev/hdb at line 23 of file /etc/smartd.conf
Jul  6 11:43:00 orclex smartd[4430]: Device: /dev/hde, opened
Jul  6 11:43:00 orclex smartd[4430]: Device: /dev/hde, packet devices [this device CD/DVD] not SMART capable
Jul  6 11:43:00 orclex smartd[4430]: Unable to register ATA device /dev/hde at line 23 of file /etc/smartd.conf
Jul  6 11:43:00 orclex smartd[4430]: Device: /dev/sda, opened
Jul  6 11:43:00 orclex kernel: program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
Jul  6 11:43:00 orclex kernel: program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
Jul  6 11:43:00 orclex smartd[4430]: Device: /dev/sda, IE (SMART) not enabled, skip device Try 'smartctl -s on /dev/sda' to turn on SMART features
Jul  6 11:43:00 orclex smartd[4430]: Unable to register SCSI device /dev/sda at line 23 of file /etc/smartd.conf
Jul  6 11:43:00 orclex smartd[4430]: Monitoring 1 ATA and 0 SCSI devices
Jul  6 11:43:01 orclex kernel: irq 201: nobody cared (try booting with the "irqpoll" option)
Jul  6 11:43:01 orclex kernel: 
Jul  6 11:43:01 orclex kernel: Call Trace: <IRQ> <ffffffff801551ef>{__report_bad_irq+48} <ffffffff801552e8>{note_interrupt+144}
Jul  6 11:43:01 orclex kernel: <ffffffff80154b13>{__do_IRQ+237} <ffffffff80110715>{do_IRQ+67}
Jul  6 11:43:01 orclex kernel: <ffffffff8010e051>{ret_from_intr+0}  <EOI> <ffffffff8010e181>{retint_kernel+38}
Jul  6 11:43:01 orclex kernel: <ffffffff8010bcf4>{mwait_idle+94} <ffffffff8010bc78>{cpu_idle+79}
Jul  6 11:43:01 orclex kernel: <ffffffff80696876>{start_kernel+445} <ffffffff8069622c>{x86_64_start_kernel+320}
Jul  6 11:43:01 orclex kernel: 
Jul  6 11:43:01 orclex kernel: handlers:
Jul  6 11:43:01 orclex kernel: [<ffffffff80317ef5>] (ide_intr+0x0/0x17a)
Jul  6 11:43:01 orclex kernel: [<ffffffff8035cc15>] (usb_hcd_irq+0x0/0x68)
Jul  6 11:43:01 orclex kernel: Disabling IRQ #201
Jul  6 11:43:11 orclex kernel: hda: lost interrupt
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex smartd[4435]: smartd has fork()ed into background mode. New PID=4435.
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex smartd[4435]: file /var/run/smartd.pid written containing PID 4435
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:11 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Jul  6 11:43:12 orclex kernel: irq 201: nobody cared (try booting with the "irqpoll" option)
Jul  6 11:43:12 orclex kernel: 
Jul  6 11:43:12 orclex kernel: Call Trace: <IRQ> <ffffffff801551ef>{__report_bad_irq+48} <ffffffff801552e8>{note_interrupt+144}
Jul  6 11:43:12 orclex kernel: <ffffffff80154b13>{__do_IRQ+237} <ffffffff80110715>{do_IRQ+67}
Jul  6 11:43:12 orclex kernel: <ffffffff8010e051>{ret_from_intr+0}  <EOI> <ffffffff80443c76>{_spin_lock+39}
Jul  6 11:43:12 orclex kernel: <ffffffff8018d98f>{__d_lookup+200} <ffffffff80182f49>{do_lookup+49}
Jul  6 11:43:12 orclex kernel: <ffffffff801833b7>{__link_path_walk+998} <ffffffff80183f75>{link_path_walk+87}
Jul  6 11:43:12 orclex kernel: <ffffffff80184440>{path_lookup+448} <ffffffff801845e5>{__user_walk+62}
Jul  6 11:43:12 orclex kernel: <ffffffff8017e4c1>{vfs_stat+41} <ffffffff8017e8d1>{sys_newstat+31}
Jul  6 11:43:12 orclex kernel: <ffffffff8010daae>{system_call+126} 
Jul  6 11:43:12 orclex kernel: handlers:
Jul  6 11:43:12 orclex kernel: [<ffffffff80317ef5>] (ide_intr+0x0/0x17a)
Jul  6 11:43:12 orclex kernel: [<ffffffff8035cc15>] (usb_hcd_irq+0x0/0x68)
Jul  6 11:43:12 orclex kernel: Disabling IRQ #201
Jul  6 11:43:13 orclex Xprt_64: No matching visual for __GLcontextMode with visual class = 0 (32775), nplanes = 8
Jul  6 11:43:14 orclex rpc.statd[4614]: Version 1.0.7 Starting
Jul  6 11:43:14 orclex rpc.statd[4614]: statd running as root. chown /var/lib/nfs/sm to choose different user
Jul  6 11:43:14 orclex anacron[4620]: Anacron 2.3 started on 2005-07-06
Jul  6 11:43:14 orclex anacron[4620]: Normal exit (0 jobs run)
Jul  6 11:43:14 orclex /usr/sbin/cron[4625]: (CRON) INFO (pidfile fd = 3)
Jul  6 11:43:14 orclex /usr/sbin/cron[4626]: (CRON) STARTUP (fork ok)
Jul  6 11:43:14 orclex /usr/sbin/cron[4626]: (CRON) INFO (Running @reboot jobs)
Jul  6 11:43:16 orclex udev[4647]: creating device node '/dev/vcs2'
Jul  6 11:43:16 orclex udev[4648]: creating device node '/dev/vcsa2'
Jul  6 11:43:16 orclex udev[4651]: creating device node '/dev/vcs3'
Jul  6 11:43:16 orclex udev[4652]: creating device node '/dev/vcsa3'
Jul  6 11:43:16 orclex udev[4671]: creating device node '/dev/vcs4'
Jul  6 11:43:16 orclex udev[4674]: creating device node '/dev/vcsa4'
Jul  6 11:43:16 orclex udev[4688]: creating device node '/dev/vcs5'
Jul  6 11:43:16 orclex udev[4689]: creating device node '/dev/vcsa5'
Jul  6 11:43:16 orclex udev[4694]: creating device node '/dev/vcs6'
Jul  6 11:43:16 orclex udev[4695]: creating device node '/dev/vcsa6'
Jul  6 11:43:16 orclex udev[4704]: creating device node '/dev/vcs7'
Jul  6 11:43:16 orclex udev[4706]: creating device node '/dev/vcsa7'
Jul  6 11:43:16 orclex udev[4724]: removing device node '/dev/vcs2'
Jul  6 11:43:16 orclex udev[4730]: removing device node '/dev/vcs3'
Jul  6 11:43:16 orclex udev[4735]: removing device node '/dev/vcsa2'
Jul  6 11:43:16 orclex udev[4737]: removing device node '/dev/vcsa3'
Jul  6 11:43:16 orclex udev[4739]: removing device node '/dev/vcsa4'
Jul  6 11:43:18 orclex gdm[4644]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Jul  6 11:43:22 orclex gdm[4765]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Jul  6 11:43:26 orclex gdm[4777]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Jul  6 11:43:26 orclex gdm[4643]: deal_with_x_crashes: Das Skript XKeepsCrashing wird gestartet
Jul  6 11:43:28 orclex gdm[4643]: X-Server konnte nicht in kurzen Zeitabständen gestartet werden; Anzeige :0 wird deaktiviert


--------------030507070408060706020609--

