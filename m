Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbTIBThb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 15:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbTIBThb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 15:37:31 -0400
Received: from bin.bash.sh ([193.201.200.216]:52637 "EHLO bin.bash.sh")
	by vger.kernel.org with ESMTP id S261363AbTIBThN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 15:37:13 -0400
Date: Tue, 2 Sep 2003 20:37:06 +0100
From: Chris Mason <chris@k-rad.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4 Bug Report
Message-ID: <20030902193706.GA21151@bin.bash.sh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Been trying 2.6.0-test4 and having problems. I am running Debian GNU/Linux =
(Woody) which is kept up-to-date. As everyone keeps on saying to report bug=
s here is my bug report:

I am not subscribed to the kernel mailing list so can all replies relating =
to more information be cc'ed to me.

The kernel configuration is included at the bottom of this email for your b=
enefit.

2.6.0-test4 is doing something weird to my network card. On the first boot =
of the kernel, eth0 comes up fine, but after a reboot I am getting the foll=
owing errors:

eth0: command 0x5800 did not complete! Status=3D0xffff
eth0: command 0x2804 did not complete! Status=3D0xffff

If I attempt to boot into 2.4.22 then I am getting the same errors and only=
 when I turn the machine off then on again will the kernel successfully boo=
t eth0 up properly.

The hardware of my machine is as follows:

00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:04.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 01)
00:04.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 01)
00:06.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
01:00.0 VGA compatible controller: Cirrus Logic GD 5465 [Laguna] (rev 03)

The other problem I am seeing is Badness in local_bh_enable at kernel/softi=
rq.c:113 error which occurs during USB bootup. I have included the dmesg ou=
tput below:

Linux version 2.6.0-test4 (root@hantu) (gcc version 2.95.4 20011002 (Debian=
 prerelease)) #2 Tue Sep 2 18:49:26 BST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f1000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000018000000 (usable)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
384MB LOWMEM available.
On node 0 totalpages: 98304
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94208 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
Building zonelist for node : 0
Kernel command line: root=3D/dev/hda1 ro console=3DttyS0,9600
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 233.922 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 460.80 BogoMIPS
Memory: 385940k/393216k available (1514k kernel code, 6520k reserved, 568k =
data, 288k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0080fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0080fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0080fbff 00000000 00000000 00000040
CPU: Intel Pentium II (Klamath) stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 233.0819 MHz.
=2E.... host bus clock speed is 66.0805 MHz.
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd9c9, last bus=3D1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Configuring network interfaces: eth0: command 0x5800 did not complete! Stat=
us=3D0x
ffff
eth0: command 0x2804 did not complete! Status=3D0xffff
done.
PM: Adding info for No Bus:pci0000:00
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:04.0
PM: Adding info for pci:0000:00:04.1
PM: Adding info for pci:0000:00:04.2
PM: Adding info for pci:0000:00:04.3
PM: Adding info for pci:0000:00:06.0
PM: Adding info for pci:0000:01:00.0
PCI: Using IRQ router PIIX [8086/7110] at 0000:00:04.0
PCI: IRQ 0 for device 0000:00:04.2 doesn't match PIRQ mask - try pci=3Dusep=
irqmask
PCI: IRQ 0 for device 0000:00:06.0 doesn't match PIRQ mask - try pci=3Dusep=
irqmask
pty: 256 Unix98 ptys configured
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Journalled Block Device driver loaded
udf: registering filesystem
Limiting direct PCI/PCI transfers.
HDLC line discipline: version $Revision: 4.8 $, maxframe=3D4096
N_HDLC line discipline registered.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
PM: Adding info for platform:floppy0
PCI: Enabling device 0000:00:06.0 (0010 -> 0013)
PCI: IRQ 0 for device 0000:00:06.0 doesn't match PIRQ mask - try pci=3Dusep=
irqmask
PCI: Assigned IRQ 5 for device 0000:00:06.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:06.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xfc00. Vers LK1.1.19
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller at PCI slot 0000:00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALL SE3.2A, ATA DISK drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
hdc: HITACHI CDR-8335, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
hdc: Disabling (U)DMA for HITACHI CDR-8335
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 128KiB
hda: 6306048 sectors (3228 MB) w/80KiB Cache, CHS=3D6256/16/63, UDMA(33)
 hda: hda1 hda2
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver=
 v2.1
PCI: Enabling device 0000:00:04.2 (0000 -> 0001)
PCI: IRQ 0 for device 0000:00:04.2 doesn't match PIRQ mask - try pci=3Dusep=
irqmask
PCI: Assigned IRQ 10 for device 0000:00:04.2
uhci-hcd 0000:00:04.2: UHCI Host Controller
uhci-hcd 0000:00:04.2: irq 10, io base 0000fcc0
uhci-hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
PM: Adding info for usb:usb1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PM: Adding info for usb:1-0:0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (3072 buckets, 24576 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/=
projects/ipt_recent/
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
kjournald starting.  Commit interval 5 seconds
hub 1-0:0: new USB device on port 2, assigned address 2
PM: Adding info for usb:1-2
PM: Adding info for usb:1-2:0
PM: Adding info for usb:1-2:1
PM: Adding info for usb:1-2:2
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 288k freed
Adding 499960k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
usb 1-2: bulk timeout on ep5in
usbfs: USBDEVFS_BULK failed dev 2 ep 0x85 len 512 ret -110
usbfs: process 146 (modem_run) did not claim interface 0 before use
usbfs: usb_submit_urb returned -32
usbfs: usb_submit_urb returned -32
Badness in local_bh_enable at kernel/softirq.c:113
Call Trace:
 [<c011b201>] local_bh_enable+0x35/0x68
 [<c01eba85>] ppp_sync_push+0xe9/0x174
 [<c01eb3e3>] ppp_sync_wakeup+0x27/0x48
 [<c01b975d>] do_tty_hangup+0x171/0x38c
 [<c01b9992>] tty_vhangup+0xa/0x10
 [<c01bfbbd>] pty_close+0xfd/0x104
 [<c01ba81a>] release_dev+0x1fa/0x53c
 [<c0135532>] unmap_page_range+0x3a/0x5c
 [<c01bae9f>] tty_release+0x23/0x58
 [<c0143267>] __fput+0x3b/0xb0
 [<c014322b>] fput+0x13/0x14
 [<c0141e83>] filp_close+0x97/0xa0
 [<c0119158>] put_files_struct+0x4c/0xb4
 [<c0119ba7>] do_exit+0x1b3/0x308
 [<c0119d22>] sys_exit+0xe/0x10
 [<c0108bbf>] syscall_call+0x7/0xb

usbfs: usb_submit_urb returned -32
usbfs: usb_submit_urb returned -32
usbfs: usb_submit_urb returned -32
usbfs: usb_submit_urb returned -32
usbfs: usb_submit_urb returned -32
usbfs: usb_submit_urb returned -32
usbfs: usb_submit_urb returned -32
usbfs: usb_submit_urb returned -32
usbfs: usb_submit_urb returned -32
usbfs: usb_submit_urb returned -32
usbfs: usb_submit_urb returned -32
usbfs: usb_submit_urb returned -32
process `snmpd' is using obsolete setsockopt SO_BSDCOMPAT

CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_EXPERIMENTAL=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_KALLSYMS=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_X86_PC=3Dy
CONFIG_MPENTIUMII=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D5
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_PREEMPT=3Dy
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_NOHIGHMEM=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy
CONFIG_PM=3Dy
CONFIG_APM=3Dy
CONFIG_APM_REAL_MODE_POWER_OFF=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_NAMES=3Dy
CONFIG_KCORE_ELF=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_BLK_DEV_FD=3Dy
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECD=3Dy
CONFIG_IDE_TASKFILE_IO=3Dy
CONFIG_BLK_DEV_CMD640=3Dy
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_BLK_DEV_RZ1000=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_ADMA=3Dy
CONFIG_BLK_DEV_PIIX=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_IDEDMA_AUTO=3Dy
CONFIG_NET=3Dy
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_FWMARK=3Dy
CONFIG_IP_ROUTE_NAT=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_TOS=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy
CONFIG_NETFILTER=3Dy
CONFIG_IP_NF_CONNTRACK=3Dy
CONFIG_IP_NF_FTP=3Dy
CONFIG_IP_NF_IPTABLES=3Dy
CONFIG_IP_NF_MATCH_LIMIT=3Dy
CONFIG_IP_NF_MATCH_MAC=3Dy
CONFIG_IP_NF_MATCH_PKTTYPE=3Dy
CONFIG_IP_NF_MATCH_MARK=3Dy
CONFIG_IP_NF_MATCH_MULTIPORT=3Dy
CONFIG_IP_NF_MATCH_TOS=3Dy
CONFIG_IP_NF_MATCH_RECENT=3Dy
CONFIG_IP_NF_MATCH_ECN=3Dy
CONFIG_IP_NF_MATCH_DSCP=3Dy
CONFIG_IP_NF_MATCH_AH_ESP=3Dy
CONFIG_IP_NF_MATCH_LENGTH=3Dy
CONFIG_IP_NF_MATCH_TTL=3Dy
CONFIG_IP_NF_MATCH_TCPMSS=3Dy
CONFIG_IP_NF_MATCH_HELPER=3Dy
CONFIG_IP_NF_MATCH_STATE=3Dy
CONFIG_IP_NF_MATCH_CONNTRACK=3Dy
CONFIG_IP_NF_MATCH_UNCLEAN=3Dy
CONFIG_IP_NF_MATCH_OWNER=3Dy
CONFIG_IP_NF_FILTER=3Dy
CONFIG_IP_NF_TARGET_REJECT=3Dy
CONFIG_IP_NF_TARGET_MIRROR=3Dy
CONFIG_IP_NF_NAT=3Dy
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dy
CONFIG_IP_NF_TARGET_REDIRECT=3Dy
CONFIG_IP_NF_NAT_LOCAL=3Dy
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dy
CONFIG_IP_NF_NAT_FTP=3Dy
CONFIG_IP_NF_MANGLE=3Dy
CONFIG_IP_NF_TARGET_TOS=3Dy
CONFIG_IP_NF_TARGET_ECN=3Dy
CONFIG_IP_NF_TARGET_DSCP=3Dy
CONFIG_IP_NF_TARGET_MARK=3Dy
CONFIG_IP_NF_TARGET_LOG=3Dy
CONFIG_IP_NF_TARGET_TCPMSS=3Dy
CONFIG_IPV6_SCTP__=3Dy
CONFIG_ATM=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_NET_ETHERNET=3Dy
CONFIG_NET_VENDOR_3COM=3Dy
CONFIG_VORTEX=3Dy
CONFIG_PPP=3Dy
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_SYNC_TTY=3Dy
CONFIG_PPP_DEFLATE=3Dy
CONFIG_PPPOATM=3Dy
CONFIG_INPUT=3Dy
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_SERIAL_NONSTANDARD=3Dy
CONFIG_N_HDLC=3Dy
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_EXT2_FS=3Dy
CONFIG_EXT3_FS=3Dy
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_JBD=3Dy
CONFIG_FS_MBCACHE=3Dy
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dy
CONFIG_UDF_FS=3Dy
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dy
CONFIG_VFAT_FS=3Dy
CONFIG_PROC_FS=3Dy
CONFIG_DEVPTS_FS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_VGA_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_USB=3Dy
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
CONFIG_USB_UHCI_HCD=3Dy
CONFIG_X86_EXTRA_IRQS=3Dy
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy

Kind Regards,
Chris

--=20
Chris Mason <chris@k-rad.org>
GnuPG 1024D/8288CEE6 37D2 B5BE 612F 568B 9A63 F193 93B4 E5B8 8288 CEE6

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/VPFik7TluIKIzuYRAg1iAJ9hOcmt8jqQXUMBF3Kt8trmLURDQACeOfhY
jUww+e3TRYinyvVg7nJeZRI=
=81R1
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
