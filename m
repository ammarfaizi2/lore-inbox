Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUEYHiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUEYHiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 03:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUEYHiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 03:38:46 -0400
Received: from netmail01.eng.net ([213.130.128.38]:50591 "EHLO
	netmail01.eng.net") by vger.kernel.org with ESMTP id S261764AbUEYHi2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 03:38:28 -0400
From: Chris Clayton <chris@theclaytons.giointernet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Unreliable cdmrw in 2.6.5/6
Date: Tue, 25 May 2004 08:40:10 +0000
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405250840.10808.chris@theclaytons.giointernet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[0] Please cc me, I'm not subscribed.

[1] Writing to CDMRW unreliable in 2.6.{5,6}

[2] Using Jens Axboe's patch and formatting utility, I have used Mt Rainier 
(cdmrw) successfully on 2.4.{24,25,26} for several months. Of course this was 
through scsi emulation, where my Lite-On LTR-48246K (/dev/hdc) 
became /dev/sr0. Since upgrading to 2.6.5 (and more recently, 2.6.6), I have 
heeded the warnings of eternal damnation and "turned off" scsi emulation. 
However, I now find cdmrw to be most unreliable. By unreliable, I mean that 
some files written to the disc appear in directory listings until the disc is 
umounted, but are missing when it is mounted again. Attempts to copy 
"gone-missing" files to the disc result in an error that the file already 
exists. At first, I thought it was a udffs problem, because of a 
regularly-experienced oops within udf, so I mailed the oops to Ben Fennema, 
copied to Jens. Jens suggested that I should try with 2.6.6 and a different 
fs, so I tried ext2 and encountered the same unreliability (but no oops). 
However, I also noticed that in both cases (udf and ext2), the 
filesystem-generated errors shown in the output from dmesg were all 
accompanied by a "tray open" message on hdc. I believe this message comes 
from drivers/ide/ide-cd.c. The diagnostics are at section 5 below.

[3] cdmrw, ide-cd, "tray open"

[4]cat /proc/version
Linux version 2.6.6 (root@upstairs) (gcc version 3.3.3) #8 Mon May 24 09:35:39 
UTC 2004

[5] UDFFS:

cdrom: hdc: mrw address space DMA selected
cdrom open: mrw_status 'bgformat inactive'
cdrom: Restarting format
UDF-fs DEBUG fs/udf/lowlevel.c:57:udf_get_last_session: XA disk: no, 
vol_desc_start=1560
UDF-fs DEBUG fs/udf/super.c:1546:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:534:udf_vrs: Starting at sector 16 (2048 byte 
sectors)
UDF-fs DEBUG fs/udf/super.c:877:udf_load_pvoldesc: recording time 
1084717322/121768, 2004/05/16 14:22 (1000)
UDF-fs DEBUG fs/udf/super.c:888:udf_load_pvoldesc: volIdent[] = 'LinuxUDF'
UDF-fs DEBUG fs/udf/super.c:895:udf_load_pvoldesc: volSetIdent[] = 
'40a7790aLinuxUDF'
UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch block 
258080, tag 2863311530 != 258080
UDF-fs DEBUG fs/udf/super.c:1087:udf_load_logicalvol: Partition (0:0) type 2 
on volume 1
UDF-fs DEBUG fs/udf/super.c:1097:udf_load_logicalvol: FileSet found in 
LogicalVolDesc at block=32, partition=0
UDF-fs DEBUG fs/udf/super.c:925:udf_load_partdesc: Searching map: (0 == 0)
UDF-fs DEBUG fs/udf/super.c:966:udf_load_partdesc: unallocSpaceBitmap (part 0) 
@ 0
UDF-fs DEBUG fs/udf/super.c:1007:udf_load_partdesc: Partition (0:0 type 1522) 
starts at physical 1408, block length 256480
UDF-fs DEBUG fs/udf/super.c:1340:udf_load_partition: Using anchor in block 256
UDF-fs DEBUG fs/udf/super.c:1573:udf_fill_super: Lastblock=0
UDF-fs DEBUG fs/udf/super.c:849:udf_find_fileset: Fileset at block=32, 
partition=0
UDF-fs DEBUG fs/udf/super.c:911:udf_load_fileset: Rootdir at block=96, 
partition=0
UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 
2004/05/16 14:22 (1000)
hdc: tray open
end_request: I/O error, dev hdc, sector 15076
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
hdc: tray open
end_request: I/O error, dev hdc, sector 17724
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
hdc: tray open
end_request: I/O error, dev hdc, sector 20776
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
hdc: tray open
end_request: I/O error, dev hdc, sector 54348
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
hdc: tray open
end_request: I/O error, dev hdc, sector 87980
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
hdc: tray open
end_request: I/O error, dev hdc, sector 105788
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
hdc: tray open
end_request: I/O error, dev hdc, sector 116868
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
hdc: tray open
end_request: I/O error, dev hdc, sector 141712
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
hdc: tray open
end_request: I/O error, dev hdc, sector 151316
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
hdc: tray open
end_request: I/O error, dev hdc, sector 163348
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
hdc: tray open
end_request: I/O error, dev hdc, sector 178436
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
hdc: tray open
end_request: I/O error, dev hdc, sector 186120
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
hdc: tray open
end_request: I/O error, dev hdc, sector 191104
UDF-fs DEBUG fs/udf/inode.c:1346:udf_update_inode: bread failure
cdrom: hdc: mrw address space DMA selected
cdrom open: mrw_status 'bgformat active'
UDF-fs DEBUG fs/udf/lowlevel.c:57:udf_get_last_session: XA disk: no, 
vol_desc_start=1560
UDF-fs DEBUG fs/udf/super.c:1546:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:534:udf_vrs: Starting at sector 16 (2048 byte 
sectors)
UDF-fs DEBUG fs/udf/super.c:877:udf_load_pvoldesc: recording time 
1084717322/121768, 2004/05/16 14:22 (1000)
UDF-fs DEBUG fs/udf/super.c:888:udf_load_pvoldesc: volIdent[] = 'LinuxUDF'
UDF-fs DEBUG fs/udf/super.c:895:udf_load_pvoldesc: volSetIdent[] = 
'40a7790aLinuxUDF'
UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch block 
258080, tag 2863311530 != 258080
UDF-fs DEBUG fs/udf/super.c:1087:udf_load_logicalvol: Partition (0:0) type 2 
on volume 1
UDF-fs DEBUG fs/udf/super.c:1097:udf_load_logicalvol: FileSet found in 
LogicalVolDesc at block=32, partition=0
UDF-fs DEBUG fs/udf/super.c:925:udf_load_partdesc: Searching map: (0 == 0)
UDF-fs DEBUG fs/udf/super.c:966:udf_load_partdesc: unallocSpaceBitmap (part 0) 
@ 0
UDF-fs DEBUG fs/udf/super.c:1007:udf_load_partdesc: Partition (0:0 type 1522) 
starts at physical 1408, block length 256480
UDF-fs DEBUG fs/udf/super.c:1340:udf_load_partition: Using anchor in block 256
UDF-fs DEBUG fs/udf/super.c:1573:udf_fill_super: Lastblock=0
UDF-fs DEBUG fs/udf/super.c:849:udf_find_fileset: Fileset at block=32, 
partition=0
UDF-fs DEBUG fs/udf/super.c:911:udf_load_fileset: Rootdir at block=96, 
partition=0
UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 
2004/05/16 14:22 (1000)
UDF-fs DEBUG fs/udf/misc.c:236:udf_read_tagged: location mismatch block 3769, 
tag 2863311530 != 2361
udf: udf_read_inode(ino 3769) failed !bh
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c01c42f2
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c01c42f2>]    Not tainted
EFLAGS: 00210293   (2.6.5) 
EIP is at udf_get_fileshortad+0x22/0x50
eax: 00000008   ebx: 0807d328   ecx: d9e8fd78   edx: 000000c0
esi: d6cf8840   edi: 00000008   ebp: d9e8fd78   esp: d9e8fcb0
ds: 007b   es: 007b   ss: 0068
Process kdeinit (pid: 907, threadinfo=d9e8e000 task=d76fe7e0)
Stack: d9e8fcd0 c01ba7ed 00000008 0807d328 d9e8fd78 00000001 00200046 00000035 
       0000000a c040be1b 00000002 c040c1ff 00200046 00000000 c036caf8 00000001 
       d9e8fd10 c0118dd1 d9e8fd94 d9e8fd80 d9e8fd84 d6cf8878 c01ba593 d6cf8878 
Call Trace:
 [<c01ba7ed>] udf_current_aext+0x17d/0x1f0
 [<c0118dd1>] __wake_up_common+0x31/0x60
 [<c01ba593>] udf_next_aext+0x43/0x120
 [<c01c2cf4>] udf_discard_prealloc+0xd4/0x2e0
 [<c0168b27>] get_new_inode_fast+0x47/0x100
 [<c01b5f36>] udf_put_inode+0x36/0x70
 [<c0169370>] iput+0x70/0x80
 [<c01b9da5>] udf_iget+0xd5/0x140
 [<c01bbbee>] udf_lookup+0xbe/0x150
 [<c02b268c>] memcpy_fromiovec+0x5c/0xb0
 [<c0160000>] vfs_follow_link+0x50/0x1b0
 [<c015d048>] real_lookup+0xc8/0xf0
 [<c015d2d6>] do_lookup+0x96/0xb0
 [<c015d7bd>] link_path_walk+0x4cd/0x940
 [<c015e119>] __user_walk+0x49/0x60
 [<c0158fbc>] vfs_lstat+0x1c/0x60
 [<c015970b>] sys_lstat64+0x1b/0x40
 [<c0108a47>] syscall_call+0x7/0xb

Code: 83 38 00 74 0d 83 7c 24 14 00 74 02 89 11 83 c4 04 c3 31 c0 
 
EXT2:

cdrom: hdc: mrw address space DMA selected
cdrom open: mrw_status 'bgformat inactive'
cdrom: Restarting format
hdc: tray open
end_request: I/O error, dev hdc, sector 131072
EXT2-fs error (device hdc): read_block_bitmap: Cannot read block bitmap - 
block_group = 2, block_bitmap = 32768
hdc: tray open
end_request: I/O error, dev hdc, sector 131072
EXT2-fs error (device hdc): read_block_bitmap: Cannot read block bitmap - 
block_group = 2, block_bitmap = 32768
hdc: tray open
end_request: I/O error, dev hdc, sector 131072
EXT2-fs error (device hdc): read_block_bitmap: Cannot read block bitmap - 
block_group = 2, block_bitmap = 32768
hdc: tray open
end_request: I/O error, dev hdc, sector 131072
EXT2-fs error (device hdc): read_block_bitmap: Cannot read block bitmap - 
block_group = 2, block_bitmap = 32768

[6] a) format a cdrw disc with Jens' cdmrw utilty;
    b) mkudffs -media-type-cdrw /dev/hdX
    c) mount -o rw,noatime /dev/hdX /mnt/cdmrw
    d) write a number of files to /mnt/cdmrw (> 30 should trigger)
    e) umount /mnt/cdmrw
    f) mount -o rw,noatime /dev/hdX /mnt/cdmrw

[7.1] ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux upstairs 2.6.6 #8 Mon May 24 09:35:39 UTC 2004 i686 unknown unknown 
GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.8
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
xfsprogs               2.6.0
pcmcia-cs              3.2.7
PPP                    2.4.1
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Linux C++ Library      5.0.5
Procps                 3.1.15
Net-tools              1.57
Kbd                    0.99
Sh-utils               5.1.2
Modules Loaded         snd_bt87x tuner tda9887 msp3400 bttv video_buf 
i2c_algo_bit v4l2_common btcx_risc i2c_core videodev evdev ipt_LOG ipt_state 
ip_conntrack_ftp ip_conntrack iptable_filter ip_tables joydev

[7.2] cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2100+
stepping        : 1
cpu MHz         : 1741.087
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3432.44

[7.3] cat /proc/modules
snd_bt87x 11204 1 - Live 0xe0933000
tuner 18832 0 - Live 0xe093a000
tda9887 11268 0 - Live 0xe092f000
msp3400 22036 0 - Live 0xe091d000
bttv 145484 0 - Live 0xe094d000
video_buf 17476 1 bttv, Live 0xe0924000
i2c_algo_bit 8904 1 bttv, Live 0xe0913000
v4l2_common 4928 1 bttv, Live 0xe0910000
btcx_risc 3848 1 bttv, Live 0xe08ce000
i2c_core 18756 5 tuner,tda9887,msp3400,bttv,i2c_algo_bit, Live 0xe0917000
videodev 7168 1 bttv, Live 0xe090d000
evdev 7296 0 - Live 0xe0906000
ipt_LOG 5760 1 - Live 0xe090a000
ipt_state 1472 1 - Live 0xe0904000
ip_conntrack_ftp 71024 0 - Live 0xe08f1000
ip_conntrack 29640 2 ipt_state,ip_conntrack_ftp, Live 0xe08e8000
iptable_filter 2176 1 - Live 0xe08d3000
ip_tables 15552 3 ipt_LOG,ipt_state,iptable_filter, Live 0xe08d9000
joydev 7808 0 - Live 0xe08d0000

[7.5] lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ec000000-edffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 2027:0035
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 2027:0035
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (250ns min, 10500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 5
        Region 0: Memory at ee001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Unknown device 2027:0032
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8500ns max), cache line size 10
        Interrupt: pin C routed to IRQ 10
        Region 0: Memory at ee002000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ee003000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo receiver, 
audio section)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at ee004000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Unex Technology Corp. ND010
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at ee005000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. 
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] 
(rev 23) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] 
(rev 23) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 
AC97 Audio Controller (rev 40)
        Subsystem: C-Media Electronics Inc: Unknown device 0301
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 
400] (rev b2) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6] cat /proc/scsi/scsi
cat: /proc/scsi/scsi: No such file or directory

[7.7] Other information.

a) If I turn scsi emulation back on (hdc=scsi argument to vmlinuz), both udf 
and ext2 on cdmrw work reliably under 2.6.6 (not tested under 2.6.5)

b) I can also reliably use udf via packet writing through the patch maintained 
by Peter Osterlund and cdmrwtool from the udftools package.

c) Recording CDR/RW through cdrtools works perfectly, every time.

d) A similar, if not identical, problem was posted on 17 March 2004 
( http://marc.theaimsgroup.com/?l=linux-kernel&m=107955822109371&w=2 ), but 
received no response.
