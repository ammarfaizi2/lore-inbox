Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131058AbQLFUcZ>; Wed, 6 Dec 2000 15:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130993AbQLFUcF>; Wed, 6 Dec 2000 15:32:05 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:33042 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S130607AbQLFUb7>; Wed, 6 Dec 2000 15:31:59 -0500
Date: Wed, 6 Dec 2000 12:01:28 -0800 (PST)
From: ferret@phonewave.net
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: ATAPI DMA hangs/fs corruption, on 2.4.0-test1x
Message-ID: <Pine.LNX.3.96.1001206111834.6399B-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1) ATAPI DMA hangs and fs corruption, Acer Aspire with 2.4.0-test1x

2) Using the 2.0.4-test1x Ali M15x3 driver in DMA transfer mode on my Acer
Aspire (Running Debian/GNU Linux) with heavy network load I get DMA
timeouts and/or (so far) minor filesystem corruption. Minor just means
that nothing important has been clobbered yet.

3) Kernel Network subsystem IDE subsystem FS corruption

4) Linux version 2.4.0-test10 (root@heathen) (gcc version 2.95.2 20000220
(Debian GNU/Linux)) #1 Thu Nov 2 20:46:13 PST 2000

5) Usually there is no Oops message; the system hangs until DMA is
disabled and/or the affected fs is mounted ro. Only one time did I get an
Oops and that was followed by a spontaneous reboot.

6) Heavy bing/ping-flooding to AND from the machine during disk activity
can trigger the problem, and also heavy NFS activity (one of the machine's
fs is exported NFS). Generating graphic thumbnails (I use xv) over 1GB of
images on the remote machine on the exported NFS is also a good trigger.

7.1a) Machine with the problem:
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux tarot 2.4.0-test10 #1 Thu Nov 2 20:46:13 PST 2000 i586 unknown
Kernel modules         2.3.19
Gnu C                  2.95.2
Gnu Make               3.78.1
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Kbd                    0.99
Sh-utils               2.0

7.1b) Machine that compiled the kernel:
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux heathen 2.4.0-test11 #1 SMP Sun Dec 3 20:40:07 PST 2000 i586 unknown
Kernel modules         2.3.21
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0i

7.2) Local machine:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 232.000116
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 463.67

7.3) No modules loaded.

7.4)
idalton@tarot:~$ cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport1
03bc-03be : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0778-077a : parport1
0cf8-0cff : PCI conf1
7000-707f : VIA Technologies, Inc. VT86C100A [Rhine 10/100]
  7000-707f : eth0
7400-74ff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
7800-780f : Acer Laboratories Inc. [ALi] M5219
  7800-7807 : ide0
  7808-780f : ide1

idalton@tarot:~$ cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-002a6927 : Kernel code
  002a6928-002c1a6f : Kernel data
05100000-0510007f : VIA Technologies, Inc. VT86C100A [Rhine 10/100]
  05100000-0510007f : eth0
05200000-05200fff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
06000000-06ffffff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
  06000000-06ffffff : atyfb
07200000-07200fff : Acer Laboratories Inc. [ALi] M5237 USB
  07200000-07200fff : usb-ohci

7.5) 

idalton@tarot:~$ sudo lspci -vv
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1521 [Aladdin III] (rev
1d)
        Subsystem: Acer Laboratories Inc. [ALi]: Unknown device 1521
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32 set

00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1523 (rev b3)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0 set

00:04.0 VGA compatible controller: ATI Technologies Inc 3D Rage I/II 215GT
[Mach64 GT] (rev 9a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 4754
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 32 set, cache line size 04
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 06000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 7400 [size=256]
        Region 2: Memory at 05200000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 05220000 [disabled] [size=128K]

00:0b.0 IDE interface: Acer Laboratories Inc. [ALi] M5219 (rev 20)
(prog-if fa)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 4 max, 32 set
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at 7800 [size=16]

00:0c.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 02)
(prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 set
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 07200000 (32-bit, non-prefetchable) [size=4K]

00:0e.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine
10/100] (rev 06)
        Subsystem: D-Link System Inc DFE-530TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 118 min, 152 max, 32 set, cache line size 04
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 7000 [size=128]
        Region 1: Memory at 05100000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at 05120000 [disabled] [size=64K]

7.6) No SCSI.

7.7) Communication between myself and Ali's Linux driver writer (do not
have contact information handy) mentioned that the specific IDE controller
was not intended by Ali to be supported for DMA transfers; but it is
supposedly supported for windows 9x (which I have no way of testing).
Kernel driver did not support this controller successfully until about
2.4.0-test6 (IIRC) versions before that would freeze the controller. There
may be possibility of this being a buggy controller, but Ali did not admit
any errata when I enquired. Just said that the controller was "no longer
supported".

However, it may be an hard drive/IDE controller combination at fault. When
experiencing the DMA time outs and corruptions through NFS activity as
described above, the NFS-exported FS is on hdc. DMA time outs affect both
hda and hdc, but fs corruptions only affect root fs on hda even when it
sees relatively less use.

idalton@tarot:~$ sudo hdparm -i /dev/hda

/dev/hda:

 Model=Maxtor 82160D2, FwRev=NAVXAA21, SerialNo=L21T5F3A
 Config={ Fixed }
 RawCHS=4092/16/63, TrkSize=0, SectSize=0, ECCbytes=20
 BuffType=3(DualPortCache), BuffSize=256kB, MaxMultSect=16, MultSect=8
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=4092/16/63, CurSects=4124736, LBA=yes, LBAsects=4124736
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2 
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2 
idalton@tarot:~$ sudo hdparm -i /dev/hdc

/dev/hdc:

 Model=WDC AC36400L, FwRev=09.09M08, SerialNo=WD-WM4202442052
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq
}
 RawCHS=13328/15/63, TrkSize=57600, SectSize=600, ECCbytes=22
 BuffType=3(DualPortCache), BuffSize=256kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=13328/15/63, CurSects=12594960, LBA=yes, LBAsects=12594960
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2 
 IORDY=on/off, tPIO={min:160,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2 

Currently I am keeping DMA turned off until I have something better to
test.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
