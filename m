Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbUBZMUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 07:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbUBZMUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 07:20:04 -0500
Received: from village.ehouse.ru ([193.111.92.18]:60434 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S262683AbUBZMTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 07:19:48 -0500
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1 IO lockup on SMP systems
Date: Thu, 26 Feb 2004 15:19:35 +0300
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, gluk@php4.ru, anton@megashop.ru,
       Mike Fedyk <mfedyk@matchmail.com>
References: <200401311940.28078.rathamahata@php4.ru> <20040223142626.48938d7c.akpm@osdl.org> <200402241454.08210.rathamahata@php4.ru>
In-Reply-To: <200402241454.08210.rathamahata@php4.ru>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402261519.35506.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 February 2004 14:54, Sergey S. Kostyliov wrote:
> On Tuesday 24 February 2004 01:26, Andrew Morton wrote:
> > "Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
> 
> <cut>
> 
> > > The memory exhaustion is indeed possible for this box. I'll double check
> > > ulimit and /etc/security/limits.conf stuff. The only thing which worries
> > > me that this box had been running for months without any problems with
> > > 2.4.23aa1.
> > 
> > It is conceivable that you have some application which runs OK on 2.4.x but
> > has some subtle bug which causes the app to go crazy on a 2.6 kernel
> > consuming lots of memory.  Or there's a bug in the 2.6 kernel ;)
> > 
> > > I have added another 2Gb to swap space (hope this give enough time
> > > to find the memory hungry process(es)).
> 
> <cut>
> 
> > 
> > OK, so it's doing a lot of swapping and your swap utilisation is
> > continuously increasing.  I would suspect an application or kernel memory
> > leak.
> > 
> > I suggest you keep that `vmstat 30' running all the time.  When the machine
> > dies, take a look at the final 20 lines.
> 
> Here is from the last lockup:

Yet another lockup has just occurred. I could be wrong but from the
/proc/meminfo content it doesn't looks like memory leak (neither kernel
nor userspace), doesn't it?

1) 3 last /proc/meminfo before a hang:
===============================
Thu Feb 26 04:58:34 MSK 2004
MemTotal:      2073868 kB
MemFree:          7008 kB
Buffers:        223100 kB
Cached:         593368 kB
SwapCached:     748824 kB
Active:        1776280 kB
Inactive:       226160 kB
HighTotal:     1179648 kB
HighFree:         2560 kB
LowTotal:       894220 kB
LowFree:          4448 kB
SwapTotal:     3583968 kB
SwapFree:      2675616 kB
Dirty:            2156 kB
Writeback:           0 kB
Mapped:        1219740 kB
Slab:            43668 kB
Committed_AS:  1846968 kB
PageTables:       4020 kB
VmallocTotal:   114680 kB
VmallocUsed:      7448 kB
VmallocChunk:   107232 kB

Thu Feb 26 04:59:05 MSK 2004
MemTotal:      2073868 kB
MemFree:          3972 kB
Buffers:          2268 kB
Cached:          36132 kB
SwapCached:     726940 kB
Active:        1157256 kB
Inactive:         3696 kB
HighTotal:     1179648 kB
HighFree:          704 kB
LowTotal:       894220 kB
LowFree:          3268 kB
SwapTotal:     3583968 kB
SwapFree:      2633444 kB
Dirty:              20 kB
Writeback:        3376 kB
Mapped:        1154812 kB
Slab:            27996 kB
Committed_AS:  1851456 kB
PageTables:       4052 kB
VmallocTotal:   114680 kB
VmallocUsed:      7448 kB
VmallocChunk:   107232 kB

Thu Feb 26 05:00:15 MSK 2004
MemTotal:      2073868 kB
MemFree:          2528 kB
Buffers:          2180 kB
Cached:          34216 kB
SwapCached:     643808 kB
Active:         999316 kB
Inactive:        12088 kB
HighTotal:     1179648 kB
HighFree:          576 kB
LowTotal:       894220 kB
LowFree:          1952 kB
SwapTotal:     3583968 kB
SwapFree:      2559796 kB
Dirty:               0 kB
Writeback:        3052 kB
Mapped:        1001208 kB
Slab:            23932 kB
Committed_AS:  1979784 kB
PageTables:       4840 kB
VmallocTotal:   114680 kB
VmallocUsed:      7448 kB
VmallocChunk:   107232 kB

2) sysrq-M:
===========
SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16

Free pages:        2120kB (512kB HighMem)
Active:1067 inactive:93 dirty:0 writeback:0 unstable:0 free:530
DMA free:176kB min:16kB low:32kB high:48kB active:884kB inactive:0kB
Normal free:1432kB min:936kB low:1872kB high:2808kB active:1376kB inactive:372kB
HighMem free:512kB min:512kB low:1024kB high:1536kB active:2008kB inactive:0kB
DMA: 0*4kB 0*8kB 1*16kB 1*32kB 0*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 176kB
Normal: 248*4kB 3*8kB 0*16kB 1*32kB 6*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1432kB
HighMem: 0*4kB 0*8kB 0*16kB 2*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 512kB
Swap cache: add 1726105, delete 1726052, find 1388170/1627421, race 19+488
Free swap:       2195688kB
524288 pages of RAM
294912 pages of HIGHMEM
5821 reserved pages
993 pages shared
54 pages swap cached

3) sysrq-T:
===========
http://sysadminday.org.ru/2.6.3-lockup/20040226/sysrq-T

3) `vmstat 30':
===============
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0 19 1255096   1952   1996  19920  426 1763   505  1778 1068   172  0  1  0 99
 0 24 1260156   1944   2028  19816  374 1650   463  1670 1067   165  0  1  0 99
 0 18 1266576   1880   2000  18960  372 1835   449  1847 1072   177  0  1  0 99
 0 19 1274696   2904   1960  17892  366 2002   422  2007 1054   179  0  1  0 99
 0 14 1279000   2896   1916  17356  203 1683   243  1693 1037   137  0  1  0 99
 0 19 1288068   2472   1912  16608  180 2074   220  2085 1048   138  0  1  0 99
 1 13 1294388   2152   1932  16404  253 1841   302  1849 1037   117  0  1  0 99
 0 17 1301552   2328   1956  15684  318 1866   375  1880 1037   162  0  1  0 99
 0 18 1307280   2448   1956  15024  331 1697   408  1714 1041   155  0  1  0 99
 0 20 1312696   2184   1852  13948  480 1720   549  1732 1041   166  0  1  0 99
 0 21 1321756   2308   1952  13400  435 2012   572  2028 1048   191  0  1  0 99
 0 20 1330740   2372   1840  12152  509 1920   564  1939 1045   162  0  1  0 99
 0 19 1336432   2616   1844  11252  513 1697   568  1704 1043   135  0  1  0 99
 0 20 1342256   2364   1896  10704  520 1810   573  1816 1042   185  0  1  0 99
 0 17 1350608   2868   1796  10112  368 2079   412  2092 1040   133  0  1  0 99
 0 19 1356100   2176   1988   9120  401 1668   533  1677 1039   161  0  1  0 99
 0 20 1359692   2248   2004   8876  369 1500   482  1514 1039   169  0  1  0 99
 0 19 1364868   2696   1904   8428  455 1643   604  1658 1038   172  0  1  0 99
 0 20 1371124   2876   1920   7212  537 2133   745  2147 1312   209  0  1  0 99
 0 20 1378172   3192   1832   6036  614 1623   793  1631 1042   180  0  1  0 99

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
