Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271121AbTHCKYc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 06:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271129AbTHCKYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 06:24:31 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:47076 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S271121AbTHCKYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 06:24:23 -0400
Date: Sun, 3 Aug 2003 12:23:25 +0200
From: Martin Pitt <martin@piware.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.0-test1/2 reiserfsck journal replaying hangs
Message-ID: <20030803102321.GA428@donald.balu5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.1; AVE: 6.20.0.1; VDF: 6.20.0.55
	 at server1 has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel developers!

I've tried 2.6.0-test1 and -test2 and discovered a problem with
reiserfs checking.

[1.] PROBLEM: 2.6.0-test1/2 reiserfsck journal replaying hangs

[2.] I use only reiserfs hd partitions. When booting 2.6.0-test2,
fsck'ing the root file system causes a journal replay which hangs
forever; one has to interrupt it (^C) and continue manually. When
mounting (and checking) the other partitions, everything works fine,
though.

Some lines before, the kernel complains about not finding the module
dependency file. That's okay, I use a monolithic kernel with no module
support.

[3.] kernel, booting, reiserfs, fsck, journal replay

[4.] Linux version 2.6.0-test2 (martin@donald) (gcc-Version 3.3.1
20030626 (Debian prerelease)) #1 Thu Jul 31 17:24:07 CEST 2003

[5.] (no oops)

[6.] script n/a; just boot the kernel to trigger the problem

[7.1] 
Linux donald 2.6.0-test2 #1 Thu Jul 31 17:24:07 CEST 2003 i686
GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      2.4.21  (I don't use modules!)
e2fsprogs              1.34-WIP
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0

[7.2]
root@donald:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : AMD Duron(tm) processor
stepping        : 1
cpu MHz         : 1296.300
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2547.71

(The error also occurs on an AMD Athlon 500)

[7.3] n/a (I don't use modules)

-------------------------------------------------------------------------------
[7.4]
root@donald:~# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0200-0207 : ns558-isa
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, In VT82C686 [Apollo Sup
  5000-5007 : viapro-smbus
6000-607f : VIA Technologies, In VT82C686 [Apollo Sup
d000-d00f : VIA Technologies, In VT82C586/B/686A/B PI
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, In USB
  d400-d41f : uhci-hcd
d800-d81f : VIA Technologies, In USB (#2)
  d800-d81f : uhci-hcd
dc00-dcff : VIA Technologies, In VT82C686 AC97 Audio
  dc00-dcff : VIA686A
e000-e003 : VIA Technologies, In VT82C686 AC97 Audio
e400-e403 : VIA Technologies, In VT82C686 AC97 Audio
  e400-e401 : VIA82xx MPU401
e800-e8ff : VIA Technologies, In VT6102 [Rhine-II]
  e800-e8ff : via-rhine

root@donald:~# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-003420ea : Kernel code
  003420eb-0041e57f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : VIA Technologies, In VT8363/8365 [KT133/K
d8000000-d9ffffff : PCI Bus #01
  d8000000-d9ffffff : nVidia Corporation NV5 [Riva TnT2]
    d8000000-d8feffff : vesafb
da000000-dbffffff : PCI Bus #01
  da000000-daffffff : nVidia Corporation NV5 [Riva TnT2]
dc010000-dc0100ff : VIA Technologies, In VT6102 [Rhine-II]
  dc010000-dc0100ff : via-rhine
ffff0000-ffffffff : reserved

-------------------------------------------------------------------------------
[7.5]

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 81)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: da000000-dbffffff
	Prefetchable memory behind bridge: d8000000-d9ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 12
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 12
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 5
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
	Subsystem: VIA Technologies, Inc. VT82C686 AC97 Audio Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at e000 [size=4]
	Region 2: I/O ports at e400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 43)
	Subsystem: D-Link System Inc DFE-530TX rev A
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at dc010000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA TNT2/TNT2 Pro] (rev 11) (prog-if 00 [VGA])
	Subsystem: Diamond Multimedia Systems Viper V770
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at da000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

-------------------------------------------------------------------------------
[7.6]
root@donald:~# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: _NEC     Model: DV-5500A         Rev: 1.05
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: RICOH    Model: CD-R/RW MP7063A  Rev: 1.30
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: D.09
  Type:   Direct-Access                    ANSI SCSI revision: 02

(However, the CDROMs are IDE devices with SCSI emulation)

-------------------------------------------------------------------------------
[7.7] Other information:
root@donald:~# cat /etc/fstab
/dev/discs/disc0/part5          swap            swap            defaults        0 0

/dev/discs/disc0/part7          /               reiserfs        defaults        0 1
/dev/discs/disc0/part6          /var            reiserfs        defaults        0 2
/dev/discs/disc0/part8          /usr            reiserfs        defaults,ro,nodev               0 2
/dev/discs/disc0/part10         /usr/local      reiserfs        defaults,ro,nodev               0 2
/dev/discs/disc0/part9          /home           reiserfs        defaults,nosuid,nodev           0 2
/dev/discs/disc0/part11         /mm             reiserfs        defaults,nosuid,nodev,noexec    0 2

proc                            /proc           proc            defaults        0 0

/dev/cdroms/cdrom0              /cdrom          auto            user,noexec,ro,noauto           0 0
/dev/cdroms/cdrom1              /cdrw           auto            user,noexec,ro,noauto           0 0
/dev/floppy/0                   /floppy         vfat            user,noexec,noauto              0 0
/dev/discs/disc1/part4          /zip            vfat            user,noauto,noexec,nodev,umask=000,rw   0 0

GRUB boot line:
title           Debian GNU/Linux 2.6.0
root            (hd0,6)
kernel          /boot/vmlinuz-2.6.0 root=/dev/discs/disc0/part7 ro vga=0x305
boot

dmesg does not print any error or unusual messages.

-------------------------------------------------------------------------------
[X.]
I use devfs with a running devfsd. I have attached my kernel config
file for further reference. Please tell me how I can assist you with
debugging.

Thanks a lot for your great work and your support!

Martin
-- 
Martin Pitt
home:  www.piware.de
eMail: martin@piware.de
