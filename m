Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293205AbSCAQQp>; Fri, 1 Mar 2002 11:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293217AbSCAQQg>; Fri, 1 Mar 2002 11:16:36 -0500
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:22519 "EHLO
	mailrelay.tugraz.at") by vger.kernel.org with ESMTP
	id <S293205AbSCAQQO>; Fri, 1 Mar 2002 11:16:14 -0500
Date: Fri, 1 Mar 2002 17:16:05 +0100 (CET)
From: Reinhard Wolfgang Kreiner <rkreiner@sbox.tugraz.at>
X-X-Sender: <rkreiner@pluto.tu-graz.ac.at>
To: <linux-kernel@vger.kernel.org>
cc: <alsa-devel@alsa-project.org>
Subject: PROBLEM: 2.5.5 with Alsa, kernel BUG at slab.c:1459
Message-ID: <Pine.LNX.4.33.0203011709020.15390-100000@pluto.tu-graz.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello, 

I tested kernel 2.5.5, 2.5.5-pre1 with alsa-sound-drivers... 
it runs great, but the system is freezing if i 
shutdown the system and i get kernel BUG at slab.c:1459!!!

i tried different combination, the problem only orrur
if im _using_ the soundcards.
 
unloading the modules manually, the same problem
only on shutdown.
seems to be freeing some resouces in memory?

loading only the es1371-driver there is no problem.
loading only the cs4232-driver without es1371 if have the problem too.
it seems to be with the cs4232-driver.

the oss-driver cs4232 works great and
the alsa cs4232-driver shipped with suse 7.3
works too.

regards,
Reinhard.


Soundcards:
PCI: ES1371, driver es1371
ISA: Adlib MSC32 (CSC3237), driver CS4232


--- modules
snd-seq-midi            4560   0 (unused)
snd-seq-midi-event      3696   0 [snd-seq-midi]
snd-seq                47408   0 [snd-seq-midi snd-seq-midi-event]
snd-cs4232              5024   0 (unused)
snd-cs4231-lib         20560   0 [snd-cs4232]
snd-opl3-lib            6928   0 [snd-cs4232]
snd-hwdep               4176   0 [snd-opl3-lib]
snd-mpu401-uart         3680   0 [snd-cs4232]
snd-ens1371            11328   0 (unused)
snd-pcm                63584   0 [snd-cs4231-lib snd-ens1371]
snd-timer              11920   0 [snd-seq snd-cs4231-lib snd-opl3-lib snd-pcm]
snd-ac97-codec         23568   0 [snd-ens1371]
snd-rawmidi            14528   0 [snd-seq-midi snd-mpu401-uart snd-ens1371]
snd-seq-device          4256   0 [snd-seq-midi snd-seq snd-opl3-lib snd-rawmidi]
snd                    34944   0 [snd-seq-midi snd-seq-midi-event snd-seq snd-cs4232 snd-cs4231-lib snd-opl3-lib snd-hwdep snd-mpu401-uart snd-ens1371 snd-pcm snd-timer snd-ac97-codec snd-rawmidi snd-seq-device]
ipv6                  171328 (uninitialized)
evdev                   5328   0 (unused)
8139too                16656   1 (autoclean)
mii                     1472   0 (autoclean) [8139too]
iptable_nat            23792   0 (autoclean) (unused)
ip_conntrack           25072   1 (autoclean) [iptable_nat]
iptable_filter          2080   0 (autoclean) (unused)
ip_tables              14144   4 [iptable_nat iptable_filter]
nls_iso8859-1           2880   5 (autoclean)
nls_cp437               4384   5 (autoclean)
---
--- modules after using soundcards
snd-pcm-oss            46336   1 (autoclean)
snd-mixer-oss          11760   0 (autoclean) [snd-pcm-oss]
snd-seq-midi            4560   0 (unused)
snd-seq-midi-event      3696   0 [snd-seq-midi]
snd-seq                47408   0 [snd-seq-midi snd-seq-midi-event]
snd-cs4232              5024   0
snd-cs4231-lib         20560   0 [snd-cs4232]
snd-opl3-lib            6928   0 [snd-cs4232]
snd-hwdep               4176   0 [snd-opl3-lib]
snd-mpu401-uart         3680   0 [snd-cs4232]
snd-ens1371            11328   1
snd-pcm                63584   0 [snd-pcm-oss snd-cs4231-lib snd-ens1371]
snd-timer              11920   0 [snd-seq snd-cs4231-lib snd-opl3-lib snd-pcm]
snd-ac97-codec         23568   0 [snd-ens1371]
snd-rawmidi            14528   0 [snd-seq-midi snd-mpu401-uart snd-ens1371]
snd-seq-device          4256   0 [snd-seq-midi snd-seq snd-opl3-lib snd-rawmidi]
snd                    34944   0 [snd-pcm-oss snd-mixer-oss snd-seq-midi snd-seq-midi-event snd-seq snd-cs4232 snd-cs4231-lib snd-opl3-lib snd-hwdep snd-mpu401-uart snd-ens1371 snd-pcm snd-timer snd-ac97-codec snd-rawmidi snd-seq-device]
ipv6                  171328 (uninitialized)
evdev                   5328   0 (unused)
8139too                16656   1 (autoclean)
mii                     1472   0 (autoclean) [8139too]
iptable_nat            23792   0 (autoclean) (unused)
ip_conntrack           25072   1 (autoclean) [iptable_nat]
iptable_filter          2080   0 (autoclean) (unused)
ip_tables              14144   4 [iptable_nat iptable_filter]
nls_iso8859-1           2880   5 (autoclean)
nls_cp437               4384   5 (autoclean)
---

--- /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 4).
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 4).
      Master Capable.  Latency=64.  Min Gnt=8.
  Bus  0, device   3, function  0:
    Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 0).
  Bus  0, device   7, function  0:
    ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev 195).
  Bus  0, device   9, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xde000000 [0xde0000ff].
  Bus  0, device  11, function  0:
    Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 6).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xd400 [0xd43f].
  Bus  0, device  15, function  0:
    IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 193).
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0xd000 [0xd00f].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 3).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xe6000000 [0xe7ffffff].
      Non-prefetchable 32 bit memory at 0xdf800000 [0xdf803fff].
      Non-prefetchable 32 bit memory at 0xdf000000 [0xdf7fffff].
---

--- ioports
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
0213-0213 : isapnp read
0290-0297 : PnPBIOS PNP0c02
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f0-03f5 : floppy
03f6-03f6 : ide0
03f7-03f7 : floppy DIR
03f8-03ff : serial(auto)
040b-040b : PnPBIOS PNP0c02
0480-049f : PnPBIOS PNP0c02
04d6-04d6 : PnPBIOS PNP0c02
0534-0537 : CS4231
0538-053f : CS4232 Control
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5c20-5c3f : Acer Laboratories Inc. [ALi] M7101 PMU
d000-d00f : Acer Laboratories Inc. [ALi] M5229 IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d43f : Ensoniq ES1371 [AudioPCI-97]
  d400-d43f : Ensoniq AudioPCI
d800-d8ff : Realtek Semiconductor Co., Ltd. RTL-8139
  d800-d8ff : 8139too
e800-e83f : PnPBIOS PNP0c02
ec00-ec3f : PnPBIOS PNP0c02

---


--- isapnp
Card 1 'CSC3237:AdLib MSC 32 Wave PnP V3SB' PnP version 1.3 Product version 0.1
  Logical device 0 'ASB1622:Unknown'
    Device is active
    Active port 0x534,0x388,0x220
    Active IRQ 5 [0x2]
    Active DMA 1,0
    Resources 0
      Priority preferred
      Port 0x534-0x534, align 0x3, size 0x4, 16-bit address decoding
      Port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
      Port 0x220-0x220, align 0x1f, size 0x10, 16-bit address decoding
      IRQ 5 High-Edge
      DMA 1 8-bit byte-count compatible
      DMA 0,3 8-bit byte-count compatible
      Alternate resources 0:1
        Priority acceptable
        Port 0x534-0xf44, align 0x3, size 0x4, 16-bit address decoding
        Port 0x388-0x3f8, align 0x7, size 0x4, 16-bit address decoding
        Port 0x220-0x2e0, align 0x1f, size 0x10, 16-bit address decoding
        IRQ 5,7,2/9,11 High-Edge
        DMA 0,1,3 8-bit byte-count compatible
  Logical device 1 'ASB16fd:Unknown'
    Device is active
    Active port 0x200
    Resources 0
      Priority preferred
      Port 0x200-0x200, align 0x7, size 0x8, 16-bit address decoding
      Alternate resources 0:1
        Priority functional
        Port 0x200-0x2f8, align 0x7, size 0x8, 16-bit address decoding
  Logical device 2 'ASB1600:Unknown'
    Device is active
    Active port 0x120
    Resources 0
      Priority preferred
      Port 0x120-0xff8, align 0x7, size 0x8, 16-bit address decoding
  Logical device 3 'ASB16fe:Unknown'
    Device is active
    Active port 0x330
    Resources 0
      Priority preferred
      Port 0x330-0x330, align 0x7, size 0x2, 16-bit address decoding
      Alternate resources 0:1
        Priority acceptable
        Port 0x330-0x330, align 0x7, size 0x2, 16-bit address decoding
        IRQ 2/9 High-Edge
      Alternate resources 0:2
        Priority acceptable
        Port 0x300-0x370, align 0x7, size 0x2, 16-bit address decoding
        IRQ 5,7,2/9,11 High-Edge
---

--- cards
0 [card0          ]: ES1371 - Ensoniq AudioPCI
                     Ensoniq AudioPCI ES1371 at 0xd400, irq 10
1 [card1          ]: ??? - ???
                     ??? at 0x534, irq 5, dma 1&5
---

--- version
Advanced Linux Sound Architecture Driver Version 0.9.0beta11 (Tue Feb 19 08:14:59 2002 UTC).
Compiled on Feb 27 2002 for kernel 2.5.5 with versioned symbols.
---


--- sndstat
Sound Driver:3.8.1a-980706 (ALSA v0.9.0beta11 emulation code)
Kernel: Linux apollo 2.5.5 #3 SMP Wed Feb 27 22:29:16 CET 2002 i586
Config options: 0

Installed drivers: 
Type 10: ALSA emulation

Card config: 
Ensoniq AudioPCI ES1371 at 0xd400, irq 10
??? at 0x534, irq 5, dma 1&5

Audio devices: NOT ENABLED IN CONFIG

Synth devices: NOT ENABLED IN CONFIG

Midi devices:
0: ES1371

Timers:
7: system timer

Mixers: NOT ENABLED IN CONFIG
---

--- timers
G0: system timer : 10000.0us (10000000 ticks)
C1-0: ??? : 9.945us (65535 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE
P1-0-0: PCM playback 1-0-0 : SLAVE
P1-0-1: PCM capture 1-0-1 : SLAVE
---



Feb 27 22:45:00 apollo init: Switching to runlevel: 6
Feb 27 22:45:03 apollo kernel: ALSA seq_clientmgr.c:2100: seq unknown ioctl() 0xc0dc5351 (type='S', number=0x51)
Feb 27 22:45:06 apollo kernel: kernel BUG at slab.c:1459!
Feb 27 22:45:06 apollo kernel: invalid operand: 0000
Feb 27 22:45:06 apollo kernel: CPU:    0
Feb 27 22:45:06 apollo kernel: EIP:    0010:[kmem_cache_reap+413/1156]    Not tainted
Feb 27 22:45:06 apollo kernel: EFLAGS: 00010016
Feb 27 22:45:06 apollo kernel: eax: 5a2cf071   ebx: c48bd000   ecx: 00000042   edx: 00000000
Feb 27 22:45:06 apollo kernel: esi: c48bd5b0   edi: c48bd5d4   ebp: c1165060   esp: c2bd9d94
Feb 27 22:45:06 apollo kernel: ds: 0018   es: 0018   ss: 0018
Feb 27 22:45:06 apollo kernel: Process httpd (pid: 811, threadinfo=c2bd8000 task=c4e928a0)
Feb 27 22:45:06 apollo kernel: Stack: 00000020 000001d2 c030f834 00000006 c01362d5 00000020 c48bd5b4 c1165070
Feb 27 22:45:06 apollo kernel:        c03b4028 00000058 c7f8ae40 c7f8ac00 c2bd8000 00000000 00000002 00000004
Feb 27 22:45:06 apollo kernel:        00000004 c1165490 c0135442 00000006 000001d2 c030f834 c030f834 c030f834
Feb 27 22:45:06 apollo kernel: Call Trace: [page_cache_release+45/48] [shrink_caches+26/136] [try_to_free_pages+29/60] [balance_classzone+102/484] [__alloc_pages+245/336]
Feb 27 22:45:06 apollo kernel:    [_alloc_pages+22/24] [shmem_getpage_locked+780/996] [shmem_getpage+71/144] [shmem_nopage+45/56] [do_no_page+120/568] [handle_mm_fault+108/272]
Feb 27 22:45:06 apollo kernel:    [do_page_fault+424/1237] [do_page_fault+0/1237] [smp_local_timer_interrupt+181/192] [bh_action+89/180] [tasklet_hi_action+102/160] [do_softirq+125/236]
Feb 27 22:45:06 apollo kernel:    [do_IRQ+281/296] [error_code+52/64]
Feb 27 22:45:06 apollo kernel:
Feb 27 22:45:06 apollo kernel: Code: 0f 0b b3 05 41 f0 29 c0 89 f2 03 55 18 b8 71 f0 2c 5a 87 42
Feb 27 22:45:11 apollo kernel:  <4>nfsd: last server has exited



Feb 27 22:53:01 apollo kernel: PCI: Found IRQ 10 for device 00:0b.0
Feb 27 22:53:01 apollo kernel: ALSA cs4231_lib.c:991: cs4231: port = 0x534, id = 0xa
Feb 27 22:53:01 apollo kernel: ALSA cs4231_lib.c:997: CS4231: VERSION (I25) = 0x3
Feb 27 22:53:01 apollo kernel: ALSA cs4231_lib.c:343: cs4231_mce_down - auto calibration time out (1)
Feb 27 22:58:02 apollo PAM-unix2[693]: session started for user unknown, service xdm
Feb 27 22:59:00 apollo /USR/SBIN/CRON[1027]: (root) CMD ( rm -f /var/spool/cron/lastrun/cron.hourly)
Feb 27 22:59:18 apollo su: FAILED SU (to root) unknown on /dev/pts/1
Feb 27 22:59:20 apollo su: (to root) unknown on /dev/pts/1
Feb 27 22:59:20 apollo PAM-unix2[1036]: session started for user root, service su
Feb 27 23:01:22 apollo init: Switching to runlevel: 6
Feb 27 23:01:24 apollo kernel: ALSA seq_clientmgr.c:2100: seq unknown ioctl() 0xc0dc5351 (type='S', number=0x51)
Feb 27 23:01:25 apollo kernel: kernel BUG at slab.c:1459!
Feb 27 23:01:25 apollo kernel: invalid operand: 0000
Feb 27 23:01:25 apollo kernel: CPU:    0
Feb 27 23:01:25 apollo kernel: EIP:    0010:[kmem_cache_reap+413/1156]    Not tainted
Feb 27 23:01:25 apollo kernel: EFLAGS: 00010016
Feb 27 23:01:25 apollo kernel: eax: 5a2cf071   ebx: c66be000   ecx: 00000050   edx: 00000000
Feb 27 23:01:25 apollo kernel: esi: c66be380   edi: c66be3a4   ebp: c1165060   esp: c7f89f34
Feb 27 23:01:25 apollo kernel: ds: 0018   es: 0018   ss: 0018
Feb 27 23:01:25 apollo kernel: Process kswapd (pid: 5, threadinfo=c7f88000 task=c117f540)
Feb 27 23:01:25 apollo kernel: Stack: 00000020 000001d0 c030cd94 00000006 c01362d5 00000020 c66be384 c1165070
Feb 27 23:01:25 apollo kernel:        c03b0028 00000062 c7f8acfc c7f8ac00 c7f88000 00000000 00000007 00000000
Feb 27 23:01:25 apollo kernel:        00000000 00000000 c0135442 00000006 000001d0 c030cd94 00000000 c030cd94
Feb 27 23:01:25 apollo kernel: Call Trace: [page_cache_release+45/48] [shrink_caches+26/136] [try_to_free_pages+29/60] [kswapd_balance_pgdat+67/144] [kswapd_balance+22/44]
Feb 27 23:01:25 apollo kernel:    [kswapd+165/192] [kernel_thread+40/56]
Feb 27 23:01:25 apollo kernel:
Feb 27 23:01:25 apollo kernel: Code: 0f 0b b3 05 a1 c5 29 c0 89 f2 03 55 18 b8 71 f0 2c 5a 87 42


Feb 27 23:12:53 apollo kernel: ALSA seq_clientmgr.c:2100: seq unknown ioctl() 0xc0dc5351 (type='S', number=0x51)
Feb 27 23:12:54 apollo kernel: kernel BUG at slab.c:1459!
Feb 27 23:12:54 apollo kernel: invalid operand: 0000
Feb 27 23:12:54 apollo kernel: CPU:    0
Feb 27 23:12:54 apollo kernel: EIP:    0010:[kmem_cache_reap+413/1156]    Not tainted
Feb 27 23:12:54 apollo kernel: EFLAGS: 00010016
Feb 27 23:12:54 apollo kernel: eax: 5a2cf071   ebx: c4bb0000   ecx: 0000004f   edx: 00000000
Feb 27 23:12:54 apollo kernel: esi: c4bb03a8   edi: c4bb03cc   ebp: c1165060   esp: c29cfd94
Feb 27 23:12:54 apollo kernel: ds: 0018   es: 0018   ss: 0018
Feb 27 23:12:54 apollo kernel: Process httpd (pid: 819, threadinfo=c29ce000 task=c70e68a0)
Feb 27 23:12:54 apollo kernel: Stack: 00000020 000001d2 c030cd94 00000006 c01362d5 00000020 c4bb03ac c1165070
Feb 27 23:12:54 apollo kernel:        c03b0028 0000005a c7f8ad74 c7f8ac00 c29ce000 00000000 00000009 00000000
Feb 27 23:12:54 apollo kernel:        00000000 00000000 c0135442 00000006 000001d2 c030cd94 c030cd94 c030cd94
Feb 27 23:12:54 apollo kernel: Call Trace: [page_cache_release+45/48] [shrink_caches+26/136] [try_to_free_pages+29/60] [balance_classzone+102/484] [__alloc_pages+245/336]
Feb 27 23:12:54 apollo kernel:    [_alloc_pages+22/24] [shmem_getpage_locked+780/996] [shmem_getpage+71/144] [shmem_nopage+45/56] [do_no_page+120/568] [handle_mm_fault+108/272]
Feb 27 23:12:54 apollo kernel:    [do_page_fault+424/1237] [do_page_fault+0/1237] [update_wall_time+11/52] [smp_local_timer_interrupt+181/192] [bh_action+89/180] [tasklet_hi_action+102/160]
Feb 27 23:12:54 apollo kernel:    [do_softirq+125/236] [do_IRQ+281/296] [error_code+52/64]
Feb 27 23:12:54 apollo kernel:
Feb 27 23:12:54 apollo kernel: Code: 0f 0b b3 05 a1 c5 29 c0 89 f2 03 55 18 b8 71 f0 2c 5a 87 42
Feb 27 23:13:00 apollo kernel:  <4>nfsd: last server has exited

Feb 27 23:18:06 apollo kernel: PCI: Found IRQ 10 for device 00:0b.0
Feb 27 23:18:06 apollo kernel: ALSA cs4231_lib.c:991: cs4231: port = 0x534, id = 0xa
Feb 27 23:18:06 apollo kernel: ALSA cs4231_lib.c:997: CS4231: VERSION (I25) = 0x3
Feb 27 23:18:06 apollo kernel: ALSA cs4231_lib.c:343: cs4231_mce_down - auto calibration time out (1)
Feb 27 23:18:30 apollo PAM-unix2[690]: session started for user unknown, service xdm
Feb 27 23:20:46 apollo init: Switching to runlevel: 6
Feb 27 23:20:47 apollo kernel: ALSA seq_clientmgr.c:2100: seq unknown ioctl() 0xc0dc5351 (type='S', number=0x51)
Feb 27 23:20:49 apollo kernel: kernel BUG at slab.c:1459!
Feb 27 23:20:49 apollo kernel: invalid operand: 0000
Feb 27 23:20:49 apollo kernel: CPU:    0
Feb 27 23:20:49 apollo kernel: EIP:    0010:[kmem_cache_reap+413/1156]    Not tainted
Feb 27 23:20:49 apollo kernel: EFLAGS: 00010016
Feb 27 23:20:49 apollo kernel: eax: 5a2cf071   ebx: c4db4000   ecx: 00000051   edx: 00000000
Feb 27 23:20:49 apollo kernel: esi: c4db4380   edi: c4db43a4   ebp: c1165060   esp: c7f89f34
Feb 27 23:20:49 apollo kernel: ds: 0018   es: 0018   ss: 0018
Feb 27 23:20:49 apollo kernel: Process kswapd (pid: 5, threadinfo=c7f88000 task=c117f540)
Feb 27 23:20:49 apollo kernel: Stack: 00000020 000001d0 c030cd94 00000006 c01362d5 00000020 c4db4384 c1165070
Feb 27 23:20:49 apollo kernel:        c03b0028 00000073 c7f8ac9c c7f8ac00 c7f88000 00000000 00000007 00000000
Feb 27 23:20:49 apollo kernel:        00000000 00000000 c0135442 00000006 000001d0 c030cd94 00000000 c030cd94
Feb 27 23:20:49 apollo kernel: Call Trace: [page_cache_release+45/48] [shrink_caches+26/136] [try_to_free_pages+29/60] [kswapd_balance_pgdat+67/144] [kswapd_balance+22/44]
Feb 27 23:20:49 apollo kernel:    [kswapd+165/192] [kernel_thread+40/56]
Feb 27 23:20:49 apollo kernel:
Feb 27 23:20:49 apollo kernel: Code: 0f 0b b3 05 a1 c5 29 c0 89 f2 03 55 18 b8 71 f0 2c 5a 87 42


Feb 28 01:03:48 apollo init: Switching to runlevel: 6
Feb 28 01:03:50 apollo kernel: ALSA seq_clientmgr.c:2100: seq unknown ioctl() 0xc0dc5351 (type='S', number=0x51)
Feb 28 01:03:51 apollo kernel: kernel BUG at slab.c:1459!
Feb 28 01:03:51 apollo kernel: invalid operand: 0000
Feb 28 01:03:51 apollo kernel: CPU:    0
Feb 28 01:03:51 apollo kernel: EIP:    0010:[free_block+195/488]    Not tainted
Feb 28 01:03:51 apollo kernel: EFLAGS: 00010016
Feb 28 01:03:51 apollo kernel: eax: 5a2cf071   ebx: c66b7000   ecx: 0000000d   edx: 00000000
Feb 28 01:03:51 apollo kernel: esi: c66b73a8   edi: 0000004c   ebp: c1165060   esp: c379ff24
Feb 28 01:03:51 apollo kernel: ds: 0018   es: 0018   ss: 0018
Feb 28 01:03:51 apollo kernel: Process kdeinit (pid: 1313, threadinfo=c379e000 task=c4834ea0)
Feb 28 01:03:51 apollo kernel: Stack: c7f8ac00 000e2b40 c1165060 c5270fdc c5773cb4 00000020 c66b73ac 00000047
Feb 28 01:03:51 apollo kernel:        c7f8aedc c0133af3 c1165060 c7f8ae00 0000007e 00000000 c5270ff0 40af4c84
Feb 28 01:03:51 apollo kernel:        00000000 00000282 c5270fdc c014d375 c5270fdc c014d7f0 c5270fdc 00000004
Feb 28 01:03:51 apollo kernel: Call Trace: [kfree+291/336] [select_bits_free+9/16] [sys_select+1140/1156] [syscall_call+7/11]
Feb 28 01:03:51 apollo kernel:
Feb 28 01:03:51 apollo kernel: Code: 0f 0b b3 05 a1 c5 29 c0 89 f2 03 55 18 b8 71 f0 2c 5a 87 42
Feb 28 01:03:59 apollo kernel:  <4>nfsd: last server has exited

Feb 28 21:23:38 apollo kernel: PCI: Found IRQ 10 for device 00:0b.0
Feb 28 21:23:39 apollo kernel: ALSA cs4231_lib.c:991: cs4231: port = 0x534, id = 0xa
Feb 28 21:23:39 apollo kernel: ALSA cs4231_lib.c:997: CS4231: VERSION (I25) = 0x3
Feb 28 21:23:39 apollo kernel: ALSA cs4231_lib.c:343: cs4231_mce_down - auto calibration time out (1)
Feb 28 21:25:40 apollo PAM-unix2[690]: session started for user unknown, service xdm
Feb 28 21:27:40 apollo kernel: ALSA cs4236.c:578: CS4236+ soundcard not found or device busy
Feb 28 21:30:32 apollo init: Switching to runlevel: 6
Feb 28 21:30:34 apollo kernel: kernel BUG at slab.c:1459!
Feb 28 21:30:34 apollo kernel: invalid operand: 0000
Feb 28 21:30:34 apollo kernel: CPU:    0
Feb 28 21:30:34 apollo kernel: EIP:    0010:[kmem_cache_reap+413/1156]    Not tainted
Feb 28 21:30:34 apollo kernel: EFLAGS: 00010016
Feb 28 21:30:34 apollo kernel: eax: 5a2cf071   ebx: c5cf4000   ecx: 0000004e   edx: 00000000
Feb 28 21:30:34 apollo kernel: esi: c5cf43a8   edi: c5cf43cc   ebp: c1165060   esp: c482fd94
Feb 28 21:30:34 apollo kernel: ds: 0018   es: 0018   ss: 0018
Feb 28 21:30:34 apollo kernel: Process httpd (pid: 815, threadinfo=c482e000 task=c4c94120)
Feb 28 21:30:34 apollo kernel: Stack: 00000020 000001d2 c030cd94 00000006 00000000 00000020 c5cf43ac c1165070
Feb 28 21:30:34 apollo kernel:        c03b0028 00000056 c7f8ad04 c7f8ac00 c482e000 00000000 00000003 00000005
Feb 28 21:30:34 apollo kernel:        00000005 c1165490 c0135442 00000006 000001d2 c030cd94 c030cd94 c030cd94
Feb 28 21:30:34 apollo kernel: Call Trace: [shrink_caches+26/136] [try_to_free_pages+29/60] [balance_classzone+102/484] [__alloc_pages+245/336] [_alloc_pages+22/24]
Feb 28 21:30:34 apollo kernel:    [shmem_getpage_locked+780/996] [shmem_getpage+71/144] [shmem_nopage+45/56] [do_no_page+120/568] [handle_mm_fault+108/272] [do_page_fault+424/1237]
Feb 28 21:30:34 apollo kernel:    [do_page_fault+0/1237] [update_wall_time+11/52] [smp_local_timer_interrupt+181/192] [bh_action+89/180] [tasklet_hi_action+102/160] [do_softirq+125/236]
Feb 28 21:30:34 apollo kernel:    [do_IRQ+281/296] [error_code+52/64]
Feb 28 21:30:34 apollo kernel:
Feb 28 21:30:34 apollo kernel: Code: 0f 0b b3 05 a1 c5 29 c0 89 f2 03 55 18 b8 71 f0 2c 5a 87 42
Feb 28 21:30:41 apollo kernel:  <4>nfsd: last server has exited 

Feb 28 21:36:11 apollo kernel: ALSA cs4231_lib.c:991: cs4231: port = 0x534, id = 0xa
Feb 28 21:36:11 apollo kernel: ALSA cs4231_lib.c:997: CS4231: VERSION (I25) = 0x3
Feb 28 21:36:11 apollo kernel: ALSA cs4231_lib.c:343: cs4231_mce_down - auto calibration time out (1)
Feb 28 21:36:30 apollo PAM-unix2[690]: session started for user unknown, service xdm
Feb 28 21:40:37 apollo init: Switching to runlevel: 6
Feb 28 21:40:39 apollo kernel: ALSA seq_clientmgr.c:2100: seq unknown ioctl() 0xc0dc5351 (type='S', number=0x51)
Feb 28 21:40:40 apollo kernel: kernel BUG at slab.c:1459!
Feb 28 21:40:40 apollo kernel: invalid operand: 0000
Feb 28 21:40:40 apollo kernel: CPU:    0
Feb 28 21:40:40 apollo kernel: EIP:    0010:[kmem_cache_reap+413/1156]    Not tainted
Feb 28 21:40:40 apollo kernel: EFLAGS: 00010016
Feb 28 21:40:40 apollo kernel: eax: 5a2cf071   ebx: c4acf000   ecx: 0000004f   edx: 00000000
Feb 28 21:40:40 apollo kernel: esi: c4acf3a8   edi: c4acf3cc   ebp: c1165060   esp: c7f89f34
Feb 28 21:40:40 apollo kernel: ds: 0018   es: 0018   ss: 0018
Feb 28 21:40:40 apollo kernel: Process kswapd (pid: 5, threadinfo=c7f88000 task=c117f540)
Feb 28 21:40:40 apollo kernel: Stack: 00000020 000001d0 c030cd94 00000006 c01362d5 00000020 c4acf3ac c1165070
Feb 28 21:40:40 apollo kernel:        c03b0028 0000005e c7f8ae34 c7f8ac00 c7f88000 00000000 00000003 00000005
Feb 28 21:40:40 apollo kernel:        00000005 c1165490 c0135442 00000006 000001d0 c030cd94 00000000 c030cd94
Feb 28 21:40:40 apollo kernel: Call Trace: [page_cache_release+45/48] [shrink_caches+26/136] [try_to_free_pages+29/60] [kswapd_balance_pgdat+67/144] [kswapd_balance+22/44]
Feb 28 21:40:40 apollo kernel:    [kswapd+165/192] [kernel_thread+40/56]
Feb 28 21:40:40 apollo kernel:
Feb 28 21:40:40 apollo kernel: Code: 0f 0b b3 05 a1 c5 29 c0 89 f2 03 55 18 b8 71 f0 2c 5a 87 42
Feb 28 21:42:28 apollo kernel:  <6>SysRq : Show Memory
Feb 28 21:42:28 apollo kernel: Mem-info:
Feb 28 21:42:28 apollo kernel: Free pages:        1920kB (     0kB HighMem)
Feb 28 21:42:28 apollo kernel: Zone:DMA freepages:  1024kB min:   128kB low:   256kB high:   384kB
Feb 28 21:42:28 apollo kernel: Zone:Normal freepages:   896kB min:   892kB low:  1784kB high:  2676kB
Feb 28 21:42:28 apollo kernel: Zone:HighMem freepages:     0kB min:     0kB low:     0kB high:     0kB
Feb 28 21:42:28 apollo kernel: ( Active: 7742, inactive: 19669, free: 480 )
Feb 28 21:42:28 apollo kernel: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB 0*2048kB = 1024kB)
Feb 28 21:42:28 apollo kernel: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 896kB)
Feb 28 21:42:28 apollo kernel: = 0kB)
Feb 28 21:42:28 apollo kernel: Swap cache: add 7, delete 6, find 7/7, race 0+0
Feb 28 21:42:28 apollo kernel: Free swap:       136508kB
Feb 28 21:42:28 apollo kernel: 32764 pages of RAM
Feb 28 21:42:28 apollo kernel: 0 pages of HIGHMEM
Feb 28 21:42:28 apollo kernel: 1152 reserved pages
Feb 28 21:42:28 apollo kernel: 46375 pages shared
Feb 28 21:42:28 apollo kernel: 1 pages swap cached
Feb 28 21:42:28 apollo kernel: Buffer memory:     4584kB
Feb 28 21:42:28 apollo kernel:     CLEAN: 662 buffers, 1901 kbyte, 26 used (last=599), 0 locked, 0 dirty


--- WITH 2.5.5-pre1 ---
Feb 28 22:37:13 apollo kernel: ALSA cs4231_lib.c:990: cs4231: port = 0x534, id = 0xa
Feb 28 22:37:13 apollo kernel: ALSA cs4231_lib.c:996: CS4231: VERSION (I25) = 0x3
Feb 28 22:37:13 apollo kernel: ALSA cs4231_lib.c:342: cs4231_mce_down - auto calibration time out (1) 
Feb 28 22:37:35 apollo insmod: Note: /etc/modules.conf is more recent than /lib/modules/2.5.5-pre1/modules.dep
Feb 28 22:37:44 apollo modprobe: Note: /etc/modules.conf is more recent than /lib/modules/2.5.5-pre1/modules.dep
Feb 28 22:37:44 apollo modprobe: Note: /etc/modules.conf is more recent than /lib/modules/2.5.5-pre1/modules.dep
Feb 28 22:37:56 apollo init: Switching to runlevel: 6
Feb 28 22:37:58 apollo kernel: invalid operand: 0000
Feb 28 22:37:58 apollo kernel: CPU:    0
Feb 28 22:37:58 apollo kernel: EIP:    0010:[kmem_cache_alloc+325/612]    Not tainted
Feb 28 22:37:58 apollo kernel: EFLAGS: 00010016
Feb 28 22:37:58 apollo kernel: eax: 5a2cf071   ebx: c3161000   ecx: 00000041   edx: 00000000
Feb 28 22:37:58 apollo kernel: esi: c3161b28   edi: c3161b4c   ebp: c7ffb060   esp: c37e9da0
Feb 28 22:37:58 apollo kernel: ds: 0018   es: 0018   ss: 0018
Feb 28 22:37:58 apollo kernel: Process httpd (pid: 816, threadinfo=c37e8000 task=c4b1a8a0)
Feb 28 22:37:58 apollo kernel: Stack: 00000020 000001d2 c02f2a28 00000006 00000000 00000020 c3161b2c c7ffb070
Feb 28 22:37:58 apollo kernel:        c0396428 00000063 c7faad48 c7faac00 c37e8000 00000000 00000007 00000000
Feb 28 22:37:58 apollo kernel:        00000000 00000000 c0134a52 00000006 000001d2 c02f2a28 c02f2a28 c02f2a28
Feb 28 22:37:58 apollo kernel: Call Trace: [lru_cache_add+26/156] [__lru_cache_del+9/80] [shrink_cache+920/1148] [shrink_caches+50/128]
[shrink_cache+822/1148]
Feb 28 22:37:58 apollo kernel:    [get_swaphandle_info+103/156] [.text.lock.swapfile+19/404] [.text.lock.swapfile+137/404] [do_wp_page+203/500] [vmtruncate+5/364] [do_page_fault+164/1233]
Feb 28 22:37:58 apollo kernel:    [__verify_write+248/368] [mod_timer+143/272] [smp_spurious_interrupt+37/44] [do_softirq+67/236] [do_adjtimex+908/932] [schedule+496/996]
Feb 28 22:37:58 apollo kernel:    [divide_error+4/16]
Feb 28 22:37:58 apollo kernel:
Feb 28 22:37:58 apollo kernel: Code: 0f 0b 89 f2 03 55 18 b8 71 f0 2c 5a 87 42 fc 3d a5 c2 0f 17
Feb 28 22:38:05 apollo kernel:  <4>nfsd: last server has exited
--- END 2.5.5-pre1 ---

Feb 28 23:04:58 apollo kernel: ALSA cs4231_lib.c:991: cs4231: port = 0x534, id = 0xa
Feb 28 23:04:58 apollo kernel: ALSA cs4231_lib.c:997: CS4231: VERSION (I25) = 0x3
Feb 28 23:04:58 apollo kernel: ALSA cs4231_lib.c:343: cs4231_mce_down - auto calibration time out (1)
Feb 28 23:07:23 apollo init: Switching to runlevel: 6
Feb 28 23:07:25 apollo kernel: kernel BUG at slab.c:1459!
Feb 28 23:07:25 apollo kernel: invalid operand: 0000
Feb 28 23:07:25 apollo kernel: CPU:    0
Feb 28 23:07:25 apollo kernel: EIP:    0010:[kmem_cache_reap+413/1156]    Not tainted
Feb 28 23:07:25 apollo kernel: EFLAGS: 00010016
Feb 28 23:07:25 apollo kernel: eax: 5a2cf071   ebx: c66e7000   ecx: 00000041   edx: 00000000
Feb 28 23:07:25 apollo kernel: esi: c66e7cb8   edi: c66e7cdc   ebp: c1165060   esp: c7f89f34
Feb 28 23:07:25 apollo kernel: ds: 0018   es: 0018   ss: 0018
Feb 28 23:07:25 apollo kernel: Process kswapd (pid: 5, threadinfo=c7f88000 task=c117f540)
Feb 28 23:07:25 apollo kernel: Stack: 00000020 000001d0 c030cd94 00000006 c01362d5 00000020 c66e7cbc c1165070
Feb 28 23:07:25 apollo kernel:        c03b0028 0000002a c7f8ad38 c7f8ac00 c7f88000 00000000 00000003 00000002
Feb 28 23:07:25 apollo kernel:        00000002 c11656a8 c0135442 00000006 000001d0 c030cd94 00000000 c030cd94
Feb 28 23:07:25 apollo kernel: Call Trace: [page_cache_release+45/48] [shrink_caches+26/136] [try_to_free_pages+29/60] [kswapd_balance_pgdat+67/144] [kswapd_balance+22/44]
Feb 28 23:07:25 apollo kernel:    [kswapd+165/192] [kernel_thread+40/56]
Feb 28 23:07:25 apollo kernel:
Feb 28 23:07:25 apollo kernel: Code: 0f 0b b3 05 a1 c5 29 c0 89 f2 03 55 18 b8 71 f0 2c 5a 87 42
Feb 28 23:07:46 apollo kernel:  <6>SysRq : Emergency Sync

Feb 28 23:11:10 apollo kernel: ALSA cs4231_lib.c:991: cs4231: port = 0x534, id = 0xa
Feb 28 23:11:10 apollo kernel: ALSA cs4231_lib.c:997: CS4231: VERSION (I25) = 0x3
Feb 28 23:11:10 apollo kernel: ALSA cs4231_lib.c:343: cs4231_mce_down - auto calibration time out (1)
Feb 28 23:11:38 apollo PAM-unix2[693]: session started for user unknown, service xdm
Feb 28 23:13:40 apollo init: Switching to runlevel: 6
Feb 28 23:13:42 apollo kernel: kernel BUG at slab.c:1459!
Feb 28 23:13:42 apollo kernel: invalid operand: 0000
Feb 28 23:13:42 apollo kernel: CPU:    0
Feb 28 23:13:42 apollo kernel: EIP:    0010:[kmem_cache_reap+413/1156]    Not tainted
Feb 28 23:13:42 apollo kernel: EFLAGS: 00010016
Feb 28 23:13:42 apollo kernel: eax: 5a2cf071   ebx: c66e6000   ecx: 00000041   edx: 00000000
Feb 28 23:13:42 apollo kernel: esi: c66e6cb8   edi: c66e6cdc   ebp: c1165060   esp: c7f89f34
Feb 28 23:13:42 apollo kernel: ds: 0018   es: 0018   ss: 0018
Feb 28 23:13:42 apollo kernel: Process kswapd (pid: 5, threadinfo=c7f88000 task=c117f540)
Feb 28 23:13:42 apollo kernel: Stack: 00000020 000001d0 c030cd94 00000006 c01362d5 00000020 c66e6cbc c1165070
Feb 28 23:13:42 apollo kernel:        c03b0028 0000002a c7f8ad28 c7f8ac00 c7f88000 00000000 00000003 00000002
Feb 28 23:13:42 apollo kernel:        00000002 c11656a8 c0135442 00000006 000001d0 c030cd94 00000000 c030cd94
Feb 28 23:13:42 apollo kernel: Call Trace: [page_cache_release+45/48] [shrink_caches+26/136] [try_to_free_pages+29/60] [kswapd_balance_pgdat+67/144] [kswapd_balance+22/44]
Feb 28 23:13:42 apollo kernel:    [kswapd+165/192] [kernel_thread+40/56]
Feb 28 23:13:42 apollo kernel:
Feb 28 23:13:42 apollo kernel: Code: 0f 0b b3 05 a1 c5 29 c0 89 f2 03 55 18 b8 71 f0 2c 5a 87 42
Feb 28 23:14:20 apollo kernel:  <6>SysRq : Emergency Sync



--- .config
#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
CONFIG_MK6=y
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM4G_HIGHPTE is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM64G_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
# CONFIG_MULTIQUAD is not set
CONFIG_HAVE_DEC_LOCK=y

#
# General options
#
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_LIMIT is not set
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_MARK is not set
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
CONFIG_IP_NF_MATCH_STATE=m
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=m

#
#   IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=m
# CONFIG_IP6_NF_MATCH_LIMIT is not set
# CONFIG_IP6_NF_MATCH_MAC is not set
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC_ADMA is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=m
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_DE2104X is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=m
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=m
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_NEW_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=y
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_PCMCIA_PCNET=y
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_ARCNET_COM20020_CS is not set
# CONFIG_PCMCIA_IBMTR is not set
# CONFIG_PCMCIA_XIRCOM is not set
# CONFIG_PCMCIA_XIRTULIP is not set
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=y
# CONFIG_AIRONET4500_CS is not set

#
# Amateur Radio support
#
CONFIG_HAMRADIO=y
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
# CONFIG_NETROM is not set
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
# CONFIG_6PACK is not set
# CONFIG_BPQETHER is not set
# CONFIG_DMASCC is not set
# CONFIG_SCC is not set
# CONFIG_BAYCOM_SER_FDX is not set
CONFIG_BAYCOM_SER_HDX=m
# CONFIG_BAYCOM_PAR is not set
# CONFIG_BAYCOM_EPP is not set
CONFIG_SOUNDMODEM=m
CONFIG_SOUNDMODEM_SBC=y
CONFIG_SOUNDMODEM_WSS=y
CONFIG_SOUNDMODEM_AFSK1200=y
# CONFIG_SOUNDMODEM_AFSK2400_7 is not set
# CONFIG_SOUNDMODEM_AFSK2400_8 is not set
# CONFIG_SOUNDMODEM_AFSK2666 is not set
# CONFIG_SOUNDMODEM_HAPN4800 is not set
# CONFIG_SOUNDMODEM_PSK4800 is not set
# CONFIG_SOUNDMODEM_FSK9600 is not set
# CONFIG_YAM is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_GAMEPORT_PCIGAME is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE_USB is not set
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
CONFIG_DRM_MGA=y

#
# PCMCIA character devices
#
# CONFIG_PCMCIA_SERIAL_CS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=m
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
# CONFIG_SND_RTCTIMER is not set
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_MEMORY is not set
# CONFIG_SND_DEBUG_FULL is not set
CONFIG_SND_DEBUG_DETECT=y

#
# Generic devices
#
CONFIG_SND_DUMMY=m
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
CONFIG_SND_AD1848=m
CONFIG_SND_CS4231=m
CONFIG_SND_CS4232=m
CONFIG_SND_CS4236=m
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
CONFIG_SND_SB16=m
CONFIG_SND_SBAWE=m
CONFIG_SND_SB16_CSP=y
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT0197H is not set
CONFIG_SND_OPL3SA2=m
# CONFIG_SND_SGALAXY is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
CONFIG_SND_CS46XX=m
# CONFIG_SND_CS46XX_ACCEPT_VALID is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA686 is not set
# CONFIG_SND_VIA8233 is not set

#
# USB support
#
# CONFIG_USB is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_HID is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
---



