Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135823AbRD2QVH>; Sun, 29 Apr 2001 12:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135824AbRD2QU6>; Sun, 29 Apr 2001 12:20:58 -0400
Received: from adsl-208-190-203-202.dsl.kscymo.swbell.net ([208.190.203.202]:18817
	"HELO sbox.labfire.com") by vger.kernel.org with SMTP
	id <S135823AbRD2QUp>; Sun, 29 Apr 2001 12:20:45 -0400
Date: Sun, 29 Apr 2001 11:20:37 -0500
From: Ian Wehrman <ian@labfire.com>
To: linux-kernel@vger.kernel.org
Subject: continued ext2fs corruption
Message-ID: <20010429112037.A1128@labfire.com>
Reply-To: ian@labfire.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello all,
all kernels since 2.4.2 (including the latest 2.4.4) have resulted in major
ext2 filesystem corruption for me. pre-2.4.2 kernels work fine, as does
2.2.19. generally the errors i see while using the filesystem look like this:

EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory
 #508411: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0,
 name_len=0

i first saw this in february, along with a few other people, read the thread
here: 
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0102.2/1350.html

basically after booting one of these new kernels, i quickly start to see a lot
of filesystem errors, and i/o errors. on reboot, fsck finds piles of errors,
and eventually clears a lot of inodes. this is a real pain. 

i don't think i'm using any exotic hardware. i've attached the output of
lspci -vv (under 2.4.0-test9, the kernel i'm running now that's stable for
me). i do have one hard disk connected to a promise 20267 ultra ata 100 board,
but that drive has never had any corruption, just the disk connected to the
onboard ide controller. 

i'd really like to help track down the problem, please let me know if i can
provide any further information.

thanks,
ian wehrman

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci_vv

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f6000000-f7ffffff
	Prefetchable memory behind bridge: fc000000-fdffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1400 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 10c0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1000 [size=128]
	Region 1: Memory at f4020000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
	Subsystem: Creative Labs CT4780 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 10e0 [size=32]
	Capabilities: <available only to root>

00:0e.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at 1410 [size=8]
	Capabilities: <available only to root>

00:10.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
	Subsystem: US Robotics/3Com: Unknown device baba
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1418 [size=8]
	Capabilities: <available only to root>

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at 1430 [size=8]
	Region 1: I/O ports at 1424 [size=4]
	Region 2: I/O ports at 1428 [size=8]
	Region 3: I/O ports at 1420 [size=4]
	Region 4: I/O ports at 1080 [size=64]
	Region 5: Memory at f4000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc.: Unknown device 1137
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at 9000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>


--Q68bSM7Ycu6FN28Q--
