Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWJQOxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWJQOxi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 10:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWJQOxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 10:53:38 -0400
Received: from web57803.mail.re3.yahoo.com ([68.142.236.81]:41328 "HELO
	web57803.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1751106AbWJQOxh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 10:53:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5aR7cpUvI26f3IJy7qrDe0XrJeTCS6rSdsCcp3lUJTVcPGE2iHAB4nT42nCwWcEu0CECrXe43z1BOBegj0ZpHrkSlDh97r5UMx56rIygqnypcY36Pz/Vm5PfKy4v64dko30+XHUGEPSglQ37VvoVbKPEkUpScU8T5iTmuW7QNpE=  ;
Message-ID: <20061017145336.65223.qmail@web57803.mail.re3.yahoo.com>
Date: Tue, 17 Oct 2006 07:53:35 -0700 (PDT)
From: John Philips <johnphilips42@yahoo.com>
Subject: Re: BUG: warning at kernel/softirq.c:141/local_bh_enable()
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you send us, once your machine is handling its typical load :
>
> lspci -v
> ethtool -S eth6
> tc -s -d qdisc
> cat /proc/slabinfo
> cat /proc/meminfo


Eric,

Here's the output of the commands you mentioned.  The box is handling a medium amount of load right now.  I set eth6 back to auto-negotiation, and haven't seen the kernel BUG messages for the past 1/2 hour.

lspci -v:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 05)
        Subsystem: VIA Technologies, Inc. VT8601 [Apollo ProMedia]
        Flags: bus master, medium devsel, latency 8
        Memory at e6000000 (32-bit, prefetchable) [size=4M]
        Capabilities: [a0] AGP version 2.0

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e0000000-e2ffffff
        Prefetchable memory behind bridge: 20000000-200fffff
        Capabilities: [80] Power Management version 2

0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2

0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2

0000:00:11.0 PCI bridge: Texas Instruments PCI2250 PCI-to-PCI Bridge (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, medium devsel, latency 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e3000000-e4ffffff
        Prefetchable memory behind bridge: 20100000-201fffff
        Capabilities: [dc] Power Management version 1

0000:00:12.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 12
        Memory at e6700000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at dc00 [size=64]
        Memory at e6400000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at 20200000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

0000:00:13.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at e6702000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at e000 [size=64]
        Memory at e6500000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at 20300000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

0000:00:14.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at e6701000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at e400 [size=64]
        Memory at e6600000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at 20400000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

0000:01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev 6a) (prog-if 00 [VGA])
        Subsystem: Trident Microsystems CyberBlade/i1
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 5
        Memory at e1800000 (32-bit, non-prefetchable) [size=8M]
        Memory at e2000000 (32-bit, non-prefetchable) [size=128K]
        Memory at e1000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at 20000000 [disabled] [size=64K]
        Capabilities: [80] AGP version 2.0
        Capabilities: [90] Power Management version 1

0000:02:00.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
        Subsystem: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at c000 [size=256]
        Memory at e4000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 20100000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2

0000:02:01.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
        Subsystem: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at c400 [size=256]
        Memory at e4001000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 20110000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2

0000:02:02.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
        Subsystem: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at c800 [size=256]
        Memory at e4002000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 20120000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2

0000:02:03.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
        Subsystem: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at cc00 [size=256]
        Memory at e4003000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 20130000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2



ethtool -S eth6:
no stats available



tc -s -d qdisc:
<< too many rules to list... there's a /22 subnet in use and a HTB & SFQ rule exist for each IP >>



cat /proc/slabinfo:
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
ip_fib_alias          37    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
ip_fib_hash           31    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
bridge_fdb_cache       0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
UNIX                  22     22    352   11    1 : tunables   54   27    0 : slabdata      2      2      0
ipt_hashlimit          0      0     40   92    1 : tunables  120   60    0 : slabdata      0      0      0
ip_conntrack_expect      0      0     92   42    1 : tunables  120   60    0 : slabdata      0      0      0
ip_conntrack        3976   9008    236   16    1 : tunables  120   60    0 : slabdata    563    563      0
flow_cache             0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
cfq_ioc_pool           0      0     88   44    1 : tunables  120   60    0 : slabdata      0      0      0
cfq_pool               0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
crq_pool               0      0     44   84    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   78    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                20     63     60   63    1 : tunables  120   60    0 : slabdata      1      1      0
mqueue_inode_cache      1      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
romfs_inode_cache      0      0    316   12    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_inode_cache       0      0    416    9    1 : tunables   54   27    0 : slabdata      0      0      0
journal_handle         8    169     20  169    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head         141    144     52   72    1 : tunables  120   60    0 : slabdata      2      2      0
revoke_table           2    254     12  254    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  203    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache   13212  13212    432    9    1 : tunables   54   27    0 : slabdata   1468   1468      0
dnotify_cache          0      0     20  169    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
inotify_event_cache      0      0     28  127    1 : tunables  120   60    0 : slabdata      0      0      0
inotify_watch_cache      0      0     36  101    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   24    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
fasync_cache           0      0     16  203    1 : tunables  120   60    0 : slabdata      0      0      0
shmem_inode_cache      4     10    400   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     88   44    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              3     59     64   59    1 : tunables  120   60    0 : slabdata      1      1      0
ip_mrt_cache           0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket       15    203     16  203    1 : tunables  120   60    0 : slabdata      1      1      0
inet_peer_cache    48968  49855     64   59    1 : tunables  120   60    0 : slabdata    845    845      0
secpath_cache          0      0     32  113    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    288   13    1 : tunables   54   27    0 : slabdata      0      0      0
ip_dst_cache       11175  11175    256   15    1 : tunables  120   60    0 : slabdata    745    745      0
arp_cache            356    390    128   30    1 : tunables  120   60    0 : slabdata     13     13      0
RAW                    9      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
UDP                    6      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
tw_sock_TCP           22     40     96   40    1 : tunables  120   60    0 : slabdata      1      1      0
request_sock_TCP       8     59     64   59    1 : tunables  120   60    0 : slabdata      1      1      0
TCP                    9     14   1056    7    2 : tunables   24   12    0 : slabdata      2      2      0
blkdev_ioc            17    127     28  127    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          25     28    920    4    1 : tunables   54   27    0 : slabdata      7      7      0
blkdev_requests       20     23    168   23    1 : tunables  120   60    0 : slabdata      1      1      0
biovec-(256)           7      8   3072    2    2 : tunables   24   12    0 : slabdata      4      4      0
biovec-128             7     10   1536    5    2 : tunables   24   12    0 : slabdata      2      2      0
biovec-64              7     10    768    5    1 : tunables   54   27    0 : slabdata      2      2      0
biovec-16              7     20    192   20    1 : tunables  120   60    0 : slabdata      1      1      0
biovec-4               7     59     64   59    1 : tunables  120   60    0 : slabdata      1      1      0
biovec-1              83    203     16  203    1 : tunables  120   60    0 : slabdata      1      1      0
bio                  354    354     64   59    1 : tunables  120   60    0 : slabdata      6      6      0
sock_inode_cache      55     55    352   11    1 : tunables   54   27    0 : slabdata      5      5      0
skbuff_fclone_cache     11     11    352   11    1 : tunables   54   27    0 : slabdata      1      1      0
skbuff_head_cache    500    820    192   20    1 : tunables  120   60    0 : slabdata     41     41      0
file_lock_cache        1     42     92   42    1 : tunables  120   60    0 : slabdata      1      1      0
proc_inode_cache     288    288    324   12    1 : tunables   54   27    0 : slabdata     24     24      0
sigqueue               8     27    144   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     1386   1386    276   14    1 : tunables   54   27    0 : slabdata     99     99      0
bdev_cache             4      9    416    9    1 : tunables   54   27    0 : slabdata      1      1      0
sysfs_dir_cache     3345   3360     44   84    1 : tunables  120   60    0 : slabdata     40     40      0
mnt_cache             17     30    128   30    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         1001   1001    308   13    1 : tunables   54   27    0 : slabdata     77     77      0
dentry_cache       15748  15748    124   31    1 : tunables  120   60    0 : slabdata    508    508      0
filp                 338    528    160   24    1 : tunables  120   60    0 : slabdata     22     22      0
names_cache            2      2   4096    1    1 : tunables   24   12    0 : slabdata      2      2      0
idr_layer_cache       94    116    136   29    1 : tunables  120   60    0 : slabdata      4      4      0
buffer_head        22524  22542     48   78    1 : tunables  120   60    0 : slabdata    289    289      0
mm_struct             40     63    416    9    1 : tunables   54   27    0 : slabdata      7      7      0
vm_area_struct       741    880     88   44    1 : tunables  120   60    0 : slabdata     20     20      0
fs_cache              39    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           40     80    192   20    1 : tunables  120   60    0 : slabdata      4      4      0
signal_cache          53     66    352   11    1 : tunables   54   27    0 : slabdata      6      6      0
sighand_cache         45     45   1312    3    1 : tunables   24   12    0 : slabdata     15     15      0
task_struct           49     57   1280    3    1 : tunables   24   12    0 : slabdata     19     19      0
anon_vma             398   1017      8  339    1 : tunables  120   60    0 : slabdata      3      3      0
pgd                   31     31   4096    1    1 : tunables   24   12    0 : slabdata     31     31      0
pid                   57    202     36  101    1 : tunables  120   60    0 : slabdata      2      2      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             3      3  65536    1   16 : tunables    8    4    0 : slabdata      3      3      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             1      1  32768    1    8 : tunables    8    4    0 : slabdata      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             56     56   8192    1    2 : tunables    8    4    0 : slabdata     56     56      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096           4094   4094   4096    1    1 : tunables   24   12    0 : slabdata   4094   4094      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            506    536   2048    2    1 : tunables   24   12    0 : slabdata    268    268      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024             75    124   1024    4    1 : tunables   54   27    0 : slabdata     31     31      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512            4279   4344    512    8    1 : tunables   54   27    0 : slabdata    543    543      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             141    255    256   15    1 : tunables  120   60    0 : slabdata     17     17      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             710    720    192   20    1 : tunables  120   60    0 : slabdata     36     36      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
size-128             360    360    128   30    1 : tunables  120   60    0 : slabdata     12     12      0
size-96(DMA)           0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
size-96              447    480     96   40    1 : tunables  120   60    0 : slabdata     12     12      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             1633   3127     64   59    1 : tunables  120   60    0 : slabdata     53     53      0
size-32             5553   5650     32  113    1 : tunables  120   60    0 : slabdata     50     50      0
kmem_cache           110    120     96   40    1 : tunables  120   60    0 : slabdata      3      3      0



cat /proc/meminfo:
MemTotal:       513972 kB
MemFree:        406748 kB
Buffers:         11312 kB
Cached:          44072 kB
SwapCached:          0 kB
Active:          44992 kB
Inactive:        19904 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513972 kB
LowFree:        406748 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             304 kB
Writeback:           0 kB
Mapped:          15712 kB
Slab:            40772 kB
CommitLimit:    256984 kB
Committed_AS:    19652 kB
PageTables:        320 kB
VmallocTotal:   516072 kB
VmallocUsed:       436 kB
VmallocChunk:   515516 kB




