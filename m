Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSKCARZ>; Sat, 2 Nov 2002 19:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSKCARZ>; Sat, 2 Nov 2002 19:17:25 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:22500 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S261523AbSKCARS>; Sat, 2 Nov 2002 19:17:18 -0500
Date: Sun, 3 Nov 2002 01:23:46 +0100
From: Luc Saillard <luc.saillard@fr.alcove.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops when using ide-cd with 2.5.45 and cdrecord
Message-ID: <20021103002346.GA25842@cedar.alcove-fr>
References: <20021102210103.GA25617@cedar.alcove-fr> <20021102213448.GA3612@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021102213448.GA3612@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 10:34:48PM +0100, Jens Axboe wrote:
> On Sat, Nov 02 2002, Luc Saillard wrote:
> > Hi,
> > I'm a using the last cdrecord version (1.11a39) when this oops occurs.
> > I can't sync my disks with alt-sys-request because we are in interrupt
> > :(
> 
> How are you invoking cdrecord? Using ide-scsi?
> 
Like this:

  ./cdrecord dev=/dev/hdc fs=32m speed=24 -v -eject driveropts=burnfree dump.001

Cdrecord 1.11a39 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
TOC Type: 1 = CD-ROM
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.7'
Driveropts: 'burnfree'
atapi: 1
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : SYNC 
Vendor_info    : 'YAMAHA  '
Identifikation : 'CRW-F1E         '
Revision       : '1.0c'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE AUDIOMASTER FORCESPEED DISKTATTOO 
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R96R
Drive buf size : 7469952 = 7294 KB
FIFO size      : 33554432 = 32768 KB
Track 01: data   689 MB        
Total size:      791 MB (78:26.69) = 353002 sectors
Lout start:      792 MB (78:28/52) = 353002 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 5
  Is not unrestricted
  Is not erasable
  Disk sub type: Medium Type B, low Beta category (B-) (4)
  ATIP start of lead in:  -12369 (97:17/06)
  ATIP start of lead out: 359849 (79:59/74)

I've do many simulations with -dummy option, without problem, when i try to burn
for real the cd, i have the oops. Between each test (or burning session), i
eject the cd. For this test, i don't pass hdc=ide-scsi to the kernel
commandline option.

Ok here informations about my system:

/mnt/linux/srcs/linux/linux-2.5/linux-2.5.45>sh ./scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux darkland 2.5.45 #6 Sat Nov 2 19:49:59 CET 2002 i686 Celeron (Mendocino) GenuineIntel GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.80
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.30-WIP
./scripts/ver_linux: 37: fsck.jfs: not found
./scripts/ver_linux: 40: reiserfsck: not found
./scripts/ver_linux: 43: xfs_db: not found
./scripts/ver_linux: 46: cardmgr: not found
PPP                    2.4.1
./scripts/ver_linux: 52: isdnctrl: not found
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.0.3
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2
Modules Loaded         nfsd lockd sunrpc exportfs snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-dummy snd-interwave snd-gus-lib snd-rawmidi snd-seq-device snd-cs4231-lib snd-pcm snd-timer snd rtc ipt_TOS ipt_MASQUERADE ipt_limit ipt_REDIRECT ipt_multiport ipt_LOG ipt_REJECT ipt_state iptable_mangle hid ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_ftp ip_conntrack iptable_filter ip_tables uhci-hcd usbmouse usbcore

darkland:~# lspci -vvv
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: c0000000-cfffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 7
        Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at e400 [size=128]
        Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at e800 [size=32]

00:0d.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at ec00 [disabled] [size=256]
        Region 1: Memory at e1001000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 4 / Voodoo 5 (rev 01) (prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc.: Unknown device 0004
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 3
        Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=128M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 2: I/O ports at d000 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [54] AGP version 2.0
                Status: RQ=15 SBA+ 64bit+ FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

darkland:~# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 0
cpu MHz         : 342.495
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 675.84

darkland:~# cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: XP34550S         Rev: LXQ1
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: XP34550S         Rev: LXQ1
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: MATSHITA Model: CD-R   CW-7502   Rev: 4.17
  Type:   CD-ROM                           ANSI SCSI revision: 02

darkland:~# cat /proc/modules 
nfsd                   73328   2 (autoclean)
lockd                  48848   1 (autoclean) [nfsd]
sunrpc                 80344   1 (autoclean) [nfsd lockd]
exportfs                3320   0 (autoclean) [nfsd]
snd-seq-oss            22144   0 (unused)
snd-seq-midi-event      3048   0 [snd-seq-oss]
snd-seq                32912   2 [snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            36548   0 (unused)
snd-mixer-oss          10264   1 [snd-pcm-oss]
snd-dummy               4028   1
snd-interwave           6644   0 (unused)
snd-gus-lib            30532   0 [snd-interwave]
snd-rawmidi            11616   0 [snd-gus-lib]
snd-seq-device          3824   0 [snd-seq-oss snd-seq snd-gus-lib snd-rawmidi]
snd-cs4231-lib         13988   0 [snd-interwave]
snd-pcm                53568   0 [snd-pcm-oss snd-dummy snd-gus-lib snd-cs4231-lib]
snd-timer               9400   0 [snd-seq snd-gus-lib snd-cs4231-lib snd-pcm]
snd                    23908   0 [snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-dummy snd-interwave snd-gus-lib snd-rawmidi snd-seq-device snd-cs4231-lib snd-pcm snd-timer]
rtc                     6864   0 (autoclean)
ipt_TOS                 1208  12 (autoclean)
ipt_MASQUERADE          1496   1 (autoclean)
ipt_limit               1176   6 (autoclean)
ipt_REDIRECT             920   2 (autoclean)
ipt_multiport            856   3 (autoclean)
ipt_LOG                 3416   8 (autoclean)
ipt_REJECT              3128   2 (autoclean)
ipt_state                792  94 (autoclean)
iptable_mangle          2292   1 (autoclean)
hid                    17992   0 (unused)
ip_nat_irc              2512   0 (unused)
ip_nat_ftp              3152   0 (unused)
iptable_nat            15704   3 [ipt_MASQUERADE ipt_REDIRECT ip_nat_irc ip_nat_ftp]
ip_conntrack_irc        3184   1
ip_conntrack_ftp        3984   1
ip_conntrack           18400   4 [ipt_MASQUERADE ipt_REDIRECT ipt_state ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_ftp]
iptable_filter          1896   1 (autoclean)
ip_tables              10264  13 [ipt_TOS ipt_MASQUERADE ipt_limit ipt_REDIRECT ipt_multiport ipt_LOG ipt_REJECT ipt_state iptable_mangle iptable_nat iptable_filter]
uhci-hcd               22920   0 (unused)
usbmouse                2436   0 (unused)
usbcore                72660   2 [hid uhci-hcd usbmouse]

darkland:/mnt/bigdur/tmp# cat /proc/ioports 
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
0213-0213 : isapnp read
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
d000-dfff : PCI Bus #01
  d000-d0ff : 3Dfx Interactive, Inc. Voodoo 4 / Voodoo 5
e000-e01f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  e000-e01f : uhci-hcd
e400-e47f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  e400-e47f : 00:09.0
e800-e81f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  e800-e81f : ne2k-pci
ec00-ecff : Adaptec AHA-2940U/UW/D / AIC-7881U
  ec00-ecff : aic7xxx
f000-f00f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1
darkland:/mnt/bigdur/tmp# cat /proc/iomem 
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc7ff : Extension ROM
000cd000-000d35ff : Extension ROM
000f0000-000fffff : System ROM
00100000-13feffff : System RAM
  00100000-0025adc3 : Kernel code
  0025adc4-002f4723 : Kernel data
13ff0000-13ff2fff : ACPI Non-volatile Storage
13ff3000-13ffffff : ACPI Tables
c0000000-cfffffff : PCI Bus #01
  c0000000-c7ffffff : 3Dfx Interactive, Inc. Voodoo 4 / Voodoo 5
d0000000-d7ffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
d8000000-dfffffff : PCI Bus #01
  d8000000-dfffffff : 3Dfx Interactive, Inc. Voodoo 4 / Voodoo 5
e1000000-e100007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
e1001000-e1001fff : Adaptec AHA-2940U/UW/D / AIC-7881U
  e1001000-e1001fff : aic7xxx
ffff0000-ffffffff : reserved

Do you want my kernel config ?


Luc
