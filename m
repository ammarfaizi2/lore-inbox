Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293687AbSCKLKf>; Mon, 11 Mar 2002 06:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293686AbSCKLKZ>; Mon, 11 Mar 2002 06:10:25 -0500
Received: from [158.194.80.80] ([158.194.80.80]:58476 "EHLO CSNT.inf.upol.cz")
	by vger.kernel.org with ESMTP id <S293684AbSCKLKK>;
	Mon, 11 Mar 2002 06:10:10 -0500
Subject: APM resume problem on Acer TravelMate 21x --- additional info
From: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Mar 2002 12:10:06 +0100
Message-Id: <1015845007.2307.4.camel@anduril>
Mime-Version: 1.0
X-OriginalArrivalTime: 11 Mar 2002 11:10:08.0533 (UTC) FILETIME=[4E0C7C50:01C1C8ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the same problem with APM as Oliver Feiler, described in
http://marc.theaimsgroup.com/?l=linux-kernel&m=100470206915414&w=2
(in short the system hangs after resume from suspend)

But I have made some research about it and found some pretty interesting
facts:
- this problem is present on Acer TravelMate 21x series (also with the newest
  BIOS)
- all kernel versions I've tested have this problem 2.4.7 - 2.4.18
- the problem occurs even if you have disabled all possible-problematic
  drivers in kernel (PCMCIA, USB, specific ALI support for IDE, sound, ...)
- it is not caused by user-mode daemons (apmd, cardmgr, usbmgr)
- kernel gives no output about the hang (nothing in all possible logs, no
  oops etc.)
- if apmd is running all resume actions are done
- no user input is accepted but console and even X are restored perfectly
- all functions in apm.c (like 'suspend') are exited normally without any
  error
- ^^^ MOST IMPORTANT ^^^ the kernel doesn't hang, it loops in 5-6 seconds
  loop with the fact that the time always returns to the time at the
  beginning; this behaviour could be seen if you try this command
  
  echo "start"; apm -s; echo "finish"; while true; do date; done
  
  and it displays the right current time for 5 to 6 seconds and the time
  displaying continues but the time always returns to the starting time;
  this behaviour is infinite till the computer is powered off.
  
  The same behaviour occurs also if the 'date' loop is started as background
  process and then the 'apm -s'.
  

Any ideas?
  
Jan "Pogo" Mynarik
  
Some computer and system information:

/proc/version:
Linux version 2.4.18 (root@anduril) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 Sat Mar 2 00:05:41 CET 2002

ver_linux:
BUT THE BUG IS NOT CAUSED BY VARIOUS KERNEL CONFIGURATION (already tested)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux anduril 2.4.18 #1 Sat Mar 2 00:05:41 CET 2002 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.13
e2fsprogs              1.26
reiserfsprogs          3.x.1a
pcmcia-cs              3.1.33
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         njbfs pcnet_cs 8390 nls_iso8859-2 nls_cp437 vfat fat ext2 usb-ohci usbcore trident soundcore ac97_codec apm

lspci -vvv
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1621 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 80100000-818fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI South Bridge Audio (rev 01)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1019
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 8000 [size=256]
	Region 1: Memory at 81a00000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Acer Incorporated [ALI]: Unknown device 1019
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) (prog-if fa)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1019
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 4: I/O ports at 7050 [size=16]
	Capabilities: <available only to root>

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Acer Incorporated [ALI]: Unknown device 1019
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:13.0 CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev 05)
	Subsystem: Acer Incorporated [ALI]: Unknown device 1019
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 17800000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 17c00000-17fff000 (prefetchable)
	Memory window 1: 18000000-183ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1019
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 81c00000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: Trident Microsystems: Unknown device 8620 (rev 5d) (prog-if 00 [VGA])
	Subsystem: Acer Incorporated [ALI]: Unknown device 1019
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 80800000 (32-bit, non-prefetchable) [size=8M]
	Region 1: Memory at 80100000 (32-bit, non-prefetchable) [size=128K]
	Region 2: Memory at 81000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 80120000 [disabled] [size=64K]
	Capabilities: <available only to root>





