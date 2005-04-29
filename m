Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVD2Kyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVD2Kyv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 06:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVD2Kyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 06:54:50 -0400
Received: from relay02.pair.com ([209.68.5.16]:65037 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S262282AbVD2KyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 06:54:12 -0400
X-pair-Authenticated: 24.241.238.70
Message-ID: <42721252.2070902@cybsft.com>
Date: Fri, 29 Apr 2005 05:54:10 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: 2.6.12-rc3 won't boot from aic7899
References: <4269C60C.3070700@cybsft.com> <1114716611.5022.6.camel@mulgrave>	 <4271413F.70809@cybsft.com> <1114719624.5022.14.camel@mulgrave>
In-Reply-To: <1114719624.5022.14.camel@mulgrave>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010207000001030509090707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010207000001030509090707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

James Bottomley wrote:
> On Thu, 2005-04-28 at 15:02 -0500, K.R. Foley wrote:
> 
>>I am attaching the relevant part of the successful boot log from 
>>2.6.12-rc2. I don't have a 2.6.11 boot log handy. I can boot it when I 
>>get home if it will help. I don't know if it is worth mentioning or not, 
>>but I have had to compile in the SCSI drivers since 2.6.12-rc1. Don't 
>>know if it's related to this or not.
>>
>>One other note: I spent enough time tracing this to find that the 
>>message "target1:0:0: Beginning Domain Validation" seems to be generated 
>>by code that is in aic79xx_osm. Is this common code or should this code 
>>not be getting executed for aic7899 cards?
> 
> 
> Actually, the code is in the scsi_transport_spi class.  aic79xx still
> has its own internal domain validation.
> 
> 
>>I'll be happy to try this when I get home.
> 
> 
> Thanks ... it may not work; I don't have access to any drives with the
> problem yours exhibits.
> 
> 
>>Apr 24 23:23:30 porky kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>>Apr 24 23:23:30 porky kernel:         <Adaptec aic7899 Ultra160 SCSI adapter>
>>Apr 24 23:23:30 porky kernel:         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
>>Apr 24 23:23:30 porky kernel: 
>>Apr 24 23:23:30 porky kernel: (scsi1:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
>>Apr 24 23:23:31 porky kernel:   Vendor: SEAGATE   Model: SX118273LC        Rev: 6679
> 
> 
> Yes, that's what I suspected.  Here the internal aic7xxx DV has silently
> configured the drive to be narrow.  Probably because of cable damage or
> something else.
> 
> James
> 
> 
> 
James,

I tried the patch that you sent. It looks like its blowing up now in 
ahc_send_async. At least now we have an oops to look at. I started 
trying to trace through this, but ran out of time. I am sending it on to 
you in hopes that you'll be able to figure this out much quicker than I can.

Thanks,

-- 
    kr

--------------010207000001030509090707
Content-Type: text/plain;
 name="aic7xxx.oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aic7xxx.oops"

Linux version 2.6.12-rc3 (kr@porky.cybersoft.int) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.fc3)) #6 SMP Thu Apr 28 20:04:26 CDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff9e000 (usable)
 BIOS-e820: 000000001ff9e000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fe710
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: WS 620       APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/ console=ttyS0,38400 console=tty0 nmi_watchdog=1
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 931.119 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514224k/523896k available (2074k kernel code, 9116k reserved, 1124k data, 228k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K<7>spurious 8259A interrupt: IRQ7.
, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 06
Booting processor 1/1 eip 2000
Initializing CPU#1
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3698.68 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
testing NMI watchdog ... CPU#1: NMI appears to be stuck!
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 304k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc03e, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/2410] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:1f.2[D] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:04:04.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:04:05.0[A] -> IRQ 17
PCI->APIC IRQ transform: 0000:04:05.1[B] -> IRQ 18
PCI->APIC IRQ transform: 0000:04:0a.0[A] -> IRQ 18
PCI: Failed to allocate mem resource #0:1000@0 for 0000:03:00.0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
nvidiafb: nVidia device/chipset 10DE0103
nvidiafb: nVidia Corporation NV10GL [Quadro]
nvidiafb: HW is currently programmed for CRT
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
nvidiafb: PCI nVidia NV10 framebuffer (64MB @ 0xE8000000)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller at PCI slot 0000:00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG CD-R/RW SW-248F, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Lite-On LTN483S 48x Max, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: QUANTUM   Model: ATLAS10K2-TY092L  Rev: DA40
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
(scsi0:A:0): 6.600MB/s transfers (16bit)
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
 target0:0:0: Ending Domain Validation
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

  Vendor: SEAGATE   Model: SX118273LC        Rev: 6679
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
 target1:0:0: Beginning Domain Validation
(scsi1:A:0): 6.600MB/s transfers (16bit)
(scsi1:A:0:0): parity error detected in Data-in phase. SEQADDR(0x6a) SCSIRATE(0x80)
Unable to handle kernel NULL pointer dereference at virtual address 00000104
 printing eip:
c02786a6
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c02786a6>]    Not tainted VLI
EFLAGS: 00010006   (2.6.12-rc3) 
EIP is at ahc_send_async+0xf6/0x2d0
eax: 00000100   ebx: ffffff00   ecx: 00000000   edx: 00000000
esi: 00000000   edi: dff7ca00   ebp: c0421d9c   esp: c0421d14
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0420000 task=c0351c00)
Stack: 00000000 00000000 00000320 00000000 00000000 dff7ca00 00000100 c0421d40 
       00000050 00000000 00000000 ffffffff c0421dd4 c027861b dfceac00 ffffffbf 
       00000000 dff7ca98 00000000 dff7ca00 c0421d80 c0262b1f dff7ca00 dff7ca90 
Call Trace:
 [<c0103e4f>] show_stack+0x7f/0xa0
 [<c0103ff3>] show_registers+0x163/0x1e0
 [<c0104231>] die+0x101/0x190
 [<c0113142>] do_page_fault+0x472/0x6b9
 [<c0103a7b>] error_code+0x4f/0x54
 [<c0266439>] ahc_set_width+0x109/0x1a0
 [<c026e611>] ahc_reset_channel+0x301/0x530
 [<c0264660>] ahc_handle_scsiint+0x180/0xf80
 [<c02781b8>] ahc_linux_isr+0x218/0x2e0
 [<c013c80e>] handle_IRQ_event+0x3e/0x90
 [<c013c937>] __do_IRQ+0xd7/0x160
 [<c0105666>] do_IRQ+0x26/0x40
 [<c0103946>] common_interrupt+0x1a/0x20
 [<c0100c8e>] cpu_idle+0x4e/0x90
 [<c0422a3f>] start_kernel+0x1af/0x1f0
 [<c010020e>] 0xc010020e
Code: 14 01 00 00 0f b6 97 3b 01 00 00 80 f9 42 8d 42 08 0f 44 d0 8b 8c 97 c0 00 00 00 8d 04 f6 8d 04 46 01 c8 05 00 01 00 00 89 45 90 <0f> b6 48 04 3a 48 0a 0f 84 ec 00 00 00 a1 0c c5 47 c0 85 c0 74 
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 

--------------010207000001030509090707--
