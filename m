Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312423AbSCYOCC>; Mon, 25 Mar 2002 09:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312422AbSCYOBw>; Mon, 25 Mar 2002 09:01:52 -0500
Received: from c0s29.ami.com.au ([203.55.31.94]:49677 "EHLO
	dugite.os2.ami.com.au") by vger.kernel.org with ESMTP
	id <S312150AbSCYOBq>; Mon, 25 Mar 2002 09:01:46 -0500
Message-Id: <200203250932.g2P9W0g04463@numbat.Os2.Ami.Com.Au>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: andre@linux-ide.org
cc: linux-kernel@vger.kernel.org
cc: Mark Lord <mlord@pobox.com>
Subject: IDE and hot-swap disk caddies
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Mar 2002 17:32:00 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running Clark Connect 0.91 (basically Red Hat Linux 7.2 plus some 
updates and extra packages), RHL kernel 2.4.9-13, hdparm v4.1.

I have a VIPowER 3-fan mobile rack (see http://www.vipower.com for a 
fuller explanation), part number VP-7010LS3F-66.

The device is hot-swap capable and has a switch (others have a key) 
that locks the drive in and powers it up; in the other position the 
drive is powered down and can be removed.

What I'd like to be able to do is insert a drive into a running system, 
register it (hdparm -R), mount it, write on it, umount it, unregister 
it (hdparm -U).

I have the system configured (when the drive's plugged in) thus:

hda   Fujitsu 4 Gbyte hdd
hdb   Vacant
hdc   Fujitsu 1 Gbyte hdd
hdd   20x CD drive
Motherboard ASUS SP97-V, SiS 5598 (detects as 5513),  chipset. Pentium 
133 CPU.

If I boot with hdc not present, then insert the drive, the system hangs 
immediately. I've configured syslogd to write kernel messages to 
/dev/tty11, but no messages about the problem are displayed.

What can I do to get some messages displayed?

I presume that Linux is getting unexpected interrupts and not coping 
well.


If I boot with hdc present, then hdparm -U /dev/hdc displays all the 
same display it does for hdparm -h

Here is a more complete list of the hardware:
[root@clark-133 root]# lspci -v -v
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582] 
(rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >
TAbort- <TAbort- <MAbort+ >SERR- <PERR-        Latency: 32

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 
01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >
TAbort- <TAbort- <MAbort- >SERR- <PERR-        Latency: 0

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 
d0) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at d000 [size=16]

00:0b.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF 
(rev 06)
        Subsystem: Standard Microsystems Corp [SMC] EtherPower II 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 7000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b800 [size=256]
        Region 1: Memory at e5800000 (32-bit, non-prefetchable) 
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:13.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
5597/5598 VGA (rev 65) (prog-if 00 [VGA])
        Subsystem: Silicon Integrated Systems [SiS] 5597/5598 VGA
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >
TAbort- <TAbort- <MAbort- >SERR- <PERR-        Region 0: Memory at 
e7000000 (32-bit, prefetchable) [size=4M]
        Region 1: Memory at e5000000 (32-bit, non-prefetchable) 
[size=64K]
        Region 2: I/O ports at b400 [size=128]
        Expansion ROM at e6ff0000 [disabled] [size=32K]

[root@clark-133 root]#


I tried to register hdc (I know, it was registered at boot time) with 
this result:
Mar 25 15:07:22 clarkconnect kernel: hdc: irq timeout: status=0xff { 
Busy }
Mar 25 15:07:27 clarkconnect kernel: hdc: status timeout: status=0xff { 
Busy }
Mar 25 15:07:27 clarkconnect kernel: hdc: drive not ready for command
Mar 25 15:07:55 clarkconnect kernel: hdc: status timeout: status=0xff { 
Busy }
Mar 25 15:07:55 clarkconnect kernel: hdc: drive not ready for command

I then tried to put it to sleep (-Y)

Mar 25 15:08:00 clarkconnect kernel: hdc: status timeout: status=0xff { 
Busy }
Mar 25 15:08:00 clarkconnect kernel: hdc: drive not ready for command
Mar 25 15:10:12 clarkconnect kernel: spurious 8259A interrupt: IRQ7.
Mar 25 15:32:48 clarkconnect kernel: ip_conntrack (480 buckets, 3840 
max)

and in standby (-y)

Mar 25 15:33:42 clarkconnect kernel: hdc: status timeout: status=0xff { 
Busy }
Mar 25 15:33:42 clarkconnect kernel: hdc: DMA disabled
Mar 25 15:33:42 clarkconnect kernel: hdc: drive not ready for command
Mar 25 15:33:42 clarkconnect kernel: ide1: reset: success

The hard drives:
[root@clark-133 root]# hdparm -i /dev/hd{a,c}

/dev/hda:

 Model=FUJITSU MPB3043ATU E, FwRev=4010, SerialNo=01075314
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=8940/15/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=16
 CurCHS=8940/15/63, CurSects=-382992256, LBA=yes, LBAsects=8448300
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3


/dev/hdc:

 Model=M1614TA, FwRev=8D-44-21, SerialNo=03022742
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=2114/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=64kB, MaxMultSect=16, MultSect=16
 CurCHS=2114/16/63, CurSects=-2082471904, LBA=yes, LBAsects=2131584
 IORDY=yes, tPIO={min:370,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
 AdvancedPM=no

[root@clark-133 root]#

-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my 
disposition.

==============================
If you don't like being told you're wrong,
	be right!



