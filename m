Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVCLXDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVCLXDC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVCLXDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:03:02 -0500
Received: from ns1.openconsultancy.com ([207.166.203.131]:63205 "EHLO
	mail.mx.davidcoulson.net") by vger.kernel.org with ESMTP
	id S261215AbVCLXCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:02:51 -0500
X-Spam-Report: SA TESTS
 -3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
  0.8 SARE_BAYES_6x8         BODY: Bayes poison 6x8
  0.8 SARE_BAYES_5x8         BODY: Bayes poison 5x8
  0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
                             [score: 0.4373]
 -1.8 AWL                    AWL: From: address is in the auto white-list
Message-ID: <42337510.4000808@davidcoulson.net>
Date: Sat, 12 Mar 2005 18:02:40 -0500
From: David Coulson <david@davidcoulson.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: unexpected IRQ trap at vector c3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a box which is using a Chaintech MPM800-3 board, with a Compaq 
NC3131 dual port NIC on a PCI slot. I have been unable to get it to run 
stable for more than a day or so with the following errors:

http://davidcoulson.net/~david/out.txt

I have tested with both a UP and SMP kernel, with similar results. 
Presently I am running it with 'apci=off noapic', although it has only 
been up for a few hours. Any information, or details as how to debug 
this issue would be appreciated.

David

Info below:

Boot Mesgs:
Linux version 2.6.10-1-686 (dilinger@toaster.hq.voxel.net) (gcc version 
3.3.5 (Debian 1:3.3.5-6)) #1 Tue Jan 18 04:34:19 EST 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003eff0000 (usable)
  BIOS-e820: 000000003eff0000 - 000000003eff3000 (ACPI NVS)
  BIOS-e820: 000000003eff3000 - 000000003f000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
111MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f4ec0
On node 0 totalpages: 258032
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 28656 pages, LIFO batch:6
DMI 2.3 present.
ACPI: RSDP (v000 PM800                                 ) @ 0x000f8c80
ACPI: RSDT (v001 PM800  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3eff3040
ACPI: FADT (v001 PM800  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3eff30c0
ACPI: MADT (v001 PM800  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3eff7f80
ACPI: DSDT (v001 PM800  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: root=/dev/md0 ro pci=noacpi console=tty0 
console=ttyS0,9600n8
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3056.165 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1015092k/1032128k available (1682k kernel code, 16340k reserved, 
704k data, 172k init, 114624k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6029.31 BogoMIPS (lpj=3014656)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
00004400 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 
00004400 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 
00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
checking if image is initramfs...it isn't (bad gzip magic numbers); 
looks like an initrd
Freeing initrd memory: 4608k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 9 devices
PnPBIOS: Disabled by ACPI
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3227] at 0000:00:11.0
PCI->APIC IRQ transform: (B0,I16,P0) -> 161
PCI->APIC IRQ transform: (B0,I16,P0) -> 161
PCI->APIC IRQ transform: (B0,I16,P1) -> 161
PCI->APIC IRQ transform: (B0,I16,P1) -> 161
PCI->APIC IRQ transform: (B0,I16,P2) -> 161
PCI->APIC IRQ transform: (B0,I18,P0) -> 169
PCI->APIC IRQ transform: (B1,I0,P0) -> 145
PCI->APIC IRQ transform: (B2,I4,P0) -> 145
PCI->APIC IRQ transform: (B2,I5,P0) -> 153
pnp: 00:01: ioport range 0x400-0x47f could not be reserved
pnp: 00:01: ioport range 0x500-0x50f has been reserved
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices:
SLPB PCI0 USB3 USB4 USB5 USB6 USB7 LAN0 AC97 UAR1
ACPI: (supports S0 S1 S4 S5)


gort:/var/run# cat /proc/interrupts
            CPU0
   0:   20864378    IO-APIC-edge  timer
   1:       3104    IO-APIC-edge  i8042
   2:          0          XT-PIC  cascade
   4:       2165    IO-APIC-edge  serial
   9:          0    IO-APIC-edge  acpi
  14:      13286    IO-APIC-edge  ide0
  15:      13181    IO-APIC-edge  ide1
145:     356075   IO-APIC-level  eth1
153:     124771   IO-APIC-level  eth2
161:          0   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd, uhci_hcd, 
ehci_hcd
NMI:          0
LOC:   20864148
ERR:          0
MIS:          0

