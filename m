Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268305AbRGWRWD>; Mon, 23 Jul 2001 13:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268306AbRGWRVy>; Mon, 23 Jul 2001 13:21:54 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:25363 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S268305AbRGWRVp>; Mon, 23 Jul 2001 13:21:45 -0400
Message-Id: <5.1.0.14.2.20010723122950.00a7d6e0@pop.glue.umd.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 23 Jul 2001 13:21:29 -0400
To: linux-kernel@vger.kernel.org
From: Jesse M <jessem@glue.umd.edu>
Subject: PROBLEM: System Freezes with 2.4.6 - IDE chipset driver probs?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello, I am not on the kernel mailing list, so please email me directly. 
This is my first time trying to track down a problem such as this and 
mailing the kernel list, so forgive me for any erorrs. Here is the 
information on the problem in the format requested in 
/usr/src/linux/REPORTING-BUGS.

Thanks, Jesse


1. System Freezes with 2.4.6 - IDE chipset driver probs?

2. I recently installed slackware 8.0 in preperation of upgrading to the 
2.4.x series kernel. (Please note a clean install was made, not an upgrade) 
After rebooting with the 2.2.x kernel supplied by the bootdisk, I compiled 
and installed kernel 2.4.6. Immediately afterwards, the system would no 
longer run more then 10 minutes before completely freezing and requiring 
the system to be rebooted. Upon rebooting, fsck (run through init scripts) 
complained about disk corruption on /dev/hda1 (my root partition) and made 
me run e2fsck -v -y /dev/hda1 manually... the disk was so corrupted that I 
had to completely reformat (with bad-block checking which found nothing) 
and reinstall slackware. I repeated this whole process a second time with 
the same results as before.

I finally decided that it may be a problem with the IDE chipset dirver i 
had chosen during 2.4.6 compilation (the Via 82cXXX driver). After 
reinstalling slackware the third time and compiling 2.4.6, I left this 
option off, and used the generic UDMA driver. Since then I have had much 
more stability but still have random freezes (such as when I was trying to 
untar the new 2.4.7 kernel, and again when I was trying to compile it). 
Logs provided no help at all and I didn't have any of these problems with 
the 2.2.x series of kernels. My best educated guess is something in the IDE 
drivers subsystem, but it is really just a guess. I'm willing to try and 
collect more information, but I really dont know how to go about it 
effectively.

3. Via 82cXXX, UDMA , IDE

4. /proc/version:
Linux version 2.4.6 (root@MotherPenguin) (gcc version 2.95.3 20010315 
(release)) #2 Sat Jul 7 04:38:39 EDT 2001

5. No Oops...

6. Disk activity seems to trigger the problem at random times.

7.1 ver_linux script:
Linux MotherPenguin 2.4.6 #2 Sat Jul 7 04:38:39 EDT 2001 i586 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         3c59x

7.2 /proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 12
cpu MHz         : 199.683
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 398.13

7.3 /proc/modules:
3c59x                  24640   1

7.4 /proc/ioports:
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
6000-600f : VIA Technologies, Inc. Bus Master IDE
   6000-6007 : ide0
   6008-600f : ide1
6200-62ff : Lite-On Communications Inc LNE100TX
   6200-62ff : tulip
6300-637f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
   6300-637f : 00:0a.0

/proc/iomem:
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
   00100000-001ebe4f : Kernel code
   001ebe50-0023b81f : Kernel data
e0000000-e00000ff : Lite-On Communications Inc LNE100TX
   e0000000-e00000ff : tulip
e0001000-e000107f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
ffff0000-ffffffff : reserved

7.5 lspci -vvv:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo VP1/VPX] 
(rev 23)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
         Latency: 32

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo 
VP] (rev 27)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 
06) (prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at 6000 [size=16]
00:09.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
         Subsystem: Netgear FA310TX
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at 6200 [size=256]
         Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at <unassigned> [disabled] [size=256K]

00:0a.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] 
(rev 04)
         Subsystem: 3Com Corporation 3C900B-TPO Etherlink XL TPO 10Mb
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
         Latency: 32 (2500ns min, 12000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at 6300 [size=128]
         Region 1: Memory at e0001000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6 no SCSI

7.7 none.



