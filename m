Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTLIJJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTLIJJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:09:49 -0500
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:60680 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S263298AbTLIJG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:06:57 -0500
Date: Tue, 9 Dec 2003 03:06:52 -0600
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
Subject: IO-APIC on MS-6163 (2.4.23). ACPI?
Message-ID: <20031209090652.GA1681@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: multipart/mixed; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

Not sure if this is appropriate for ACPI or kernel list so I Cc: both.

On my MS-6163 v3.0 (BX Master) board, the IO-APIC was previously being
used before a blacklist was incorrectly added last year.  Now that the
blacklist is removed when I upgraded to 2.4.23, ACPI doesn't seem to
want to enable IO-APIC usage (dmesg attached).  I don't remember whether
or not I had ACPI enabled when the IO-APIC was working a long time ago.

I added some debug statements to arch/i386/kernel/acpi.c/acpi_boot_init()
to try to diagnose the code flow.  However, when recompiling, almost the en=
tire
kernel must be rebuilt for dependencies, which takes forever on my poor
machine... :(  So I didn't want to spend much more time without some outside
opinion of the situation.

But, as you can see from dmesg, it gets here:
|
=3D=3D=3D>        printk(KERN_INFO PREFIX "past blacklist\n");

#ifdef CONFIG_X86_LOCAL_APIC

        /*=20
         * MADT
         * ----
         * Parse the Multiple APIC Description Table (MADT), if exists.
         * Note that this table provides platform SMP configuration=20
         * information -- the successor to MPS tables.
         */

XXX     result =3D acpi_table_parse(ACPI_APIC, acpi_parse_madt);
        if (!result) {
                return 0;
        }
        else if (result < 0) {
                printk(KERN_ERR PREFIX "Error parsing MADT\n");
                return result;
        }
        else if (result > 1)
                printk(KERN_WARNING PREFIX "Multiple MADT tables exist\n");

=3D=3D=3D>        printk(KERN_INFO PREFIX "past MADT\n")
|
but not here.  There are no other kernel messages printed, so I think XXX i=
s the
failing part.  Why would that happen?  Is it because this is a UP machine a=
nd
the call only works for SMP?  (CONFIG_X86_LOCAL_APIC is definitely enabled)

Is it possible that IO-APIC and ACPI can work individually but be mutually
exclusive on a system if the ACPI tables don't correctly describe the IO-AP=
IC?

I have only a shallow understanding of how this works (from reading www.acp=
i.info
and kernel source) so please bear with me if I am overlooking something obv=
ious.

thanks,

--=20
Ryan Underwood, <nemesis@icequake.net>

--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=messages
Content-Transfer-Encoding: quoted-printable

Dec  9 02:50:40 dbz syslogd 1.4.1#13: restart.
Dec  9 02:50:40 dbz kernel: klogd 1.4.1#13, log source =3D /proc/kmsg start=
ed.
Dec  9 02:50:40 dbz kernel: Inspecting /boot/System.map-2.4.23
Dec  9 02:50:40 dbz kernel: Loaded 18013 symbols from /boot/System.map-2.4.=
23.
Dec  9 02:50:40 dbz kernel: Symbols match kernel version 2.4.23.
Dec  9 02:50:40 dbz kernel: Loaded 937 symbols from 55 modules.
Dec  9 02:50:40 dbz kernel: Linux version 2.4.23 (nemesis@dbz) (gcc version=
 3.3.3 20031206 (prerelease) (Debian)) #5 Tue Dec 9 02:39:46 CST 2003
Dec  9 02:50:40 dbz kernel: BIOS-provided physical RAM map:
Dec  9 02:50:40 dbz kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00=
 (usable)
Dec  9 02:50:40 dbz kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000=
 (reserved)
Dec  9 02:50:40 dbz kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000=
 (reserved)
Dec  9 02:50:40 dbz kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000=
 (usable)
Dec  9 02:50:40 dbz kernel:  BIOS-e820: 000000000fff0000 - 000000000fff3000=
 (ACPI NVS)
Dec  9 02:50:40 dbz kernel:  BIOS-e820: 000000000fff3000 - 0000000010000000=
 (ACPI data)
Dec  9 02:50:40 dbz kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000=
 (reserved)
Dec  9 02:50:40 dbz kernel: 255MB LOWMEM available.
Dec  9 02:50:40 dbz kernel: On node 0 totalpages: 65520
Dec  9 02:50:40 dbz kernel: zone(0): 4096 pages.
Dec  9 02:50:40 dbz kernel: zone(1): 61424 pages.
Dec  9 02:50:40 dbz kernel: zone(2): 0 pages.
Dec  9 02:50:40 dbz kernel: ACPI: ACPI boot init 0 1
Dec  9 02:50:40 dbz kernel: ACPI: RSDP (v000 MSISYS                        =
            ) @ 0x000f7460
Dec  9 02:50:40 dbz kernel: ACPI: RSDT (v001 MSISYS MS-6163W 0x30302e33 AWR=
D 0x00000000) @ 0x0fff3000
Dec  9 02:50:40 dbz kernel: ACPI: FADT (v001 MSISYS MS-6163W 0x30302e33 AWR=
D 0x00000000) @ 0x0fff3040
Dec  9 02:50:40 dbz kernel: ACPI: DSDT (v001 MSISYS AWRDACPI 0x00001000 MSF=
T 0x01000007) @ 0x00000000
Dec  9 02:50:40 dbz kernel: ACPI: past blacklist
Dec  9 02:50:40 dbz kernel: Kernel command line: auto BOOT_IMAGE=3DLinux-ne=
w ro root=3D305 parport=3Dauto video=3Dscrollback:0 acpi=3Dforce nmi_watchd=
og=3D1
Dec  9 02:50:40 dbz kernel: Local APIC disabled by BIOS -- reenabling.
Dec  9 02:50:40 dbz kernel: Found and enabled local APIC!
Dec  9 02:50:40 dbz kernel: Initializing CPU#0
Dec  9 02:50:40 dbz kernel: Detected 801.827 MHz processor.
Dec  9 02:50:40 dbz kernel: Console: colour VGA+ 132x43
Dec  9 02:50:40 dbz kernel: Calibrating delay loop... 1599.07 BogoMIPS
Dec  9 02:50:40 dbz kernel: Memory: 256556k/262080k available (1389k kernel=
 code, 5136k reserved, 514k data, 108k init, 0k highmem)
Dec  9 02:50:40 dbz kernel: Dentry cache hash table entries: 32768 (order: =
6, 262144 bytes)
Dec  9 02:50:40 dbz kernel: Inode cache hash table entries: 16384 (order: 5=
, 131072 bytes)
Dec  9 02:50:40 dbz kernel: Mount cache hash table entries: 512 (order: 0, =
4096 bytes)
Dec  9 02:50:40 dbz kernel: Buffer cache hash table entries: 16384 (order: =
4, 65536 bytes)
Dec  9 02:50:40 dbz kernel: Page-cache hash table entries: 65536 (order: 6,=
 262144 bytes)
Dec  9 02:50:40 dbz kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Dec  9 02:50:40 dbz kernel: CPU: L2 cache: 128K
Dec  9 02:50:40 dbz kernel: Intel machine check architecture supported.
Dec  9 02:50:40 dbz kernel: Intel machine check reporting enabled on CPU#0.
Dec  9 02:50:40 dbz kernel: CPU: Intel Celeron (Coppermine) stepping 03
Dec  9 02:50:40 dbz kernel: Enabling fast FPU save and restore... done.
Dec  9 02:50:40 dbz kernel: Enabling unmasked SIMD FPU exception support...=
 done.
Dec  9 02:50:40 dbz kernel: Checking 'hlt' instruction... OK.
Dec  9 02:50:40 dbz kernel: POSIX conformance testing by UNIFIX
Dec  9 02:50:40 dbz kernel: enabled ExtINT on CPU#0
Dec  9 02:50:40 dbz kernel: ESR value before enabling vector: 00000000
Dec  9 02:50:40 dbz kernel: ESR value after enabling vector: 00000000
Dec  9 02:50:40 dbz kernel: testing NMI watchdog ... OK.
Dec  9 02:50:40 dbz kernel: Using local APIC timer interrupts.
Dec  9 02:50:40 dbz kernel: calibrating APIC timer ...
Dec  9 02:50:40 dbz kernel: ..... CPU clock speed is 801.8444 MHz.
Dec  9 02:50:40 dbz kernel: ..... host bus clock speed is 100.2305 MHz.
Dec  9 02:50:40 dbz kernel: cpu: 0, clocks: 1002305, slice: 501152
Dec  9 02:50:40 dbz kernel: CPU0<T0:1002304,T1:501152,D:0,S:501152,C:100230=
5>
Dec  9 02:50:40 dbz kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@at=
nf.csiro.au)
Dec  9 02:50:40 dbz kernel: mtrr: detected mtrr type: Intel
Dec  9 02:50:40 dbz kernel: ACPI: Subsystem revision 20031002
Dec  9 02:50:40 dbz kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb360, l=
ast bus=3D1
Dec  9 02:50:40 dbz kernel: PCI: Using configuration type 1
Dec  9 02:50:40 dbz kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI=
 Tables successfully acquired
Dec  9 02:50:40 dbz kernel: Parsing all Control Methods:...................=
=2E...............................................
Dec  9 02:50:40 dbz kernel: Table [DSDT](id F004) - 280 Objects with 27 Dev=
ices 67 Methods 23 Regions
Dec  9 02:50:40 dbz kernel: ACPI Namespace successfully loaded at root c031=
9ffc
Dec  9 02:50:40 dbz kernel: ACPI: IRQ9 SCI: Level Trigger.
Dec  9 02:50:40 dbz kernel: evxfevnt-0093 [04] acpi_enable           : Tran=
sition to ACPI mode successful
Dec  9 02:50:40 dbz kernel: evgpeblk-0748 [06] ev_create_gpe_block   : GPE =
00 to 15 [_GPE] 2 regs at 000000000000400C on int 9
Dec  9 02:50:40 dbz kernel: Completing Region/Field/Buffer/Package initiali=
zation:...............................................................
Dec  9 02:50:40 dbz kernel: Initialized 23/23 Regions 16/16 Fields 17/17 Bu=
ffers 7/7 Packages (288 nodes)
Dec  9 02:50:40 dbz kernel: Executing all Device _STA and_INI methods:.....=
=2E......................
Dec  9 02:50:40 dbz kernel: 28 Devices found containing: 28 _STA, 0 _INI me=
thods
Dec  9 02:50:40 dbz kernel: ACPI: Interpreter enabled
Dec  9 02:50:40 dbz kernel: ACPI: Using PIC for interrupt routing
Dec  9 02:50:40 dbz kernel: ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
Dec  9 02:50:40 dbz kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Dec  9 02:50:40 dbz kernel: PCI: Probing PCI hardware (bus 00)
Dec  9 02:50:40 dbz kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7=
 10 *11 12 14 15)
Dec  9 02:50:40 dbz kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7=
 10 11 12 14 15)
Dec  9 02:50:40 dbz kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7=
 10 11 12 14 15)
Dec  9 02:50:40 dbz kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7=
 *10 11 12 14 15)
Dec  9 02:50:40 dbz kernel: PCI: Probing PCI hardware
Dec  9 02:50:40 dbz kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ =
10
Dec  9 02:50:40 dbz kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
Dec  9 02:50:40 dbz kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ =
11
Dec  9 02:50:40 dbz kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
Dec  9 02:50:40 dbz kernel: PCI: Using ACPI for IRQ routing
Dec  9 02:50:40 dbz kernel: PCI: if you experience problems, try using opti=
on 'pci=3Dnoacpi' or even 'acpi=3Doff'
Dec  9 02:50:40 dbz kernel: Limiting direct PCI/PCI transfers.
Dec  9 02:50:40 dbz kernel: Linux NET4.0 for Linux 2.4
Dec  9 02:50:40 dbz kernel: Based upon Swansea University Computer Society =
NET3.039
Dec  9 02:50:40 dbz kernel: Initializing RT netlink socket
Dec  9 02:50:40 dbz kernel: Starting kswapd
Dec  9 02:50:40 dbz kernel: Journalled Block Device driver loaded
Dec  9 02:50:40 dbz kernel: devfs: v1.12c (20020818) Richard Gooch (rgooch@=
atnf.csiro.au)
Dec  9 02:50:40 dbz kernel: devfs: boot_options: 0x1
Dec  9 02:50:40 dbz kernel: pty: 256 Unix98 ptys configured
Dec  9 02:50:40 dbz kernel: Uniform Multi-Platform E-IDE driver Revision: 7=
=2E00beta4-2.4
Dec  9 02:50:40 dbz kernel: ide: Assuming 33MHz system bus speed for PIO mo=
des; override with idebus=3Dxx
Dec  9 02:50:40 dbz kernel: PIIX4: IDE controller at PCI slot 00:07.1
Dec  9 02:50:40 dbz kernel: PIIX4: chipset revision 1
Dec  9 02:50:40 dbz kernel: PIIX4: not 100%% native mode: will probe irqs l=
ater
Dec  9 02:50:40 dbz kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS setting=
s: hda:DMA, hdb:DMA
Dec  9 02:50:40 dbz kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS setting=
s: hdc:DMA, hdd:DMA
Dec  9 02:50:40 dbz kernel: PDC20262: IDE controller at PCI slot 00:0c.0
Dec  9 02:50:40 dbz kernel: PDC20262: chipset revision 1
Dec  9 02:50:40 dbz kernel: PDC20262: not 100%% native mode: will probe irq=
s later
Dec  9 02:50:40 dbz kernel: PDC20262: ROM enabled at 0xea000000
Dec  9 02:50:40 dbz kernel: PDC20262: (U)DMA Burst Bit ENABLED Primary PCI =
Mode Secondary PCI Mode.
Dec  9 02:50:40 dbz kernel:     ide2: BM-DMA at 0xb400-0xb407, BIOS setting=
s: hde:DMA, hdf:pio
Dec  9 02:50:40 dbz kernel:     ide3: BM-DMA at 0xb408-0xb40f, BIOS setting=
s: hdg:DMA, hdh:pio
Dec  9 02:50:40 dbz kernel: hda: WDC WD200EB-11BHF0, ATA DISK drive
Dec  9 02:50:40 dbz kernel: blk: queue c0330260, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec  9 02:50:40 dbz kernel: hde: Maxtor 5T040H4, ATA DISK drive
Dec  9 02:50:40 dbz kernel: blk: queue c0330b08, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec  9 02:50:40 dbz kernel: hdg: Maxtor 94098U8, ATA DISK drive
Dec  9 02:50:40 dbz kernel: blk: queue c0330f5c, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec  9 02:50:40 dbz kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec  9 02:50:40 dbz kernel: ide2 at 0xa400-0xa407,0xa802 on irq 9
Dec  9 02:50:40 dbz kernel: ide3 at 0xac00-0xac07,0xb002 on irq 9
Dec  9 02:50:40 dbz kernel: hda: attached ide-disk driver.
Dec  9 02:50:40 dbz kernel: hda: host protected area =3D> 1
Dec  9 02:50:40 dbz kernel: hda: 39102336 sectors (20020 MB) w/2048KiB Cach=
e, CHS=3D19396/32/63, UDMA(33)
Dec  9 02:50:40 dbz kernel: hde: attached ide-disk driver.
Dec  9 02:50:40 dbz kernel: hde: host protected area =3D> 1
Dec  9 02:50:40 dbz kernel: hde: 80043264 sectors (40982 MB) w/2048KiB Cach=
e, CHS=3D79408/16/63, UDMA(66)
Dec  9 02:50:40 dbz kernel: hdg: attached ide-disk driver.
Dec  9 02:50:40 dbz kernel: hdg: host protected area =3D> 1
Dec  9 02:50:40 dbz kernel: hdg: 80041248 sectors (40981 MB) w/2048KiB Cach=
e, CHS=3D79406/16/63, UDMA(66)
Dec  9 02:50:40 dbz kernel: Partition check:
Dec  9 02:50:40 dbz kernel:  /dev/ide/host0/bus0/target0/lun0: p1 < p5 p6 p=
7 p8 >
Dec  9 02:50:40 dbz kernel:  /dev/ide/host2/bus0/target0/lun0: [PTBL] [4982=
/255/63] p1 p2 < p5 >
Dec  9 02:50:40 dbz kernel:  /dev/ide/host2/bus1/target0/lun0: [PTBL] [4982=
/255/63] p1 p2 < p5 >
Dec  9 02:50:40 dbz kernel: Initializing Cryptographic API
Dec  9 02:50:40 dbz kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec  9 02:50:40 dbz kernel: IP Protocols: ICMP, UDP, TCP
Dec  9 02:50:40 dbz kernel: IP: routing cache hash table of 2048 buckets, 1=
6Kbytes
Dec  9 02:50:40 dbz kernel: TCP: Hash tables configured (established 16384 =
bind 32768)
Dec  9 02:50:40 dbz kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET=
4.0.
Dec  9 02:50:40 dbz kernel: kjournald starting.  Commit interval 5 seconds
Dec  9 02:50:40 dbz kernel: EXT3-fs: mounted filesystem with ordered data m=
ode.
Dec  9 02:50:40 dbz kernel: VFS: Mounted root (ext3 filesystem) readonly.
Dec  9 02:50:40 dbz kernel: Mounted devfs on /dev
Dec  9 02:50:40 dbz kernel: Freeing unused kernel memory: 108k freed
Dec  9 02:50:40 dbz kernel: Adding Swap: 124956k swap-space (priority -1)
Dec  9 02:50:40 dbz kernel: EXT3-fs warning: maximal mount count reached, r=
unning e2fsck is recommended
Dec  9 02:50:40 dbz kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5)=
, internal journal
Dec  9 02:50:40 dbz kernel: Real Time Clock Driver v1.10e
Dec  9 02:50:40 dbz kernel: i2c: initialized
Dec  9 02:50:40 dbz kernel: Linux video capture interface: v1.00
Dec  9 02:50:40 dbz kernel: Software Watchdog Timer: 0.05, timer margin: 60=
 sec
Dec  9 02:50:40 dbz kernel: ACPI: Processor [CPU0] (supports C1 C2, 8 throt=
tling states)
Dec  9 02:50:40 dbz kernel: ACPI: Power Button (FF) [PWRF]
Dec  9 02:50:40 dbz kernel: ACPI: Fan [FAN0] (on)
Dec  9 02:50:40 dbz kernel: SCSI subsystem driver Revision: 1.00
Dec  9 02:50:40 dbz kernel: sym.0.20.0: setting PCI_COMMAND_PARITY...
Dec  9 02:50:40 dbz kernel: sym.0.20.0: setting PCI_COMMAND_INVALIDATE.
Dec  9 02:50:40 dbz kernel: sym0: <875> rev 0x26 on pci bus 0 device 20 fun=
ction 0 irq 9
Dec  9 02:50:40 dbz kernel: sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity =
checking
Dec  9 02:50:40 dbz kernel: sym0: open drain IRQ line driver, using on-chip=
 SRAM
Dec  9 02:50:40 dbz kernel: sym0: using LOAD/STORE-based firmware.
Dec  9 02:50:40 dbz kernel: sym0: SCAN AT BOOT disabled for targets 0 4 5 6=
 8 9 10 11 12 13 14 15.
Dec  9 02:50:40 dbz kernel: sym0: SCAN FOR LUNS disabled for targets 0 1 2 =
3 4 5 6 8 9 10 11 12 13 14 15.
Dec  9 02:50:40 dbz kernel: sym0: SCSI BUS has been reset.
Dec  9 02:50:40 dbz kernel: scsi0 : sym-2.1.17a
Dec  9 02:50:40 dbz kernel: blk: queue cff3fbd0, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec  9 02:50:40 dbz kernel:   Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Re=
v: 1.13
Dec  9 02:50:40 dbz kernel:   Type:   CD-ROM                             AN=
SI SCSI revision: 02
Dec  9 02:50:40 dbz kernel: blk: queue cff3fcd8, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec  9 02:50:40 dbz kernel:   Vendor: SONY      Model: CD-RW  CRX140S    Re=
v: 1.0e
Dec  9 02:50:40 dbz kernel:   Type:   CD-ROM                             AN=
SI SCSI revision: 04
Dec  9 02:50:40 dbz kernel: blk: queue cff3fde0, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec  9 02:50:40 dbz kernel:   Vendor: PIONEER   Model: DVD-ROM DVD-303   Re=
v: 1.09
Dec  9 02:50:40 dbz kernel:   Type:   CD-ROM                             AN=
SI SCSI revision: 02
Dec  9 02:50:40 dbz kernel: blk: queue cff3fee8, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec  9 02:50:40 dbz kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, i=
d 1, lun 0
Dec  9 02:50:40 dbz kernel: Attached scsi CD-ROM sr1 at scsi0, channel 0, i=
d 2, lun 0
Dec  9 02:50:40 dbz kernel: Attached scsi CD-ROM sr2 at scsi0, channel 0, i=
d 3, lun 0
Dec  9 02:50:40 dbz kernel: sym0:1: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, off=
set 15)
Dec  9 02:50:40 dbz kernel: sr0: scsi-1 drive
Dec  9 02:50:40 dbz kernel: Uniform CD-ROM driver Revision: 3.12
Dec  9 02:50:40 dbz kernel: sym0:2: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, of=
fset 15)
Dec  9 02:50:40 dbz kernel: sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/f=
orm2 cdda tray
Dec  9 02:50:40 dbz kernel: sym0:3: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, off=
set 8)
Dec  9 02:50:40 dbz kernel: sr2: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda=
 tray
Dec  9 02:50:40 dbz kernel: Linux Tulip driver version 0.9.15-pre12 (Aug 9,=
 2002)
Dec  9 02:50:40 dbz kernel: tulip0:  EEPROM default media type Autosense.
Dec  9 02:50:40 dbz kernel: tulip0:  Index #0 - Media MII (#11) described b=
y a 21142 MII PHY (3) block.
Dec  9 02:50:40 dbz kernel: tulip0:  MII transceiver #1 config 1000 status =
782d advertising 01e1.
Dec  9 02:50:40 dbz kernel: eth0: Digital DS21143 Tulip rev 65 at 0xd089200=
0, 00:C0:F0:4D:28:0E, IRQ 9.
Dec  9 02:50:40 dbz kernel: matroxfb: Matrox G400 (AGP) detected
Dec  9 02:50:40 dbz kernel: matroxfb: MTRR's turned on
Dec  9 02:50:40 dbz kernel: matroxfb: 640x480x8bpp (virtual: 640x26208)
Dec  9 02:50:40 dbz kernel: matroxfb: framebuffer at 0xE8000000, mapped to =
0xd08c1000, size 33554432
Dec  9 02:50:40 dbz kernel: Console: switching to colour frame buffer devic=
e 80x30
Dec  9 02:50:40 dbz kernel: fb0: MATROX VGA frame buffer device
Dec  9 02:50:40 dbz kernel: i2c-core.o: i2c core module
Dec  9 02:50:40 dbz kernel: i2c-algo-bit.o: i2c bit algorithm module
Dec  9 02:50:40 dbz kernel: i2c-core.o: adapter DDC:fb0 #0 on i2c-matroxfb =
registered as adapter 0.
Dec  9 02:50:40 dbz kernel: i2c-core.o: adapter DDC:fb0 #1 on i2c-matroxfb =
registered as adapter 1.
Dec  9 02:50:40 dbz kernel: i2c-core.o: adapter MAVEN:fb0 on i2c-matroxfb r=
egistered as adapter 2.
Dec  9 02:50:40 dbz kernel: i2c-core.o: driver maven registered.
Dec  9 02:50:40 dbz kernel: i2c-core.o: client [maven client] registered to=
 adapter [MAVEN:fb0 on i2c-matroxfb](pos. 0).
Dec  9 02:50:40 dbz kernel: matroxfb_crtc2: secondary head of fb0 was regis=
tered as fb1
Dec  9 02:50:40 dbz kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Dec  9 02:50:40 dbz kernel: agpgart: Maximum main memory to use for agp mem=
ory: 203M
Dec  9 02:50:40 dbz kernel: agpgart: Detected Intel 440BX chipset
Dec  9 02:50:40 dbz kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Dec  9 02:50:40 dbz kernel: [drm] Initialized mga 3.1.0 20021029 on minor 0
Dec  9 02:50:40 dbz kernel: Matrox MGA G200/G400/G450/G550 YUV Video interf=
ace v2.01 (c) Aaron Holtzman & A'rpi
Dec  9 02:50:40 dbz kernel: mga_vid: Found MGA G400/G450 at 01:00.0 [01:00.=
0]
Dec  9 02:50:40 dbz kernel: mga_vid: MMIO at 0xd2940000 IRQ: 11  framebuffe=
r: 0xE8000000
Dec  9 02:50:40 dbz kernel: mga_vid: OPTION word: 0x50044120  mem: 0x10  SG=
RAM
Dec  9 02:50:40 dbz kernel: mga_vid: RAMSIZE forced to 24 MB
Dec  9 02:50:40 dbz kernel: usb.c: registered new driver usbdevfs
Dec  9 02:50:40 dbz kernel: usb.c: registered new driver hub
Dec  9 02:50:40 dbz kernel: usb-uhci.c: $Revision: 1.275 $ time 16:12:33 De=
c  5 2003
Dec  9 02:50:40 dbz kernel: usb-uhci.c: High bandwidth mode enabled
Dec  9 02:50:40 dbz kernel: usb-uhci.c: USB UHCI at I/O 0xa000, IRQ 10
Dec  9 02:50:40 dbz kernel: usb-uhci.c: Detected 2 ports
Dec  9 02:50:40 dbz kernel: usb.c: new USB bus registered, assigned bus num=
ber 1
Dec  9 02:50:40 dbz kernel: Product: USB UHCI Root Hub
Dec  9 02:50:40 dbz kernel: SerialNumber: a000
Dec  9 02:50:40 dbz kernel: hub.c: USB hub found
Dec  9 02:50:40 dbz kernel: hub.c: 2 ports detected
Dec  9 02:50:40 dbz kernel: usb-uhci.c: v1.275:USB Universal Host Controlle=
r Interface driver
Dec  9 02:50:40 dbz kernel: usb.c: registered new driver iforce
Dec  9 02:50:40 dbz kernel: hub.c: new USB device 00:07.2-1, assigned addre=
ss 2
Dec  9 02:50:40 dbz kernel: hub.c: USB hub found
Dec  9 02:50:40 dbz kernel: hub.c: 7 ports detected
Dec  9 02:50:40 dbz kernel: hub.c: new USB device 00:07.2-2, assigned addre=
ss 3
Dec  9 02:50:40 dbz kernel: hub.c: USB hub found
Dec  9 02:50:40 dbz kernel: hub.c: 7 ports detected
Dec  9 02:50:40 dbz kernel: hub.c: new USB device 00:07.2-1.4, assigned add=
ress 4
Dec  9 02:50:40 dbz kernel: Manufacturer: EPSON
Dec  9 02:50:40 dbz kernel: Product: Perfection1240
Dec  9 02:50:40 dbz kernel: usb.c: USB device 4 (vend/prod 0x4b8/0x10b) is =
not claimed by any active driver.
Dec  9 02:50:40 dbz kernel:   Length              =3D 18
Dec  9 02:50:40 dbz kernel:   DescriptorType      =3D 01
Dec  9 02:50:40 dbz kernel:   USB version         =3D 1.00
Dec  9 02:50:40 dbz kernel:   Vendor:Product      =3D 04b8:010b
Dec  9 02:50:40 dbz kernel:   MaxPacketSize0      =3D 64
Dec  9 02:50:40 dbz kernel:   NumConfigurations   =3D 1
Dec  9 02:50:40 dbz kernel:   Device version      =3D 1.14
Dec  9 02:50:40 dbz kernel:   Device Class:SubClass:Protocol =3D ff:ff:ff
Dec  9 02:50:40 dbz kernel:     Vendor class
Dec  9 02:50:40 dbz kernel: Configuration:
Dec  9 02:50:40 dbz kernel:   bLength             =3D    9
Dec  9 02:50:40 dbz kernel:   bDescriptorType     =3D   02
Dec  9 02:50:40 dbz kernel:   wTotalLength        =3D 0020
Dec  9 02:50:40 dbz kernel:   bNumInterfaces      =3D   01
Dec  9 02:50:40 dbz kernel:   bConfigurationValue =3D   01
Dec  9 02:50:40 dbz kernel:   iConfiguration      =3D   00
Dec  9 02:50:40 dbz kernel:   bmAttributes        =3D   40
Dec  9 02:50:40 dbz kernel:   MaxPower            =3D    2mA
Dec  9 02:50:40 dbz kernel:=20
Dec  9 02:50:40 dbz kernel:   Interface: 0
Dec  9 02:50:40 dbz kernel:   Alternate Setting:  0
Dec  9 02:50:40 dbz kernel:     bLength             =3D    9
Dec  9 02:50:40 dbz kernel:     bDescriptorType     =3D   04
Dec  9 02:50:40 dbz kernel:     bInterfaceNumber    =3D   00
Dec  9 02:50:40 dbz kernel:     bAlternateSetting   =3D   00
Dec  9 02:50:40 dbz kernel:     bNumEndpoints       =3D   02
Dec  9 02:50:40 dbz kernel:     bInterface Class:SubClass:Protocol =3D   ff=
:ff:ff
Dec  9 02:50:40 dbz kernel:     iInterface          =3D   00
Dec  9 02:50:40 dbz kernel:     Endpoint:
Dec  9 02:50:40 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   81 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   02 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel: hub.c: new USB device 00:07.2-1.5, assigned add=
ress 5
Dec  9 02:50:41 dbz kernel: usb.c: USB device 5 (vend/prod 0x1645/0x6) is n=
ot claimed by any active driver.
Dec  9 02:50:41 dbz kernel:   Length              =3D 18
Dec  9 02:50:41 dbz kernel:   DescriptorType      =3D 01
Dec  9 02:50:41 dbz kernel:   USB version         =3D 1.00
Dec  9 02:50:41 dbz kernel:   Vendor:Product      =3D 1645:0006
Dec  9 02:50:41 dbz kernel:   MaxPacketSize0      =3D 8
Dec  9 02:50:41 dbz kernel:   NumConfigurations   =3D 1
Dec  9 02:50:41 dbz kernel:   Device version      =3D 1.00
Dec  9 02:50:41 dbz kernel:   Device Class:SubClass:Protocol =3D 00:00:00
Dec  9 02:50:41 dbz kernel:     Per-interface classes
Dec  9 02:50:41 dbz kernel: Configuration:
Dec  9 02:50:41 dbz kernel:   bLength             =3D    9
Dec  9 02:50:41 dbz kernel:   bDescriptorType     =3D   02
Dec  9 02:50:41 dbz kernel:   wTotalLength        =3D 004e
Dec  9 02:50:41 dbz kernel:   bNumInterfaces      =3D   01
Dec  9 02:50:41 dbz kernel:   bConfigurationValue =3D   01
Dec  9 02:50:41 dbz kernel:   iConfiguration      =3D   00
Dec  9 02:50:41 dbz kernel:   bmAttributes        =3D   80
Dec  9 02:50:41 dbz kernel:   MaxPower            =3D   98mA
Dec  9 02:50:41 dbz kernel:=20
Dec  9 02:50:41 dbz kernel:   Interface: 0
Dec  9 02:50:41 dbz kernel:   Alternate Setting:  0
Dec  9 02:50:41 dbz kernel:     bLength             =3D    9
Dec  9 02:50:41 dbz kernel:     bDescriptorType     =3D   04
Dec  9 02:50:41 dbz kernel:     bInterfaceNumber    =3D   00
Dec  9 02:50:41 dbz kernel:     bAlternateSetting   =3D   00
Dec  9 02:50:41 dbz kernel:     bNumEndpoints       =3D   01
Dec  9 02:50:41 dbz kernel:     bInterface Class:SubClass:Protocol =3D   07=
:01:01
Dec  9 02:50:41 dbz kernel:     iInterface          =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   01 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:   Alternate Setting:  1
Dec  9 02:50:41 dbz kernel:     bLength             =3D    9
Dec  9 02:50:41 dbz kernel:     bDescriptorType     =3D   04
Dec  9 02:50:41 dbz kernel:     bInterfaceNumber    =3D   00
Dec  9 02:50:41 dbz kernel:     bAlternateSetting   =3D   01
Dec  9 02:50:41 dbz kernel:     bNumEndpoints       =3D   02
Dec  9 02:50:41 dbz kernel:     bInterface Class:SubClass:Protocol =3D   07=
:01:02
Dec  9 02:50:41 dbz kernel:     iInterface          =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   01 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   82 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:   Alternate Setting:  2
Dec  9 02:50:41 dbz kernel:     bLength             =3D    9
Dec  9 02:50:41 dbz kernel:     bDescriptorType     =3D   04
Dec  9 02:50:41 dbz kernel:     bInterfaceNumber    =3D   00
Dec  9 02:50:41 dbz kernel:     bAlternateSetting   =3D   02
Dec  9 02:50:41 dbz kernel:     bNumEndpoints       =3D   03
Dec  9 02:50:41 dbz kernel:     bInterface Class:SubClass:Protocol =3D   ff=
:00:ff
Dec  9 02:50:41 dbz kernel:     iInterface          =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   01 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   82 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   83 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   03 (Interrupt)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0004
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel: hub.c: new USB device 00:07.2-1.6, assigned add=
ress 6
Dec  9 02:50:41 dbz kernel: usb.c: USB device 6 (vend/prod 0x1645/0x8002) i=
s not claimed by any active driver.
Dec  9 02:50:41 dbz kernel:   Length              =3D 18
Dec  9 02:50:41 dbz kernel:   DescriptorType      =3D 01
Dec  9 02:50:41 dbz kernel:   USB version         =3D 1.00
Dec  9 02:50:41 dbz kernel:   Vendor:Product      =3D 1645:8002
Dec  9 02:50:41 dbz kernel:   MaxPacketSize0      =3D 64
Dec  9 02:50:41 dbz kernel:   NumConfigurations   =3D 1
Dec  9 02:50:41 dbz kernel:   Device version      =3D 2.04
Dec  9 02:50:41 dbz kernel:   Device Class:SubClass:Protocol =3D ff:ff:ff
Dec  9 02:50:41 dbz kernel:     Vendor class
Dec  9 02:50:41 dbz kernel: Configuration:
Dec  9 02:50:41 dbz kernel:   bLength             =3D    9
Dec  9 02:50:41 dbz kernel:   bDescriptorType     =3D   02
Dec  9 02:50:41 dbz kernel:   wTotalLength        =3D 00da
Dec  9 02:50:41 dbz kernel:   bNumInterfaces      =3D   01
Dec  9 02:50:41 dbz kernel:   bConfigurationValue =3D   01
Dec  9 02:50:41 dbz kernel:   iConfiguration      =3D   00
Dec  9 02:50:41 dbz kernel:   bmAttributes        =3D   80
Dec  9 02:50:41 dbz kernel:   MaxPower            =3D  100mA
Dec  9 02:50:41 dbz kernel:=20
Dec  9 02:50:41 dbz kernel:   Interface: 0
Dec  9 02:50:41 dbz kernel:   Alternate Setting:  0
Dec  9 02:50:41 dbz kernel:     bLength             =3D    9
Dec  9 02:50:41 dbz kernel:     bDescriptorType     =3D   04
Dec  9 02:50:41 dbz kernel:     bInterfaceNumber    =3D   00
Dec  9 02:50:41 dbz kernel:     bAlternateSetting   =3D   00
Dec  9 02:50:41 dbz kernel:     bNumEndpoints       =3D   00
Dec  9 02:50:41 dbz kernel:     bInterface Class:SubClass:Protocol =3D   ff=
:ff:ff
Dec  9 02:50:41 dbz kernel:     iInterface          =3D   00
Dec  9 02:50:41 dbz kernel:   Alternate Setting:  1
Dec  9 02:50:41 dbz kernel:     bLength             =3D    9
Dec  9 02:50:41 dbz kernel:     bDescriptorType     =3D   04
Dec  9 02:50:41 dbz kernel:     bInterfaceNumber    =3D   00
Dec  9 02:50:41 dbz kernel:     bAlternateSetting   =3D   01
Dec  9 02:50:41 dbz kernel:     bNumEndpoints       =3D   0d
Dec  9 02:50:41 dbz kernel:     bInterface Class:SubClass:Protocol =3D   ff=
:ff:ff
Dec  9 02:50:41 dbz kernel:     iInterface          =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   81 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   03 (Interrupt)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0010
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   0a
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   82 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   02 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   84 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   04 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   86 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   06 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   88 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0010
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   08 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0010
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   89 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0010
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   09 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0010
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   8a (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0010
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   0a (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0010
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel:   Alternate Setting:  2
Dec  9 02:50:41 dbz kernel:     bLength             =3D    9
Dec  9 02:50:41 dbz kernel:     bDescriptorType     =3D   04
Dec  9 02:50:41 dbz kernel:     bInterfaceNumber    =3D   00
Dec  9 02:50:41 dbz kernel:     bAlternateSetting   =3D   02
Dec  9 02:50:41 dbz kernel:     bNumEndpoints       =3D   0d
Dec  9 02:50:41 dbz kernel:     bInterface Class:SubClass:Protocol =3D   ff=
:ff:ff
Dec  9 02:50:41 dbz kernel:     iInterface          =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   81 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   03 (Interrupt)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   0a
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   82 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   02 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   84 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   04 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   86 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   06 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   88 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0100
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   08 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0100
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   89 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0010
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   09 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0010
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   8a (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0010
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   0a (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0010
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   01
Dec  9 02:50:41 dbz kernel: hub.c: new USB device 00:07.2-2.1, assigned add=
ress 7
Dec  9 02:50:41 dbz kernel: Manufacturer: Gravis
Dec  9 02:50:41 dbz kernel: Product: Xterminator Digital Gamepad
Dec  9 02:50:41 dbz kernel: usb.c: USB device 7 (vend/prod 0x47d/0x4003) is=
 not claimed by any active driver.
Dec  9 02:50:41 dbz kernel:   Length              =3D 18
Dec  9 02:50:41 dbz kernel:   DescriptorType      =3D 01
Dec  9 02:50:41 dbz kernel:   USB version         =3D 1.00
Dec  9 02:50:41 dbz kernel:   Vendor:Product      =3D 047d:4003
Dec  9 02:50:41 dbz kernel:   MaxPacketSize0      =3D 8
Dec  9 02:50:41 dbz kernel:   NumConfigurations   =3D 1
Dec  9 02:50:41 dbz kernel:   Device version      =3D 1.00
Dec  9 02:50:41 dbz kernel:   Device Class:SubClass:Protocol =3D 00:00:00
Dec  9 02:50:41 dbz kernel:     Per-interface classes
Dec  9 02:50:41 dbz kernel: Configuration:
Dec  9 02:50:41 dbz kernel:   bLength             =3D    9
Dec  9 02:50:41 dbz kernel:   bDescriptorType     =3D   02
Dec  9 02:50:41 dbz kernel:   wTotalLength        =3D 0022
Dec  9 02:50:41 dbz kernel:   bNumInterfaces      =3D   01
Dec  9 02:50:41 dbz kernel:   bConfigurationValue =3D   01
Dec  9 02:50:41 dbz kernel:   iConfiguration      =3D   00
Dec  9 02:50:41 dbz kernel:   bmAttributes        =3D   80
Dec  9 02:50:41 dbz kernel:   MaxPower            =3D  100mA
Dec  9 02:50:41 dbz kernel:=20
Dec  9 02:50:41 dbz kernel:   Interface: 0
Dec  9 02:50:41 dbz kernel:   Alternate Setting:  0
Dec  9 02:50:41 dbz kernel:     bLength             =3D    9
Dec  9 02:50:41 dbz kernel:     bDescriptorType     =3D   04
Dec  9 02:50:41 dbz kernel:     bInterfaceNumber    =3D   00
Dec  9 02:50:41 dbz kernel:     bAlternateSetting   =3D   00
Dec  9 02:50:41 dbz kernel:     bNumEndpoints       =3D   01
Dec  9 02:50:41 dbz kernel:     bInterface Class:SubClass:Protocol =3D   03=
:00:00
Dec  9 02:50:41 dbz kernel:     iInterface          =3D   03
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   81 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   03 (Interrupt)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0008
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   0a
Dec  9 02:50:41 dbz kernel: hub.c: new USB device 00:07.2-2.2, assigned add=
ress 8
Dec  9 02:50:41 dbz kernel: Manufacturer: Gravis
Dec  9 02:50:41 dbz kernel: Product: GamePad Pro USB=20
Dec  9 02:50:41 dbz kernel: usb.c: USB device 8 (vend/prod 0x428/0x4001) is=
 not claimed by any active driver.
Dec  9 02:50:41 dbz kernel:   Length              =3D 18
Dec  9 02:50:41 dbz kernel:   DescriptorType      =3D 01
Dec  9 02:50:41 dbz kernel:   USB version         =3D 1.00
Dec  9 02:50:41 dbz kernel:   Vendor:Product      =3D 0428:4001
Dec  9 02:50:41 dbz kernel:   MaxPacketSize0      =3D 8
Dec  9 02:50:41 dbz kernel:   NumConfigurations   =3D 1
Dec  9 02:50:41 dbz kernel:   Device version      =3D 2.00
Dec  9 02:50:41 dbz kernel:   Device Class:SubClass:Protocol =3D 00:00:00
Dec  9 02:50:41 dbz kernel:     Per-interface classes
Dec  9 02:50:41 dbz kernel: Configuration:
Dec  9 02:50:41 dbz kernel:   bLength             =3D    9
Dec  9 02:50:41 dbz kernel:   bDescriptorType     =3D   02
Dec  9 02:50:41 dbz kernel:   wTotalLength        =3D 0022
Dec  9 02:50:41 dbz kernel:   bNumInterfaces      =3D   01
Dec  9 02:50:41 dbz kernel:   bConfigurationValue =3D   01
Dec  9 02:50:41 dbz kernel:   iConfiguration      =3D   00
Dec  9 02:50:41 dbz kernel:   bmAttributes        =3D   80
Dec  9 02:50:41 dbz kernel:   MaxPower            =3D  100mA
Dec  9 02:50:41 dbz kernel:=20
Dec  9 02:50:41 dbz kernel:   Interface: 0
Dec  9 02:50:41 dbz kernel:   Alternate Setting:  0
Dec  9 02:50:41 dbz kernel:     bLength             =3D    9
Dec  9 02:50:41 dbz kernel:     bDescriptorType     =3D   04
Dec  9 02:50:41 dbz kernel:     bInterfaceNumber    =3D   00
Dec  9 02:50:41 dbz kernel:     bAlternateSetting   =3D   00
Dec  9 02:50:41 dbz kernel:     bNumEndpoints       =3D   01
Dec  9 02:50:41 dbz kernel:     bInterface Class:SubClass:Protocol =3D   03=
:00:00
Dec  9 02:50:41 dbz kernel:     iInterface          =3D   03
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   81 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   03 (Interrupt)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0006
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   0a
Dec  9 02:50:41 dbz kernel: hub.c: new USB device 00:07.2-2.3, assigned add=
ress 9
Dec  9 02:50:41 dbz kernel: isapnp: Scanning for PnP cards...
Dec  9 02:50:41 dbz kernel: isapnp: No Plug & Play device found
Dec  9 02:50:41 dbz kernel: Manufacturer: Logitech
Dec  9 02:50:41 dbz kernel: Serial driver version 5.05c (2001-07-08) with M=
ANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Dec  9 02:50:41 dbz kernel: ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
Dec  9 02:50:41 dbz kernel: ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Dec  9 02:50:41 dbz kernel: Product: Wingman Force
Dec  9 02:50:41 dbz kernel: input0: Logitech WingMan Force [10 effects, 200=
 bytes memory] on usb1:9.0
Dec  9 02:50:41 dbz kernel: reiserfs: found format "3.6" with standard jour=
nal
Dec  9 02:50:41 dbz kernel: hub.c: new USB device 00:07.2-2.5, assigned add=
ress 10
Dec  9 02:50:41 dbz kernel: Manufacturer: SCM Microsystems Inc.
Dec  9 02:50:41 dbz kernel: Product: eUSB SmartMedia Adapter
Dec  9 02:50:41 dbz kernel: usb.c: USB device 10 (vend/prod 0x4e6/0x3) is n=
ot claimed by any active driver.
Dec  9 02:50:41 dbz kernel:   Length              =3D 18
Dec  9 02:50:41 dbz kernel:   DescriptorType      =3D 01
Dec  9 02:50:41 dbz kernel:   USB version         =3D 1.10
Dec  9 02:50:41 dbz kernel:   Vendor:Product      =3D 04e6:0003
Dec  9 02:50:41 dbz kernel:   MaxPacketSize0      =3D 16
Dec  9 02:50:41 dbz kernel:   NumConfigurations   =3D 1
Dec  9 02:50:41 dbz kernel:   Device version      =3D 2.08
Dec  9 02:50:41 dbz kernel:   Device Class:SubClass:Protocol =3D 00:00:00
Dec  9 02:50:41 dbz kernel:     Per-interface classes
Dec  9 02:50:41 dbz kernel: Configuration:
Dec  9 02:50:41 dbz kernel:   bLength             =3D    9
Dec  9 02:50:41 dbz kernel:   bDescriptorType     =3D   02
Dec  9 02:50:41 dbz kernel:   wTotalLength        =3D 0027
Dec  9 02:50:41 dbz kernel:   bNumInterfaces      =3D   01
Dec  9 02:50:41 dbz kernel:   bConfigurationValue =3D   01
Dec  9 02:50:41 dbz kernel:   iConfiguration      =3D   03
Dec  9 02:50:41 dbz kernel:   bmAttributes        =3D   a0
Dec  9 02:50:41 dbz kernel:   MaxPower            =3D  100mA
Dec  9 02:50:41 dbz kernel:=20
Dec  9 02:50:41 dbz kernel:   Interface: 0
Dec  9 02:50:41 dbz kernel:   Alternate Setting:  0
Dec  9 02:50:41 dbz kernel:     bLength             =3D    9
Dec  9 02:50:41 dbz kernel:     bDescriptorType     =3D   04
Dec  9 02:50:41 dbz kernel:     bInterfaceNumber    =3D   00
Dec  9 02:50:41 dbz kernel:     bAlternateSetting   =3D   00
Dec  9 02:50:41 dbz kernel:     bNumEndpoints       =3D   03
Dec  9 02:50:41 dbz kernel:     bInterface Class:SubClass:Protocol =3D   ff=
:01:01
Dec  9 02:50:41 dbz kernel:     iInterface          =3D   04
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   01 (out)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   82 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0040
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   00
Dec  9 02:50:41 dbz kernel:     Endpoint:
Dec  9 02:50:41 dbz kernel:       bLength             =3D    7
Dec  9 02:50:41 dbz kernel:       bDescriptorType     =3D   05
Dec  9 02:50:41 dbz kernel:       bEndpointAddress    =3D   83 (in)
Dec  9 02:50:41 dbz kernel:       bmAttributes        =3D   03 (Interrupt)
Dec  9 02:50:41 dbz kernel:       wMaxPacketSize      =3D 0002
Dec  9 02:50:41 dbz kernel:       bInterval           =3D   20
Dec  9 02:50:41 dbz kernel: reiserfs: checking transaction log (device ide0=
(3,6)) ...
Dec  9 02:50:41 dbz kernel: for (ide0(3,6))
Dec  9 02:50:41 dbz kernel: ide0(3,6):Using r5 hash to sort names
Dec  9 02:50:41 dbz kernel: kjournald starting.  Commit interval 5 seconds
Dec  9 02:50:41 dbz kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8)=
, internal journal
Dec  9 02:50:41 dbz kernel: EXT3-fs: mounted filesystem with ordered data m=
ode.
Dec  9 02:50:41 dbz kernel: reiserfs: found format "3.6" with standard jour=
nal
Dec  9 02:50:41 dbz kernel: reiserfs: checking transaction log (device ide3=
(34,5)) ...
Dec  9 02:50:41 dbz kernel: for (ide3(34,5))
Dec  9 02:50:41 dbz kernel: ide3(34,5):Using r5 hash to sort names
Dec  9 02:50:41 dbz kernel: loop: loaded (max 8 devices)
Dec  9 02:50:41 dbz kernel: reiserfs: found format "3.6" with standard jour=
nal
Dec  9 02:50:41 dbz kernel: reiserfs: checking transaction log (device loop=
(7,0)) ...
Dec  9 02:50:41 dbz kernel: for (loop(7,0))
Dec  9 02:50:41 dbz kernel: loop(7,0):Using r5 hash to sort names
Dec  9 02:50:41 dbz kernel: uhci.c: USB Universal Host Controller Interface=
 driver v1.1
Dec  9 02:50:41 dbz kernel: usb.c: registered new driver usbscanner
Dec  9 02:50:41 dbz kernel: scanner.c: USB scanner device (0x04b8/0x010b) n=
ow attached to scanner0
Dec  9 02:50:41 dbz kernel: scanner.c: 0.4.15:USB Scanner Driver
Dec  9 02:50:41 dbz kernel: usb.c: registered new driver hid
Dec  9 02:50:41 dbz kernel: usb-uhci.c: interrupt, status 2, frame# 1347
Dec  9 02:50:41 dbz kernel: usb_control/bulk_msg: timeout
Dec  9 02:50:41 dbz kernel: input: USB HID v1.00 Joystick [Gravis Xterminat=
or Digital Gamepad] on usb1:7.0
Dec  9 02:50:41 dbz kernel: usb-uhci.c: interrupt, status 2, frame# 236
Dec  9 02:50:41 dbz kernel: usb_control/bulk_msg: timeout
Dec  9 02:50:41 dbz kernel: usb-uhci.c: interrupt, status 3, frame# 1150
Dec  9 02:50:41 dbz kernel: input: USB HID v1.00 Gamepad [Gravis GamePad Pr=
o USB ] on usb1:8.0
Dec  9 02:50:41 dbz kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik =
<vojtech@suse.cz>
Dec  9 02:50:41 dbz kernel: hid-core.c: USB HID support drivers
Dec  9 02:50:41 dbz kernel: mice: PS/2 mouse device common for all mice
Dec  9 02:50:41 dbz kernel: Initializing USB Mass Storage driver...
Dec  9 02:50:41 dbz kernel: usb.c: registered new driver usb-storage
Dec  9 02:50:41 dbz kernel: scsi1 : SCSI emulation for USB Mass Storage dev=
ices
Dec  9 02:50:41 dbz kernel:   Vendor: Sandisk   Model: ImageMate SDDR09  Re=
v: 0208
Dec  9 02:50:41 dbz kernel:   Type:   Direct-Access                      AN=
SI SCSI revision: 02
Dec  9 02:50:41 dbz kernel: Attached scsi removable disk sda at scsi1, chan=
nel 0, id 0, lun 0
Dec  9 02:50:41 dbz kernel: usb-uhci.c: interrupt, status 3, frame# 1075
Dec  9 02:50:41 dbz kernel: sddr09: Found Flash card, ID =3D 98 73 A5 BA: M=
anuf. Toshiba, 16 MB, 128-bit ID
Dec  9 02:50:41 dbz kernel: SCSI device sda: 32000 512-byte hdwr sectors (1=
6 MB)
Dec  9 02:50:41 dbz kernel: sda: Write Protect is off
Dec  9 02:50:41 dbz kernel:  /dev/scsi/host1/bus0/target0/lun0: p1
Dec  9 02:50:41 dbz kernel: USB Mass Storage support registered.
Dec  9 02:50:41 dbz kernel: eth0: Setting full-duplex based on MII#1 link p=
artner capability of 45e1.
Dec  9 02:50:41 dbz kernel: IA-32 Microcode Update Driver: v1.11 <tigran@ve=
ritas.com>
Dec  9 02:50:41 dbz kernel: microcode: CPU0 updated from revision 16 to 20,=
 date=3D02062001
Dec  9 02:50:41 dbz kernel: microcode: freed 2048 bytes
Dec  9 02:50:42 dbz kernel: Vortex: hardware init.... <6>done.
Dec  9 02:50:43 dbz usb.agent[147]: ... no modules for USB product 1645/800=
2/204
Dec  9 02:50:44 dbz usb.agent[153]: Setup hid for USB product 47d/4003/100
Dec  9 02:50:44 dbz usb.agent[153]: kernel driver hid already loaded
Dec  9 02:50:44 dbz usb.agent[159]: Setup hid for USB product 428/4001/200
Dec  9 02:50:44 dbz usb.agent[159]: kernel driver hid already loaded
Dec  9 02:50:44 dbz usb.agent[159]: Setup joydev for USB product 428/4001/2=
00
Dec  9 02:50:44 dbz usb.agent[159]: kernel driver joydev already loaded
Dec  9 02:50:45 dbz usb.agent[178]: Setup iforce for USB product 46d/c281/1=
00
Dec  9 02:50:45 dbz usb.agent[178]: kernel driver iforce already loaded
Dec  9 02:50:45 dbz usb.agent[103]: Setup usbcore for USB product 0/0/0
Dec  9 02:50:45 dbz usb.agent[103]: kernel driver usbcore already loaded
Dec  9 02:50:45 dbz usb.agent[103]: Setup usbcore for USB product 0/0/0
Dec  9 02:50:45 dbz usb.agent[103]: kernel driver usbcore already loaded
Dec  9 02:50:46 dbz usb.agent[196]: Setup usb-storage for USB product 4e6/3=
/208
Dec  9 02:50:46 dbz usb.agent[196]: kernel driver usb-storage already loaded
Dec  9 02:50:46 dbz usb.agent[123]: Setup usbcore for USB product 451/1446/=
100
Dec  9 02:50:46 dbz usb.agent[123]: kernel driver usbcore already loaded
Dec  9 02:50:46 dbz usb.agent[123]: Setup usbcore for USB product 451/1446/=
100
Dec  9 02:50:46 dbz usb.agent[123]: kernel driver usbcore already loaded
Dec  9 02:50:47 dbz usb.agent[129]: Setup usbcore for USB product 451/1446/=
100
Dec  9 02:50:47 dbz usb.agent[129]: kernel driver usbcore already loaded
Dec  9 02:50:47 dbz usb.agent[129]: Setup usbcore for USB product 451/1446/=
100
Dec  9 02:50:47 dbz usb.agent[129]: kernel driver usbcore already loaded
Dec  9 02:50:47 dbz usb.agent[135]: Setup scanner for USB product 4b8/10b/1=
14
Dec  9 02:50:47 dbz usb.agent[135]: kernel driver scanner already loaded
Dec  9 02:50:47 dbz kernel: SDAC detected blk: queue c0330260, I/O limit 40=
95Mb (mask 0xffffffff)
Dec  9 02:50:47 dbz kernel: blk: queue c0330b08, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec  9 02:50:47 dbz kernel: blk: queue c0330f5c, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec  9 02:50:48 dbz usb.agent[141]: ... no modules for USB product 1645/6/1=
00
Dec  9 02:50:58 dbz kernel: Starting AFS cache scan...found 741 non-empty c=
ache files (14%%).
Dec  9 02:51:02 dbz kernel: Adding Swap: 409592k swap-space (priority -2)
Dec  9 02:51:05 dbz kernel: Linux video capture interface: v1.00
Dec  9 02:51:05 dbz kernel: i2c: initialized
Dec  9 02:51:06 dbz kernel: Zoran ZR36060 + ZR36057/67 MJPEG board driver v=
ersion 0.9
Dec  9 02:51:06 dbz kernel: MJPEG[0]: Zoran ZR36067 (rev 2) irq: 10, memory=
: 0xed160000
Dec  9 02:51:06 dbz kernel: MJPEG[0]: subsystem vendor=3D0x1031 id=3D0x7efe
Dec  9 02:51:06 dbz kernel: MJPEG[0]: Changing PCI latency from 64 to 32.
Dec  9 02:51:06 dbz kernel: MJPEG[0]: Initializing i2c bus...
Dec  9 02:51:06 dbz kernel: saa7110_attach: SAA7110A version 1 at 0x9c, sta=
tus=3D0xd0
Dec  9 02:51:06 dbz kernel: adv7176_attach: adv7176 rev. 1 at 0x56
Dec  9 02:51:06 dbz kernel: DC10plus[0] card detected
Dec  9 02:51:06 dbz kernel: DC10plus[0]: Zoran ZR36060 (rev 1)
Dec  9 02:51:06 dbz kernel: MJPEG: 1 card(s) found
Dec  9 02:51:06 dbz kernel: MJPEG: using 2 V4L buffers of size 128 KB
Dec  9 02:51:06 dbz kernel: MJPEG: Host bridge: 440BX - 82443BX Host, enabl=
ing Natoma workaround.
Dec  9 02:51:06 dbz kernel: MJPEG: Host bridge: 440BX - 82443BX AGP, enabli=
ng Natoma workaround.
Dec  9 02:51:06 dbz kernel: DC10plus[0]: Initializing card[0], zr=3Dd2f39700
Dec  9 02:51:06 dbz kernel: DC10plus[0]: enable_jpg IDLE
Dec  9 02:51:07 dbz kernel: DC10plus[0]: Testing interrupts...
Dec  9 02:51:07 dbz kernel: DC10plus[0]: interrupts received: GIRQ1:49 queu=
e_state=3D0/0/0/0
Dec  9 02:51:07 dbz kernel: DC10plus[0]: procfs entry /proc/zoran0 allocate=
d. data=3Dd2f39700
Dec  9 02:52:11 dbz kernel: mtrr: no MTRR for e8000000,1000000 found
Dec  9 02:52:11 dbz kernel: mtrr: no MTRR for e9000000,800000 found
Dec  9 02:52:12 dbz kernel: mtrr: no MTRR for e8000000,1000000 found
Dec  9 02:52:12 dbz kernel: mtrr: no MTRR for e9000000,800000 found
Dec  9 02:52:13 dbz kernel: mtrr: no MTRR for e9800000,800000 found
Dec  9 02:52:14 dbz kernel: mtrr: base(0xe8000000) is not aligned on a size=
(0x1800000) boundary
Dec  9 02:52:15 dbz kernel: DC10plus[0]: zoran_open, XFree86 pid=3D[1540]
Dec  9 02:52:15 dbz kernel: DC10plus[0]: V4L frame 0 mem 0xc9cc0000 (bus: 0=
x9cc0000)
Dec  9 02:52:15 dbz kernel: DC10plus[0]: V4L frame 1 mem 0xc9ca0000 (bus: 0=
x9ca0000)
Dec  9 02:52:15 dbz kernel: DC10plus[0]: enable_jpg IDLE
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGCAP
Dec  9 02:52:15 dbz kernel: DC10plus[0]: UNKNOWN ioctl cmd: 0x800476c6
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGCHAN for channel 0
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGCHAN for channel 1
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGCHAN for channel 2
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGPICT
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCSPICT bri=3D32768 hue=
=3D32768 col=3D32768 con=3D32768 dep=3D16 pal=3D7
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGPICT
Dec  9 02:52:15 dbz kernel: DC10plus[0]: zoran_close, XFree86 pid=3D[1540]
Dec  9 02:52:15 dbz kernel: DC10plus[0]: enable_jpg IDLE
Dec  9 02:52:15 dbz kernel: DC10plus[0]: interrupts received: GIRQ1:2 queue=
_state=3D0/0/0/0
Dec  9 02:52:15 dbz kernel: DC10plus[0]: zoran_close done
Dec  9 02:52:15 dbz kernel: DC10plus[0]: zoran_open, XFree86 pid=3D[1540]
Dec  9 02:52:15 dbz kernel: DC10plus[0]: V4L frame 0 mem 0xc9ca0000 (bus: 0=
x9ca0000)
Dec  9 02:52:15 dbz kernel: DC10plus[0]: V4L frame 1 mem 0xc9cc0000 (bus: 0=
x9cc0000)
Dec  9 02:52:15 dbz kernel: DC10plus[0]: enable_jpg IDLE
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGCAP
Dec  9 02:52:15 dbz kernel: DC10plus[0]: UNKNOWN ioctl cmd: 0x800476c6
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGCHAN for channel 0
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGCHAN for channel 1
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGCHAN for channel 2
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGPICT
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCSPICT bri=3D32768 hue=
=3D32768 col=3D32768 con=3D32768 dep=3D16 pal=3D7
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGPICT
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGPICT
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCSPICT bri=3D32768 hue=
=3D32768 col=3D32768 con=3D32768 dep=3D16 pal=3D9
Dec  9 02:52:15 dbz kernel: DC10plus[0]: ioctl VIDIOCGPICT
Dec  9 02:52:15 dbz kernel: DC10plus[0]: zoran_close, XFree86 pid=3D[1540]
Dec  9 02:52:15 dbz kernel: DC10plus[0]: enable_jpg IDLE
Dec  9 02:52:15 dbz kernel: DC10plus[0]: interrupts received: GIRQ1:2 queue=
_state=3D0/0/0/0
Dec  9 02:52:15 dbz kernel: DC10plus[0]: zoran_close done
Dec  9 02:55:56 dbz uptimed: moving up to position 10: 0 days, 00:06:43

--rJwd6BRFiFCcLxzm--

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1ZCsIonHnh+67jkRArhAAKDAJ/WeIsyhjRsWvq9OghBeXUgRfgCcDJgp
dBH7TCMQsAOQwz25ESz7A8A=
=BgwR
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
