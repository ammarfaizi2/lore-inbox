Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTLJM6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 07:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTLJM6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 07:58:16 -0500
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:48654 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S262076AbTLJM4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 07:56:47 -0500
Date: Wed, 10 Dec 2003 06:55:43 -0600
From: Ryan Underwood <nemesis-lists@icequake.net>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] IO-APIC on MS-6163 (2.4.23). ACPI?
Message-ID: <20031210125543.GA1444@dbz.icequake.net>
References: <3ACA40606221794F80A5670F0AF15F8401720C15@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C15@PDSMSX403.ccr.corp.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Attached dmesg and interrupts with acpi=3Doff.  Also attached kernel
config.

As you see, it acknowledges a local APIC but mentions nothing about
IO-APIC.  So I guess this isn't ACPI issue after all.  But, I wonder why
the IO-APIC isn't being used on this board anymore.  There was a
blacklist entry for it, but it was removed after it was discovered to be
in error.

anyway I guess best to continue this on the kernel list, thanks.

On Wed, Dec 10, 2003 at 10:56:55AM +0800, Yu, Luming wrote:
> I found " evxfevnt-0093 [04] acpi_enable           : Transition to ACPI m=
ode successful". So ACPI seems to work on your machine.=20
> Since you previous email complain transition to acpi mode failed, could y=
ou please tell me what kind of kernel could result in acp mode transition f=
ailure on your box?
>=20
> Regarding IO-APIC issue, I didn't find MADT. Please try acpi=3Doff to ver=
ify IO-APCI can work on your box.
>=20
> Thanks=20
> Luming
>=20
> -----Original Message-----
> From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-admin@lis=
ts.sourceforge.net]On Behalf Of Ryan Underwood
> Sent: 2003?12?9? 17:07
> To: linux-kernel@vger.kernel.org
> Cc: acpi-devel@lists.sourceforge.net
> Subject: [ACPI] IO-APIC on MS-6163 (2.4.23). ACPI?
>=20
>=20
>=20
> Hello,
>=20
> Not sure if this is appropriate for ACPI or kernel list so I Cc: both.
>=20
> On my MS-6163 v3.0 (BX Master) board, the IO-APIC was previously being
> used before a blacklist was incorrectly added last year.  Now that the
> blacklist is removed when I upgraded to 2.4.23, ACPI doesn't seem to
> want to enable IO-APIC usage (dmesg attached).  I don't remember whether
> or not I had ACPI enabled when the IO-APIC was working a long time ago.
>=20
> I added some debug statements to arch/i386/kernel/acpi.c/acpi_boot_init()
> to try to diagnose the code flow.  However, when recompiling, almost the =
entire
> kernel must be rebuilt for dependencies, which takes forever on my poor
> machine... :(  So I didn't want to spend much more time without some outs=
ide
> opinion of the situation.
>=20
> But, as you can see from dmesg, it gets here:
> |
> =3D=3D=3D>        printk(KERN_INFO PREFIX "past blacklist\n");
>=20
> #ifdef CONFIG_X86_LOCAL_APIC
>=20
>         /*=20
>          * MADT
>          * ----
>          * Parse the Multiple APIC Description Table (MADT), if exists.
>          * Note that this table provides platform SMP configuration=20
>          * information -- the successor to MPS tables.
>          */
>=20
> XXX     result =3D acpi_table_parse(ACPI_APIC, acpi_parse_madt);
>         if (!result) {
>                 return 0;
>         }
>         else if (result < 0) {
>                 printk(KERN_ERR PREFIX "Error parsing MADT\n");
>                 return result;
>         }
>         else if (result > 1)
>                 printk(KERN_WARNING PREFIX "Multiple MADT tables exist\n"=
);
>=20
> =3D=3D=3D>        printk(KERN_INFO PREFIX "past MADT\n")
> |
> but not here.  There are no other kernel messages printed, so I think XXX=
 is the
> failing part.  Why would that happen?  Is it because this is a UP machine=
 and
> the call only works for SMP?  (CONFIG_X86_LOCAL_APIC is definitely enable=
d)
>=20
> Is it possible that IO-APIC and ACPI can work individually but be mutually
> exclusive on a system if the ACPI tables don't correctly describe the IO-=
APIC?
>=20
> I have only a shallow understanding of how this works (from reading www.a=
cpi.info
> and kernel source) so please bear with me if I am overlooking something o=
bvious.
>=20
> thanks,
>=20
> --=20
> Ryan Underwood, <nemesis@icequake.net>
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20

--=20
Ryan Underwood, <nemesis@icequake.net>

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=noacpi_interrupts
Content-Transfer-Encoding: quoted-printable

           CPU0      =20
  0:      14123          XT-PIC  timer
  1:        354          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  7:          0          XT-PIC  MPU401 UART
  8:          4          XT-PIC  rtc
  9:       2631          XT-PIC  ide2, ide3, sym53c8xx, eth0
 10:      10323          XT-PIC  usb-uhci, DC10plus[0]
 11:          0          XT-PIC  Syncfb Time Base, au8830
 12:         12          XT-PIC  PS/2 Mouse
 14:       6091          XT-PIC  ide0
NMI:         42=20
LOC:      14079=20
ERR:          0
MIS:          0

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=noacpi_messages
Content-Transfer-Encoding: quoted-printable

Dec 10 06:43:55 dbz syslogd 1.4.1#13: restart.
Dec 10 06:43:55 dbz kernel: klogd 1.4.1#13, log source =3D /proc/kmsg start=
ed.
Dec 10 06:43:55 dbz kernel: Inspecting /boot/System.map-2.4.23
Dec 10 06:43:55 dbz kernel: Loaded 18013 symbols from /boot/System.map-2.4.=
23.
Dec 10 06:43:55 dbz kernel: Symbols match kernel version 2.4.23.
Dec 10 06:43:55 dbz kernel: Loaded 917 symbols from 52 modules.
Dec 10 06:43:55 dbz kernel: Linux version 2.4.23 (nemesis@dbz) (gcc version=
 3.3.3 20031206 (prerelease) (Debian)) #5 Tue Dec 9 02:39:46 CST 2003
Dec 10 06:43:55 dbz kernel: BIOS-provided physical RAM map:
Dec 10 06:43:55 dbz kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00=
 (usable)
Dec 10 06:43:55 dbz kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000=
 (reserved)
Dec 10 06:43:55 dbz kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000=
 (reserved)
Dec 10 06:43:55 dbz kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000=
 (usable)
Dec 10 06:43:55 dbz kernel:  BIOS-e820: 000000000fff0000 - 000000000fff3000=
 (ACPI NVS)
Dec 10 06:43:55 dbz kernel:  BIOS-e820: 000000000fff3000 - 0000000010000000=
 (ACPI data)
Dec 10 06:43:55 dbz kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000=
 (reserved)
Dec 10 06:43:55 dbz kernel: 255MB LOWMEM available.
Dec 10 06:43:55 dbz kernel: On node 0 totalpages: 65520
Dec 10 06:43:55 dbz kernel: zone(0): 4096 pages.
Dec 10 06:43:55 dbz kernel: zone(1): 61424 pages.
Dec 10 06:43:55 dbz kernel: zone(2): 0 pages.
Dec 10 06:43:55 dbz kernel: ACPI: ACPI boot init 1 0
Dec 10 06:43:55 dbz kernel: Kernel command line: BOOT_IMAGE=3Dlinux-new ro =
root=3D305 parport=3Dauto video=3Dscrollback:0 acpi=3Dforce nmi_watchdog=3D=
1 acpi=3Doff
Dec 10 06:43:55 dbz kernel: Local APIC disabled by BIOS -- reenabling.
Dec 10 06:43:55 dbz kernel: Found and enabled local APIC!
Dec 10 06:43:55 dbz kernel: Initializing CPU#0
Dec 10 06:43:55 dbz kernel: Detected 801.829 MHz processor.
Dec 10 06:43:55 dbz kernel: Console: colour VGA+ 132x43
Dec 10 06:43:55 dbz kernel: Calibrating delay loop... 1599.07 BogoMIPS
Dec 10 06:43:55 dbz kernel: Memory: 256556k/262080k available (1389k kernel=
 code, 5136k reserved, 514k data, 108k init, 0k highmem)
Dec 10 06:43:55 dbz kernel: Dentry cache hash table entries: 32768 (order: =
6, 262144 bytes)
Dec 10 06:43:55 dbz kernel: Inode cache hash table entries: 16384 (order: 5=
, 131072 bytes)
Dec 10 06:43:55 dbz kernel: Mount cache hash table entries: 512 (order: 0, =
4096 bytes)
Dec 10 06:43:55 dbz kernel: Buffer cache hash table entries: 16384 (order: =
4, 65536 bytes)
Dec 10 06:43:55 dbz kernel: Page-cache hash table entries: 65536 (order: 6,=
 262144 bytes)
Dec 10 06:43:55 dbz kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Dec 10 06:43:55 dbz kernel: CPU: L2 cache: 128K
Dec 10 06:43:55 dbz kernel: Intel machine check architecture supported.
Dec 10 06:43:55 dbz kernel: Intel machine check reporting enabled on CPU#0.
Dec 10 06:43:55 dbz kernel: CPU: Intel Celeron (Coppermine) stepping 03
Dec 10 06:43:55 dbz kernel: Enabling fast FPU save and restore... done.
Dec 10 06:43:55 dbz kernel: Enabling unmasked SIMD FPU exception support...=
 done.
Dec 10 06:43:55 dbz kernel: Checking 'hlt' instruction... OK.
Dec 10 06:43:55 dbz kernel: POSIX conformance testing by UNIFIX
Dec 10 06:43:55 dbz kernel: enabled ExtINT on CPU#0
Dec 10 06:43:55 dbz kernel: ESR value before enabling vector: 00000000
Dec 10 06:43:55 dbz kernel: ESR value after enabling vector: 00000000
Dec 10 06:43:55 dbz kernel: testing NMI watchdog ... OK.
Dec 10 06:43:55 dbz kernel: Using local APIC timer interrupts.
Dec 10 06:43:55 dbz kernel: calibrating APIC timer ...
Dec 10 06:43:55 dbz kernel: ..... CPU clock speed is 801.8442 MHz.
Dec 10 06:43:55 dbz kernel: ..... host bus clock speed is 100.2304 MHz.
Dec 10 06:43:55 dbz kernel: cpu: 0, clocks: 1002304, slice: 501152
Dec 10 06:43:55 dbz kernel: CPU0<T0:1002304,T1:501152,D:0,S:501152,C:100230=
4>
Dec 10 06:43:55 dbz kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@at=
nf.csiro.au)
Dec 10 06:43:55 dbz kernel: mtrr: detected mtrr type: Intel
Dec 10 06:43:55 dbz kernel: ACPI: Subsystem revision 20031002
Dec 10 06:43:55 dbz kernel: ACPI: Interpreter disabled.
Dec 10 06:43:55 dbz kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb360, l=
ast bus=3D1
Dec 10 06:43:55 dbz kernel: PCI: Using configuration type 1
Dec 10 06:43:55 dbz kernel: PCI: Probing PCI hardware
Dec 10 06:43:55 dbz kernel: PCI: ACPI tables contain no PCI IRQ routing ent=
ries
Dec 10 06:43:55 dbz kernel: PCI: Probing PCI hardware (bus 00)
Dec 10 06:43:55 dbz kernel: PCI: Using IRQ router PIIX/ICH [8086/7110] at 0=
0:07.0
Dec 10 06:43:55 dbz kernel: Limiting direct PCI/PCI transfers.
Dec 10 06:43:55 dbz kernel: Linux NET4.0 for Linux 2.4
Dec 10 06:43:55 dbz kernel: Based upon Swansea University Computer Society =
NET3.039
Dec 10 06:43:55 dbz kernel: Initializing RT netlink socket
Dec 10 06:43:55 dbz kernel: Starting kswapd
Dec 10 06:43:55 dbz kernel: Journalled Block Device driver loaded
Dec 10 06:43:55 dbz kernel: devfs: v1.12c (20020818) Richard Gooch (rgooch@=
atnf.csiro.au)
Dec 10 06:43:55 dbz kernel: devfs: boot_options: 0x1
Dec 10 06:43:55 dbz kernel: pty: 256 Unix98 ptys configured
Dec 10 06:43:55 dbz kernel: Uniform Multi-Platform E-IDE driver Revision: 7=
=2E00beta4-2.4
Dec 10 06:43:55 dbz kernel: ide: Assuming 33MHz system bus speed for PIO mo=
des; override with idebus=3Dxx
Dec 10 06:43:55 dbz kernel: PIIX4: IDE controller at PCI slot 00:07.1
Dec 10 06:43:55 dbz kernel: PIIX4: chipset revision 1
Dec 10 06:43:55 dbz kernel: PIIX4: not 100%% native mode: will probe irqs l=
ater
Dec 10 06:43:55 dbz kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS setting=
s: hda:DMA, hdb:DMA
Dec 10 06:43:55 dbz kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS setting=
s: hdc:DMA, hdd:DMA
Dec 10 06:43:55 dbz kernel: PDC20262: IDE controller at PCI slot 00:0c.0
Dec 10 06:43:55 dbz kernel: PCI: Found IRQ 9 for device 00:0c.0
Dec 10 06:43:55 dbz kernel: PCI: Sharing IRQ 9 with 00:12.0
Dec 10 06:43:55 dbz kernel: PDC20262: chipset revision 1
Dec 10 06:43:55 dbz kernel: PDC20262: not 100%% native mode: will probe irq=
s later
Dec 10 06:43:55 dbz kernel: PDC20262: ROM enabled at 0xea000000
Dec 10 06:43:55 dbz kernel: PDC20262: (U)DMA Burst Bit ENABLED Primary PCI =
Mode Secondary PCI Mode.
Dec 10 06:43:55 dbz kernel:     ide2: BM-DMA at 0xb400-0xb407, BIOS setting=
s: hde:DMA, hdf:pio
Dec 10 06:43:55 dbz kernel:     ide3: BM-DMA at 0xb408-0xb40f, BIOS setting=
s: hdg:DMA, hdh:pio
Dec 10 06:43:55 dbz kernel: hda: WDC WD200EB-11BHF0, ATA DISK drive
Dec 10 06:43:55 dbz kernel: blk: queue c0330260, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec 10 06:43:55 dbz kernel: hde: Maxtor 5T040H4, ATA DISK drive
Dec 10 06:43:55 dbz kernel: blk: queue c0330b08, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec 10 06:43:55 dbz kernel: hdg: Maxtor 94098U8, ATA DISK drive
Dec 10 06:43:55 dbz kernel: blk: queue c0330f5c, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec 10 06:43:55 dbz kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 10 06:43:55 dbz kernel: ide2 at 0xa400-0xa407,0xa802 on irq 9
Dec 10 06:43:55 dbz kernel: ide3 at 0xac00-0xac07,0xb002 on irq 9
Dec 10 06:43:55 dbz kernel: hda: attached ide-disk driver.
Dec 10 06:43:55 dbz kernel: hda: host protected area =3D> 1
Dec 10 06:43:55 dbz kernel: hda: 39102336 sectors (20020 MB) w/2048KiB Cach=
e, CHS=3D19396/32/63, UDMA(33)
Dec 10 06:43:55 dbz kernel: hde: attached ide-disk driver.
Dec 10 06:43:55 dbz kernel: hde: host protected area =3D> 1
Dec 10 06:43:55 dbz kernel: hde: 80043264 sectors (40982 MB) w/2048KiB Cach=
e, CHS=3D79408/16/63, UDMA(66)
Dec 10 06:43:55 dbz kernel: hdg: attached ide-disk driver.
Dec 10 06:43:55 dbz kernel: hdg: host protected area =3D> 1
Dec 10 06:43:55 dbz kernel: hdg: 80041248 sectors (40981 MB) w/2048KiB Cach=
e, CHS=3D79406/16/63, UDMA(66)
Dec 10 06:43:55 dbz kernel: Partition check:
Dec 10 06:43:55 dbz kernel:  /dev/ide/host0/bus0/target0/lun0: p1 < p5 p6 p=
7 p8 >
Dec 10 06:43:55 dbz kernel:  /dev/ide/host2/bus0/target0/lun0: [PTBL] [4982=
/255/63] p1 p2 < p5 >
Dec 10 06:43:55 dbz kernel:  /dev/ide/host2/bus1/target0/lun0: [PTBL] [4982=
/255/63] p1 p2 < p5 >
Dec 10 06:43:55 dbz kernel: Initializing Cryptographic API
Dec 10 06:43:55 dbz kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec 10 06:43:55 dbz kernel: IP Protocols: ICMP, UDP, TCP
Dec 10 06:43:55 dbz kernel: IP: routing cache hash table of 2048 buckets, 1=
6Kbytes
Dec 10 06:43:55 dbz kernel: TCP: Hash tables configured (established 16384 =
bind 32768)
Dec 10 06:43:55 dbz kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET=
4.0.
Dec 10 06:43:55 dbz kernel: kjournald starting.  Commit interval 5 seconds
Dec 10 06:43:55 dbz kernel: EXT3-fs: mounted filesystem with ordered data m=
ode.
Dec 10 06:43:55 dbz kernel: VFS: Mounted root (ext3 filesystem) readonly.
Dec 10 06:43:55 dbz kernel: Mounted devfs on /dev
Dec 10 06:43:55 dbz kernel: Freeing unused kernel memory: 108k freed
Dec 10 06:43:55 dbz kernel: Adding Swap: 124956k swap-space (priority -1)
Dec 10 06:43:55 dbz kernel: EXT3-fs warning: maximal mount count reached, r=
unning e2fsck is recommended
Dec 10 06:43:55 dbz kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5)=
, internal journal
Dec 10 06:43:55 dbz kernel: Real Time Clock Driver v1.10e
Dec 10 06:43:55 dbz kernel: i2c: initialized
Dec 10 06:43:55 dbz kernel: Linux video capture interface: v1.00
Dec 10 06:43:55 dbz kernel: Software Watchdog Timer: 0.05, timer margin: 60=
 sec
Dec 10 06:43:55 dbz kernel: SCSI subsystem driver Revision: 1.00
Dec 10 06:43:55 dbz kernel: PCI: Found IRQ 9 for device 00:14.0
Dec 10 06:43:55 dbz kernel: PCI: Sharing IRQ 9 with 00:10.0
Dec 10 06:43:55 dbz kernel: sym.0.20.0: setting PCI_COMMAND_PARITY...
Dec 10 06:43:55 dbz kernel: sym.0.20.0: setting PCI_COMMAND_INVALIDATE.
Dec 10 06:43:55 dbz kernel: sym0: <875> rev 0x26 on pci bus 0 device 20 fun=
ction 0 irq 9
Dec 10 06:43:55 dbz kernel: sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity =
checking
Dec 10 06:43:55 dbz kernel: sym0: open drain IRQ line driver, using on-chip=
 SRAM
Dec 10 06:43:55 dbz kernel: sym0: using LOAD/STORE-based firmware.
Dec 10 06:43:55 dbz kernel: sym0: SCAN AT BOOT disabled for targets 0 4 5 6=
 8 9 10 11 12 13 14 15.
Dec 10 06:43:55 dbz kernel: sym0: SCAN FOR LUNS disabled for targets 0 1 2 =
3 4 5 6 8 9 10 11 12 13 14 15.
Dec 10 06:43:55 dbz kernel: sym0: SCSI BUS has been reset.
Dec 10 06:43:55 dbz kernel: scsi0 : sym-2.1.17a
Dec 10 06:43:55 dbz kernel: blk: queue c12e59c0, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec 10 06:43:55 dbz kernel:   Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Re=
v: 1.13
Dec 10 06:43:55 dbz kernel:   Type:   CD-ROM                             AN=
SI SCSI revision: 02
Dec 10 06:43:55 dbz kernel: blk: queue c12e5ac8, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec 10 06:43:55 dbz kernel:   Vendor: SONY      Model: CD-RW  CRX140S    Re=
v: 1.0e
Dec 10 06:43:55 dbz kernel:   Type:   CD-ROM                             AN=
SI SCSI revision: 04
Dec 10 06:43:55 dbz kernel: blk: queue c12e5bd0, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec 10 06:43:55 dbz kernel:   Vendor: PIONEER   Model: DVD-ROM DVD-303   Re=
v: 1.09
Dec 10 06:43:55 dbz kernel:   Type:   CD-ROM                             AN=
SI SCSI revision: 02
Dec 10 06:43:55 dbz kernel: blk: queue c12e5cd8, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec 10 06:43:55 dbz kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, i=
d 1, lun 0
Dec 10 06:43:55 dbz kernel: Attached scsi CD-ROM sr1 at scsi0, channel 0, i=
d 2, lun 0
Dec 10 06:43:55 dbz kernel: Attached scsi CD-ROM sr2 at scsi0, channel 0, i=
d 3, lun 0
Dec 10 06:43:55 dbz kernel: sym0:1: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, off=
set 15)
Dec 10 06:43:55 dbz kernel: sr0: scsi-1 drive
Dec 10 06:43:55 dbz kernel: Uniform CD-ROM driver Revision: 3.12
Dec 10 06:43:55 dbz kernel: sym0:2: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, of=
fset 15)
Dec 10 06:43:55 dbz kernel: sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/f=
orm2 cdda tray
Dec 10 06:43:55 dbz kernel: sym0:3: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, off=
set 8)
Dec 10 06:43:55 dbz kernel: sr2: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda=
 tray
Dec 10 06:43:55 dbz kernel: Linux Tulip driver version 0.9.15-pre12 (Aug 9,=
 2002)
Dec 10 06:43:55 dbz kernel: PCI: Found IRQ 9 for device 00:10.0
Dec 10 06:43:55 dbz kernel: PCI: Sharing IRQ 9 with 00:14.0
Dec 10 06:43:55 dbz kernel: tulip0:  EEPROM default media type Autosense.
Dec 10 06:43:55 dbz kernel: tulip0:  Index #0 - Media MII (#11) described b=
y a 21142 MII PHY (3) block.
Dec 10 06:43:55 dbz kernel: tulip0:  MII transceiver #1 config 1000 status =
782d advertising 01e1.
Dec 10 06:43:55 dbz kernel: eth0: Digital DS21143 Tulip rev 65 at 0xd088000=
0, 00:C0:F0:4D:28:0E, IRQ 9.
Dec 10 06:43:55 dbz kernel: matroxfb: Matrox G400 (AGP) detected
Dec 10 06:43:55 dbz kernel: matroxfb: MTRR's turned on
Dec 10 06:43:55 dbz kernel: matroxfb: 640x480x8bpp (virtual: 640x26208)
Dec 10 06:43:55 dbz kernel: matroxfb: framebuffer at 0xE8000000, mapped to =
0xd08af000, size 33554432
Dec 10 06:43:55 dbz kernel: Console: switching to colour frame buffer devic=
e 80x30
Dec 10 06:43:55 dbz kernel: fb0: MATROX VGA frame buffer device
Dec 10 06:43:55 dbz kernel: i2c-core.o: i2c core module
Dec 10 06:43:55 dbz kernel: i2c-algo-bit.o: i2c bit algorithm module
Dec 10 06:43:55 dbz kernel: i2c-core.o: adapter DDC:fb0 #0 on i2c-matroxfb =
registered as adapter 0.
Dec 10 06:43:55 dbz kernel: i2c-core.o: adapter DDC:fb0 #1 on i2c-matroxfb =
registered as adapter 1.
Dec 10 06:43:55 dbz kernel: i2c-core.o: adapter MAVEN:fb0 on i2c-matroxfb r=
egistered as adapter 2.
Dec 10 06:43:55 dbz kernel: i2c-core.o: driver maven registered.
Dec 10 06:43:55 dbz kernel: i2c-core.o: client [maven client] registered to=
 adapter [MAVEN:fb0 on i2c-matroxfb](pos. 0).
Dec 10 06:43:55 dbz kernel: matroxfb_crtc2: secondary head of fb0 was regis=
tered as fb1
Dec 10 06:43:55 dbz kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Dec 10 06:43:55 dbz kernel: agpgart: Maximum main memory to use for agp mem=
ory: 203M
Dec 10 06:43:55 dbz kernel: agpgart: Detected Intel 440BX chipset
Dec 10 06:43:55 dbz kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Dec 10 06:43:55 dbz kernel: [drm] Initialized mga 3.1.0 20021029 on minor 0
Dec 10 06:43:55 dbz kernel: Matrox MGA G200/G400/G450/G550 YUV Video interf=
ace v2.01 (c) Aaron Holtzman & A'rpi
Dec 10 06:43:55 dbz kernel: mga_vid: Found MGA G400/G450 at 01:00.0 [01:00.=
0]
Dec 10 06:43:55 dbz kernel: mga_vid: MMIO at 0xd292e000 IRQ: 11  framebuffe=
r: 0xE8000000
Dec 10 06:43:55 dbz kernel: mga_vid: OPTION word: 0x50044120  mem: 0x10  SG=
RAM
Dec 10 06:43:55 dbz kernel: mga_vid: RAMSIZE forced to 24 MB
Dec 10 06:43:55 dbz kernel: usb.c: registered new driver usbdevfs
Dec 10 06:43:55 dbz kernel: usb.c: registered new driver hub
Dec 10 06:43:55 dbz kernel: usb-uhci.c: $Revision: 1.275 $ time 16:12:33 De=
c  5 2003
Dec 10 06:43:55 dbz kernel: usb-uhci.c: High bandwidth mode enabled
Dec 10 06:43:55 dbz kernel: PCI: Found IRQ 10 for device 00:07.2
Dec 10 06:43:55 dbz kernel: PCI: Sharing IRQ 10 with 00:13.0
Dec 10 06:43:55 dbz kernel: usb-uhci.c: USB UHCI at I/O 0xa000, IRQ 10
Dec 10 06:43:55 dbz kernel: usb-uhci.c: Detected 2 ports
Dec 10 06:43:55 dbz kernel: usb.c: new USB bus registered, assigned bus num=
ber 1
Dec 10 06:43:55 dbz kernel: Product: USB UHCI Root Hub
Dec 10 06:43:55 dbz kernel: SerialNumber: a000
Dec 10 06:43:55 dbz kernel: hub.c: USB hub found
Dec 10 06:43:55 dbz kernel: hub.c: 2 ports detected
Dec 10 06:43:55 dbz kernel: usb-uhci.c: v1.275:USB Universal Host Controlle=
r Interface driver
Dec 10 06:43:55 dbz kernel: usb.c: registered new driver iforce
Dec 10 06:43:55 dbz kernel: hub.c: new USB device 00:07.2-1, assigned addre=
ss 2
Dec 10 06:43:55 dbz kernel: hub.c: USB hub found
Dec 10 06:43:55 dbz kernel: hub.c: 7 ports detected
Dec 10 06:43:55 dbz kernel: hub.c: new USB device 00:07.2-2, assigned addre=
ss 3
Dec 10 06:43:55 dbz kernel: hub.c: USB hub found
Dec 10 06:43:55 dbz kernel: hub.c: 7 ports detected
Dec 10 06:43:55 dbz kernel: hub.c: new USB device 00:07.2-2.1, assigned add=
ress 4
Dec 10 06:43:55 dbz kernel: usb-uhci.c: interrupt, status 2, frame# 1828
Dec 10 06:43:55 dbz kernel: hub.c: new USB device 00:07.2-2.1, assigned add=
ress 5
Dec 10 06:43:55 dbz kernel: Manufacturer: Gravis
Dec 10 06:43:55 dbz kernel: Product: Xterminator Digital Gamepad
Dec 10 06:43:55 dbz kernel: usb.c: USB device 5 (vend/prod 0x47d/0x4003) is=
 not claimed by any active driver.
Dec 10 06:43:55 dbz kernel:   Length              =3D 18
Dec 10 06:43:55 dbz kernel:   DescriptorType      =3D 01
Dec 10 06:43:55 dbz kernel:   USB version         =3D 1.00
Dec 10 06:43:55 dbz kernel:   Vendor:Product      =3D 047d:4003
Dec 10 06:43:55 dbz kernel:   MaxPacketSize0      =3D 8
Dec 10 06:43:55 dbz kernel:   NumConfigurations   =3D 1
Dec 10 06:43:55 dbz kernel:   Device version      =3D 1.00
Dec 10 06:43:55 dbz kernel:   Device Class:SubClass:Protocol =3D 00:00:00
Dec 10 06:43:55 dbz kernel:     Per-interface classes
Dec 10 06:43:55 dbz kernel: Configuration:
Dec 10 06:43:55 dbz kernel:   bLength             =3D    9
Dec 10 06:43:55 dbz kernel:   bDescriptorType     =3D   02
Dec 10 06:43:55 dbz kernel:   wTotalLength        =3D 0022
Dec 10 06:43:55 dbz kernel:   bNumInterfaces      =3D   01
Dec 10 06:43:55 dbz kernel:   bConfigurationValue =3D   01
Dec 10 06:43:55 dbz kernel:   iConfiguration      =3D   00
Dec 10 06:43:55 dbz kernel:   bmAttributes        =3D   80
Dec 10 06:43:55 dbz kernel:   MaxPower            =3D  100mA
Dec 10 06:43:55 dbz kernel:=20
Dec 10 06:43:55 dbz kernel:   Interface: 0
Dec 10 06:43:55 dbz kernel:   Alternate Setting:  0
Dec 10 06:43:55 dbz kernel:     bLength             =3D    9
Dec 10 06:43:55 dbz kernel:     bDescriptorType     =3D   04
Dec 10 06:43:55 dbz kernel:     bInterfaceNumber    =3D   00
Dec 10 06:43:55 dbz kernel:     bAlternateSetting   =3D   00
Dec 10 06:43:55 dbz kernel:     bNumEndpoints       =3D   01
Dec 10 06:43:55 dbz kernel:     bInterface Class:SubClass:Protocol =3D   03=
:00:00
Dec 10 06:43:55 dbz kernel:     iInterface          =3D   03
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   81 (in)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   03 (Interrupt)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0008
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   0a
Dec 10 06:43:55 dbz kernel: hub.c: new USB device 00:07.2-2.2, assigned add=
ress 6
Dec 10 06:43:55 dbz kernel: Manufacturer: Gravis
Dec 10 06:43:55 dbz kernel: Product: GamePad Pro USB=20
Dec 10 06:43:55 dbz kernel: usb.c: USB device 6 (vend/prod 0x428/0x4001) is=
 not claimed by any active driver.
Dec 10 06:43:55 dbz kernel:   Length              =3D 18
Dec 10 06:43:55 dbz kernel:   DescriptorType      =3D 01
Dec 10 06:43:55 dbz kernel:   USB version         =3D 1.00
Dec 10 06:43:55 dbz kernel:   Vendor:Product      =3D 0428:4001
Dec 10 06:43:55 dbz kernel:   MaxPacketSize0      =3D 8
Dec 10 06:43:55 dbz kernel:   NumConfigurations   =3D 1
Dec 10 06:43:55 dbz kernel:   Device version      =3D 2.00
Dec 10 06:43:55 dbz kernel:   Device Class:SubClass:Protocol =3D 00:00:00
Dec 10 06:43:55 dbz kernel:     Per-interface classes
Dec 10 06:43:55 dbz kernel: Configuration:
Dec 10 06:43:55 dbz kernel:   bLength             =3D    9
Dec 10 06:43:55 dbz kernel:   bDescriptorType     =3D   02
Dec 10 06:43:55 dbz kernel:   wTotalLength        =3D 0022
Dec 10 06:43:55 dbz kernel:   bNumInterfaces      =3D   01
Dec 10 06:43:55 dbz kernel:   bConfigurationValue =3D   01
Dec 10 06:43:55 dbz kernel:   iConfiguration      =3D   00
Dec 10 06:43:55 dbz kernel:   bmAttributes        =3D   80
Dec 10 06:43:55 dbz kernel:   MaxPower            =3D  100mA
Dec 10 06:43:55 dbz kernel:=20
Dec 10 06:43:55 dbz kernel:   Interface: 0
Dec 10 06:43:55 dbz kernel:   Alternate Setting:  0
Dec 10 06:43:55 dbz kernel:     bLength             =3D    9
Dec 10 06:43:55 dbz kernel:     bDescriptorType     =3D   04
Dec 10 06:43:55 dbz kernel:     bInterfaceNumber    =3D   00
Dec 10 06:43:55 dbz kernel:     bAlternateSetting   =3D   00
Dec 10 06:43:55 dbz kernel:     bNumEndpoints       =3D   01
Dec 10 06:43:55 dbz kernel:     bInterface Class:SubClass:Protocol =3D   03=
:00:00
Dec 10 06:43:55 dbz kernel:     iInterface          =3D   03
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   81 (in)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   03 (Interrupt)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0006
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   0a
Dec 10 06:43:55 dbz kernel: hub.c: new USB device 00:07.2-2.3, assigned add=
ress 7
Dec 10 06:43:55 dbz kernel: Manufacturer: Logitech
Dec 10 06:43:55 dbz kernel: Product: Wingman Force
Dec 10 06:43:55 dbz kernel: input0: Logitech WingMan Force [10 effects, 200=
 bytes memory] on usb1:7.0
Dec 10 06:43:55 dbz kernel: hub.c: new USB device 00:07.2-2.5, assigned add=
ress 8
Dec 10 06:43:55 dbz kernel: Manufacturer: SCM Microsystems Inc.
Dec 10 06:43:55 dbz kernel: Product: eUSB SmartMedia Adapter
Dec 10 06:43:55 dbz kernel: usb.c: USB device 8 (vend/prod 0x4e6/0x3) is no=
t claimed by any active driver.
Dec 10 06:43:55 dbz kernel:   Length              =3D 18
Dec 10 06:43:55 dbz kernel:   DescriptorType      =3D 01
Dec 10 06:43:55 dbz kernel:   USB version         =3D 1.10
Dec 10 06:43:55 dbz kernel:   Vendor:Product      =3D 04e6:0003
Dec 10 06:43:55 dbz kernel:   MaxPacketSize0      =3D 16
Dec 10 06:43:55 dbz kernel:   NumConfigurations   =3D 1
Dec 10 06:43:55 dbz kernel:   Device version      =3D 2.08
Dec 10 06:43:55 dbz kernel:   Device Class:SubClass:Protocol =3D 00:00:00
Dec 10 06:43:55 dbz kernel:     Per-interface classes
Dec 10 06:43:55 dbz kernel: Configuration:
Dec 10 06:43:55 dbz kernel:   bLength             =3D    9
Dec 10 06:43:55 dbz kernel:   bDescriptorType     =3D   02
Dec 10 06:43:55 dbz kernel:   wTotalLength        =3D 0027
Dec 10 06:43:55 dbz kernel:   bNumInterfaces      =3D   01
Dec 10 06:43:55 dbz kernel:   bConfigurationValue =3D   01
Dec 10 06:43:55 dbz kernel:   iConfiguration      =3D   03
Dec 10 06:43:55 dbz kernel:   bmAttributes        =3D   a0
Dec 10 06:43:55 dbz kernel:   MaxPower            =3D  100mA
Dec 10 06:43:55 dbz kernel:=20
Dec 10 06:43:55 dbz kernel:   Interface: 0
Dec 10 06:43:55 dbz kernel:   Alternate Setting:  0
Dec 10 06:43:55 dbz kernel:     bLength             =3D    9
Dec 10 06:43:55 dbz kernel:     bDescriptorType     =3D   04
Dec 10 06:43:55 dbz kernel:     bInterfaceNumber    =3D   00
Dec 10 06:43:55 dbz kernel:     bAlternateSetting   =3D   00
Dec 10 06:43:55 dbz kernel:     bNumEndpoints       =3D   03
Dec 10 06:43:55 dbz kernel:     bInterface Class:SubClass:Protocol =3D   ff=
:01:01
Dec 10 06:43:55 dbz kernel:     iInterface          =3D   04
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   01 (out)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   82 (in)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   83 (in)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   03 (Interrupt)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0002
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   20
Dec 10 06:43:55 dbz kernel: hub.c: new USB device 00:07.2-1.4, assigned add=
ress 9
Dec 10 06:43:55 dbz kernel: Manufacturer: EPSON
Dec 10 06:43:55 dbz kernel: Product: Perfection1240
Dec 10 06:43:55 dbz kernel: usb.c: USB device 9 (vend/prod 0x4b8/0x10b) is =
not claimed by any active driver.
Dec 10 06:43:55 dbz kernel:   Length              =3D 18
Dec 10 06:43:55 dbz kernel:   DescriptorType      =3D 01
Dec 10 06:43:55 dbz kernel:   USB version         =3D 1.00
Dec 10 06:43:55 dbz kernel:   Vendor:Product      =3D 04b8:010b
Dec 10 06:43:55 dbz kernel:   MaxPacketSize0      =3D 64
Dec 10 06:43:55 dbz kernel:   NumConfigurations   =3D 1
Dec 10 06:43:55 dbz kernel:   Device version      =3D 1.14
Dec 10 06:43:55 dbz kernel:   Device Class:SubClass:Protocol =3D ff:ff:ff
Dec 10 06:43:55 dbz kernel:     Vendor class
Dec 10 06:43:55 dbz kernel: Configuration:
Dec 10 06:43:55 dbz kernel:   bLength             =3D    9
Dec 10 06:43:55 dbz kernel:   bDescriptorType     =3D   02
Dec 10 06:43:55 dbz kernel:   wTotalLength        =3D 0020
Dec 10 06:43:55 dbz kernel:   bNumInterfaces      =3D   01
Dec 10 06:43:55 dbz kernel:   bConfigurationValue =3D   01
Dec 10 06:43:55 dbz kernel:   iConfiguration      =3D   00
Dec 10 06:43:55 dbz kernel:   bmAttributes        =3D   40
Dec 10 06:43:55 dbz kernel:   MaxPower            =3D    2mA
Dec 10 06:43:55 dbz kernel:=20
Dec 10 06:43:55 dbz kernel:   Interface: 0
Dec 10 06:43:55 dbz kernel:   Alternate Setting:  0
Dec 10 06:43:55 dbz kernel:     bLength             =3D    9
Dec 10 06:43:55 dbz kernel:     bDescriptorType     =3D   04
Dec 10 06:43:55 dbz kernel:     bInterfaceNumber    =3D   00
Dec 10 06:43:55 dbz kernel:     bAlternateSetting   =3D   00
Dec 10 06:43:55 dbz kernel:     bNumEndpoints       =3D   02
Dec 10 06:43:55 dbz kernel:     bInterface Class:SubClass:Protocol =3D   ff=
:ff:ff
Dec 10 06:43:55 dbz kernel:     iInterface          =3D   00
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   81 (in)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   02 (out)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:55 dbz kernel: hub.c: new USB device 00:07.2-1.5, assigned add=
ress 10
Dec 10 06:43:55 dbz kernel: usb.c: USB device 10 (vend/prod 0x1645/0x6) is =
not claimed by any active driver.
Dec 10 06:43:55 dbz kernel:   Length              =3D 18
Dec 10 06:43:55 dbz kernel:   DescriptorType      =3D 01
Dec 10 06:43:55 dbz kernel:   USB version         =3D 1.00
Dec 10 06:43:55 dbz kernel:   Vendor:Product      =3D 1645:0006
Dec 10 06:43:55 dbz kernel:   MaxPacketSize0      =3D 8
Dec 10 06:43:55 dbz kernel:   NumConfigurations   =3D 1
Dec 10 06:43:55 dbz kernel:   Device version      =3D 1.00
Dec 10 06:43:55 dbz kernel:   Device Class:SubClass:Protocol =3D 00:00:00
Dec 10 06:43:55 dbz kernel:     Per-interface classes
Dec 10 06:43:55 dbz kernel: Configuration:
Dec 10 06:43:55 dbz kernel:   bLength             =3D    9
Dec 10 06:43:55 dbz kernel:   bDescriptorType     =3D   02
Dec 10 06:43:55 dbz kernel:   wTotalLength        =3D 004e
Dec 10 06:43:55 dbz kernel:   bNumInterfaces      =3D   01
Dec 10 06:43:55 dbz kernel:   bConfigurationValue =3D   01
Dec 10 06:43:55 dbz kernel:   iConfiguration      =3D   00
Dec 10 06:43:55 dbz kernel:   bmAttributes        =3D   80
Dec 10 06:43:55 dbz kernel:   MaxPower            =3D   98mA
Dec 10 06:43:55 dbz kernel:=20
Dec 10 06:43:55 dbz kernel:   Interface: 0
Dec 10 06:43:55 dbz kernel:   Alternate Setting:  0
Dec 10 06:43:55 dbz kernel:     bLength             =3D    9
Dec 10 06:43:55 dbz kernel:     bDescriptorType     =3D   04
Dec 10 06:43:55 dbz kernel:     bInterfaceNumber    =3D   00
Dec 10 06:43:55 dbz kernel:     bAlternateSetting   =3D   00
Dec 10 06:43:55 dbz kernel:     bNumEndpoints       =3D   01
Dec 10 06:43:55 dbz kernel:     bInterface Class:SubClass:Protocol =3D   07=
:01:01
Dec 10 06:43:55 dbz kernel:     iInterface          =3D   00
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   01 (out)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:55 dbz kernel:   Alternate Setting:  1
Dec 10 06:43:55 dbz kernel:     bLength             =3D    9
Dec 10 06:43:55 dbz kernel:     bDescriptorType     =3D   04
Dec 10 06:43:55 dbz kernel:     bInterfaceNumber    =3D   00
Dec 10 06:43:55 dbz kernel:     bAlternateSetting   =3D   01
Dec 10 06:43:55 dbz kernel:     bNumEndpoints       =3D   02
Dec 10 06:43:55 dbz kernel:     bInterface Class:SubClass:Protocol =3D   07=
:01:02
Dec 10 06:43:55 dbz kernel:     iInterface          =3D   00
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   01 (out)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   82 (in)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:55 dbz kernel:   Alternate Setting:  2
Dec 10 06:43:55 dbz kernel:     bLength             =3D    9
Dec 10 06:43:55 dbz kernel:     bDescriptorType     =3D   04
Dec 10 06:43:55 dbz kernel:     bInterfaceNumber    =3D   00
Dec 10 06:43:55 dbz kernel:     bAlternateSetting   =3D   02
Dec 10 06:43:55 dbz kernel:     bNumEndpoints       =3D   03
Dec 10 06:43:55 dbz kernel:     bInterface Class:SubClass:Protocol =3D   ff=
:00:ff
Dec 10 06:43:55 dbz kernel:     iInterface          =3D   00
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   01 (out)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   82 (in)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   83 (in)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   03 (Interrupt)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0004
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:55 dbz kernel: isapnp: Scanning for PnP cards...
Dec 10 06:43:55 dbz kernel: isapnp: No Plug & Play device found
Dec 10 06:43:55 dbz kernel: hub.c: new USB device 00:07.2-1.6, assigned add=
ress 11
Dec 10 06:43:55 dbz kernel: usb.c: USB device 11 (vend/prod 0x1645/0x8002) =
is not claimed by any active driver.
Dec 10 06:43:55 dbz kernel:   Length              =3D 18
Dec 10 06:43:55 dbz kernel:   DescriptorType      =3D 01
Dec 10 06:43:55 dbz kernel:   USB version         =3D 1.00
Dec 10 06:43:55 dbz kernel:   Vendor:Product      =3D 1645:8002
Dec 10 06:43:55 dbz kernel:   MaxPacketSize0      =3D 64
Dec 10 06:43:55 dbz kernel:   NumConfigurations   =3D 1
Dec 10 06:43:55 dbz kernel:   Device version      =3D 2.04
Dec 10 06:43:55 dbz kernel:   Device Class:SubClass:Protocol =3D ff:ff:ff
Dec 10 06:43:55 dbz kernel:     Vendor class
Dec 10 06:43:55 dbz kernel: Configuration:
Dec 10 06:43:55 dbz kernel:   bLength             =3D    9
Dec 10 06:43:55 dbz kernel:   bDescriptorType     =3D   02
Dec 10 06:43:55 dbz kernel:   wTotalLength        =3D 00da
Dec 10 06:43:55 dbz kernel:   bNumInterfaces      =3D   01
Dec 10 06:43:55 dbz kernel:   bConfigurationValue =3D   01
Dec 10 06:43:55 dbz kernel:   iConfiguration      =3D   00
Dec 10 06:43:55 dbz kernel:   bmAttributes        =3D   80
Dec 10 06:43:55 dbz kernel:   MaxPower            =3D  100mA
Dec 10 06:43:55 dbz kernel:=20
Dec 10 06:43:55 dbz kernel:   Interface: 0
Dec 10 06:43:55 dbz kernel:   Alternate Setting:  0
Dec 10 06:43:55 dbz kernel:     bLength             =3D    9
Dec 10 06:43:55 dbz kernel:     bDescriptorType     =3D   04
Dec 10 06:43:55 dbz kernel:     bInterfaceNumber    =3D   00
Dec 10 06:43:55 dbz kernel:     bAlternateSetting   =3D   00
Dec 10 06:43:55 dbz kernel:     bNumEndpoints       =3D   00
Dec 10 06:43:55 dbz kernel:     bInterface Class:SubClass:Protocol =3D   ff=
:ff:ff
Dec 10 06:43:55 dbz kernel:     iInterface          =3D   00
Dec 10 06:43:55 dbz kernel:   Alternate Setting:  1
Dec 10 06:43:55 dbz kernel:     bLength             =3D    9
Dec 10 06:43:55 dbz kernel:     bDescriptorType     =3D   04
Dec 10 06:43:55 dbz kernel:     bInterfaceNumber    =3D   00
Dec 10 06:43:55 dbz kernel:     bAlternateSetting   =3D   01
Dec 10 06:43:55 dbz kernel:     bNumEndpoints       =3D   0d
Dec 10 06:43:55 dbz kernel:     bInterface Class:SubClass:Protocol =3D   ff=
:ff:ff
Dec 10 06:43:55 dbz kernel:     iInterface          =3D   00
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   81 (in)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   03 (Interrupt)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0010
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   0a
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   82 (in)
Dec 10 06:43:55 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:55 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:55 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:55 dbz kernel:     Endpoint:
Dec 10 06:43:55 dbz kernel:       bLength             =3D    7
Dec 10 06:43:55 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:55 dbz kernel:       bEndpointAddress    =3D   02 (out)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   84 (in)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   04 (out)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   86 (in)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   06 (out)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   88 (in)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0010
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   08 (out)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0010
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   89 (in)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0010
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   09 (out)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0010
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   8a (in)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0010
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   0a (out)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0010
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:56 dbz kernel:   Alternate Setting:  2
Dec 10 06:43:56 dbz kernel:     bLength             =3D    9
Dec 10 06:43:56 dbz kernel:     bDescriptorType     =3D   04
Dec 10 06:43:56 dbz kernel:     bInterfaceNumber    =3D   00
Dec 10 06:43:56 dbz kernel:     bAlternateSetting   =3D   02
Dec 10 06:43:56 dbz kernel:     bNumEndpoints       =3D   0d
Dec 10 06:43:56 dbz kernel:     bInterface Class:SubClass:Protocol =3D   ff=
:ff:ff
Dec 10 06:43:56 dbz kernel:     iInterface          =3D   00
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   81 (in)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   03 (Interrupt)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   0a
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   82 (in)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   02 (out)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   84 (in)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   04 (out)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   86 (in)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   06 (out)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   02 (Bulk)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0040
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   00
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   88 (in)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0100
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   08 (out)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0100
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   89 (in)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0010
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   09 (out)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0010
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   8a (in)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0010
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:56 dbz kernel:     Endpoint:
Dec 10 06:43:56 dbz kernel:       bLength             =3D    7
Dec 10 06:43:56 dbz kernel:       bDescriptorType     =3D   05
Dec 10 06:43:56 dbz kernel:       bEndpointAddress    =3D   0a (out)
Dec 10 06:43:56 dbz kernel:       bmAttributes        =3D   01 (Isochronous)
Dec 10 06:43:56 dbz kernel:       wMaxPacketSize      =3D 0010
Dec 10 06:43:56 dbz kernel:       bInterval           =3D   01
Dec 10 06:43:56 dbz kernel: Serial driver version 5.05c (2001-07-08) with M=
ANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Dec 10 06:43:56 dbz kernel: ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
Dec 10 06:43:56 dbz kernel: ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Dec 10 06:43:56 dbz kernel: usb.c: registered new driver hid
Dec 10 06:43:56 dbz kernel: mice: PS/2 mouse device common for all mice
Dec 10 06:43:56 dbz kernel: Initializing USB Mass Storage driver...
Dec 10 06:43:56 dbz kernel: usb.c: registered new driver usb-storage
Dec 10 06:43:56 dbz kernel: usb.c: registered new driver usbscanner
Dec 10 06:43:56 dbz kernel: usb_control/bulk_msg: timeout
Dec 10 06:43:56 dbz kernel: usb-uhci.c: interrupt, status 3, frame# 1225
Dec 10 06:43:56 dbz kernel: input: USB HID v1.00 Joystick [Gravis Xterminat=
or Digital Gamepad] on usb1:5.0
Dec 10 06:43:56 dbz kernel: usb_control/bulk_msg: timeout
Dec 10 06:43:56 dbz kernel: usb-uhci.c: interrupt, status 3, frame# 121
Dec 10 06:43:56 dbz kernel: input: USB HID v1.00 Gamepad [Gravis GamePad Pr=
o USB ] on usb1:6.0
Dec 10 06:43:56 dbz kernel: scsi1 : SCSI emulation for USB Mass Storage dev=
ices
Dec 10 06:43:56 dbz kernel:   Vendor: Sandisk   Model: ImageMate SDDR09  Re=
v: 0208
Dec 10 06:43:56 dbz kernel:   Type:   Direct-Access                      AN=
SI SCSI revision: 02
Dec 10 06:43:56 dbz kernel: Attached scsi removable disk sda at scsi1, chan=
nel 0, id 0, lun 0
Dec 10 06:43:56 dbz kernel: sddr09: Found Flash card, ID =3D 98 73 A5 BA: M=
anuf. Toshiba, 16 MB, 128-bit ID
Dec 10 06:43:56 dbz kernel: SCSI device sda: 32000 512-byte hdwr sectors (1=
6 MB)
Dec 10 06:43:56 dbz kernel: sda: Write Protect is off
Dec 10 06:43:56 dbz kernel:  /dev/scsi/host1/bus0/target0/lun0: p1
Dec 10 06:43:56 dbz kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik =
<vojtech@suse.cz>
Dec 10 06:43:56 dbz kernel: hid-core.c: USB HID support drivers
Dec 10 06:43:56 dbz kernel: scanner.c: USB scanner device (0x04b8/0x010b) n=
ow attached to scanner0
Dec 10 06:43:56 dbz kernel: USB Mass Storage support registered.
Dec 10 06:43:56 dbz kernel: scanner.c: 0.4.15:USB Scanner Driver
Dec 10 06:43:56 dbz kernel: reiserfs: found format "3.6" with standard jour=
nal
Dec 10 06:43:56 dbz kernel: reiserfs: checking transaction log (device ide0=
(3,6)) ...
Dec 10 06:43:56 dbz kernel: for (ide0(3,6))
Dec 10 06:43:56 dbz kernel: ide0(3,6):Using r5 hash to sort names
Dec 10 06:43:56 dbz kernel: kjournald starting.  Commit interval 5 seconds
Dec 10 06:43:56 dbz kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8)=
, internal journal
Dec 10 06:43:56 dbz kernel: EXT3-fs: mounted filesystem with ordered data m=
ode.
Dec 10 06:43:56 dbz kernel: reiserfs: found format "3.6" with standard jour=
nal
Dec 10 06:43:56 dbz kernel: reiserfs: checking transaction log (device ide3=
(34,5)) ...
Dec 10 06:43:56 dbz kernel: for (ide3(34,5))
Dec 10 06:43:56 dbz kernel: ide3(34,5):Using r5 hash to sort names
Dec 10 06:43:56 dbz kernel: loop: loaded (max 8 devices)
Dec 10 06:43:56 dbz kernel: reiserfs: found format "3.6" with standard jour=
nal
Dec 10 06:43:56 dbz kernel: reiserfs: checking transaction log (device loop=
(7,0)) ...
Dec 10 06:43:56 dbz kernel: for (loop(7,0))
Dec 10 06:43:56 dbz kernel: loop(7,0):Using r5 hash to sort names
Dec 10 06:43:56 dbz kernel: uhci.c: USB Universal Host Controller Interface=
 driver v1.1
Dec 10 06:43:56 dbz kernel: eth0: Setting full-duplex based on MII#1 link p=
artner capability of 45e1.
Dec 10 06:43:56 dbz kernel: IA-32 Microcode Update Driver: v1.11 <tigran@ve=
ritas.com>
Dec 10 06:43:56 dbz kernel: microcode: CPU0 updated from revision 16 to 20,=
 date=3D02062001
Dec 10 06:43:56 dbz kernel: microcode: freed 2048 bytes
Dec 10 06:43:56 dbz kernel: PCI: Found IRQ 11 for device 00:0e.0
Dec 10 06:43:56 dbz kernel: Vortex: hardware init.... <6>done.
Dec 10 06:44:01 dbz kernel: SDAC detected blk: queue c0330260, I/O limit 40=
95Mb (mask 0xffffffff)
Dec 10 06:44:01 dbz kernel: blk: queue c0330b08, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec 10 06:44:01 dbz kernel: blk: queue c0330f5c, I/O limit 4095Mb (mask 0xf=
fffffff)
Dec 10 06:44:12 dbz kernel: Starting AFS cache scan...found 658 non-empty c=
ache files (13%%).
Dec 10 06:44:16 dbz kernel: Adding Swap: 409592k swap-space (priority -2)
Dec 10 06:44:19 dbz kernel: Linux video capture interface: v1.00
Dec 10 06:44:19 dbz kernel: i2c: initialized
Dec 10 06:44:21 dbz kernel: Zoran ZR36060 + ZR36057/67 MJPEG board driver v=
ersion 0.9
Dec 10 06:44:21 dbz kernel: PCI: Found IRQ 10 for device 00:13.0
Dec 10 06:44:21 dbz kernel: PCI: Sharing IRQ 10 with 00:07.2
Dec 10 06:44:21 dbz kernel: MJPEG[0]: Zoran ZR36067 (rev 2) irq: 10, memory=
: 0xed160000
Dec 10 06:44:21 dbz kernel: MJPEG[0]: subsystem vendor=3D0x1031 id=3D0x7efe
Dec 10 06:44:21 dbz kernel: MJPEG[0]: Changing PCI latency from 64 to 32.
Dec 10 06:44:21 dbz kernel: MJPEG[0]: Initializing i2c bus...
Dec 10 06:44:21 dbz kernel: saa7110_attach: SAA7110A version 1 at 0x9c, sta=
tus=3D0xd0
Dec 10 06:44:21 dbz kernel: adv7176_attach: adv7176 rev. 1 at 0x56
Dec 10 06:44:21 dbz kernel: DC10plus[0] card detected
Dec 10 06:44:21 dbz kernel: DC10plus[0]: Zoran ZR36060 (rev 1)
Dec 10 06:44:21 dbz kernel: MJPEG: 1 card(s) found
Dec 10 06:44:21 dbz kernel: MJPEG: using 2 V4L buffers of size 128 KB
Dec 10 06:44:21 dbz kernel: MJPEG: Host bridge: 440BX - 82443BX Host, enabl=
ing Natoma workaround.
Dec 10 06:44:21 dbz kernel: MJPEG: Host bridge: 440BX - 82443BX AGP, enabli=
ng Natoma workaround.
Dec 10 06:44:21 dbz kernel: DC10plus[0]: Initializing card[0], zr=3Dd2f27700
Dec 10 06:44:21 dbz kernel: DC10plus[0]: enable_jpg IDLE
Dec 10 06:44:22 dbz kernel: DC10plus[0]: Testing interrupts...
Dec 10 06:44:22 dbz kernel: DC10plus[0]: interrupts received: GIRQ1:49 queu=
e_state=3D0/0/0/0
Dec 10 06:44:22 dbz kernel: DC10plus[0]: procfs entry /proc/zoran0 allocate=
d. data=3Dd2f27700
Dec 10 06:45:34 dbz shutdown[1150]: shutting down for system reboot
Dec 10 06:45:40 dbz kernel: WARM shutting down of: CB... afs... BkG... CTru=
nc... AFSDB... RxEvent... RxListener...=20
Dec 10 06:45:47 dbz kernel: Vortex: hardware shutdown...SDAC detected <6>do=
ne.
Dec 10 06:45:49 dbz kernel: Kernel logging (proc) stopped.
Dec 10 06:45:49 dbz kernel: Kernel log daemon terminating.
Dec 10 06:45:49 dbz exiting on signal 15

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=".config"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_EDD=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
# CONFIG_APM is not set

#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
# CONFIG_ACPI_THERMAL is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_RELAXED_AML is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=m
CONFIG_ISAPNP=m

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=8
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_MEGARAID2 is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=m
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_SCx200_I2C is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_ALGOPCF=m
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
CONFIG_INPUT_GAMEPORT=m
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
CONFIG_INPUT_PCIGAME=m
CONFIG_INPUT_CS461X=m
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
CONFIG_INPUT_ANALOG=m
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
CONFIG_INPUT_GRIP=m
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
CONFIG_INPUT_IFORCE_USB=m
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
CONFIG_INPUT_DB9=m
CONFIG_INPUT_GAMECON=m
CONFIG_INPUT_TURBOGRAFX=m
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
CONFIG_SOFT_WATCHDOG=m
# CONFIG_W83877F_WDT is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_AMD_PM768 is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_K8 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_ATI is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=m
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I810_XFREE_41 is not set
# CONFIG_DRM_I830 is not set
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
# CONFIG_I2C_PARPORT is not set
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
CONFIG_VIDEO_ZORAN=m
# CONFIG_VIDEO_ZORAN_BUZ is not set
CONFIG_VIDEO_ZORAN_DC10=m
# CONFIG_VIDEO_ZORAN_LML33 is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_MEYE is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_MIROPCM20 is not set
# CONFIG_RADIO_MIROPCM20_RDS is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_EFS_FS=m
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=m
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_DIRECTIO=y
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_MATROX_PROC=m
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_RADEON=m
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB2=m
CONFIG_FBCON_CFB4=m
CONFIG_FBCON_CFB8=m
CONFIG_FBCON_CFB16=m
CONFIG_FBCON_CFB24=m
CONFIG_FBCON_CFB32=m
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set
# CONFIG_FBCON_VGA_PLANES is not set
# CONFIG_FBCON_VGA is not set
# CONFIG_FBCON_HGA is not set
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
CONFIG_FBCON_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set
# CONFIG_SOUND_AD1980 is not set
# CONFIG_SOUND_WM97XX is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
# CONFIG_USB_OHCI is not set
# CONFIG_USB_SL811HS_ALT is not set
# CONFIG_USB_SL811HS is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_DPCM=y
# CONFIG_USB_STORAGE_HP8200e is not set
CONFIG_USB_STORAGE_SDDR09=y
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=m
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_W9968CF is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_DEBUG is not set
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
CONFIG_USB_SERIAL_XIRCOM=m
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_FRAME_POINTER=y
CONFIG_LOG_BUF_SHIFT=16

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_FW_LOADER=m

--ZGiS0Q5IWpPtfppv--

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1xfPIonHnh+67jkRAlWcAJ9B13WfciZtqjtzCosJDfyIBoe4eQCfZQ7W
j1HwqsDBLOr6Dw1JPLhdT+4=
=Bhw5
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
