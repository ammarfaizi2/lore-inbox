Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSEVOiu>; Wed, 22 May 2002 10:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSEVOit>; Wed, 22 May 2002 10:38:49 -0400
Received: from loisexc2.loislaw.com ([12.5.234.240]:39432 "EHLO
	loisexc2.loislaw.com") by vger.kernel.org with ESMTP
	id <S315372AbSEVOiW>; Wed, 22 May 2002 10:38:22 -0400
Message-ID: <4188788C3E1BD411AA60009027E92DFD0962E2BE@loisexc2.loislaw.com>
From: "Rose, Billy" <wrose@loislaw.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: RedHat 7.2 Stock SMP Install
Date: Wed, 22 May 2002 09:38:17 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an HP LPr Dual P-III 550 with 2 18G SCSI drives that locked up. No
response at the console, ssh failed, and ping never answered. Looking in
/var/log/messages shows no entries at or even near the time of lock up.
Below is included some info from ver_linux and the /proc fs. Production use:
Tux web server for static content, Apache/PHP for simple variable
substitution in .php pages. System runs Samba 2.2.1a for connection from
clients to store web content. How can I find more info on the lockup?


[root@warnock root]# ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux warnock 2.4.7-10smp #1 SMP Thu Sep 6 17:09:31 EDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
reiserfsprogs          3.x.0j
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         ide-scsi nfsd lockd sunrpc tux autofs eepro100
usb-uhci usbcore ext3 jbd sym53c8xx sd_mod scsi_mod

[root@warnock root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 549.074
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1094.45
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 549.074
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
pat pse36 mmx fxsr sse
bogomips        : 1097.72


[root@warnock root]# cat /proc/modules
ide-scsi                8352   0
nfsd                   71808   8 (autoclean)
lockd                  53744   1 (autoclean) [nfsd]
sunrpc                 70000   1 (autoclean) [nfsd lockd]
tux                    80432   3
autofs                 12096   0 (autoclean) (unused)
eepro100               18144   1
usb-uhci               22880   0 (unused)
usbcore                54528   1 [usb-uhci]
ext3                   67728   3
jbd                    44480   3 [ext3]
sym53c8xx              57920   4
sd_mod                 11584   4
scsi_mod               98512   3 [ide-scsi sym53c8xx sd_mod]


[root@warnock root]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-101f : Intel Corporation 82371AB PIIX4 USB
  1000-101f : usb-uhci
1020-102f : Intel Corporation 82371AB PIIX4 IDE
  1020-1027 : ide0
1040-105f : Intel Corporation 82371AB PIIX4 ACPI
8000-803f : Intel Corporation 82371AB PIIX4 ACPI
9000-9fff : PCI Bus #01
  9000-90ff : Symbios Logic Inc. (formerly NCR) 53c895
    9000-907f : sym53c8xx
  9400-941f : Intel Corporation 82557 [Ethernet Pro 100]
    9400-941f : eepro100


[root@warnock root]# cat /proc/iomem
00000000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cb7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0025d2c7 : Kernel code
  0025d2c8-00276bff : Kernel data
1fff0000-1ffffbff : ACPI Tables
1ffffc00-1fffffff : ACPI Non-volatile Storage
fa000000-fa000fff : Cirrus Logic GD 5446
fa100000-fa2fffff : PCI Bus #01
  fa100000-fa1fffff : Intel Corporation 82557 [Ethernet Pro 100]
  fa200000-fa200fff : Symbios Logic Inc. (formerly NCR) 53c895
  fa201000-fa2010ff : Symbios Logic Inc. (formerly NCR) 53c895
fa500000-fa5fffff : PCI Bus #01
  fa500000-fa500fff : Intel Corporation 82557 [Ethernet Pro 100]
    fa500000-fa500fff : eepro100
fc000000-fdffffff : Cirrus Logic GD 5446
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fffe9800-ffffffff : reserved

[root@warnock root]# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(AGP disabled) (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at <unassigned> (32-bit, prefetchable) [size=256M]

00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if
80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at 1020 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at 1000 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:07.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 57, cache line size 08
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=249
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: fa100000-fa2fffff
        Prefetchable memory behind bridge: 00000000fa500000-00000000fa500000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+

00:0d.0 VGA compatible controller: Cirrus Logic GD 5446 (rev 45) (prog-if 00
[VGA])
        Subsystem: Hewlett-Packard Company: Unknown device 0001
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at fa000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=32K]
 
01:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
05)        Subsystem: Hewlett-Packard Company Ethernet Pro 10/100TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at fa500000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at 9400 [size=32]
        Region 2: Memory at fa100000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
 
01:04.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c895
(rev 01)
        Subsystem: Hewlett-Packard Company: Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 247 (7500ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at 9000 [size=256]
        Region 1: Memory at fa201000 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at fa200000 (32-bit, non-prefetchable) [size=4K]


[root@warnock root]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HP       Model: 18.2GB C 80-8C42 Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: HP       Model: 18.2GB C 80-8C42 Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: TEAC     Model: CD-224E          Rev: 1.5A
  Type:   CD-ROM                           ANSI SCSI revision: 02

[root@warnock root]# cat /proc/mounts
/dev/root / ext3 rw 0 0
/proc /proc proc rw 0 0
usbdevfs /proc/bus/usb usbdevfs rw 0 0
/dev/sda1 /boot ext3 rw 0 0
none /dev/pts devpts rw 0 0
none /dev/shm tmpfs rw 0 0
/dev/sdb1 /var ext3 rw 0 0

[root@warnock root]# cat /proc/slabinfo
slabinfo - version: 1.1 (SMP)
kmem_cache            85     85    232    5    5    1 :  252  126
ip_fib_hash          226    226     32    2    2    1 :  252  126
urb_priv               0      0     64    0    0    1 :  252  126
journal_head         276    780     48    8   10    1 :  252  126
revoke_table         252    253     12    1    1    1 :  252  126
revoke_record        113    113     32    1    1    1 :  252  126
clip_arp_cache         0      0    128    0    0    1 :  252  126
ip_mrt_cache           0      0     96    0    0    1 :  252  126
tcp_tw_bucket        594    720    128   24   24    1 :  252  126
tcp_bind_bucket      226    226     32    2    2    1 :  252  126
tcp_open_request     154    280     96    6    7    1 :  252  126
inet_peer_cache      118    118     64    2    2    1 :  252  126
ip_dst_cache         834    960    192   48   48    1 :  252  126
arp_cache             60     60    128    2    2    1 :  252  126
blkdev_requests     5438   6320     96  141  158    1 :  252  126
dnotify cache        126    169     20    1    1    1 :  252  126
file lock cache      126    126     92    3    3    1 :  252  126
fasync cache         202    202     16    1    1    1 :  252  126
uid_cache            226    226     32    2    2    1 :  252  126
skbuff_head_cache    504    504    160   21   21    1 :  252  126
sock                 144    174   1280   58   58    1 :   60   30
sigqueue             261    261    132    9    9    1 :  252  126
cdev_cache           236    236     64    4    4    1 :  252  126
bdev_cache           177    177     64    3    3    1 :  252  126
mnt_cache             80     80     96    2    2    1 :  252  126
inode_cache        11493  11493    416 1277 1277    1 :  124   62
dentry_cache       12780  12780    128  426  426    1 :  252  126
dquot                  0      0    128    0    0    1 :  252  126
filp                 440    440     96   11   11    1 :  252  126
names_cache           23     23   4096   23   23    1 :   60   30
buffer_head        38680  38680     96  967  967    1 :  252  126
mm_struct             72     72    160    3    3    1 :  252  126
vm_area_struct      1054   1180     64   20   20    1 :  252  126
fs_cache             118    118     64    2    2    1 :  252  126
files_cache           81     81    416    9    9    1 :  124   62
signal_act            93     93   1312   31   31    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             1      1  65536    1    1   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      1  32768    0    1    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             8      9  16384    8    9    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              2      3   8192    2    3    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             93     93   4096   93   93    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            236    236   2048  118  118    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            280    280   1024   70   70    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             216    216    512   27   27    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             360    360    256   24   24    1 :  252  126
size-128(DMA)         30     30    128    1    1    1 :  252  126
size-128            1200   1200    128   40   40    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              295    295     64    5    5    1 :  252  126
size-32(DMA)         113    113     32    1    1    1 :  252  126
size-32             4520   4520     32   40   40    1 :  252  126



Billy Rose 
wrose@loislaw.com
