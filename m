Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268964AbUHME1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268964AbUHME1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 00:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268965AbUHME1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 00:27:53 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:8928 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S268964AbUHME13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 00:27:29 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Fri, 13 Aug 2004 00:27:24 -0400
User-Agent: KMail/1.6.82
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408110047.32611.gene.heskett@verizon.net> <Pine.LNX.4.58.0408102159000.1839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408102159000.1839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408130027.24470.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.57.32] at Thu, 12 Aug 2004 23:27:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 August 2004 00:59, Linus Torvalds wrote:
>I wrote:
>> Notably, the output of "/proc/meminfo" and "/proc/slabinfo". "ps
>> axm" helps too.
>
>That should be "ps axv" of course. Just shows what a retard I am.
>
>		Linus
Acck!  I just logged an Oops:
Aug 13 00:02:00 coyote kernel: kjournald starting.  Commit interval 5 seconds
Aug 13 00:02:00 coyote kernel: EXT3 FS on hdb3, internal journal
Aug 13 00:02:00 coyote kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 13 00:05:09 coyote kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Aug 13 00:05:09 coyote kernel:  printing eip:
Aug 13 00:05:09 coyote kernel: c014e0dc
Aug 13 00:05:09 coyote kernel: *pde = 00000000
Aug 13 00:05:09 coyote kernel: Oops: 0002 [#1]
Aug 13 00:05:09 coyote kernel: PREEMPT
Aug 13 00:05:09 coyote kernel: Modules linked in: eeprom snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd forcedeth sg
Aug 13 00:05:09 coyote kernel: CPU:    0
Aug 13 00:05:09 coyote kernel: EIP:    0060:[<c014e0dc>]    Not tainted
Aug 13 00:05:09 coyote kernel: EFLAGS: 00010246   (2.6.8-rc4)
Aug 13 00:05:09 coyote kernel: EIP is at remove_inode_buffers+0x4c/0x90
Aug 13 00:05:09 coyote kernel: eax: 00000000   ebx: d7ff68b4   ecx: d7ffffb4   edx: 00000000
Aug 13 00:05:09 coyote kernel: esi: d7ff67e0   edi: 00000001   ebp: c198bed8   esp: c198bec8
Aug 13 00:05:09 coyote kernel: ds: 007b   es: 007b   ss: 0068
Aug 13 00:05:09 coyote kernel: Process kswapd0 (pid: 66, threadinfo=c198b000 task=c1978050)
Aug 13 00:05:09 coyote kernel: Stack: d7ff67e0 d7ff67e8 d7ff67e0 0000001e c198bf04 c0165242 d7ff67e0 c198b000
Aug 13 00:05:09 coyote kernel:        00000000 0000001e d7ff6988 ed3be928 00000080 00000000 c198b000 c198bf10
Aug 13 00:05:09 coyote kernel:        c016532f 00000080 c198bf44 c013a32c 00000080 000000d0 0002cc1d 013b0a00
Aug 13 00:05:09 coyote kernel: Call Trace:
Aug 13 00:05:09 coyote kernel:  [<c010476f>] show_stack+0x7f/0xa0
Aug 13 00:05:09 coyote kernel:  [<c0104908>] show_registers+0x158/0x1b0
Aug 13 00:05:09 coyote kernel:  [<c0104a89>] die+0x89/0x100
Aug 13 00:05:09 coyote kernel:  [<c0111725>] do_page_fault+0x1f5/0x553
Aug 13 00:05:09 coyote kernel:  [<c01043d9>] error_code+0x2d/0x38
Aug 13 00:05:09 coyote kernel:  [<c0165242>] prune_icache+0x142/0x1f0
Aug 13 00:05:09 coyote kernel:  [<c016532f>] shrink_icache_memory+0x3f/0x50
Aug 13 00:05:09 coyote kernel:  [<c013a32c>] shrink_slab+0x14c/0x190
Aug 13 00:05:09 coyote kernel:  [<c013b639>] balance_pgdat+0x1a9/0x1f0
Aug 13 00:05:09 coyote kernel:  [<c013b73f>] kswapd+0xbf/0xd0
Aug 13 00:05:09 coyote kernel:  [<c0102471>] kernel_thread_helper+0x5/0x14
Aug 13 00:05:09 coyote kernel: Code: 89 50 04 89 02 89 49 04 89 09 8b 03 39 d8 89 c1 75 e2 b8 00
Aug 13 00:05:09 coyote kernel:  <6>note: kswapd0[66] exited with preempt_count 1

The first 3 entries are from a nightly run of rsync, which mounts a
normally unmounted partition for the duration of its run.

Now lets see if I can get meminfo and slabinfo
meminfo:
root@coyote themes]# cat /proc/meminfo
MemTotal:      1035844 kB
MemFree:        152884 kB
Buffers:          4896 kB
Cached:          41276 kB
SwapCached:      36740 kB
Active:         131792 kB
Inactive:        11792 kB
HighTotal:      131008 kB
HighFree:        52640 kB
LowTotal:       904836 kB
LowFree:        100244 kB
SwapTotal:     3857104 kB
SwapFree:      3731720 kB
Dirty:              16 kB
Writeback:           0 kB
Mapped:         121068 kB
Slab:           728876 kB
Committed_AS:   348500 kB
PageTables:       3480 kB
VmallocTotal:   114680 kB
VmallocUsed:     19644 kB
VmallocChunk:    94932 kB

slabinfo:
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
unix_sock            171    190    384   10    1 : tunables   54   27    0 : slabdata     19     19      0
tcp_tw_bucket          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket       19    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_hash           10    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache          17     30    256   15    1 : tunables  120   60    0 : slabdata      2      2      0
arp_cache              4     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    480    8    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               2      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock              31     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
flow_cache             0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
mqueue_inode_cache      1      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
udf_inode_cache        0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
smb_request            0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
smb_inode_cache        2     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
isofs_inode_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache        1     11    352   11    1 : tunables   54   27    0 : slabdata      1      1      0
ext2_inode_cache       0      0    416    9    1 : tunables   54   27    0 : slabdata      0      0      0
journal_handle         8    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head         889   2025     48   81    1 : tunables  120   60    0 : slabdata     25     25      0
revoke_table          14    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache  1373751 1373751    416    9    1 : tunables   54   27    0 : slabdata 152639 152639      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache        172    370     20  185    1 : tunables  120   60    0 : slabdata      2      2      0
file_lock_cache       43     43     92   43    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache      5     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              7    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    0 : slabdata      2      2      0
cfq_pool              72    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool              35    107     36  107    1 : tunables  120   60    0 : slabdata      1      1      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                 0      0     60   65    1 : tunables  120   60    0 : slabdata      0      0      0
blkdev_ioc            91    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          12     18    448    9    1 : tunables   54   27    0 : slabdata      2      2      0
blkdev_requests       23     78    152   26    1 : tunables  120   60    0 : slabdata      3      3      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             257    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             294    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  294    366     64   61    1 : tunables  120   60    0 : slabdata      6      6      0
sock_inode_cache     208    231    352   11    1 : tunables   54   27    0 : slabdata     21     21      0
skbuff_head_cache    225    625    160   25    1 : tunables  120   60    0 : slabdata     25     25      0
sock                   3     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     353    504    320   12    1 : tunables   54   27    0 : slabdata     42     42      0
sigqueue              84    108    148   27    1 : tunables  120   60    0 : slabdata      4      4      0
radix_tree_node     1590   4046    276   14    1 : tunables   54   27    0 : slabdata    289    289      0
bdev_cache            12     18    416    9    1 : tunables   54   27    0 : slabdata      2      2      0
mnt_cache             26     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         2179   2198    288   14    1 : tunables   54   27    0 : slabdata    157    157      0
dentry_cache      564066 764232    140   28    1 : tunables  120   60    0 : slabdata  27294  27294      0
filp                2045   2225    160   25    1 : tunables  120   60    0 : slabdata     89     89      0
names_cache           19     19   4096    1    1 : tunables   24   12    0 : slabdata     19     19      0
idr_layer_cache       80     87    136   29    1 : tunables  120   60    0 : slabdata      3      3      0
buffer_head         1467   9477     48   81    1 : tunables  120   60    0 : slabdata    117    117      0
mm_struct             98     98    512    7    1 : tunables   54   27    0 : slabdata     14     14      0
vm_area_struct      7667   8272     84   47    1 : tunables  120   60    0 : slabdata    176    176      0
fs_cache             102    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           99     99    416    9    1 : tunables   54   27    0 : slabdata     11     11      0
signal_cache         122    123     96   41    1 : tunables  120   60    0 : slabdata      3      3      0
sighand_cache        105    105   1312    3    1 : tunables   24   12    0 : slabdata     35     35      0
task_struct          115    115   1424    5    2 : tunables   24   12    0 : slabdata     23     23      0
anon_vma            1839   2035      8  407    1 : tunables  120   60    0 : slabdata      5      5      0
pgd                   89     89   4096    1    1 : tunables   24   12    0 : slabdata     89     89      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             8      8  16384    1    4 : tunables    8    4    0 : slabdata      8      8      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             10     10   8192    1    2 : tunables    8    4    0 : slabdata     10     10      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096            190    190   4096    1    1 : tunables   24   12    0 : slabdata    190    190      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            170    192   2048    2    1 : tunables   24   12    0 : slabdata     96     96      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            132    132   1024    4    1 : tunables   54   27    0 : slabdata     33     33      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             184    448    512    8    1 : tunables   54   27    0 : slabdata     56     56      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             180    435    256   15    1 : tunables  120   60    0 : slabdata     29     29      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             100    100    192   20    1 : tunables  120   60    0 : slabdata      5      5      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            1176   1271    128   31    1 : tunables  120   60    0 : slabdata     41     41      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             1290   2440     64   61    1 : tunables  120   60    0 : slabdata     40     40      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             1368   1428     32  119    1 : tunables  120   60    0 : slabdata     12     12      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

dmesg >/foo:
Linux version 2.6.8-rc4 (root@coyote.coyote.den) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #3 Wed Aug 11 04:58:21 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f7220
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff7dc0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Kernel command line: ro root=/dev/hda7 elevator=cfq
Initializing CPU#0
CPU 0 irqstacks, hard=c0408000 soft=c0407000
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2088.428 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035184k/1048512k available (2080k kernel code, 12424k reserved, 863k data, 140k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4128.76 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
CPU: AMD Athlon(tm) XP 2800+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4c0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf60, dseg 0xf0000
pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: match found with the PnP device '00:08' and the driver 'system'
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
PCI: Using IRQ router default [10de/01e0] at 0000:00:00.0
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=200.00 Mhz, System=166.00 MHz
radeonfb: Monitor 1 type CRT found
radeonfb: Monitor 2 type no found
radeonfb: ATI Radeon Yd  DDR SGRAM 128 MB
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
highmem bounce pool size: 64 pages
udf: registering filesystem
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xc0000000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 SE]
ipmi message handler version v32
ipmi device interface version v32
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:0b' and the driver 'serial'
pnp: match found with the PnP device '00:0f' and the driver 'serial'
pnp: the driver 'parport_pc' has been registered
pnp: match found with the PnP device '00:0d' and the driver 'parport_pc'
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
Using cfq io scheduler
Floppy drive(s): fd0 is 1.44M, fd1 is 360K PC
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y120P0, ATA DISK drive
hdb: Maxtor 54610H6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON DVDRW LDW-451S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hdb: max request size: 128KiB
hdb: 90045648 sectors (46103 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hdb: hdb1 hdb2 hdb3 hdb4
hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 5, pci mem f985b000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 12, pci mem f985d000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 11, pci mem f985f000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.11
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c /dev entries driver
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
ohci_hcd 0000:00:02.0: wakeup
ohci_hcd 0000:00:02.1: wakeup
usb 2-1: new full speed USB device using address 2
usb 2-2: new low speed USB device using address 3
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:02.0-2
usb 3-1: new full speed USB device using address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
usb 3-2: new full speed USB device using address 3
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 4 ports detected
usb 3-3: new full speed USB device using address 4
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 0 alt 0 proto 2 vid 0x04B8 pid 0x0005
usb 3-2.3: new full speed USB device using address 5
EXT3 FS on hda7, internal journal
Adding 3857104k swap on /dev/hdb4.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xf9a39000, 00:50:ba:5d:eb:7d, IRQ 12
eth0:  Identified 8139 chip type 'RTL-8139C'
forcedeth: Unknown parameter `mem'
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.28.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth1: forcedeth.c: subsystem: 01565:2301 bound to 0000:00:04.0
forcedeth: Unknown parameter `mem'
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.28.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 01565:2301 bound to 0000:00:04.0
eth0: no link during initialization.
eth0: link up.
eth0: Promiscuous mode enabled.
device eth0 entered promiscuous mode
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49436 usecs
intel8x0: clocking to 47459
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c014e0dc
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: eeprom snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd forcedeth sg
CPU:    0
EIP:    0060:[<c014e0dc>]    Not tainted
EFLAGS: 00010246   (2.6.8-rc4) 
EIP is at remove_inode_buffers+0x4c/0x90
eax: 00000000   ebx: d7ff68b4   ecx: d7ffffb4   edx: 00000000
esi: d7ff67e0   edi: 00000001   ebp: c198bed8   esp: c198bec8
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 66, threadinfo=c198b000 task=c1978050)
Stack: d7ff67e0 d7ff67e8 d7ff67e0 0000001e c198bf04 c0165242 d7ff67e0 c198b000 
       00000000 0000001e d7ff6988 ed3be928 00000080 00000000 c198b000 c198bf10 
       c016532f 00000080 c198bf44 c013a32c 00000080 000000d0 0002cc1d 013b0a00 
Call Trace:
 [<c010476f>] show_stack+0x7f/0xa0
 [<c0104908>] show_registers+0x158/0x1b0
 [<c0104a89>] die+0x89/0x100
 [<c0111725>] do_page_fault+0x1f5/0x553
 [<c01043d9>] error_code+0x2d/0x38
 [<c0165242>] prune_icache+0x142/0x1f0
 [<c016532f>] shrink_icache_memory+0x3f/0x50
 [<c013a32c>] shrink_slab+0x14c/0x190
 [<c013b639>] balance_pgdat+0x1a9/0x1f0
 [<c013b73f>] kswapd+0xbf/0xd0
 [<c0102471>] kernel_thread_helper+0x5/0x14
Code: 89 50 04 89 02 89 49 04 89 09 8b 03 39 d8 89 c1 75 e2 b8 00 
 <6>note: kswapd0[66] exited with preempt_count 1

And a 'ps axv':
  PID TTY      STAT   TIME  MAJFL   TRS   DRS  RSS %MEM COMMAND
    1 ?        S      0:01     13    31  1440  288  0.0 init [3]  
    2 ?        SWN    0:00      0     0     0    0  0.0 [ksoftirqd/0]
    3 ?        SW<    0:00      0     0     0    0  0.0 [events/0]
    4 ?        SW<    0:00      0     0     0    0  0.0 [khelper]
   21 ?        SW<    0:00      0     0     0    0  0.0 [kblockd/0]
   22 ?        SW     0:00      0     0     0    0  0.0 [khubd]
   62 ?        SW     0:00      0     0     0    0  0.0 [kapmd]
   64 ?        SW     0:00      0     0     0    0  0.0 [pdflush]
   65 ?        SW     0:00      0     0     0    0  0.0 [pdflush]
   67 ?        SW<    0:00      0     0     0    0  0.0 [aio/0]
  194 ?        SW     0:00      0     0     0    0  0.0 [kseriod]
  231 ?        SW     0:01      0     0     0    0  0.0 [kjournald]
 1419 ?        SW     0:00      0     0     0    0  0.0 [kjournald]
 1420 ?        SW     0:00      0     0     0    0  0.0 [kjournald]
 1421 ?        SW     0:00      0     0     0    0  0.0 [kjournald]
 1422 ?        SW     0:01      0     0     0    0  0.0 [kjournald]
 1423 ?        SW     0:00      0     0     0    0  0.0 [kjournald]
 1874 ?        S      0:00      5    27  1432  308  0.0 syslogd -m 0
 1878 ?        S      0:00      7    20  1383  316  0.0 klogd -x
 1889 ?        S      0:00      4    27  1508  272  0.0 portmap
 1955 ?        S      0:00      9   149  2918  376  0.0 arpwatch -u pcap -e root -s root (Arpwatch)
 1964 ?        S      0:00     34   237  8886  920  0.0 cupsd
 2092 ?        S      0:00      0   262  3385  440  0.0 /usr/sbin/sshd
 2107 ?        S      0:00      1   143  1872  356  0.0 xinetd -stayalive -pidfile /var/run/xinetd.pid
 2129 ?        S      0:00      1   690  6357 1948  0.1 sendmail: accepting connections
 2140 ?        S      0:00      0   690  5433 1544  0.1 sendmail: Queue runner@01:00:00 for /var/spool/clientmqueue
 2150 ?        S      0:00      0    78  1521  324  0.0 gpm -m /dev/input/mice -t imps2
 2162 ?        S      0:00     34   250 22985 5564  0.5 /usr/sbin/httpd
 2215 ?        S      0:00      0   133  1758  264  0.0 /usr/sbin/cannaserver -syslog -u bin
 2227 ?        S      0:00      0    23  1488  332  0.0 crond
 2259 ?        S      0:00      1   250 22985 5452  0.5 /usr/sbin/httpd
 2260 ?        S      0:00      1   250 22985 5452  0.5 /usr/sbin/httpd
 2261 ?        S      0:00      1   250 22985 5452  0.5 /usr/sbin/httpd
 2262 ?        S      0:00      1   250 22985 5452  0.5 /usr/sbin/httpd
 2263 ?        S      0:00      1   250 22985 5452  0.5 /usr/sbin/httpd
 2264 ?        S      0:00      1   250 22985 5452  0.5 /usr/sbin/httpd
 2265 ?        S      0:00      1   250 22985 5452  0.5 /usr/sbin/httpd
 2266 ?        S      0:00      1   250 22985 5452  0.5 /usr/sbin/httpd
 2298 ?        S      0:02     87    72  7675 2936  0.2 xfs -droppriv -daemon
 2307 ?        S      0:00      4  2727  7584 1584  0.1 smbd -D
 2311 ?        S      0:00      3   868  7183 1044  0.1 nmbd -D
 2347 ?        S      0:00      0    15  1484  320  0.0 /usr/sbin/atd
 2364 ?        S      0:00      0   230  1629  508  0.0 dbus-daemon-1 --system
 2377 ttyS0    S      2:10      5   153  1810  756  0.0 /usr/local/bulldog/upsd
 2482 ?        S      0:00      0   554  3797  696  0.0 /bin/sh /root/bin/setibatch -run
 2569 ?        S      0:00      4    17  2594  424  0.0 login -- root     
 2570 tty2     S      0:00      0     8  1375  236  0.0 /sbin/mingetty tty2
 2571 tty3     S      0:00      0     8  1375  236  0.0 /sbin/mingetty tty3
 2572 tty4     S      0:00      0     8  1375  236  0.0 /sbin/mingetty tty4
 2573 tty5     S      0:00      0     8  1375  236  0.0 /sbin/mingetty tty5
 2574 tty6     S      0:00      0     8  1375  236  0.0 /sbin/mingetty tty6
 2725 tty1     S      0:00      1   554  3801  372  0.0 -bash
 2757 tty1     S      0:00      1   554  3741  276  0.0 /bin/sh /usr/X11R6/bin/startx
 2768 tty1     S      0:00      4     8  2195  284  0.0 xinit /etc/X11/xinit/xinitrc --
 2769 ?        S<    36:22    975  1498 186685 26996  2.6 X :0
 2783 tty1     S      0:00      2   554  3745  296  0.0 /bin/sh /root/kde3.3-beta2/bin/startkde
 2802 ?        S      0:00      0    55  3252  280  0.0 ssh-agent /etc/X11/xinit/Xclients
 2844 ?        S      0:00     14    34 24313 2724  0.2 kdeinit: Running...      
 2847 ?        S      0:00     18    34 23533 2280  0.2 kdeinit: dcopserver --nosid
 2849 ?        S      0:00     47    34 27793 3504  0.3 kdeinit: klauncher       
 2852 ?        S      0:11     69    34 28977 4812  0.4 kdeinit: kded            
 2853 ?        S      0:18     62   135  4160 2316  0.2 fam
 2861 ?        S      0:04     28    34 27033 4244  0.4 kdeinit: kxkb            
 2869 ?        S      1:16    159   154 20441 6680  0.6 artsd -F 11 -S 4096 -a alsa -s 15 -m artsmessage -c drkonqi -l 3 -f
 2871 ?        S      0:04     33    34 33453 6632  0.6 kdeinit: knotify         
 2873 tty1     S      0:00      7     1 20546 4508  0.4 ksmserver
 2874 ?        S      0:13     58    34 36565 5776  0.5 kdeinit: kwin -session 11c0a80103000104545060000000016110000_1092106762_766963
 2877 ?        S      0:03     12    34 25225 4160  0.4 kdeinit: khotkeys        
 2878 ?        S      0:23     99    34 28225 6604  0.6 kdeinit: kdesktop        
 2885 ?        S      0:47    152    34 45721 8400  0.8 kdeinit: kicker          
 2888 ?        S      0:03     53    34 42293 5768  0.5 kdeinit: klipper         
 2893 ?        S      0:15     43    61 28138 6068  0.5 korgac --miniicon korganizer
 2894 ?        S      0:05     54   830 28705 6176  0.5 kgpg -session 11c0a84703000109133389800000023980007_1092106762_470713
 2897 ?        S      0:05     44   240 28987 5196  0.5 knotes -session 11c0a84703000107107498500000013490017_1092106762_471216
 2899 ?        S      0:11     33    34 28829 5200  0.5 kdeinit: kmix -session 11c0a84703000109118722300000023870010_1092106762_471781
 2900 ?        S      0:04     95    34 29497 5996  0.5 kdeinit: konsole -session 11c0a84703000109146439400000023670008_1092106762_472128 -name Qt-subapplication
 2904 pts/1    S      0:00      0   554  3801  368  0.0 /bin/bash
 2908 ?        S      1:21    144   590 34129 4292  0.4 /usr/bin/gkrellm --sm-client-id 11c0a84703000109197323200000021320011
 2922 ?        S      7:24   1138    11 90820 39460  3.8 kmail -session 11c0a84703000109193895800000021320008_1092106762_468128
 2924 ?        S      0:46     15  1060  4947 1964  0.1 /usr/local/bulldog/monitor
 2927 ?        S      0:00      2    96 25219 2576  0.2 kalarmd --login
 2946 pts/1    S      0:00      0    33  3934  264  0.0 tail -f /var/log/messages
 2948 ?        S      3:25     34    34 29369 5664  0.5 kdeinit: konsole         
 2949 pts/2    S      0:00      1   554  3801  368  0.0 /bin/bash
 2967 pts/2    S      4:47      1    47  1776  668  0.0 top
 2976 ?        S      0:14     88    34 34297 6204  0.5 kdeinit: konsole         
 2977 pts/3    S      0:00      8   554  3805  880  0.0 /bin/bash
14824 ?        S      0:04     56    34 28885 5824  0.5 kdeinit: kio_uiserver    
32416 ?        S      0:00      0   141  1566  748  0.0 /usr/sbin/smartd
14706 ?        S      0:00      0    37  2482  700  0.0 /usr/bin/esd -terminate -nobeeps -as 2 -spawnfd 17
19677 ?        S      0:00     24    34 27993 4084  0.3 kdeinit: kio_file file /tmp/ksocket-root/klauncher4bqXZb.slave-socket /tmp/ksocket-root/kioexecyNpOWa.slave-socket
20320 ?        S      0:00      1    23  1492  380  0.0 CROND
20321 ?        Z      0:00      0     0     0    0  0.0 [night-switch] <defunct>
20333 ttyS1    S      0:00      5    44  1567  524  0.0 heyu_relay ck
20335 ?        S      0:00      1   690  5449 1812  0.1 /usr/sbin/sendmail -FCronDaemon -i -odi -oem root@coyote.coyote.den
20339 ?        S      0:04      1    44  1571  480  0.0 heyu monitor
20353 ?        S      0:00      0    19  1392  368  0.0 /usr/local/bin/xtend -f /etc/.xtendrc
20807 ?        S      0:00      0   627  5232 1380  0.1 /sbin/mount.smbfs //gene.coyote.den/public /mnt/gene -o rw username root password XXXXXXXXX
20809 ?        SW     0:00      0     0     0    0  0.0 [smbiod]
20812 ?        S      0:00      1   627  5180 1308  0.1 /sbin/mount.smbfs //gene.coyote.den/dlds /mnt/dlds -o rw username root password XXXXXXXXX
 4848 ?        RN    40:32     18   131 16596 14448  1.3 /usr/local/bin/setiathome -stop_after_process -nice 19
 5157 ?        S      0:00      0    23  1488  396  0.0 CROND
 5158 ?        S      0:00      3   554  1449  736  0.0 /bin/sh /root/bin/backup-me-nightly
 5160 ?        SW     0:00      0     0     0    0  0.0 [kjournald]
 5324 ?        D      0:01      6    46  1377  356  0.0 umount /mnt/hdb3
 5418 ?        S      0:00     28    34 51109 7512  0.7 kdeinit: kio_pop3 pop3 /tmp/ksocket-root/klauncher4bqXZb.slave-socket /tmp/ksocket-root/kmailhxI3Ga.slave-socket
 5532 pts/3    R      0:00      0    64  2143  576  0.0 ps axv

The system is still up, and I'll probably leave it till the rsync run is done,
maybe another 30 minutes if it stays up.  Humm, its not running now according
to top or a ps, but the partition /dev/hdb3 is still mounted according to 
/etc/mtab.  So I assume its safe to reboot if rsync isn't alive yet.  I presume
it will self-destruct eventually if kswapd isn't on duty.

Is this enough for an autopsy?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
