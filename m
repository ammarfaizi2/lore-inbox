Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTFPAJN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 20:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTFPAJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 20:09:13 -0400
Received: from netmagic.net ([206.14.125.10]:61637 "EHLO mail.netmagic.net")
	by vger.kernel.org with ESMTP id S263084AbTFPAJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 20:09:02 -0400
Subject: PROBLEM: 2.4.21 crashes hard running cdrecord in X.
From: Per Nystrom <pnystrom@netmagic.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1055722972.1502.39.camel@spike.sunnydale>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Jun 2003 17:22:53 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.21 crashes hard running cdrecord in X.

I just compiled installed 2.4.21, and when I try to burn a cd in X,
everything locks up hard.  I've enabled kernel debugging and set up a
serial console to try to capture anything I can, but I don't even get a
panic or an oops message.  The following line is the last dying gasp
from syslogd:

Jun 15 16:21:54 spike kernel: scsi : aborting command due to timeout :
pid 569,
scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00

After that, everything is locked up hard.  Even the SysRq keys won't
work.  The command I was running that particular time was

cdrecord dev=0,0,0 blank=fast

This only seems to happen when I'm running in X.  I can use cdrecord to
burn cds all day when X is not running.  I haven't gotten any
finer-grained with it than that; I don't know if it's X itself, the
window manager, the desktop, nvidia's drivers, or any other bits that
are interacting badly with cdrecord.

My system is mostly Red Hat 8.  I updated the cdrecord rpm to the very
latest I could get when this started happening, cdrecord-2.0-10, but
that made no difference.  Here is the output from
/usr/src/linux/scripts/ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux spike.sunnydale 2.4.21 #6 Sun Jun 15 15:35:26 PDT 2003 i686 i686
i386 GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         sr_mod awe_wave sb sb_lib uart401 sound nvidia
parport_pc lp parport nfsd lockd sunrpc autofs4 tulip iptable_filter
ip_tables ide-scsi scsi_mod vfat fat mousedev keybdev hid input usb-uhci
usbcore

By the way, cdrecord --scanbus works fine whether in text or X mode,
here's the output from it:

Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Linux sg driver version: 3.1.25
Using libscg version 'schily-0.7'
cdrecord: Warning: using inofficial libscg transport code version
(schily - Red
Hat-scsi-linux-sg.c-1.75-RH '@(#)scsi-linux-sg.c        1.75 02/10/21
Copyright
1997 J. Schilling').
scsibus0:
        0,0,0     0) 'SONY    ' 'CD-RW  CRX160E  ' '1.0e' Removable
CD-ROM
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

More stuff about this box follows.  Any help would be greatly
appreciated!!!


lspci -vvv
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 02)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
(prog-if 80
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 14
        Region 4: I/O ports at c000 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0e.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 01)
        Subsystem: CMD Technology Inc PCI0649
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at c400 [size=8]
        Region 1: I/O ports at c800 [size=4]
        Region 2: I/O ports at cc00 [size=8]
        Region 3: I/O ports at d000 [size=4]
        Region 4: I/O ports at d400 [size=16]
        Expansion ROM at e8000000 [disabled] [size=512K]
        Capabilities: <available only to root>

00:12.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet
10/100 model NC100 (rev 11)
        Subsystem: Linksys: Unknown device 0574
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min, 63750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at ea000000 (32-bit, non-prefetchable)
[size=1K]
        Expansion ROM at e9000000 [disabled] [size=128K]
        Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation NV5 [Riva TnT2
Ultra] (rev 11) (prog-if 00 [VGA])
        Subsystem: Creative Labs 3D Blaster RIVA TNT2 Ultra
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e4000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at e6000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at e5000000 [disabled] [size=64K]
        Capabilities: <available only to root>

cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SONY     Model: CD-RW  CRX160E   Rev: 1.0e
  Type:   CD-ROM                           ANSI SCSI revision: 02

cat /proc/scsi/sg/*
0
dev_max(currently)=7 max_active_device=1 (origin 1)
 scsi_dma_free_sectors=96 sg_pool_secs_aval=320 def_reserved_size=32768
32768
host    chan    id      lun     type    opens   qdepth  busy    online
0       0       0       0       5       0       5       0       1
SONY            CD-RW  CRX160E          1.0e
uid     busy    cpl     scatg   isa     emul
0       0       5       256     0       1
SCSI host adapter emulation for IDE ATAPI devices
30125   Version: 3.1.25 (20030529)

cat /proc/scsi/ide-scsi/*
SCSI host adapter emulation for IDE ATAPI devices

-- 
Per Nystrom <pnystrom@netmagic.net>

