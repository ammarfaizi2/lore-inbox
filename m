Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUGQRmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUGQRmb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 13:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUGQRmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 13:42:31 -0400
Received: from infoblvd.net ([216.42.64.4]:47375 "EHLO infoblvd.net")
	by vger.kernel.org with ESMTP id S265248AbUGQRmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 13:42:21 -0400
Date: Sat, 17 Jul 2004 13:45:45 -0400
From: John Vogel <johnv@infoblvd.net>
To: linux-kernel@vger.kernel.org
Subject: usb mouse stops responding
Message-ID: <20040717174545.GA311@overbyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
X-Declude-Sender: johnv@infoblvd.net [216.42.67.22]
X-Declude-Spoolname: D64f64824005cf5db.SMD
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Organization: Information Boulevard 1-877-INFOBLV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While in moving the mouse, my 3 button optical mouse stops responding. I get
the following syslog message at the same time:

Jul  16 18:15:13 overbyte kernel: host/usb-ohci.c: unlink URB timeout.

The problem didn't occure when using plain ps/2 and serial mice. I have
searched the mailing list archives for similar problems, and it looks like
this is an ongoing problem for both 2.4 and 2.6 kernels (though I might be
mistaken about that). I haven't noticed many (or any) postings related to mouse
lockups, yet I suspect the problem is in the urb processing in the host driver.
I get the same error in kernels 2.4.21, 2.4.25, 2.4.26, and 2.4.27-rc3.
I tried using 2.6.5, 2.6.6, and 2.6.7 kernels and the mouse locked up with out
the error message. Could it be that an active urb is being unlinked before
it has been processed? Most coding I have done has been fairly trivial
compared to kernel drivers, so I'm probably out of my league here. I'm
interesting in working on this problem, for what ever that is worth.


system:
	Intel P200MMX
	Tyan Tomcat IIIs mainboard
	128 mB ram (4-32mB simms)
	CMD usb pci (2 port hub)
	Trident Blade3d pci svga
	3com/USRobitics 56k internal modem (not winmodem)
	Promise TX2 Ultra 133 ATA controller (pci)
	Maxtor 72004 AP ide drive
	WDC AC31600H ide drive
	GCR-8521B atapi cd
	Maxtor 6E040L0 ide drive
	TEAC CD-W540E atapi cdrw

Output of 'su -c "lspci -vvv"':

00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64

00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:11.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
	Subsystem: US Robotics/3Com: Unknown device 00d3
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 6400 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:12.0 USB Controller: CMD Technology Inc USB0670 (rev 06) (prog-if 10 [OHCI])
	Subsystem: CMD Technology Inc USB0670
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at e1024000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 VGA compatible controller: Trident Microsystems Blade 3D PCI/AGP (rev 3a) (prog-if 00 [VGA])
	Subsystem: Jaton Corp: Unknown device 9880
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=8M]
	Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=128K]
	Region 2: Memory at e0800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [80] AGP version 1.0
		Status: RQ=33 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [90] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 4500ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 6800 [size=8]
	Region 1: I/O ports at 6c00 [size=4]
	Region 2: I/O ports at 7000 [size=8]
	Region 3: I/O ports at 7400 [size=4]
	Region 4: I/O ports at 7800 [size=16]
	Region 5: Memory at e1020000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

current kernel config:

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_M586MMX=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_MCE=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_IPV6=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_TUN=y
CONFIG_PLIP=y
CONFIG_PPP=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=800
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=600
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MINIX_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=y
CONFIG_ZISOFS_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_SB=y
CONFIG_SOUND_AWE32_SYNTH=y
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_OHCI=y
CONFIG_USB_MOUSE=y
CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_NET2280=y
CONFIG_USB_NET2280=y
CONFIG_USB_GADGET_CONTROLLER=y
CONFIG_USB_GADGET_DUALSPEED=y
CONFIG_LOG_BUF_SHIFT=0
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
