Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbUASLqK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264594AbUASLqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:46:10 -0500
Received: from kruuna.helsinki.fi ([128.214.205.14]:33920 "EHLO
	kruuna.Helsinki.FI") by vger.kernel.org with ESMTP id S264563AbUASLp0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:45:26 -0500
From: Atro Tossavainen <atossava@cc.helsinki.fi>
Message-Id: <200401191145.i0JBjOsv013637@kruuna.Helsinki.FI>
Subject: PROBLEM: Panic reading EFS CDs on SCSI CD drives through loop
To: linux-kernel@vger.kernel.org
Date: Mon, 19 Jan 2004 13:45:24 +0200 (EET)
Reply-To: Atro.Tossavainen@helsinki.fi
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Reading files from EFS CD through loop-mounted SCSI CD causes panic

[2.] I am attempting to read Silicon Graphics IRIX installation CDs on
     SCSI CD drives, either real SCSI or emulated IDE-SCSI drives.

     Since SCSI CD-ROMs can't set blocksize (IDE-SCSI emulated drives
     included), I would usually do this with an IDE drive, disabling
     ide-scsi temporarily if applicable.  However, the following article

     http://groups.google.fi/groups?selm=8765hq3j2u.fsf%40ID-48333.user.dfncis.de

     claims that by using the loop interface, it should be possible to
     use EFS CDs with SCSI drives, too.

     I have tried this as follows:

     losetup /dev/loop0 /dev/scd0
     mount -r -t efs /dev/loop0 /cdrom
     cd /cdrom
     tar cf - . | tar xv -C/somewhere/else -f-

     It reads a few files, then panics on a large file.  If I am running
     X11, the only symptom I see is that the machine freezes totally and
     the Caps Lock and Scroll Lock lights on the keyboard start blinking.
     If I'm in the text console, it displays the message:

Kernel panic: scsi_free:Trying to free unused memory

     I also tried this on an Alpha XL266 with a real SCSI CD-ROM and the
     2.4.19 kernel.  There was an oops but the machine didn't panic.  It
     also oopsed when trying to mount the EFS CD directly (whereas on an
     x86, there was no oops, the EFS module just said the device can't
     set blocksize).

[3.] kernel efs loop

[4.] 2.4.24

[5.] 
[6.] 
[7.] 
[7.1.]
Linux bofh 2.4.24 #1 Mon Jan 19 12:08:07 EET 2004 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux             
util-linux             Note: /usr/bin/fdformat is obsolete and is no longer avai
lable.
util-linux             Please use /usr/bin/superformat instead (make sure you ha
ve the 
util-linux             fdutils package installed first).  Also, there had been s
ome
util-linux             major changes from version 4.x.  Please refer to the docu
mentation.
util-linux             
mount                  2.10f
modutils               2.3.11
e2fsprogs              1.18
reiserfsprogs          3.x.0j
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Kbd                    0.96
Sh-utils               2.0
Modules Loaded         efs sr_mod ide-scsi scsi_mod libafs-2.4.24 e100 mga agpgart i810_audio ac97_codec soundcore


[7.2.]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 0
model name      : Intel(R) Pentium(R) 4 CPU 1500MHz
stepping        : 10
cpu MHz         : 1498.783
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2988.44

[7.3.]
efs                     7016   0 (unused)
sr_mod                 13140   0  (unused)
ide-scsi                8836   0
scsi_mod               56848   2  [sr_mod ide-scsi]
libafs-2.4.24         414296   2
e100                   48168   1 (autoclean)
mga                    97956   1
agpgart                17104   3
i810_audio             23360   0 (unused)
ac97_codec             11980   0 [i810_audio]
soundcore               3588   2 [i810_audio]

[7.4.]
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
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
  03c0-03df : matrox
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
1000-10ff : Intel Corp. 82801BA/BAM AC'97 Audio
  1000-10ff : Intel ICH2
1400-141f : Intel Corp. 82801BA/BAM USB (Hub #1)
1800-180f : Intel Corp. 82801BA/BAM SMBus
1c00-1c1f : Intel Corp. 82801BA/BAM USB (Hub #2)
2000-203f : Intel Corp. 82801BA/BAM AC'97 Audio
  2000-203f : Intel ICH2
2400-240f : Intel Corp. 82801BA IDE U100
  2400-2407 : ide0
  2408-240f : ide1
3400-343f : Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller
  3400-343f : e100

00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ca000-000cbfff : reserved
000f0000-000fffff : System ROM
00100000-1feeffff : System RAM
  00100000-0026054f : Kernel code
  00260550-002c5363 : Kernel data
1fef0000-1fefefff : ACPI Tables
1feff000-1fefffff : ACPI Non-volatile Storage
1ff00000-1fffffff : System RAM
f4000000-f48fffff : PCI Bus #01
  f4000000-f47fffff : Matrox Graphics, Inc. MGA G400 AGP
  f4800000-f4803fff : Matrox Graphics, Inc. MGA G400 AGP
    f4800000-f4803fff : matroxfb MMIO
f4900000-f4900fff : Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller
  f4900000-f4900fff : e100
f6000000-f7ffffff : PCI Bus #01
  f6000000-f7ffffff : Matrox Graphics, Inc. MGA G400 AGP
    f6000000-f7ffffff : matroxfb FB
f8000000-fbffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
fec00000-fecfffff : reserved
fee00000-fee00fff : reserved
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved

[7.5.]
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 03)
        Subsystem: Siemens Nixdorf AG: Unknown device 0087
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [0104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=421
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=1

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=136
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f4000000-f48fffff
        Prefetchable memory behind bridge: f6000000-f7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: f4900000-f49fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 12)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 12) (prog-if 80 [Master])
        Subsystem: Siemens Nixdorf AG: Unknown device 0055
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Region 4: I/O ports at 2400 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 12) (prog-if 00 [UHCI])
        Subsystem: Siemens Nixdorf AG: Unknown device 0055
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at 1400 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 12)
        Subsystem: Siemens Nixdorf AG: Unknown device 0055
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at 1800 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub  (rev 12) (prog-if 00 [UHCI])
        Subsystem: Siemens Nixdorf AG: Unknown device 0055
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 1c00 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 12)
        Subsystem: Siemens Nixdorf AG: Unknown device 0056
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 1000 [size=256]
        Region 1: I/O ports at 2000 [size=64]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G450 Dual Head
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 min, 32 max, 128 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at f4800000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at f4000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=421
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=1

02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller (rev 03)
        Subsystem: Intel Corp. EtherExpress PRO/100 VE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 56 max, 66 set, cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at f4900000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 3400 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.]
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: CD-RW GCE-8400B  Rev: 1.02
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.]
[X.]

-- 
Atro Tossavainen (Mr.)               / The Institute of Biotechnology at
Systems Analyst, Techno-Amish &     / the University of Helsinki, Finland,
+358-9-19158939  UNIX Dinosaur     / employs me, but my opinions are my own.
< URL : http : / / www . helsinki . fi / %7E atossava / > NO FILE ATTACHMENTS
