Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTLWUFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 15:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTLWUFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 15:05:54 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:61897 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S262683AbTLWUET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 15:04:19 -0500
Date: Tue, 23 Dec 2003 12:04:12 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Klaus Frahm <frahm@irsamc.ups-tlse.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug/Problem when using 2 USB memory sticks in 2.4.23 and 2.4.24-pre2
Message-ID: <20031223200412.GA13048@one-eyed-alien.net>
Mail-Followup-To: Klaus Frahm <frahm@irsamc.ups-tlse.fr>,
	linux-kernel@vger.kernel.org
References: <200312231952.hBNJqB502763@pttpc1.ups-tlse.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <200312231952.hBNJqB502763@pttpc1.ups-tlse.fr>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Use 'eject /dev/sda' to force the kernel to re-scan the new media when you
change sticks.

The problem is that the device does not give a media-change indication, as
it should.

Matt

On Tue, Dec 23, 2003 at 08:52:11PM +0100, Klaus Frahm wrote:
> Bug/Problem when using 2 USB memory sticks in 2.4.23 and 2.4.24-pre2
>=20
> I have encountered a strange problem/bug with 2.4.23 (and 2.4.24-pre2)=20
> when using two different USB-memory sticks (256 MB and 128 MB, both from=
=20
> Kingmax). The bug is NOT present in 2.6.0 where everything works perfectl=
y.
>=20
> When I insert the first memory stick (with 256 MB) and mount it via the=
=20
> scsi-emulation (/dev/sda) it works correctly and /proc/partitions gives:
>=20
>    8     0     256000 sda  <-- memory stick=20
>    8     1  985184692 sda1
>    8     2  271759162 sda2
>    8     3 1093808825 sda3
>    8     4 1751209472 sda4
>    3     0   19535040 hda
>    3     1      32098 hda1
>    3     2    8120857 hda2
>    3     3      72292 hda3
>    3     4          1 hda4
>    3     5    1052226 hda5
>    3     6     530113 hda6
>    3     7    9727326 hda7
>=20
> After unmounting and unplugging the memory stick the entries with sda rem=
ain=20
> present in /proc/partitions with Kernel version 2.4.23 (and 2.4.24-pre2)=
=20
> while with Kernel version 2.6.0 they disappear (as it should be ??).=20
> There is no problem if I continue to use later the same memory stick. How=
ever,=20
> when using another memory stick the remaining entry for sda will provide =
false=20
> information about the stick to the kernel. For example, I have a second=
=20
> stick with 128 MB which is "formatted" with two partitions of 114 MB and=
=20
> 10 MB. (I would need to access a Windows PC to change that with the=20
> windows-driver from Kingmax; however I don't believe that the issue with=
=20
> the two partitions is relevant for the bug I am reporting.)
> Then, the second partition (of 10 MB) is correctly recognized on sdb and =
it=20
> can be mounted correctly. However, /proc/partition is wrong about the fir=
st=20
> partition on sda:
>=20
>    8     0     256000 sda  <-- should be 1st partion of 2nd stick=20
>                                  with about 114000, incorrect !!
>    8     1  985184692 sda1
>    8     2  271759162 sda2
>    8     3 1093808825 sda3
>    8     4 1751209472 sda4
>    8    16      10240 sdb  <-- 2nd partition of 2nd stick, correct
>    8    17  985184692 sdb1
>    8    18  271759162 sdb2
>    8    19 1093808825 sdb3
>    8    20 1751209472 sdb4
>    3     0   19535040 hda
>    3     1      32098 hda1
>    3     2    8120857 hda2
>    3     3      72292 hda3
>    3     4          1 hda4
>    3     5    1052226 hda5
>    3     6     530113 hda6
>    3     7    9727326 hda7
>=20
>=20
> However, I can mount /dev/sda and it seems okay (for reading):
> df gives:
> /dev/sdb                 10212      3808      6404  38% /mnt/memory2
> /dev/sda                117512     27880     89632  24% /mnt/memory
>=20
> but when I try the other way round (first the small and then the larger=
=20
> stick) I get strange errors (like "reading beyond device boundaries" etc =
).=20
> Once, I also got a corruption of the vfat file-system on one of the stick=
s=20
> which is not really a surprise if the kernel assume a wrong device size.=
=20
>=20
> Both partitions are correctly recognized when I directly use the 2nd smal=
l=20
> memory stick (without using the 1st stick) after boot.=20
>=20
>=20
> This problem is not at all present in 2.6.0 where the bad entries about=
=20
> /dev/sda in /proc/partitions disappear after unplugging of the first stic=
k=20
> and reappear correctly when inserting the other stick.=20
> However, I remember that in a former version=20
> of 2.6.0-test6 or -test7 there was a similar bug with a problematic/wrong=
=20
> entry in /proc/partitions. (There the bug was more serious because the=20
> device name increased permanently from sda to sdb, sdc, sdd etc. when=20
> unplugging, inserting the stick. This does not happen in 2.4.23 or=20
> 2.4.24-pre2.) A further effect of this bug is that running "lilo" after=
=20
> using the memory stick gives first an error message. Running "lilo" a sec=
ond=20
> time is okay (while for 2.6.0-test6/7 "lilo" was really broken).=20
>=20
> A kind of workaround of the bug is to unload the modules: sd_mod,=20
> usb-storage, scsi_mod   after unplugging the first stick. Then the entrie=
s=20
> in /proc/partitions are cleaned from sda and it seems one can insert save=
ly=20
> the 2nd stick (which will automatically reload the same modules).=20
>=20
> I have added below some info (dmesg, lsmod output and .config). Please=20
> make cc to me (frahm _(!)_ irsamc _dot_ ups-tlse _dot_ fr) if you need fu=
rther=20
> information. I have the impression that this bug is quite general and not=
=20
> dependent on the particular hardware. I have seen the "bad" sda-entries=
=20
> in /proc/partition also on other machines (for the moment I cannot=20
> access these machines to test with the 2 sticks). I know that other types=
=20
> of memory sticks require mount-points like /dev/sda1 instead /dev/sda.=20
> This seems to be a particularity for the Kingmax memory sticks.=20
> I don't know if this is relevant for the problem described here.=20
>=20
>=20
> Greetings,
>=20
> Klaus Frahm.
>=20
> --------------------------------------------------------------------------
> ----- Output of dmesg; see at the end for the entries concerning USB -----
> --------------------------------------------------------------------------
> Linux version 2.4.24-pre2 (frahm@pttpc1.ups-tlse.fr) (gcc version 3.3.2) =
#1 Tue Dec 23 13:49:03 CET 2003
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000ffe2800 (usable)
>  BIOS-e820: 000000000ffe2800 - 0000000010000000 (reserved)
>  BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
>  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
> 255MB LOWMEM available.
> On node 0 totalpages: 65506
> zone(0): 4096 pages.
> zone(1): 61410 pages.
> zone(2): 0 pages.
> Kernel command line: ro root=3D/dev/hda7
> Initializing CPU#0
> Detected 1794.744 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 3578.26 BogoMIPS
> Memory: 256448k/262024k available (1407k kernel code, 5188k reserved, 524=
k data, 124k init, 0k highmem)
> Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
> Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
> Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
> CPU:             Common caps: bfebf9ff 00000000 00000000 00000000
> CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz stepping 07
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: Intel
> PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=3D2
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
> Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
> PCI: Discovered primary peer bus 08 [IRQ]
> PCI: Using IRQ router PIIX/ICH [8086/248c] at 00:1f.0
> PCI: Found IRQ 11 for device 00:1f.1
> PCI: Sharing IRQ 11 with 00:1d.2
> PCI: Sharing IRQ 11 with 02:00.0
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
> Starting kswapd
> VFS: Disk quotas vdquot_6.5.1
> Journalled Block Device driver loaded
> pty: 2048 Unix98 ptys configured
> Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz@debian.org)
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_=
IRQ SERIAL_PCI ISAPNP enabled
> ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
> PCI: Found IRQ 11 for device 00:1f.6
> PCI: Sharing IRQ 11 with 00:1f.5
> Real Time Clock Driver v1.10f
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> NET4: Frame Diverter 0.46
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> PCI: Found IRQ 11 for device 02:00.0
> PCI: Sharing IRQ 11 with 00:1d.2
> PCI: Sharing IRQ 11 with 00:1f.1
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> See Documentation/networking/vortex.txt
> 02:00.0: 3Com PCI 3c905C Tornado at 0xec80. Vers LK1.1.18-ac
>  00:08:74:e1:17:8f, IRQ 11
>   product code 0000 rev 00.6 date 08-17-02
>   Internal config register is 1840000, transceivers 0xa.
>   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
>   MII transceiver found at address 24, status 7809.
>   Enabling bus-master transmits and whole-frame receives.
> 02:00.0: scatter/gather enabled. h/w checksums enabled
> divert: allocating divert_blk for eth0
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx
> ICH3M: IDE controller at PCI slot 00:1f.1
> PCI: Enabling device 00:1f.1 (0005 -> 0007)
> PCI: Found IRQ 11 for device 00:1f.1
> PCI: Sharing IRQ 11 with 00:1d.2
> PCI: Sharing IRQ 11 with 02:00.0
> ICH3M: chipset revision 2
> ICH3M: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
> hda: IC25N020ATCS04-0, ATA DISK drive
> hdb: TOSHIBA DVD-ROM SD-C2612, ATAPI CD/DVD-ROM drive
> blk: queue c033c380, I/O limit 4095Mb (mask 0xffffffff)
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: attached ide-disk driver.
> hda: host protected area =3D> 1
> hda: 39070080 sectors (20004 MB) w/1768KiB Cache, CHS=3D2432/255/63, UDMA=
(100)
> hdb: attached ide-cdrom driver.
> hdb: ATAPI 24X DVD-ROM drive, 192kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> Partition check:
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
> ide: late registration of driver.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 32768)
> Linux IP multicast router 0.06 plus PIM-SM
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 124k freed
> Adding Swap: 530104k swap-space (priority -1)
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.275 $ time 13:58:21 Dec 23 2003
> usb-uhci.c: High bandwidth mode enabled
> PCI: Found IRQ 11 for device 00:1d.0
> PCI: Sharing IRQ 11 with 01:00.0
> PCI: Setting latency timer of device 00:1d.0 to 64
> usb-uhci.c: USB UHCI at I/O 0xbf80, IRQ 11
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Found IRQ 11 for device 00:1d.2
> PCI: Sharing IRQ 11 with 00:1f.1
> PCI: Sharing IRQ 11 with 02:00.0
> PCI: Setting latency timer of device 00:1d.2 to 64
> usb-uhci.c: USB UHCI at I/O 0xbf20, IRQ 11
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> attempt to access beyond end of device
> 03:06: rw=3D0, want=3D530116, limit=3D530113
> attempt to access beyond end of device
> 03:07: rw=3D0, want=3D9727328, limit=3D9727326
> EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> hdb: DMA disabled
> parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> parport0: irq 7 detected
> Linux Kernel Card Services 3.1.22
>   options:  [pci] [cardbus] [pm]
> PCI: Found IRQ 11 for device 02:01.0
> PCI: Sharing IRQ 11 with 02:01.1
> PCI: Sharing IRQ 11 with 02:01.2
> PCI: Found IRQ 11 for device 02:01.1
> PCI: Sharing IRQ 11 with 02:01.0
> PCI: Sharing IRQ 11 with 02:01.2
> Yenta ISA IRQ mask 0x06b8, PCI irq 11
> Socket status: 30000006
> Yenta ISA IRQ mask 0x06b8, PCI irq 11
> Socket status: 30000006
> cs: IO port probe 0x0c00-0x0cff: clean.
> cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
> cs: IO port probe 0x0a00-0x0aff: clean.
> parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> parport0: irq 7 detected
> lp0: using parport0 (polling).
> lp0: console ready
> hub.c: new USB device 00:1d.0-1, assigned address 2
> hub.c: USB hub found
> hub.c: 1 port detected
> hub.c: new USB device 00:1d.0-1.1, assigned address 3
> usb.c: USB device 3 (vend/prod 0x67b/0x2517) is not claimed by any active=
 driver.
> SCSI subsystem driver Revision: 1.00
> Initializing USB Mass Storage driver...
> usb.c: registered new driver usb-storage
> scsi0 : SCSI emulation for USB Mass Storage devices
>   Vendor: Prolific  Model: USB Flash Disk    Rev: 1.00
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 3
> USB Mass Storage support registered.
> Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> SCSI device sda: 512000 512-byte hdwr sectors (262 MB)
> sda: Write Protect is off
>  sda: sda1 sda2 sda3 sda4
> SCSI error: host 0 id 0 lun 0 return code =3D 8000002
> 	Sense class 7, sense error 0, extended sense 0
> SCSI error: host 0 id 0 lun 0 return code =3D 8000002
> 	Sense class 7, sense error 0, extended sense 0
> usb.c: USB disconnect on device 00:1d.0-1 address 2
> usb.c: USB disconnect on device 00:1d.0-1.1 address 3
> hub.c: new USB device 00:1d.0-1, assigned address 4
> hub.c: USB hub found
> hub.c: 2 ports detected
> hub.c: new USB device 00:1d.0-1.1, assigned address 5
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 5
> hub.c: new USB device 00:1d.0-1.2, assigned address 6
> scsi1 : SCSI emulation for USB Mass Storage devices
>   Vendor: Prolific  Model: USB Flash Disk    Rev: PROL
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 0
> SCSI device sdb: 20480 512-byte hdwr sectors (10 MB)
> sdb: Write Protect is off
>  sdb: sdb1 sdb2 sdb3 sdb4
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 6
> usb.c: USB disconnect on device 00:1d.0-1 address 4
> usb.c: USB disconnect on device 00:1d.0-1.1 address 5
> usb.c: USB disconnect on device 00:1d.0-1.2 address 6
> -----------------------------------------------------------
> --- output of lsmod ---------------------------------------
> -----------------------------------------------------------
> Module                  Size  Used by    Not tainted
> sd_mod                 12652   0 (autoclean)
> usb-storage            28752   0
> scsi_mod               69236   3 [sd_mod usb-storage]
> binfmt_misc             7560   1
> parport_pc             19140   1 (autoclean)
> lp                      9156   0 (autoclean)
> parport                37160   1 (autoclean) [parport_pc lp]
> ds                      8724   2
> yenta_socket           13728   2
> pcmcia_core            56992   0 [ds yenta_socket]
> nls_iso8859-1           3516   1 (autoclean)
> nls_cp437               5148   1 (autoclean)
> vfat                   13068   1 (autoclean)
> fat                    38264   0 (autoclean) [vfat]
> usb-uhci               26512   0 (unused)
> usbcore                78956   1 [usb-storage usb-uhci]
> ---------------------------------------------------------------------
> ---- .config --------------------------------------------------------
> ---------------------------------------------------------------------
> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=3Dy
> # CONFIG_SBUS is not set
> CONFIG_UID16=3Dy
>=20
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=3Dy
>=20
> #
> # Loadable module support
> #
> CONFIG_MODULES=3Dy
> CONFIG_MODVERSIONS=3Dy
> CONFIG_KMOD=3Dy
>=20
> #
> # Processor type and features
> #
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMIII is not set
> CONFIG_MPENTIUM4=3Dy
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> CONFIG_X86_WP_WORKS_OK=3Dy
> CONFIG_X86_INVLPG=3Dy
> CONFIG_X86_CMPXCHG=3Dy
> CONFIG_X86_XADD=3Dy
> CONFIG_X86_BSWAP=3Dy
> CONFIG_X86_POPAD_OK=3Dy
> # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
> CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> CONFIG_X86_L1_CACHE_SHIFT=3D7
> CONFIG_X86_HAS_TSC=3Dy
> CONFIG_X86_GOOD_APIC=3Dy
> CONFIG_X86_PGE=3Dy
> CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
> CONFIG_X86_F00F_WORKS_OK=3Dy
> CONFIG_X86_MCE=3Dy
> # CONFIG_TOSHIBA is not set
> CONFIG_I8K=3Dy
> CONFIG_MICROCODE=3Dm
> CONFIG_X86_MSR=3Dm
> CONFIG_X86_CPUID=3Dm
> # CONFIG_EDD is not set
> CONFIG_NOHIGHMEM=3Dy
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_HIGHMEM is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=3Dy
> # CONFIG_SMP is not set
> # CONFIG_X86_UP_APIC is not set
> # CONFIG_X86_TSC_DISABLE is not set
> CONFIG_X86_TSC=3Dy
>=20
> #
> # General setup
> #
> CONFIG_NET=3Dy
> CONFIG_PCI=3Dy
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=3Dy
> CONFIG_PCI_BIOS=3Dy
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_ISA=3Dy
> CONFIG_PCI_NAMES=3Dy
> CONFIG_EISA=3Dy
> # CONFIG_MCA is not set
> CONFIG_HOTPLUG=3Dy
>=20
> #
> # PCMCIA/CardBus support
> #
> CONFIG_PCMCIA=3Dm
> CONFIG_CARDBUS=3Dy
> CONFIG_TCIC=3Dy
> CONFIG_I82092=3Dy
> CONFIG_I82365=3Dy
>=20
> #
> # PCI Hotplug Support
> #
> # CONFIG_HOTPLUG_PCI is not set
> CONFIG_SYSVIPC=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_SYSCTL=3Dy
> CONFIG_KCORE_ELF=3Dy
> # CONFIG_KCORE_AOUT is not set
> CONFIG_BINFMT_AOUT=3Dm
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_BINFMT_MISC=3Dm
> # CONFIG_OOM_KILLER is not set
> CONFIG_PM=3Dy
> CONFIG_APM=3Dy
> # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> # CONFIG_APM_DO_ENABLE is not set
> CONFIG_APM_CPU_IDLE=3Dy
> # CONFIG_APM_DISPLAY_BLANK is not set
> CONFIG_APM_RTC_IS_GMT=3Dy
> # CONFIG_APM_ALLOW_INTS is not set
> # CONFIG_APM_REAL_MODE_POWER_OFF is not set
>=20
> #
> # ACPI Support
> #
> # CONFIG_ACPI is not set
>=20
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
>=20
> #
> # Parallel port support
> #
> CONFIG_PARPORT=3Dm
> CONFIG_PARPORT_PC=3Dm
> CONFIG_PARPORT_PC_CML1=3Dm
> CONFIG_PARPORT_SERIAL=3Dm
> # CONFIG_PARPORT_PC_FIFO is not set
> # CONFIG_PARPORT_PC_SUPERIO is not set
> CONFIG_PARPORT_PC_PCMCIA=3Dm
> # CONFIG_PARPORT_AMIGA is not set
> # CONFIG_PARPORT_MFC3 is not set
> # CONFIG_PARPORT_ATARI is not set
> # CONFIG_PARPORT_GSC is not set
> # CONFIG_PARPORT_SUNBPP is not set
> # CONFIG_PARPORT_IP22 is not set
> # CONFIG_PARPORT_OTHER is not set
> CONFIG_PARPORT_1284=3Dy
>=20
> #
> # Plug and Play configuration
> #
> CONFIG_PNP=3Dy
> CONFIG_ISAPNP=3Dy
>=20
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=3Dy
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=3Dm
> CONFIG_BLK_DEV_NBD=3Dm
> CONFIG_BLK_DEV_RAM=3Dy
> CONFIG_BLK_DEV_RAM_SIZE=3D4096
> CONFIG_BLK_DEV_INITRD=3Dy
> # CONFIG_BLK_STATS is not set
>=20
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
>=20
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_MMAP=3Dy
> CONFIG_NETLINK_DEV=3Dy
> CONFIG_NETFILTER=3Dy
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_FILTER=3Dy
> CONFIG_UNIX=3Dy
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_FWMARK=3Dy
> CONFIG_IP_ROUTE_NAT=3Dy
> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> CONFIG_IP_ROUTE_TOS=3Dy
> CONFIG_IP_ROUTE_VERBOSE=3Dy
> # CONFIG_IP_PNP is not set
> CONFIG_NET_IPIP=3Dm
> CONFIG_NET_IPGRE=3Dm
> CONFIG_NET_IPGRE_BROADCAST=3Dy
> CONFIG_IP_MROUTE=3Dy
> CONFIG_IP_PIMSM_V1=3Dy
> CONFIG_IP_PIMSM_V2=3Dy
> # CONFIG_ARPD is not set
> # CONFIG_INET_ECN is not set
> CONFIG_SYN_COOKIES=3Dy
>=20
> #
> #   IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=3Dm
> CONFIG_IP_NF_FTP=3Dm
> # CONFIG_IP_NF_AMANDA is not set
> # CONFIG_IP_NF_TFTP is not set
> CONFIG_IP_NF_IRC=3Dm
> CONFIG_IP_NF_QUEUE=3Dm
> CONFIG_IP_NF_IPTABLES=3Dm
> CONFIG_IP_NF_MATCH_LIMIT=3Dm
> CONFIG_IP_NF_MATCH_MAC=3Dm
> # CONFIG_IP_NF_MATCH_PKTTYPE is not set
> CONFIG_IP_NF_MATCH_MARK=3Dm
> CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
> CONFIG_IP_NF_MATCH_TOS=3Dm
> # CONFIG_IP_NF_MATCH_RECENT is not set
> # CONFIG_IP_NF_MATCH_ECN is not set
> # CONFIG_IP_NF_MATCH_DSCP is not set
> CONFIG_IP_NF_MATCH_AH_ESP=3Dm
> CONFIG_IP_NF_MATCH_LENGTH=3Dm
> CONFIG_IP_NF_MATCH_TTL=3Dm
> CONFIG_IP_NF_MATCH_TCPMSS=3Dm
> # CONFIG_IP_NF_MATCH_HELPER is not set
> CONFIG_IP_NF_MATCH_STATE=3Dm
> # CONFIG_IP_NF_MATCH_CONNTRACK is not set
> CONFIG_IP_NF_MATCH_UNCLEAN=3Dm
> CONFIG_IP_NF_MATCH_OWNER=3Dm
> CONFIG_IP_NF_FILTER=3Dm
> CONFIG_IP_NF_TARGET_REJECT=3Dm
> CONFIG_IP_NF_TARGET_MIRROR=3Dm
> CONFIG_IP_NF_NAT=3Dm
> CONFIG_IP_NF_NAT_NEEDED=3Dy
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP_NF_TARGET_REDIRECT=3Dm
> CONFIG_IP_NF_NAT_LOCAL=3Dm
> CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
> CONFIG_IP_NF_NAT_IRC=3Dm
> CONFIG_IP_NF_NAT_FTP=3Dm
> CONFIG_IP_NF_MANGLE=3Dm
> CONFIG_IP_NF_TARGET_TOS=3Dm
> # CONFIG_IP_NF_TARGET_ECN is not set
> # CONFIG_IP_NF_TARGET_DSCP is not set
> CONFIG_IP_NF_TARGET_MARK=3Dm
> CONFIG_IP_NF_TARGET_LOG=3Dm
> CONFIG_IP_NF_TARGET_ULOG=3Dm
> CONFIG_IP_NF_TARGET_TCPMSS=3Dm
> CONFIG_IP_NF_ARPTABLES=3Dm
> CONFIG_IP_NF_ARPFILTER=3Dm
> # CONFIG_IP_NF_ARP_MANGLE is not set
> CONFIG_IP_NF_COMPAT_IPCHAINS=3Dm
> CONFIG_IP_NF_NAT_NEEDED=3Dy
> CONFIG_IP_NF_COMPAT_IPFWADM=3Dm
> CONFIG_IP_NF_NAT_NEEDED=3Dy
>=20
> #
> #   IP: Virtual Server Configuration
> #
> # CONFIG_IP_VS is not set
> CONFIG_IPV6=3Dm
>=20
> #
> #   IPv6: Netfilter Configuration
> #
> # CONFIG_IP6_NF_QUEUE is not set
> CONFIG_IP6_NF_IPTABLES=3Dm
> CONFIG_IP6_NF_MATCH_LIMIT=3Dm
> CONFIG_IP6_NF_MATCH_MAC=3Dm
> # CONFIG_IP6_NF_MATCH_RT is not set
> # CONFIG_IP6_NF_MATCH_OPTS is not set
> # CONFIG_IP6_NF_MATCH_FRAG is not set
> # CONFIG_IP6_NF_MATCH_HL is not set
> CONFIG_IP6_NF_MATCH_MULTIPORT=3Dm
> CONFIG_IP6_NF_MATCH_OWNER=3Dm
> CONFIG_IP6_NF_MATCH_MARK=3Dm
> # CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
> # CONFIG_IP6_NF_MATCH_AHESP is not set
> # CONFIG_IP6_NF_MATCH_LENGTH is not set
> # CONFIG_IP6_NF_MATCH_EUI64 is not set
> CONFIG_IP6_NF_FILTER=3Dm
> CONFIG_IP6_NF_TARGET_LOG=3Dm
> CONFIG_IP6_NF_MANGLE=3Dm
> CONFIG_IP6_NF_TARGET_MARK=3Dm
> # CONFIG_KHTTPD is not set
>=20
> #
> #    SCTP Configuration (EXPERIMENTAL)
> #
> CONFIG_IPV6_SCTP__=3Dm
> # CONFIG_IP_SCTP is not set
> CONFIG_ATM=3Dy
> CONFIG_ATM_CLIP=3Dy
> # CONFIG_ATM_CLIP_NO_ICMP is not set
> CONFIG_ATM_LANE=3Dm
> CONFIG_ATM_MPOA=3Dm
> CONFIG_ATM_BR2684=3Dm
> CONFIG_ATM_BR2684_IPFILTER=3Dy
> CONFIG_VLAN_8021Q=3Dm
>=20
> #
> # =20
> #
> CONFIG_IPX=3Dm
> # CONFIG_IPX_INTERN is not set
> CONFIG_ATALK=3Dm
>=20
> #
> # Appletalk devices
> #
> CONFIG_DEV_APPLETALK=3Dy
> CONFIG_LTPC=3Dm
> CONFIG_COPS=3Dm
> CONFIG_COPS_DAYNA=3Dy
> CONFIG_COPS_TANGENT=3Dy
> CONFIG_IPDDP=3Dm
> CONFIG_IPDDP_ENCAP=3Dy
> CONFIG_IPDDP_DECAP=3Dy
> CONFIG_DECNET=3Dm
> CONFIG_DECNET_SIOCGIFCONF=3Dy
> CONFIG_DECNET_ROUTER=3Dy
> CONFIG_DECNET_ROUTE_FWMARK=3Dy
> CONFIG_BRIDGE=3Dm
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_LLC is not set
> CONFIG_NET_DIVERT=3Dy
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
>=20
> #
> # QoS and/or fair queueing
> #
> CONFIG_NET_SCHED=3Dy
> CONFIG_NET_SCH_CBQ=3Dm
> CONFIG_NET_SCH_HTB=3Dm
> CONFIG_NET_SCH_CSZ=3Dm
> # CONFIG_NET_SCH_ATM is not set
> CONFIG_NET_SCH_PRIO=3Dm
> CONFIG_NET_SCH_RED=3Dm
> CONFIG_NET_SCH_SFQ=3Dm
> CONFIG_NET_SCH_TEQL=3Dm
> CONFIG_NET_SCH_TBF=3Dm
> CONFIG_NET_SCH_GRED=3Dm
> CONFIG_NET_SCH_DSMARK=3Dm
> CONFIG_NET_SCH_INGRESS=3Dm
> CONFIG_NET_QOS=3Dy
> CONFIG_NET_ESTIMATOR=3Dy
> CONFIG_NET_CLS=3Dy
> CONFIG_NET_CLS_TCINDEX=3Dm
> CONFIG_NET_CLS_ROUTE4=3Dm
> CONFIG_NET_CLS_ROUTE=3Dy
> CONFIG_NET_CLS_FW=3Dm
> CONFIG_NET_CLS_U32=3Dm
> CONFIG_NET_CLS_RSVP=3Dm
> CONFIG_NET_CLS_RSVP6=3Dm
> CONFIG_NET_CLS_POLICE=3Dy
>=20
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
>=20
> #
> # Telephony Support
> #
> CONFIG_PHONE=3Dm
> CONFIG_PHONE_IXJ=3Dm
> CONFIG_PHONE_IXJ_PCMCIA=3Dm
>=20
> #
> # ATA/IDE/MFM/RLL support
> #
> CONFIG_IDE=3Dy
>=20
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=3Dy
>=20
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_HD is not set
> CONFIG_BLK_DEV_IDEDISK=3Dy
> CONFIG_IDEDISK_MULTI_MODE=3Dy
> # CONFIG_IDEDISK_STROKE is not set
> CONFIG_BLK_DEV_IDECS=3Dm
> CONFIG_BLK_DEV_IDECD=3Dy
> CONFIG_BLK_DEV_IDETAPE=3Dm
> CONFIG_BLK_DEV_IDEFLOPPY=3Dy
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
>=20
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_BLK_DEV_CMD640=3Dy
> # CONFIG_BLK_DEV_CMD640_ENHANCED is not set
> CONFIG_BLK_DEV_ISAPNP=3Dy
> CONFIG_BLK_DEV_IDEPCI=3Dy
> CONFIG_BLK_DEV_GENERIC=3Dy
> CONFIG_IDEPCI_SHARE_IRQ=3Dy
> CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=3Dy
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_IDEDMA=3Dy
> # CONFIG_IDEDMA_PCI_WIP is not set
> CONFIG_BLK_DEV_ADMA100=3Dy
> CONFIG_BLK_DEV_AEC62XX=3Dy
> CONFIG_BLK_DEV_ALI15X3=3Dy
> # CONFIG_WDC_ALI15X3 is not set
> CONFIG_BLK_DEV_AMD74XX=3Dy
> # CONFIG_AMD74XX_OVERRIDE is not set
> CONFIG_BLK_DEV_CMD64X=3Dy
> # CONFIG_BLK_DEV_TRIFLEX is not set
> CONFIG_BLK_DEV_CY82C693=3Dy
> CONFIG_BLK_DEV_CS5530=3Dy
> CONFIG_BLK_DEV_HPT34X=3Dy
> CONFIG_BLK_DEV_HPT366=3Dy
> CONFIG_BLK_DEV_PIIX=3Dy
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> CONFIG_BLK_DEV_RZ1000=3Dy
> # CONFIG_BLK_DEV_SC1200 is not set
> CONFIG_BLK_DEV_SVWKS=3Dy
> # CONFIG_BLK_DEV_SIIMAGE is not set
> CONFIG_BLK_DEV_SIS5513=3Dy
> CONFIG_BLK_DEV_SLC90E66=3Dy
> # CONFIG_BLK_DEV_TRM290 is not set
> CONFIG_BLK_DEV_VIA82CXXX=3Dy
> # CONFIG_IDE_CHIPSETS is not set
> CONFIG_IDEDMA_AUTO=3Dy
> # CONFIG_IDEDMA_IVB is not set
> # CONFIG_DMA_NONPCI is not set
> CONFIG_BLK_DEV_IDE_MODES=3Dy
> CONFIG_BLK_DEV_ATARAID=3Dm
> CONFIG_BLK_DEV_ATARAID_PDC=3Dm
> CONFIG_BLK_DEV_ATARAID_HPT=3Dm
> # CONFIG_BLK_DEV_ATARAID_SII is not set
>=20
> #
> # SCSI support
> #
> CONFIG_SCSI=3Dm
>=20
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=3Dm
> CONFIG_SD_EXTRA_DEVS=3D40
> CONFIG_CHR_DEV_ST=3Dm
> CONFIG_CHR_DEV_OSST=3Dm
> CONFIG_BLK_DEV_SR=3Dm
> # CONFIG_BLK_DEV_SR_VENDOR is not set
> CONFIG_SR_EXTRA_DEVS=3D2
> CONFIG_CHR_DEV_SG=3Dm
>=20
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_DEBUG_QUEUES is not set
> # CONFIG_SCSI_MULTI_LUN is not set
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
>=20
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AHA1740 is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_MEGARAID2 is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_DMA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_NCR53C7xx is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_NCR53C8XX is not set
> # CONFIG_SCSI_SYM53C8XX is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SEAGATE is not set
> # CONFIG_SCSI_SIM710 is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
>=20
> #
> # PCMCIA SCSI adapter support
> #
> # CONFIG_SCSI_PCMCIA is not set
>=20
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> # CONFIG_FUSION_BOOT is not set
> # CONFIG_FUSION_ISENSE is not set
> # CONFIG_FUSION_CTL is not set
> # CONFIG_FUSION_LAN is not set
>=20
> #
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> CONFIG_IEEE1394=3Dm
>=20
> #
> # Device Drivers
> #
>=20
> #
> #   Texas Instruments PCILynx requires I2C bit-banging
> #
> CONFIG_IEEE1394_OHCI1394=3Dm
>=20
> #
> # Protocol Drivers
> #
> CONFIG_IEEE1394_VIDEO1394=3Dm
> # CONFIG_IEEE1394_SBP2 is not set
> CONFIG_IEEE1394_ETH1394=3Dm
> CONFIG_IEEE1394_DV1394=3Dm
> CONFIG_IEEE1394_RAWIO=3Dm
> CONFIG_IEEE1394_CMP=3Dm
> CONFIG_IEEE1394_AMDTP=3Dm
> # CONFIG_IEEE1394_VERBOSEDEBUG is not set
> # CONFIG_IEEE1394_OUI_DB is not set
>=20
> #
> # I2O device support
> #
> CONFIG_I2O=3Dm
> CONFIG_I2O_PCI=3Dm
> CONFIG_I2O_BLOCK=3Dm
> CONFIG_I2O_LAN=3Dm
> # CONFIG_I2O_SCSI is not set
> CONFIG_I2O_PROC=3Dm
>=20
> #
> # Network device support
> #
> CONFIG_NETDEVICES=3Dy
>=20
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> CONFIG_DUMMY=3Dm
> CONFIG_BONDING=3Dm
> CONFIG_EQUALIZER=3Dm
> CONFIG_TUN=3Dm
> CONFIG_ETHERTAP=3Dm
> CONFIG_NET_SB1000=3Dm
>=20
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=3Dy
> CONFIG_HAPPYMEAL=3Dm
> CONFIG_SUNGEM=3Dm
> CONFIG_NET_VENDOR_3COM=3Dy
> # CONFIG_EL1 is not set
> # CONFIG_EL2 is not set
> # CONFIG_ELPLUS is not set
> # CONFIG_EL16 is not set
> # CONFIG_EL3 is not set
> # CONFIG_3C515 is not set
> CONFIG_VORTEX=3Dy
> # CONFIG_TYPHOON is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> # CONFIG_AT1700 is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> # CONFIG_NET_PCI is not set
> # CONFIG_NET_POCKET is not set
>=20
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
> CONFIG_FDDI=3Dy
> CONFIG_DEFXX=3Dm
> CONFIG_SKFP=3Dm
> # CONFIG_HIPPI is not set
> CONFIG_PLIP=3Dm
> CONFIG_PPP=3Dm
> CONFIG_PPP_MULTILINK=3Dy
> CONFIG_PPP_FILTER=3Dy
> CONFIG_PPP_ASYNC=3Dm
> CONFIG_PPP_SYNC_TTY=3Dm
> CONFIG_PPP_DEFLATE=3Dm
> # CONFIG_PPP_BSDCOMP is not set
> # CONFIG_PPPOE is not set
> # CONFIG_PPPOATM is not set
> # CONFIG_SLIP is not set
>=20
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
>=20
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> CONFIG_NET_FC=3Dy
> # CONFIG_IPHASE5526 is not set
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set
>=20
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
>=20
> #
> # PCMCIA network device support
> #
> # CONFIG_NET_PCMCIA is not set
>=20
> #
> # ATM drivers
> #
> # CONFIG_ATM_TCP is not set
> # CONFIG_ATM_LANAI is not set
> # CONFIG_ATM_ENI is not set
> # CONFIG_ATM_FIRESTREAM is not set
> # CONFIG_ATM_ZATM is not set
> # CONFIG_ATM_NICSTAR is not set
> # CONFIG_ATM_IDT77252 is not set
> # CONFIG_ATM_AMBASSADOR is not set
> # CONFIG_ATM_HORIZON is not set
> # CONFIG_ATM_IA is not set
> # CONFIG_ATM_FORE200E_MAYBE is not set
> # CONFIG_ATM_HE is not set
>=20
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
>=20
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
>=20
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
>=20
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
>=20
> #
> # Input core support
> #
> CONFIG_INPUT=3Dm
> CONFIG_INPUT_KEYBDEV=3Dm
> CONFIG_INPUT_MOUSEDEV=3Dm
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> CONFIG_INPUT_JOYDEV=3Dm
> CONFIG_INPUT_EVDEV=3Dm
> # CONFIG_INPUT_UINPUT is not set
>=20
> #
> # Character devices
> #
> CONFIG_VT=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_SERIAL=3Dy
> CONFIG_SERIAL_CONSOLE=3Dy
> CONFIG_SERIAL_EXTENDED=3Dy
> CONFIG_SERIAL_MANY_PORTS=3Dy
> CONFIG_SERIAL_SHARE_IRQ=3Dy
> # CONFIG_SERIAL_DETECT_IRQ is not set
> CONFIG_SERIAL_MULTIPORT=3Dy
> # CONFIG_HUB6 is not set
> CONFIG_SERIAL_NONSTANDARD=3Dy
> CONFIG_COMPUTONE=3Dm
> CONFIG_ROCKETPORT=3Dm
> CONFIG_CYCLADES=3Dm
> # CONFIG_CYZ_INTR is not set
> CONFIG_DIGIEPCA=3Dm
> CONFIG_ESPSERIAL=3Dm
> CONFIG_MOXA_INTELLIO=3Dm
> CONFIG_MOXA_SMARTIO=3Dm
> CONFIG_ISI=3Dm
> CONFIG_SYNCLINK=3Dm
> # CONFIG_SYNCLINKMP is not set
> CONFIG_N_HDLC=3Dm
> CONFIG_RISCOM8=3Dm
> CONFIG_SPECIALIX=3Dm
> CONFIG_SPECIALIX_RTSCTS=3Dy
> CONFIG_SX=3Dm
> # CONFIG_RIO is not set
> # CONFIG_STALDRV is not set
> CONFIG_UNIX98_PTYS=3Dy
> CONFIG_UNIX98_PTY_COUNT=3D2048
> CONFIG_PRINTER=3Dm
> CONFIG_LP_CONSOLE=3Dy
> CONFIG_PPDEV=3Dm
> # CONFIG_TIPAR is not set
>=20
> #
> # I2C support
> #
> # CONFIG_I2C is not set
>=20
> #
> # Mice
> #
> CONFIG_BUSMOUSE=3Dm
> CONFIG_ATIXL_BUSMOUSE=3Dm
> CONFIG_LOGIBUSMOUSE=3Dm
> CONFIG_MS_BUSMOUSE=3Dm
> CONFIG_MOUSE=3Dy
> CONFIG_PSMOUSE=3Dy
> CONFIG_82C710_MOUSE=3Dm
> CONFIG_PC110_PAD=3Dm
> CONFIG_MK712_MOUSE=3Dm
>=20
> #
> # Joysticks
> #
> # CONFIG_INPUT_GAMEPORT is not set
> # CONFIG_INPUT_SERIO is not set
>=20
> #
> # Joysticks
> #
> # CONFIG_INPUT_IFORCE_USB is not set
> # CONFIG_INPUT_DB9 is not set
> # CONFIG_INPUT_GAMECON is not set
> # CONFIG_INPUT_TURBOGRAFX is not set
> # CONFIG_QIC02_TAPE is not set
> # CONFIG_IPMI_HANDLER is not set
>=20
> #
> # Watchdog Cards
> #
> CONFIG_WATCHDOG=3Dy
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_ACQUIRE_WDT=3Dm
> CONFIG_ADVANTECH_WDT=3Dm
> # CONFIG_ALIM1535_WDT is not set
> CONFIG_ALIM7101_WDT=3Dm
> CONFIG_SC520_WDT=3Dm
> CONFIG_PCWATCHDOG=3Dm
> CONFIG_EUROTECH_WDT=3Dm
> CONFIG_IB700_WDT=3Dm
> CONFIG_WAFER_WDT=3Dm
> CONFIG_I810_TCO=3Dm
> # CONFIG_MIXCOMWD is not set
> # CONFIG_60XX_WDT is not set
> CONFIG_SC1200_WDT=3Dm
> # CONFIG_SCx200_WDT is not set
> CONFIG_SOFT_WATCHDOG=3Dm
> CONFIG_W83877F_WDT=3Dm
> CONFIG_WDT=3Dm
> CONFIG_WDTPCI=3Dm
> # CONFIG_WDT_501 is not set
> CONFIG_MACHZ_WDT=3Dm
> CONFIG_AMD7XX_TCO=3Dm
> # CONFIG_SCx200_GPIO is not set
> CONFIG_AMD_RNG=3Dm
> CONFIG_INTEL_RNG=3Dm
> # CONFIG_HW_RANDOM is not set
> CONFIG_AMD_PM768=3Dm
> CONFIG_NVRAM=3Dm
> CONFIG_RTC=3Dy
> # CONFIG_DS1742 is not set
> CONFIG_DTLK=3Dm
> CONFIG_R3964=3Dm
> # CONFIG_APPLICOM is not set
> CONFIG_SONYPI=3Dm
>=20
> #
> # Ftape, the floppy tape device driver
> #
> CONFIG_FTAPE=3Dm
> CONFIG_ZFTAPE=3Dm
> CONFIG_ZFT_DFLT_BLK_SZ=3D10240
>=20
> #
> #   The compressor will be built as a module only!
> #
> CONFIG_ZFT_COMPRESSOR=3Dm
> CONFIG_FT_NR_BUFFERS=3D3
> # CONFIG_FT_PROC_FS is not set
> CONFIG_FT_NORMAL_DEBUG=3Dy
> # CONFIG_FT_FULL_DEBUG is not set
> # CONFIG_FT_NO_TRACE is not set
> # CONFIG_FT_NO_TRACE_AT_ALL is not set
>=20
> #
> # Hardware configuration
> #
> CONFIG_FT_STD_FDC=3Dy
> # CONFIG_FT_MACH2 is not set
> # CONFIG_FT_PROBE_FC10 is not set
> # CONFIG_FT_ALT_FDC is not set
> CONFIG_FT_FDC_THR=3D8
> CONFIG_FT_FDC_MAX_RATE=3D2000
> CONFIG_FT_ALPHA_CLOCK=3D0
> CONFIG_AGP=3Dm
> CONFIG_AGP_INTEL=3Dy
> CONFIG_AGP_I810=3Dy
> CONFIG_AGP_VIA=3Dy
> CONFIG_AGP_AMD=3Dy
> # CONFIG_AGP_AMD_K8 is not set
> CONFIG_AGP_SIS=3Dy
> CONFIG_AGP_ALI=3Dy
> CONFIG_AGP_SWORKS=3Dy
> # CONFIG_AGP_NVIDIA is not set
> # CONFIG_AGP_ATI is not set
>=20
> #
> # Direct Rendering Manager (XFree86 DRI support)
> #
> CONFIG_DRM=3Dy
> # CONFIG_DRM_OLD is not set
>=20
> #
> # DRM 4.1 drivers
> #
> CONFIG_DRM_NEW=3Dy
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_GAMMA is not set
> # CONFIG_DRM_R128 is not set
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_I810 is not set
> # CONFIG_DRM_I830 is not set
> # CONFIG_DRM_MGA is not set
> # CONFIG_DRM_SIS is not set
>=20
> #
> # PCMCIA character devices
> #
> # CONFIG_PCMCIA_SERIAL_CS is not set
> # CONFIG_SYNCLINK_CS is not set
> # CONFIG_MWAVE is not set
>=20
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
>=20
> #
> # File systems
> #
> CONFIG_QUOTA=3Dy
> # CONFIG_QFMT_V2 is not set
> CONFIG_AUTOFS_FS=3Dm
> CONFIG_AUTOFS4_FS=3Dm
> CONFIG_REISERFS_FS=3Dm
> # CONFIG_REISERFS_CHECK is not set
> CONFIG_REISERFS_PROC_INFO=3Dy
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> CONFIG_HFS_FS=3Dm
> # CONFIG_HFSPLUS_FS is not set
> CONFIG_BEFS_FS=3Dm
> # CONFIG_BEFS_DEBUG is not set
> CONFIG_BFS_FS=3Dm
> CONFIG_EXT3_FS=3Dy
> CONFIG_JBD=3Dy
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FAT_FS=3Dm
> CONFIG_MSDOS_FS=3Dm
> CONFIG_UMSDOS_FS=3Dm
> CONFIG_VFAT_FS=3Dm
> # CONFIG_EFS_FS is not set
> CONFIG_CRAMFS=3Dm
> CONFIG_TMPFS=3Dy
> CONFIG_RAMFS=3Dy
> CONFIG_ISO9660_FS=3Dy
> CONFIG_JOLIET=3Dy
> CONFIG_ZISOFS=3Dy
> CONFIG_JFS_FS=3Dm
> CONFIG_JFS_DEBUG=3Dy
> # CONFIG_JFS_STATISTICS is not set
> CONFIG_MINIX_FS=3Dm
> CONFIG_VXFS_FS=3Dm
> CONFIG_NTFS_FS=3Dm
> # CONFIG_NTFS_RW is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_PROC_FS=3Dy
> # CONFIG_DEVFS_FS is not set
> CONFIG_DEVPTS_FS=3Dy
> # CONFIG_QNX4FS_FS is not set
> CONFIG_ROMFS_FS=3Dm
> CONFIG_EXT2_FS=3Dy
> CONFIG_SYSV_FS=3Dm
> CONFIG_UDF_FS=3Dm
> CONFIG_UDF_RW=3Dy
> CONFIG_UFS_FS=3Dm
> # CONFIG_UFS_FS_WRITE is not set
> # CONFIG_XFS_FS is not set
>=20
> #
> # Network File Systems
> #
> CONFIG_CODA_FS=3Dm
> CONFIG_INTERMEZZO_FS=3Dm
> CONFIG_NFS_FS=3Dm
> CONFIG_NFS_V3=3Dy
> # CONFIG_NFS_DIRECTIO is not set
> CONFIG_NFSD=3Dm
> CONFIG_NFSD_V3=3Dy
> # CONFIG_NFSD_TCP is not set
> CONFIG_SUNRPC=3Dm
> CONFIG_LOCKD=3Dm
> CONFIG_LOCKD_V4=3Dy
> CONFIG_SMB_FS=3Dm
> # CONFIG_SMB_NLS_DEFAULT is not set
> CONFIG_NCP_FS=3Dm
> CONFIG_NCPFS_PACKET_SIGNING=3Dy
> CONFIG_NCPFS_IOCTL_LOCKING=3Dy
> CONFIG_NCPFS_STRONG=3Dy
> CONFIG_NCPFS_NFS_NS=3Dy
> CONFIG_NCPFS_OS2_NS=3Dy
> CONFIG_NCPFS_SMALLDOS=3Dy
> CONFIG_NCPFS_NLS=3Dy
> CONFIG_NCPFS_EXTRAS=3Dy
> CONFIG_ZISOFS_FS=3Dy
>=20
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=3Dy
> # CONFIG_ACORN_PARTITION is not set
> CONFIG_OSF_PARTITION=3Dy
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> CONFIG_MAC_PARTITION=3Dy
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_BSD_DISKLABEL=3Dy
> CONFIG_MINIX_SUBPARTITION=3Dy
> CONFIG_SOLARIS_X86_PARTITION=3Dy
> CONFIG_UNIXWARE_DISKLABEL=3Dy
> # CONFIG_LDM_PARTITION is not set
> CONFIG_SGI_PARTITION=3Dy
> # CONFIG_ULTRIX_PARTITION is not set
> CONFIG_SUN_PARTITION=3Dy
> # CONFIG_EFI_PARTITION is not set
> CONFIG_SMB_NLS=3Dy
> CONFIG_NLS=3Dy
>=20
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT=3D"iso8859-1"
> CONFIG_NLS_CODEPAGE_437=3Dm
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=3Dm
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ISO8859_1=3Dm
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_UTF8 is not set
>=20
> #
> # Console drivers
> #
> CONFIG_VGA_CONSOLE=3Dy
> CONFIG_VIDEO_SELECT=3Dy
> CONFIG_MDA_CONSOLE=3Dm
>=20
> #
> # Frame-buffer support
> #
> CONFIG_FB=3Dy
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_FB_RIVA=3Dm
> CONFIG_FB_CLGEN=3Dm
> CONFIG_FB_PM2=3Dm
> # CONFIG_FB_PM2_FIFO_DISCONNECT is not set
> CONFIG_FB_PM2_PCI=3Dy
> CONFIG_FB_PM3=3Dm
> # CONFIG_FB_CYBER2000 is not set
> CONFIG_FB_VESA=3Dy
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_HGA=3Dm
> CONFIG_VIDEO_SELECT=3Dy
> CONFIG_FB_MATROX=3Dm
> CONFIG_FB_MATROX_MILLENIUM=3Dy
> CONFIG_FB_MATROX_MYSTIQUE=3Dy
> # CONFIG_FB_MATROX_G450 is not set
> CONFIG_FB_MATROX_G100A=3Dy
> CONFIG_FB_MATROX_G100=3Dy
> # CONFIG_FB_MATROX_PROC is not set
> CONFIG_FB_MATROX_MULTIHEAD=3Dy
> CONFIG_FB_ATY=3Dm
> CONFIG_FB_ATY_GX=3Dy
> CONFIG_FB_ATY_CT=3Dy
> # CONFIG_FB_ATY_GENERIC_LCD is not set
> CONFIG_FB_RADEON=3Dm
> CONFIG_FB_ATY128=3Dm
> # CONFIG_FB_INTEL is not set
> CONFIG_FB_SIS=3Dm
> CONFIG_FB_SIS_300=3Dy
> CONFIG_FB_SIS_315=3Dy
> CONFIG_FB_NEOMAGIC=3Dm
> CONFIG_FB_3DFX=3Dm
> CONFIG_FB_VOODOO1=3Dm
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FBCON_ADVANCED is not set
> CONFIG_FBCON_MFB=3Dm
> CONFIG_FBCON_CFB8=3Dy
> CONFIG_FBCON_CFB16=3Dy
> CONFIG_FBCON_CFB24=3Dy
> CONFIG_FBCON_CFB32=3Dy
> CONFIG_FBCON_HGA=3Dm
> # CONFIG_FBCON_FONTWIDTH8_ONLY is not set
> # CONFIG_FBCON_FONTS is not set
> CONFIG_FONT_8x8=3Dy
> CONFIG_FONT_8x16=3Dy
>=20
> #
> # Sound
> #
> CONFIG_SOUND=3Dm
> # CONFIG_SOUND_ALI5455 is not set
> CONFIG_SOUND_BT878=3Dm
> CONFIG_SOUND_CMPCI=3Dm
> CONFIG_SOUND_CMPCI_FM=3Dy
> CONFIG_SOUND_CMPCI_FMIO=3D388
> CONFIG_SOUND_CMPCI_FMIO=3D388
> CONFIG_SOUND_CMPCI_MIDI=3Dy
> CONFIG_SOUND_CMPCI_MPUIO=3D330
> CONFIG_SOUND_CMPCI_JOYSTICK=3Dy
> CONFIG_SOUND_CMPCI_CM8738=3Dy
> # CONFIG_SOUND_CMPCI_SPDIFINVERSE is not set
> CONFIG_SOUND_CMPCI_SPDIFLOOP=3Dy
> CONFIG_SOUND_CMPCI_SPEAKERS=3D2
> CONFIG_SOUND_EMU10K1=3Dm
> CONFIG_MIDI_EMU10K1=3Dy
> CONFIG_SOUND_FUSION=3Dm
> CONFIG_SOUND_CS4281=3Dm
> CONFIG_SOUND_ES1370=3Dm
> CONFIG_SOUND_ES1371=3Dm
> CONFIG_SOUND_ESSSOLO1=3Dm
> CONFIG_SOUND_MAESTRO=3Dm
> CONFIG_SOUND_MAESTRO3=3Dm
> # CONFIG_SOUND_FORTE is not set
> CONFIG_SOUND_ICH=3Dm
> CONFIG_SOUND_RME96XX=3Dm
> CONFIG_SOUND_SONICVIBES=3Dm
> CONFIG_SOUND_TRIDENT=3Dm
> CONFIG_SOUND_MSNDCLAS=3Dm
> # CONFIG_MSNDCLAS_HAVE_BOOT is not set
> CONFIG_MSNDCLAS_INIT_FILE=3D"/etc/sound/msndinit.bin"
> CONFIG_MSNDCLAS_PERM_FILE=3D"/etc/sound/msndperm.bin"
> CONFIG_SOUND_MSNDPIN=3Dm
> # CONFIG_MSNDPIN_HAVE_BOOT is not set
> CONFIG_MSNDPIN_INIT_FILE=3D"/etc/sound/pndspini.bin"
> CONFIG_MSNDPIN_PERM_FILE=3D"/etc/sound/pndsperm.bin"
> CONFIG_SOUND_VIA82CXXX=3Dm
> CONFIG_MIDI_VIA82CXXX=3Dy
> CONFIG_SOUND_OSS=3Dm
> # CONFIG_SOUND_TRACEINIT is not set
> CONFIG_SOUND_DMAP=3Dy
> CONFIG_SOUND_AD1816=3Dm
> # CONFIG_SOUND_AD1889 is not set
> CONFIG_SOUND_SGALAXY=3Dm
> CONFIG_SOUND_ADLIB=3Dm
> CONFIG_SOUND_ACI_MIXER=3Dm
> CONFIG_SOUND_CS4232=3Dm
> CONFIG_SOUND_SSCAPE=3Dm
> CONFIG_SOUND_GUS=3Dm
> CONFIG_SOUND_GUS16=3Dy
> CONFIG_SOUND_GUSMAX=3Dy
> CONFIG_SOUND_VMIDI=3Dm
> CONFIG_SOUND_TRIX=3Dm
> CONFIG_SOUND_MSS=3Dm
> CONFIG_SOUND_MPU401=3Dm
> CONFIG_SOUND_NM256=3Dm
> CONFIG_SOUND_MAD16=3Dm
> CONFIG_MAD16_OLDCARD=3Dy
> CONFIG_SOUND_PAS=3Dm
> CONFIG_SOUND_PSS=3Dm
> # CONFIG_PSS_MIXER is not set
> # CONFIG_PSS_HAVE_BOOT is not set
> CONFIG_SOUND_SB=3Dm
> CONFIG_SOUND_AWE32_SYNTH=3Dm
> # CONFIG_SOUND_KAHLUA is not set
> CONFIG_SOUND_WAVEFRONT=3Dm
> CONFIG_SOUND_MAUI=3Dm
> CONFIG_SOUND_YM3812=3Dm
> CONFIG_SOUND_OPL3SA1=3Dm
> CONFIG_SOUND_OPL3SA2=3Dm
> CONFIG_SOUND_YMFPCI=3Dm
> CONFIG_SOUND_YMFPCI_LEGACY=3Dy
> CONFIG_SOUND_UART6850=3Dm
> CONFIG_SOUND_AEDSP16=3Dm
> CONFIG_SC6600=3Dy
> CONFIG_SC6600_JOY=3Dy
> CONFIG_SC6600_CDROM=3D4
> CONFIG_SC6600_CDROMBASE=3D0
> CONFIG_AEDSP16_SBPRO=3Dy
> CONFIG_AEDSP16_MPU401=3Dy
> # CONFIG_SOUND_AD1980 is not set
> # CONFIG_SOUND_WM97XX is not set
>=20
> #
> # USB support
> #
> CONFIG_USB=3Dm
> # CONFIG_USB_DEBUG is not set
>=20
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=3Dy
> # CONFIG_USB_BANDWIDTH is not set
>=20
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_EHCI_HCD=3Dm
> CONFIG_USB_UHCI=3Dm
> CONFIG_USB_UHCI_ALT=3Dm
> CONFIG_USB_OHCI=3Dm
> # CONFIG_USB_SL811HS_ALT is not set
> # CONFIG_USB_SL811HS is not set
>=20
> #
> # USB Device Class drivers
> #
> CONFIG_USB_AUDIO=3Dm
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_BLUETOOTH is not set
> # CONFIG_USB_MIDI is not set
> CONFIG_USB_STORAGE=3Dm
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_DPCM is not set
> # CONFIG_USB_STORAGE_HP8200e is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> CONFIG_USB_ACM=3Dm
> CONFIG_USB_PRINTER=3Dm
>=20
> #
> # USB Human Interface Devices (HID)
> #
> CONFIG_USB_HID=3Dm
> CONFIG_USB_HIDINPUT=3Dy
> CONFIG_USB_HIDDEV=3Dy
> # CONFIG_USB_KBD is not set
> # CONFIG_USB_MOUSE is not set
> CONFIG_USB_AIPTEK=3Dm
> CONFIG_USB_WACOM=3Dm
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
>=20
> #
> # USB Imaging devices
> #
> # CONFIG_USB_DC2XX is not set
> CONFIG_USB_MDC800=3Dm
> CONFIG_USB_SCANNER=3Dm
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USB_HPUSBSCSI is not set
>=20
> #
> # USB Multimedia devices
> #
>=20
> #
> #   Video4Linux support is needed for USB Multimedia device support
> #
>=20
> #
> # USB Network adaptors
> #
> CONFIG_USB_PEGASUS=3Dm
> CONFIG_USB_RTL8150=3Dm
> CONFIG_USB_KAWETH=3Dm
> CONFIG_USB_CATC=3Dm
> # CONFIG_USB_AX8817X is not set
> CONFIG_USB_CDCETHER=3Dm
> CONFIG_USB_USBNET=3Dm
>=20
> #
> # USB port drivers
> #
> CONFIG_USB_USS720=3Dm
>=20
> #
> # USB Serial Converter support
> #
> CONFIG_USB_SERIAL=3Dm
> CONFIG_USB_SERIAL_GENERIC=3Dy
> CONFIG_USB_SERIAL_BELKIN=3Dm
> CONFIG_USB_SERIAL_WHITEHEAT=3Dm
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
> CONFIG_USB_SERIAL_EMPEG=3Dm
> CONFIG_USB_SERIAL_FTDI_SIO=3Dm
> CONFIG_USB_SERIAL_VISOR=3Dm
> CONFIG_USB_SERIAL_IPAQ=3Dm
> CONFIG_USB_SERIAL_IR=3Dm
> CONFIG_USB_SERIAL_EDGEPORT=3Dm
> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
> CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
> CONFIG_USB_SERIAL_KEYSPAN=3Dm
> # CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
> CONFIG_USB_SERIAL_KEYSPAN_USA28XA=3Dy
> CONFIG_USB_SERIAL_KEYSPAN_USA28XB=3Dy
> # CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
> # CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
> CONFIG_USB_SERIAL_KEYSPAN_USA19QW=3Dy
> CONFIG_USB_SERIAL_KEYSPAN_USA19QI=3Dy
> # CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
> CONFIG_USB_SERIAL_KEYSPAN_USA49W=3Dy
> # CONFIG_USB_SERIAL_KEYSPAN_USA49WLC is not set
> CONFIG_USB_SERIAL_MCT_U232=3Dm
> CONFIG_USB_SERIAL_KLSI=3Dm
> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
> CONFIG_USB_SERIAL_PL2303=3Dm
> CONFIG_USB_SERIAL_CYBERJACK=3Dm
> CONFIG_USB_SERIAL_XIRCOM=3Dm
> CONFIG_USB_SERIAL_OMNINET=3Dm
>=20
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_RIO500=3Dm
> CONFIG_USB_AUERSWALD=3Dm
> # CONFIG_USB_TIGL is not set
> CONFIG_USB_BRLVGER=3Dm
> CONFIG_USB_LCD=3Dm
> # CONFIG_USB_SPEEDTOUCH is not set
>=20
> #
> # Support for USB gadgets
> #
> # CONFIG_USB_GADGET is not set
>=20
> #
> # Bluetooth support
> #
> # CONFIG_BLUEZ is not set
>=20
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=3Dy
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_IOVIRT is not set
> CONFIG_MAGIC_SYSRQ=3Dy
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_FRAME_POINTER is not set
> CONFIG_LOG_BUF_SHIFT=3D0
>=20
> #
> # Cryptographic options
> #
> # CONFIG_CRYPTO is not set
>=20
> #
> # Library routines
> #
> # CONFIG_CRC32 is not set
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dm
> # CONFIG_FW_LOADER is not set
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I'm a pink gumdrop! How can anything be worse?!!
					-- Erwin
User Friendly, 10/4/1998

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/6J+8IjReC7bSPZARAglTAJ0W+7fe1WnbcdoZSVOFRLTIo1twegCfZhgP
h8ENAyx6yDtUatHWKBvt6ss=
=nHi9
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
