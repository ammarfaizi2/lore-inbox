Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271007AbRHZOcA>; Sun, 26 Aug 2001 10:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271275AbRHZObw>; Sun, 26 Aug 2001 10:31:52 -0400
Received: from ns.ranet.sk ([195.146.17.11]:1800 "EHLO ns.ranet.sk")
	by vger.kernel.org with ESMTP id <S271007AbRHZObk>;
	Sun, 26 Aug 2001 10:31:40 -0400
Date: Sun, 26 Aug 2001 16:31:54 +0200
Message-Id: <200108261431.QAA24146@ns.ranet.sk>
To: linux-kernel@vger.kernel.org
Subject: Kernel bug at slab.c when loading module with modem driver
From: Bohdan Kolecek <bk@freemail.sk>
Reply-To: Bohdan Kolecek <bk@freemail.sk>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: mmail WebMail Interface by manaz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: bk@freemail.sk
To: linux-kernel@vger.kernel.org
Subject: Kernel bug at slab.c when loading module with modem driver

1. One line summary of the problem
----------------------------------

Loading Motorola SM56 Softmodem driver causes kernel bug at slab.c line 1062.

2. Full description of the problem
----------------------------------

I've got Motorola SM56 Softmodem using vendor's driver. When I try to insert driver module by 'insmod sm56.o' I get kernel bug message followed by unsuccesfull installation of the module.

3. Kernel version
-----------------

cat /proc/version:

Linux version 2.4.9 (root@pentium-mmx) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Ne srp 26 14:48:49 CEST 2001

4. Output of kernel bug message
-------------------------------

kernel: kernel BUG at slab.c:1062!
kernel: invalid operand: 0000
kernel: CPU:    0
kernel: EIP:    0010:[<c01237fb>]
kernel: EFLAGS: 00010282
kernel: eax: 0000001b   ebx: c12272b4   ecx: c66e0000   edx: c6fdf320
kernel: esi: 00000202   edi: c12272b4   ebp: 00000007   esp: c66e1e38
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process modprobe (pid: 525, stackpage=c66e1000)
kernel: Stack: c021d57a c021d616 00000426 c12272b4 00000202 00000007 c66e1e8c c0263d54
kernel:        c0123a99 c12272b4 00000007 00000064 00000000 c881f065 c886d24b 00000064
kernel:        00000007 c02af5a0 00000000 c881f000 c881f065 c66e1ebc c886d820 00000064
kernel: Call Trace: [<c0123a99>] [<c881f065>] [<c886d24b>] [<c881f065>] [<c886d820>]
kernel:    [<c0113eba>] [<c881f065>] [<c886d54d>] [<c0107f4d>] [<c89247dc>] [<c0106c00>]
kernel:    [<c89247dc>] [<c881f065>] [<c881f065>] [<c011142d>] [<c881f060>] [<c0106b63>]
kernel:
kernel: Code: 0f 0b 83 c4 0c f7 c5 00 10 00 00 0f 85 c4 01 00 00 a1 c8 77

5. Invoking error
-----------------

insmod /lib/modules/2.4.9/kernel/drivers/char/sm56.o

6. Installed software
---------------------

Motorola Softmodem SM56 Rel. 5.01 Build 01

output of ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux pentium-mmx 2.4.9 #1 Ne srp 26 14:48:49 CEST 2001 i586 unknown

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux             2.10s
mount                  2.10s
modutils               2.4.6
e2fsprogs              1.22
PPP                    2.4.1
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.60
Kbd                    [pøepínaè...]
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         sm56

7. Processor information
------------------------

cat /proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 200.457
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 399.76

8. Module information
---------------------

cat /proc/modules:

sm56                 1346016   0 (unused)

9. Loaded driver and hardware information
-----------------------------------------

cat /proc/ioports:

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
0300-031f : eth0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
6400-64ff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
6800-683f : Ensoniq ES1370 [AudioPCI]
  6800-683f : es1370
f000-f00f : VIA Technologies, Inc. Bus Master IDE
  f000-f007 : ide0
  f008-f00f : ide1

cat /proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-00219ecf : Kernel code
  00219ed0-0028045f : Kernel data
e0000000-e0ffffff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
e1000000-e1000fff : ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB]
e1001000-e10010ff : PCI device 11d4:1805 (Analog Devices)
ffff0000-ffffffff : reserved

10. PCI information
-------------------

output of lspci -vvv:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo VP1/VPX] (rev 23)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 64 set

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 27)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Region 4: I/O ports at f000 [size=16]

00:09.0 VGA compatible controller: ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB] (rev 9a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 4755
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 64 set, cache line size 08
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 6400 [size=256]
        Region 2: Memory at e1000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]

00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
        Subsystem: Unknown device 4942:4c4c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 12 min, 128 max, 64 set
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 6800 [size=64]

00:0b.0 Communication controller: Analog Devices: Unknown device 1805
        Subsystem: Analog Devices: Unknown device 1805
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 1 min, 255 max, 64 set
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at e1001000 (32-bit, prefetchable) [size=256]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

11. /proc/slabinfo
------------------

/proc/slabinfo before driver is loaded:

slabinfo - version: 1.1
kmem_cache            55     78    100    2    2    1
ip_conntrack           0     11    352    0    1    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket       16    113     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           1     24    160    1    1    1
arp_cache              1     30    128    1    1    1
blkdev_requests      384    520     96   10   13    1
dnotify cache          0      0     20    0    0    1
file lock cache       16     42     92    1    1    1
fasync cache           1    202     16    1    1    1
uid_cache              4    113     32    1    1    1
skbuff_head_cache     79     96    160    4    4    1
sock                  41     54    832    5    6    2
sigqueue               0     29    132    0    1    1
cdev_cache           273    295     64    5    5    1
bdev_cache             7     59     64    1    1    1
mnt_cache             11     59     64    1    1    1
inode_cache         1014   1016    480  127  127    1
dentry_cache        1411   1440    128   48   48    1
filp                 254    280     96    7    7    1
names_cache            0      6   4096    0    6    1
buffer_head        19008  19040     96  476  476    1
mm_struct             28     48    160    2    2    1
vm_area_struct       737    767     64   13   13    1
fs_cache              27     59     64    1    1    1
files_cache           27     27    416    3    3    1
signal_act            29     30   1312   10   10    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      0  32768    0    0    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              6      6   8192    6    6    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             27     27   4096   27   27    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048              4      4   2048    2    2    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             22     24   1024    6    6    1
size-512(DMA)          0      0    512    0    0    1
size-512              23     24    512    3    3    1
size-256(DMA)          0      0    256    0    0    1
size-256              27     75    256    2    5    1
size-128(DMA)          0      0    128    0    0    1
size-128             457    510    128   16   17    1
size-64(DMA)           0      0     64    0    0    1
size-64               87    118     64    2    2    1
size-32(DMA)           0      0     32    0    0    1
size-32              260    339     32    3    3    1

/proc/slabinfo after driver is loaded using workaround (see chapter 12):

slabinfo - version: 1.1
kmem_cache            55     78    100    2    2    1
ip_conntrack           0     11    352    0    1    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket       16    113     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            8    113     32    1    1    1
ip_dst_cache           1     24    160    1    1    1
arp_cache              1     30    128    1    1    1
blkdev_requests      384    520     96   10   13    1
dnotify cache          0      0     20    0    0    1
file lock cache       16     42     92    1    1    1
fasync cache           1    202     16    1    1    1
uid_cache              4    113     32    1    1    1
skbuff_head_cache     79     96    160    4    4    1
sock                  41     54    832    5    6    2
sigqueue               0     29    132    0    1    1
cdev_cache           273    295     64    5    5    1
bdev_cache             7     59     64    1    1    1
mnt_cache             11     59     64    1    1    1
inode_cache         1019   1024    480  128  128    1
dentry_cache        1419   1440    128   48   48    1
filp                 254    280     96    7    7    1
names_cache            0      6   4096    0    6    1
buffer_head        19044  19080     96  477  477    1
mm_struct             28     48    160    2    2    1
vm_area_struct       737    767     64   13   13    1
fs_cache              27     59     64    1    1    1
files_cache           27     27    416    3    3    1
signal_act            29     30   1312   10   10    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             0      0  32768    0    0    8
size-16384(DMA)        1      1  16384    1    1    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              6      6   8192    6    6    2
size-4096(DMA)         3      3   4096    3    3    1
size-4096             28     29   4096   28   29    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048              4      6   2048    2    3    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             22     24   1024    6    6    1
size-512(DMA)          2      8    512    1    1    1
size-512              23     32    512    3    4    1
size-256(DMA)          0      0    256    0    0    1
size-256              27     75    256    2    5    1
size-128(DMA)          2     30    128    1    1    1
size-128             457    510    128   16   17    1
size-64(DMA)           1     59     64    1    1    1
size-64               89    118     64    2    2    1
size-32(DMA)           1    113     32    1    1    1
size-32              272    339     32    3    3    1

12. Bug workaround
------------------

The bug can be workarounded by commenting lines 1061 and 1062 at slab.c, that causes the bug report. It seems modem works without problem then.

13. Notice for different kernel version
---------------------------------------

kernel-linux 2.4.5:

-no kernel bug report
-no unresolved symbols
-modem works OK

kernel-linux 2.4.7:

-kernel bug appears (at slab.c:1062)
-no unresolved symbols
-modem works only using workaround (see chapter 12)

kernel-linux 2.4.9:

-kernel bug appears (ar slab.c:1062)
-found some unresolved symbols
-modem works only using workaround (see chapter 12)

I don't think the bug is caused by unresolved symbols, because this bug appeared also (as you can see) in Linux 2.4.7. Because SM56 modem driver isn't open-source, we must wait until Motorola fix unresolved symbols himself.


Thanks,
Bohdan Kolecek


(Excuse my English)


