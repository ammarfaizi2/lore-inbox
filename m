Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbREYVuf>; Fri, 25 May 2001 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261966AbREYVuZ>; Fri, 25 May 2001 17:50:25 -0400
Received: from dewey.mindlink.net ([204.174.16.4]:63749 "EHLO
	dewey.paralynx.net") by vger.kernel.org with ESMTP
	id <S261950AbREYVuM>; Fri, 25 May 2001 17:50:12 -0400
Subject: PROBLEM: Alpha SMP Low Outbound Bandwidth
From: Jay Thorne <Yohimbe@userfriendly.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 25 May 2001 14:50:07 -0700
Message-Id: <990827407.27355.2.camel@gracie.userfriendly.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
Kernel 2.4.4 ac15
Tested with several cards and pieces of software, the outbound bandwidth
on a quad cpu alpha is 2 megabytes a second or less on a 100 mbit
switched ethernet network. Other machines on same switch do 10 or more
megabytes per second. Switch is DLink 3624, 24 port, only 12 ports in
use.

[2.] Full description of the problem/report:
Using a quad 400Mhz Dodge/Rawhide machine with Tulip or VIARhine cards,
on wuFTP, the outbound bandwidth tops out at 2 megabytes per second and
the inbound at 6 megabytes per second.  Also noticeable are apparent
slowdowns or console lockups/sluggishness during the transfer.

[3.] Keywords (i.e., modules, networking, kernel):
networking, alpha, tulip, via_rhine

[4.] Kernel version (from /proc/version):
Linux version 2.4.4-ac15 (root@lister) (gcc version 2.96 20000731 (SuSE
Linux 7.1/Alpha)) #1 SMP Thu May 24 18:41:13 PDT 2001    

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
     problem (if possible)

Problem machine:
ncftp /tmp > put foo
foo:                                                    34.38 MB    5.16
MB/s
ncftp /tmp > get -z foo baz
baz:                                                    34.38 MB    1.16
MB/s

other machine on same switch to same ftp server.
ncftp /home/jay > get foo
foo:                                                    34.38 MB   10.12
MB/s
ncftp /home/jay > put -z foo baz
foo:                                                    34.38 MB    9.93
MB/s

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
 
Linux lister 2.4.4-ac15 #1 SMP Thu May 24 18:41:13 PDT 2001 alpha
unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.10q
mount                  2.10q
modutils               2.4.2
e2fsprogs              1.19
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1a
Linux C Library        so.6.1
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         tulip via-rhine

[7.2.] Processor information (from /proc/cpuinfo):
lister:/usr/src/linux # cat /proc/cpuinfo
cpu                     : Alpha
cpu model               : EV56
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : Rawhide
system variation        : Dodge
system revision         : 0
system serial number    : NI70904KB0
cycle frequency [Hz]    : 400000000
timer frequency [Hz]    : 1200.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 738.12
kernel unaligned acc    : 1646246
(pc=fffffc000042a3d8,va=fffffc005d9b784e)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : AlphaServer 4100 5/400 4MB
cpus detected           : 4
cpus active             : 4
cpu active mask         : 000000000000000f

[7.3.] Module information (from /proc/modules):
lister:/usr/src/linux # cat /proc/modules
tulip                  59296   1
via-rhine              16464   0 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
lister:/usr/src/linux # cat /proc/ioports
00000000-0000ffff : PCI IO bus 0
  00000000-0000001f : dma1
  00000020-0000003f : pic1
  00000040-0000005f : timer
  00000060-0000006f : keyboard
  00000070-00000080 : rtc
    00000070-0000007f : rtc
  000000a0-000000bf : pic2
  000000c0-000000df : dma2
  000002f8-000002ff : serial(auto)
  000003f8-000003ff : serial(auto)
  00008000-000080ff : VIA Technologies, Inc. Ethernet Controller
    00008000-000080ff : via-rhine
  00008400-0000847f : Digital Equipment Corporation DECchip 21140
[FasterNet]
    00008400-0000847f : tulip
200000000-20000ffff : PCI IO bus 1
  200008000-2000080ff : Symbios Logic Inc. (formerly NCR) 53c810
    200008000-20000807f : ncr53c8xx
  200009000-2000090fe : qlogicisp
lister:/usr/src/linux # cat /proc/iomem
00000000-ffffffff : PCI mem bus 0
  00000000-07ffffff : HAE0
    02200000-0223ffff : Digital Equipment Corporation DECchip 21140
[FasterNet]
    02240000-0224ffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
    02250000-0225ffff : VIA Technologies, Inc. Ethernet Controller
    02260000-022600ff : VIA Technologies, Inc. Ethernet Controller
      02260000-022600ff : via-rhine
    02261000-0226107f : Digital Equipment Corporation DECchip 21140
[FasterNet]
      02261000-0226107f : tulip
200000000-2ffffffff : PCI mem bus 1
  200000000-207ffffff : HAE0
    202200000-2022000ff : Symbios Logic Inc. (formerly NCR) 53c810

[7.5.] PCI information ('lspci -vvv' as root)
lister:/usr/src/linux # lspci -vvv
00:01.0 Non-VGA unclassified device: Intel Corporation 82375EB (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin ? routed to IRQ 32

00:02.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
(rev 54) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at 000000000c000000 (32-bit, non-prefetchable)
        Expansion ROM at 0000000002240000 [size=64K]

00:03.0 Ethernet controller: Digital Equipment Corporation DECchip 21140
[FasterNet] (rev 22)
        Subsystem: Digital Equipment Corporation: Unknown device 500a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5000ns min, 10000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at 8400 [size=128]
        Region 1: Memory at 0000000002261000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at 0000000002200000 [disabled] [size=256K]
 
00:05.0 Ethernet controller: VIA Technologies, Inc. Ethernet Controller
(rev 42)
        Subsystem: D-Link System Inc: Unknown device 1400
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping+ SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 28
        Region 0: I/O ports at 8000 [size=256]
        Region 1: Memory at 0000000002260000 (32-bit, non-prefetchable)
[size=256]
        Expansion ROM at 0000000002250000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:01.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR)
53c810 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 56
        Region 0: I/O ports at 200008000 [size=256]
        Region 1: Memory at 0000000202200000 (32-bit, non-prefetchable)
[size=256]
 
01:02.0 PCI bridge: Digital Equipment Corporation DECchip 21050 (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: 02300000-023fffff
        Prefetchable memory behind bridge: 00100000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
 
02:00.0 SCSI storage controller: Q Logic ISP1020 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Interrupt: pin A routed to IRQ 40
        Region 0: I/O ports at 200009000 [size=256]
        Region 1: Memory at 0000000202310000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at 0000000202300000 [disabled] [size=64K]

[7.6.] SCSI information (from /proc/scsi/scsi)
lister:/usr/src/linux # cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: DEC      Model: RZ1CB-CS (C) DEC Rev: 0844
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: DEC      Model: RZ1CB-CA (C) DEC Rev: LYJ0
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: DEC      Model: RZ1CB-CA (C) DEC Rev: LYJ0
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: DEC      Model: RZ1CB-CA (C) DEC Rev: LYJ0
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: DEC      Model: RRD45   (C) DEC  Rev: 0436
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

There is a tcpdump available. 4.6 megabytes for anyone who wants it.



[X.] Other notes, patches, fixes, workarounds:

During one of the slowdowns, the console appeared to lock up. holding
down the ALT key seemed to make it wake up.




-- 
--
Jay Thorne Manager, Systems & Technology, UserFriendly Media, Inc.

