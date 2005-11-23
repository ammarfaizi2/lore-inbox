Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVKWNO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVKWNO1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 08:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVKWNO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 08:14:27 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:5763 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750787AbVKWNO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 08:14:26 -0500
Date: Wed, 23 Nov 2005 14:14:17 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-ID: <20051123131417.GH24091@fi.muni.cz>
References: <20051122125959.GR16080@fi.muni.cz> <20051122163550.160e4395.akpm@osdl.org> <20051123010122.GA7573@fi.muni.cz> <4383D1CC.4050407@yahoo.com.au> <20051123051358.GB7573@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123051358.GB7573@fi.muni.cz>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: Nick Piggin wrote:
: : Can't see anything yet. Sysrq-M would be good. cat /proc/zoneinfo gets you
: : most of the way there though.
: : 
: : A couple of samples would be handy, especially from /proc/vmstat.
: : 
: : cat /proc/vmstat > vmstat.out ; sleep 10 ; cat /proc/vmstat >> vmstat.out
: : 
: : The same for /proc/zoneinfo would be a good idea as well.
: 
: 	I will send it tomorrow - I will try to boot 2.6.15-rc2
: to see if the problem is still there.
: 
	I am at 2.6.15-rc2 now, the problem is still there.
Currently according to top(1), kswapd1 eats >98% CPU for 50 minutes now
and counting. The last cron job which apparently triggers this has been
started at 13:15, and now it is 14:07; the cron job itself has finished
after few minutes, no processes of the user who runs this cron job are
remaining in the system, but kswapd still eats CPU).

	At the end of this mail you can find the top(1) output,
the two outputs of /proc/vmstat and /proc/zoneinfo separated by a 10 second
sleep, as well as sysrq-m ouptut, which has been taken about at the
same time as the vmstat and zoneinfo outputs.

	What else can be unusual on my system? I run 8-way RAID-5 volume,
but it is OK according to /proc/vmstat. I run each memory bus at the
different speed - CPU0 has 400MHz memory modules, CPU1 has 333MHz
modules. It is supported configuration according to Tyan docs. Anything else?

-Yenya

=========================== top:
top - 14:04:33 up  7:40,  5 users,  load average: 5.05, 3.32, 2.93
Tasks: 418 total,   2 running, 416 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.5% us, 52.1% sy,  0.7% ni, 40.4% id,  3.8% wa,  0.0% hi,  2.5% si
Mem:   8174368k total,  8148188k used,    26180k free,    43956k buffers
Swap: 14651256k total,      656k used, 14650600k free,  7677580k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
   17 root      25   0     0    0    0 R 98.8  0.0  67:58.25 kswapd1
   28 root      10  -5     0    0    0 S  1.0  0.0   4:59.17 md5_raid5
11421 ftp       20   5 10036 1504  764 S  1.0  0.0   0:00.05 proftpd
   18 root      15   0     0    0    0 S  0.7  0.0  23:39.88 kswapd0


============================== vmstat:
nr_dirty 1096
nr_writeback 0
nr_unstable 0
nr_page_table_pages 7897
nr_mapped 54381
nr_slab 31427
pgpgin 168267503
pgpgout 16779856
pswpin 0
pswpout 164
pgalloc_high 0
pgalloc_normal 68192735
pgalloc_dma 78742215
pgfree 146943386
pgactivate 11885097
pgdeactivate 10486693
pgfault 94787199
pgmajfault 3619
pgrefill_high 0
pgrefill_normal 7394476
pgrefill_dma 7988611
pgsteal_high 0
pgsteal_normal 13516901
pgsteal_dma 18774322
pgscan_kswapd_high 0
pgscan_kswapd_normal 12889635
pgscan_kswapd_dma 18124029
pgscan_direct_high 0
pgscan_direct_normal 1419165
pgscan_direct_dma 1397649
pginodesteal 1788228
slabs_scanned 8055609881856
kswapd_steal 29616872
kswapd_inodesteal 7587662
pageoutrun 997021
allocstall 168227
pgrotated 900
nr_bounce 0
============================== zoneinfo:
Node 1, zone   Normal
  pages free     1809
        min      1423
        low      1778
        high     2134
        active   251683
        inactive 753741
        scanned  66 (a: 0 i: 0)
        spanned  1048576
        present  1013647
        protection: (0, 0, 0, 0)
  pagesets
    cpu: 0 pcp: 0
              count: 66
              low:   0
              high:  384
              batch: 64
    cpu: 0 pcp: 1
              count: 127
              low:   0
              high:  128
              batch: 32
            numa_hit:       2155
            numa_miss:      26392398
            numa_foreign:   150
            interleave_hit: 2070
            local_node:     0
            other_node:     26394553
    cpu: 1 pcp: 0
              count: 68
              low:   0
              high:  384
              batch: 64
    cpu: 1 pcp: 1
              count: 111
              low:   0
              high:  128
              batch: 32
            numa_hit:       41672333
            numa_miss:      1482
            numa_foreign:   5904214
            interleave_hit: 5717
            local_node:     41673815
            other_node:     0
  all_unreclaimable: 0
  prev_priority:     12
  temp_priority:     12
  start_pfn:         1048576
Node 0, zone      DMA
  pages free     2855
        min      3
        low      3
        high     4
        active   0
        inactive 0
        scanned  0 (a: 12 i: 12)
        spanned  4096
        present  2761
        protection: (0, 3944, 3944, 3944)
  pagesets
    cpu: 1 pcp: 0
              count: 10
              low:   0
              high:  12
              batch: 2
    cpu: 1 pcp: 1
              count: 0
              low:   0
              high:  4
              batch: 1
            numa_hit:       5286426
            numa_miss:      0
            numa_foreign:   0
            interleave_hit: 3821307
            local_node:     0
            other_node:     5286426
  all_unreclaimable: 0
  prev_priority:     12
  temp_priority:     12
  start_pfn:         0
Node 0, zone    DMA32
  pages free     2912
        min      1418
        low      1772
        high     2127
        active   33310
        inactive 946725
        scanned  0 (a: 27 i: 0)
        spanned  1044480
        present  1009704
        protection: (0, 0, 0, 0)
  pagesets
    cpu: 0 pcp: 0
              count: 51
              low:   0
              high:  384
              batch: 64
    cpu: 0 pcp: 1
              count: 20
              low:   0
              high:  128
              batch: 32
            numa_hit:       47176253
            numa_miss:      150
            numa_foreign:   26392398
            interleave_hit: 1788
            local_node:     47176403
            other_node:     0
    cpu: 1 pcp: 0
              count: 345
              low:   0
              high:  384
              batch: 64
    cpu: 1 pcp: 1
              count: 62
              low:   0
              high:  128
              batch: 32
            numa_hit:       5081
            numa_miss:      5904214
            numa_foreign:   1482
            interleave_hit: 4507
            local_node:     0
            other_node:     5909295
  all_unreclaimable: 0
  prev_priority:     12
  temp_priority:     12
  start_pfn:         4096
============================== sleep 10:
============================== vmstat:
nr_dirty 922
nr_writeback 0
nr_unstable 0
nr_page_table_pages 7873
nr_mapped 54376
nr_slab 31318
pgpgin 168411599
pgpgout 16784255
pswpin 0
pswpout 164
pgalloc_high 0
pgalloc_normal 68198690
pgalloc_dma 78829202
pgfree 147035725
pgactivate 11887559
pgdeactivate 10489812
pgfault 94831072
pgmajfault 3621
pgrefill_high 0
pgrefill_normal 7396819
pgrefill_dma 7997162
pgsteal_high 0
pgsteal_normal 13519173
pgsteal_dma 18807281
pgscan_kswapd_high 0
pgscan_kswapd_normal 12889635
pgscan_kswapd_dma 18155676
pgscan_direct_high 0
pgscan_direct_normal 1421508
pgscan_direct_dma 1399992
pginodesteal 1788228
slabs_scanned 8065934875904
kswapd_steal 29647559
kswapd_inodesteal 7587889
pageoutrun 998045
allocstall 168298
pgrotated 900
nr_bounce 0
============================== zoneinfo:
Node 1, zone   Normal
  pages free     1765
        min      1423
        low      1778
        high     2134
        active   250416
        inactive 754970
        scanned  198 (a: 0 i: 0)
        spanned  1048576
        present  1013647
        protection: (0, 0, 0, 0)
  pagesets
    cpu: 0 pcp: 0
              count: 2
              low:   0
              high:  384
              batch: 64
    cpu: 0 pcp: 1
              count: 127
              low:   0
              high:  128
              batch: 32
            numa_hit:       2155
            numa_miss:      26395832
            numa_foreign:   151
            interleave_hit: 2070
            local_node:     0
            other_node:     26397987
    cpu: 1 pcp: 0
              count: 248
              low:   0
              high:  384
              batch: 64
    cpu: 1 pcp: 1
              count: 84
              low:   0
              high:  128
              batch: 32
            numa_hit:       41674836
            numa_miss:      1482
            numa_foreign:   5908193
            interleave_hit: 5718
            local_node:     41676318
            other_node:     0
  all_unreclaimable: 0
  prev_priority:     12
  temp_priority:     12
  start_pfn:         1048576
Node 0, zone      DMA
  pages free     2854
        min      3
        low      3
        high     4
        active   0
        inactive 0
        scanned  0 (a: 17 i: 17)
        spanned  4096
        present  2761
        protection: (0, 3944, 3944, 3944)
  pagesets
    cpu: 1 pcp: 0
              count: 11
              low:   0
              high:  12
              batch: 2
    cpu: 1 pcp: 1
              count: 0
              low:   0
              high:  4
              batch: 1
            numa_hit:       5288040
            numa_miss:      0
            numa_foreign:   0
            interleave_hit: 3822015
            local_node:     0
            other_node:     5288040
  all_unreclaimable: 0
  prev_priority:     12
  temp_priority:     12
  start_pfn:         0
Node 0, zone    DMA32
  pages free     2143
        min      1418
        low      1772
        high     2127
        active   33907
        inactive 946983
        scanned  0 (a: 0 i: 0)
        spanned  1044480
        present  1009704
        protection: (0, 0, 0, 0)
  pagesets
    cpu: 0 pcp: 0
              count: 146
              low:   0
              high:  384
              batch: 64
    cpu: 0 pcp: 1
              count: 54
              low:   0
              high:  128
              batch: 32
            numa_hit:       47239978
            numa_miss:      151
            numa_foreign:   26395832
            interleave_hit: 1790
            local_node:     47240129
            other_node:     0
    cpu: 1 pcp: 0
              count: 366
              low:   0
              high:  384
              batch: 64
    cpu: 1 pcp: 1
              count: 31
              low:   0
              high:  128
              batch: 32
            numa_hit:       5082
            numa_miss:      5908193
            numa_foreign:   1482
            interleave_hit: 4508
            local_node:     0
            other_node:     5913275
  all_unreclaimable: 0
  prev_priority:     12
  temp_priority:     12
  start_pfn:         4096

======================== dmesg after sysrq-m ============================
SysRq : Show Memory
Mem-info:
Node 1 DMA per-cpu: empty
Node 1 DMA32 per-cpu: empty
Node 1 Normal per-cpu:
cpu 0 hot: low 0, high 384, batch 64 used:59
cpu 0 cold: low 0, high 128, batch 32 used:24
cpu 1 hot: low 0, high 384, batch 64 used:84
cpu 1 cold: low 0, high 128, batch 32 used:93
Node 1 HighMem per-cpu: empty
Node 0 DMA per-cpu:
cpu 0 hot: low 0, high 12, batch 2 used:1
cpu 0 cold: low 0, high 4, batch 1 used:0
cpu 1 hot: low 0, high 12, batch 2 used:10
cpu 1 cold: low 0, high 4, batch 1 used:0
Node 0 DMA32 per-cpu:
cpu 0 hot: low 0, high 384, batch 64 used:334
cpu 0 cold: low 0, high 128, batch 32 used:31
cpu 1 hot: low 0, high 384, batch 64 used:66
cpu 1 cold: low 0, high 128, batch 32 used:31
Node 0 Normal per-cpu: empty
Node 0 HighMem per-cpu: empty
Free pages:       25780kB (0kB HighMem)
Active:283000 inactive:1704247 dirty:1177 writeback:1 unstable:0 free:6445 slab:31088 mapped:54478 pagetables:7852
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 3959 3959
Node 1 DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 3959 3959
Node 1 Normal free:7320kB min:5692kB low:7112kB high:8536kB active:996400kB inactive:3025596kB present:4054588kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 1 HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 DMA free:11412kB min:12kB low:12kB high:16kB active:0kB inactive:0kB present:11044kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 3944 3944 3944
Node 0 DMA32 free:7048kB min:5672kB low:7088kB high:8508kB active:135612kB inactive:3791400kB present:4038816kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 1 DMA: empty
Node 1 DMA32: empty
Node 1 Normal: 10*4kB 28*8kB 13*16kB 4*32kB 1*64kB 2*128kB 1*256kB 0*512kB 0*1024kB 1*2048kB 1*4096kB = 7320kB
Node 1 HighMem: empty
Node 0 DMA: 19*4kB 19*8kB 19*16kB 18*32kB 17*64kB 12*128kB 6*256kB 6*512kB 3*1024kB 0*2048kB 0*4096kB = 11412kB
Node 0 DMA32: 0*4kB 1*8kB 14*16kB 1*32kB 2*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 1*4096kB = 7048kB
Node 0 Normal: empty
Node 0 HighMem: empty
Swap cache: add 164, delete 164, find 0/0, race 0+0
Free swap  = 14650600kB
Total swap = 14651256kB
Free swap:       14650600kB
2097152 pages of RAM
53560 reserved pages
278668 pages shared
0 pages swap cached

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
