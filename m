Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRDWFJ5>; Mon, 23 Apr 2001 01:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRDWFJu>; Mon, 23 Apr 2001 01:09:50 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:28955 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S131157AbRDWFJj>; Mon, 23 Apr 2001 01:09:39 -0400
From: dechris@mindspring.com
Date: Mon, 23 Apr 2001 01:13:17 -0400
To: linux-kernel@vger.kernel.org
Cc: chaffee@cs.berkeley.edu
Subject: 640MB MO disk major problems
Message-ID: <Springmail.105.988002797.0.80594400@www.springmail.com>
X-Originating-IP: 168.191.169.105
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] one-line summary of the problem

I/O fails with 640MB MO disks due to 2K sector size (128MB MO disks use 512-byte sectors and work fine)
 
[2.] full description of the problem
 
There is a problem writing to a 640MB MO disk using FAT or VFAT.  The 
problem appears to be when reading or writing to a device that has >512K 
sectors.  The read function can be patched so that using generic_file_read() 
routine will solve the read problem.  The problem is the write routines.  My 
machine locks up to the point where I need to reset it.  No OOPS information
is available that I can send along (unless there is a way to force a dump).
If someone can *please* help me create a dump (when writing), I can process it, and send you a stack trace.  This is something that used to work in 2.2, but now is severely broken.  Thanks for your attention...

[3.] Keywords...

FAT VFAT MO Magneto-Optical hang  

[4.] Kernel info:
Linux version 2.4.3-K6 (root@localhost.localdomain) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #4 Fri Apr 6 17:30:56 CDT 2001
[5.] OOPS info:
[6.] shell program or script
[7.] Environment:
BASH=/bin/bash
BASH_ENV=/root/.bashrc
BASH_VERSINFO=([0]="2" [1]="04" [2]="11" [3]="1" [4]="release" [5]="i386-redhat-linux-gnu")
BASH_VERSION='2.04.11(1)-release'
DIRSTACK=()
EUID=0
GROUPS=()
HISTSIZE=1000
HOME=/root
HOSTNAME=localhost.localdomain
HOSTTYPE=i386
IFS=' 	
'
INPUTRC=/etc/inputrc
KDEDIR=/usr
LANG=en_US
LESSOPEN='|/usr/bin/lesspipe.sh %s'
LOGNAME=root
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:'
MACHTYPE=i386-redhat-linux-gnu
MAIL=/var/spool/mail/root
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PATH=/usr/local/sbin:/usr/sbin:/sbin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:/root/bin
PIPESTATUS=([0]="0")
PPID=676
PS4='+ '
PWD=/root/bugrpt
QTDIR=/usr/lib/qt-2.2.0
SHELL=/bin/bash
SHELLOPTS=braceexpand:hashall:interactive-comments
SHLVL=2
SSH_ASKPASS=/usr/libexec/openssh/gnome-ssh-askpass
TERM=linux
UID=0
USER=root
USERNAME=root
_='[7.] Environment:'
[7.1.] Software:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux localhost.localdomain 2.4.3-K6 #4 Fri Apr 6 17:30:56 CDT 2001 i586 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
modutils               2.4.2
e2fsprogs              1.18
pcmcia-cs              3.1.19
PPP                    2.3.11
isdn4k-utils           3.1pre1
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         tulip emu10k1
[7.2.] Processor Information:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 9
model name	: AMD-K6(tm) 3D+ Processor
stepping	: 1
cpu MHz		: 451.034
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips	: 897.84

[7.3.] Module Information:
tulip                  35616   1 (autoclean)
emu10k1                45840   0
[7.4.1.] ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
9000-9fff : PCI Bus #01
  9000-90ff : 3Dfx Interactive, Inc. Voodoo 4
a000-a00f : VIA Technologies, Inc. Bus Master IDE
  a000-a007 : ide0
  a008-a00f : ide1
a400-a41f : VIA Technologies, Inc. UHCI USB
  a400-a41f : usb-uhci
a800-a807 : CMD Technology Inc PCI0649
  a800-a807 : ide2
ac00-ac03 : CMD Technology Inc PCI0649
  ac02-ac02 : ide2
b000-b007 : CMD Technology Inc PCI0649
  b000-b007 : ide3
b400-b403 : CMD Technology Inc PCI0649
  b402-b402 : ide3
b800-b80f : CMD Technology Inc PCI0649
  b800-b807 : ide2
  b808-b80f : ide3
bc00-bcff : Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100]
  bc00-bcff : eth0
c000-c01f : Creative Labs SB Live! EMU10000
  c000-c01f : EMU10K1
c400-c407 : Creative Labs SB Live!
[7.4.2.] iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca5ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-00287075 : Kernel code
  00287076-003207d7 : Kernel data
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 3Dfx Interactive, Inc. Voodoo 4
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 3Dfx Interactive, Inc. Voodoo 4
e8000000-e9ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
ec000000-ec0000ff : Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100]
  ec000000-ec0000ff : eth0
ffff0000-ffffffff : reserved
[7.5.] PCI Information
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 16
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0000000-dfffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
	Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at a000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at a400 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0a.0 RAID bus controller: CMD Technology Inc: Unknown device 0649 (rev 01)
	Subsystem: CMD Technology Inc: Unknown device 0649
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a800 [size=8]
	Region 1: I/O ports at ac00 [size=4]
	Region 2: I/O ports at b000 [size=8]
	Region 3: I/O ports at b400 [size=4]
	Region 4: I/O ports at b800 [size=16]
	Expansion ROM at ea000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=3 PME-

00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX Fast Ethernet Adapter (rev 25)
	Subsystem: Lite-On Communications Inc: Unknown device c001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at bc00 [size=256]
	Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at eb000000 [disabled] [size=64K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=220mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 05)
	Subsystem: Creative Labs CT4790 SoundBlaster PCI512
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at c000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Input device controller: Creative Labs SB Live! (rev 05)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at c400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc.: Unknown device 0009 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc.: Unknown device 0004
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=128M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 2: I/O ports at 9000 [size=256]
	Expansion ROM at d8000000 [disabled] [size=64K]
	Capabilities: [54] AGP version 2.0
		Status: RQ=15 SBA+ 64bit+ FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information:
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: FUJITSU  Model: M25-MCC3064AP    Rev: 0051
  Type:   Optical Device                   ANSI SCSI revision: 02
[7.7.] Other information :







