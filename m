Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbUBXLya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 06:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbUBXLya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 06:54:30 -0500
Received: from village.ehouse.ru ([193.111.92.18]:24588 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S262229AbUBXLyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 06:54:16 -0500
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1 IO lockup on SMP systems
Date: Tue, 24 Feb 2004 14:54:08 +0300
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, gluk@php4.ru, anton@megashop.ru
References: <200401311940.28078.rathamahata@php4.ru> <200402232027.26958.rathamahata@php4.ru> <20040223142626.48938d7c.akpm@osdl.org>
In-Reply-To: <20040223142626.48938d7c.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402241454.08210.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 February 2004 01:26, Andrew Morton wrote:
> "Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:

<cut>

> > The memory exhaustion is indeed possible for this box. I'll double check
> > ulimit and /etc/security/limits.conf stuff. The only thing which worries
> > me that this box had been running for months without any problems with
> > 2.4.23aa1.
> 
> It is conceivable that you have some application which runs OK on 2.4.x but
> has some subtle bug which causes the app to go crazy on a 2.6 kernel
> consuming lots of memory.  Or there's a bug in the 2.6 kernel ;)
> 
> > I have added another 2Gb to swap space (hope this give enough time
> > to find the memory hungry process(es)).

<cut>

> 
> OK, so it's doing a lot of swapping and your swap utilisation is
> continuously increasing.  I would suspect an application or kernel memory
> leak.
> 
> I suggest you keep that `vmstat 30' running all the time.  When the machine
> dies, take a look at the final 20 lines.

Here is from the last lockup:

1) last 20 entries of the `vmstat 30':
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  1 116676   7752 266156 621360    8    1  1031   186 1364   444 53  5 30 12
 1  0 116656   7512 266316 617716    2    3   334    79 1355   334 59  4 34  3
 1  0 116240   8072 266800 616444   17    1   539   302 1397   464 59  7 29  6
 1  0 116216  13320 266948 614044    1    1  1229    92 1505   587 61  6 27  6
 2  0 116208   8344 267152 618048    1    0   436   143 1367   386 58  5 32  5
 1  1 116216   6024 267308 619188    0   59  4574   164 1554   742 61  6 20 12
 1  1 116284   6468 267736 614028    4    2  1087   117 1458   529 60  7 27  6
 1  0 116280   6336 267888 617860    1    0  1225   101 1419   542 59  6 30  6
 2  1 116472   7264 268148 619288    0    4  7788   100 1645   950 33  6 29 33
 1  1 116728   5976 268296 617112    0    7  7799    86 1566   815 30  6 32 32
 2  0 116752   6080 268488 615992    6    8  7434   136 1627   910 34  7 25 34
 0  1 116944   6368 268588 615420    1    4  7601    95 1696   952 39  6 25 30
 1  0 116968  30600 268896 585832    0    4  2212   176 1584   642 62  7 16 15
 0  1 116968   6128 269064 604912    0    0  1410    67 1460   532 60  5 29  6
 1  0 116964   6280 269308 604008    0    4  7449   106 1561   819 35  5 30 30
 0  1 116976   6080 269400 603208    1    0  7317   121 1535   762 31  6 31 32
 1 16 331784   4452   2488  25132   30 7369  1916  7441 1177   333  7  6  6 81
 1 26 627540   3116   2172  23156  134 10159   217 10173 1159   200  0  4  0 96
 5 29 884564   3144   2036  16032  468 9443   622  9471 1106   435  0  5  0 95
 0 50 1097880   2800   2108   8592  484 7141   794  7164 1119   831  0  6  0 94

2) sysrq-M (This one looks strange to me because of
"Free swap:       2326708kB")

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

Free pages:        2136kB (512kB HighMem)
Active:832 inactive:103 dirty:0 writeback:0 unstable:0 free:534
DMA free:256kB min:16kB low:32kB high:48kB active:0kB inactive:0kB
Normal free:1368kB min:936kB low:1872kB high:2808kB active:1380kB inactive:352kB
HighMem free:512kB min:512kB low:1024kB high:1536kB active:2008kB inactive:0kB
DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 256kB
Normal: 170*4kB 10*8kB 0*16kB 1*32kB 1*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1368kB
HighMem: 8*4kB 0*8kB 2*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 512kB
Swap cache: add 392088, delete 392033, find 22279/32705, race 16+47
Free swap:       2326708kB
524288 pages of RAM
294912 pages of HIGHMEM
5821 reserved pages
860 pages shared
55 pages swap cached

3) sysrq-T:
http://sysadminday.org.ru/2.6.3-io_lockup/ope/sysrq-T

4) 3 last copies of /proc/vmstat

Tue Feb 24 02:36:53 MSK 2004
nr_dirty 320
nr_writeback 0
nr_unstable 0
nr_page_table_pages 822
nr_mapped 289207
nr_slab 11709
pgpgin 15829228
pgpgout 18320340
pswpin 25882
pswpout 37006
pgalloc 28844087
pgfree 28845931
pgactivate 923552
pgdeactivate 760039
pgfault 25500106
pgmajfault 66503
pgscan 7611061
pgrefill 4989936
pgsteal 5628844
pginodesteal 0
kswapd_steal 5211828
kswapd_inodesteal 2958
pageoutrun 33148
allocstall 12799
pgrotated 205322

Tue Feb 24 02:37:03 MSK 2004
nr_dirty 566
nr_writeback 0
nr_unstable 0
nr_page_table_pages 823
nr_mapped 289174
nr_slab 11733
pgpgin 15917192
pgpgout 18321888
pswpin 25882
pswpout 37006
pgalloc 28886326
pgfree 28888201
pgactivate 923806
pgdeactivate 760254
pgfault 25519499
pgmajfault 66550
pgscan 7633363
pgrefill 5008883
pgsteal 5650891
pginodesteal 0
kswapd_steal 5233875
kswapd_inodesteal 2958
pageoutrun 33287
allocstall 12799
pgrotated 205322

Tue Feb 24 02:37:23 MSK 2004
nr_dirty 4
nr_writeback 4559
nr_unstable 0
nr_page_table_pages 962
nr_mapped 197703
nr_slab 4887
pgpgin 15935652
pgpgout 18698124
pswpin 26444
pswpout 130749
pgalloc 29203531
pgfree 29204764
pgactivate 927401
pgdeactivate 944643
pgfault 25525960
pgmajfault 66694
pgscan 9534651
pgrefill 6027760
pgsteal 5952333
pginodesteal 0
kswapd_steal 5421086
kswapd_inodesteal 4181
pageoutrun 33500
allocstall 16189
pgrotated 292969
Tue Feb 24 02:38:16 MSK 2004
nr_dirty 0
nr_writeback 1805
nr_unstable 0
nr_page_table_pages 1433
nr_mapped 102046
nr_slab 4782
pgpgin 15956340
pgpgout 19099784
pswpin 30206
pswpout 230912
pgalloc 29315002
pgfree 29316033
pgactivate 1082560
pgdeactivate 1202414
pgfault 25537663
pgmajfault 67369
pgscan 11280124
pgrefill 6802507
pgsteal 6058697
pginodesteal 0
kswapd_steal 5476702
kswapd_inodesteal 4257
pageoutrun 33668
allocstall 17610
pgrotated 391878

4) Full top output:

top - 02:39:00 up  8:22,  3 users,  load average: 76.16, 25.71, 10.41
Tasks: 225 total,   1 running, 224 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.4% us,  5.3% sy,  0.0% ni,  0.2% id, 93.9% wa,  0.2% hi,  0.0% si
Mem:   2073868k total,  2071260k used,     2608k free,     2104k buffers
Swap:  3583968k total,  1097884k used,  2486084k free,     8604k cached

25123 mysql     15   0 1002m 142m 4896 D  1.0  7.0  10:35.25 mysqld
25122 mysql     15   0 1002m 142m 4896 D  0.0  7.0   0:05.91 mysqld
24132 mysql     15   0 1002m 142m 4896 D  0.0  7.0   0:28.97 mysqld
24129 mysql     15   0 1002m 142m 4896 S  0.0  7.0   0:05.90 mysqld
24125 mysql     15   0 1002m 142m 4896 D  0.1  7.0   0:07.59 mysqld
 5420 mysql     16   0 1002m 142m 4896 S  0.0  7.0   0:50.44 mysqld
 4748 mysql     15   0 1002m 142m 4896 D  0.0  7.0   3:10.94 mysqld
 4746 mysql     15   0 1002m 142m 4896 S  0.0  7.0   2:52.37 mysqld
  970 mysql     16   0 1002m 142m 4896 S  0.0  7.0   0:19.57 mysqld
  969 mysql     16   0 1002m 142m 4896 S  0.0  7.0   0:17.52 mysqld
  968 mysql     15   0 1002m 142m 4896 D  0.1  7.0   0:15.47 mysqld
  967 mysql     16   0 1002m 142m 4896 S  0.0  7.0   0:00.00 mysqld
  958 mysql     16   0 1002m 142m 4896 S  0.0  7.0   0:15.64 mysqld
  957 mysql     15   0 1002m 142m 4896 S  0.0  7.0   2:17.52 mysqld
  956 mysql     16   0 1002m 142m 4896 S  0.0  7.0   0:00.16 mysqld
  955 mysql     17   0 1002m 142m 4896 S  0.0  7.0   0:00.00 mysqld
  954 mysql     15   0 1002m 142m 4896 S  0.0  7.0   0:00.01 mysqld
  898 mysql     15   0 1002m 142m 4896 D  0.0  7.0   0:03.57 mysqld
30132 pricemat  25   0 88976  12m 1944 S  0.0  0.6   2:29.37 make_words
29381 apache    15   0 57948 3200  41m D  0.0  0.2   0:26.14 httpd
29652 apache    15   0 57920 3188  41m S  0.0  0.2   0:19.16 httpd
31015 apache    15   0 56456 2484  41m D  0.0  0.1   0:14.68 httpd
29155 apache    15   0 55064 2916  42m S  0.0  0.1   0:21.33 httpd
30281 apache    15   0 54756 5096  41m D  0.0  0.2   0:11.47 httpd
29638 apache    16   0 54744 3816  42m S  0.0  0.2   0:17.62 httpd
29540 apache    15   0 54436 4732  41m D  0.0  0.2   0:19.75 httpd
30153 apache    15   0 54404 3472  41m S  0.0  0.2   0:12.79 httpd
30123 apache    15   0 54356 4024  41m D  0.0  0.2   0:13.18 httpd
30116 apache    15   0 54316 3352  41m D  0.0  0.2   0:11.75 httpd
29647 apache    15   0 54308 4224  41m D  0.0  0.2   0:17.31 httpd
30134 apache    15   0 53416 2968  41m D  0.0  0.1   0:14.14 httpd
29651 apache    15   0 53040 3220  41m D  0.0  0.2   0:17.58 httpd
29013 apache    15   0 52888 4552  41m S  0.0  0.2   0:13.12 httpd
30619 apache    15   0 52824 3584  41m D  0.0  0.2   0:05.70 httpd
28174 apache    15   0 52692 3956  41m D  0.0  0.2   0:17.85 httpd
30926 apache    15   0 52572 2960  41m S  0.0  0.1   0:04.82 httpd
30117 apache    15   0 52464 4356  41m D  0.1  0.2   0:12.74 httpd
30135 apache    15   0 52392 3984  41m D  0.0  0.2   0:11.73 httpd
30126 apache    15   0 52380 4076  41m D  0.0  0.2   0:13.88 httpd
30133 apache    15   0 52340 2856  41m D  0.0  0.1   0:13.50 httpd
31136 apache    15   0 52316 2596  41m D  0.0  0.1   0:00.90 httpd
30127 apache    15   0 52312 3044  41m D  0.0  0.1   0:12.13 httpd
30136 apache    15   0 52208 2780  41m D  0.0  0.1   0:13.56 httpd
31138 apache    15   0 52116 3272  41m D  0.1  0.2   0:00.78 httpd
31137 apache    15   0 52068 2420  41m D  0.0  0.1   0:00.99 httpd
31289 apache    16   0 51476 1900  41m D  0.0  0.1   0:00.00 httpd
31273 apache    17   0 51360 2188  41m D  0.0  0.1   0:00.01 httpd
31261 apache    16   0 51252 1740  41m D  0.0  0.1   0:00.02 httpd
31234 apache    16   0 51220 1520  41m D  0.1  0.1   0:00.02 httpd
31208 apache    16   0 51220 1888  41m D  0.0  0.1   0:00.02 httpd
31276 apache    16   0 51144 1920  41m D  0.0  0.1   0:00.00 httpd
31274 apache    16   0 51144 1952  41m D  0.0  0.1   0:00.00 httpd
31258 apache    18   0 51144 2068  41m D  0.0  0.1   0:00.02 httpd
31255 apache    18   0 51144 2068  41m D  0.0  0.1   0:00.01 httpd
31254 apache    16   0 51144 2012  41m D  0.0  0.1   0:00.01 httpd
31252 apache    17   0 51144 1996  41m D  0.0  0.1   0:00.01 httpd
31251 apache    16   0 51144 2012  41m D  0.0  0.1   0:00.01 httpd
31238 apache    16   0 51144 2068  41m D  0.0  0.1   0:00.01 httpd
31212 apache    17   0 51144 2028  41m D  0.0  0.1   0:00.01 httpd
31288 apache    17   0 51140 2056  41m D  0.0  0.1   0:00.01 httpd
31287 apache    16   0 51140 2020  41m D  0.0  0.1   0:00.00 httpd
31227 apache    18   0 51140 2084  41m D  0.0  0.1   0:00.00 httpd
31201 apache    16   0 51140 2024  41m D  0.0  0.1   0:00.01 httpd
31225 apache    16   0 51136 1768  41m D  0.0  0.1   0:00.01 httpd
31300 apache    16   0 51132 1700  41m D  0.0  0.1   0:00.00 httpd
31285 apache    16   0 51132 2112  41m D  0.0  0.1   0:00.00 httpd
31283 apache    16   0 51132 1708  41m D  0.0  0.1   0:00.00 httpd
31280 apache    16   0 51132 1692  41m D  0.0  0.1   0:00.00 httpd
31272 apache    18   0 51132 1828  41m D  0.0  0.1   0:00.00 httpd
31257 apache    16   0 51132 2012  41m D  0.0  0.1   0:00.00 httpd
31207 apache    16   0 51132 1708  41m D  0.0  0.1   0:00.00 httpd
31243 apache    16   0 51128 1856  41m D  0.0  0.1   0:00.00 httpd
31296 apache    16   0 51120 1844  41m D  0.0  0.1   0:00.00 httpd
31295 apache    16   0 51120 1632  41m D  0.0  0.1   0:00.00 httpd
31284 apache    16   0 51120 1640  41m D  0.0  0.1   0:00.01 httpd
31277 apache    16   0 51120 1616  41m D  0.0  0.1   0:00.00 httpd
31271 apache    18   0 51120 1656  41m D  0.0  0.1   0:00.00 httpd
31220 apache    16   0 51120 1620  41m D  0.0  0.1   0:00.01 httpd
31206 apache    16   0 51108 1944  41m D  0.0  0.1   0:00.01 httpd
31249 apache    17   0 51104 1788  41m D  0.0  0.1   0:00.01 httpd
31237 apache    16   0 51104 1848  41m D  0.1  0.1   0:00.02 httpd
31253 apache    16   0 51100 2140  41m D  0.0  0.1   0:00.01 httpd
31203 apache    17   0 51100 1608  41m D  0.0  0.1   0:00.01 httpd
31211 apache    16   0 51096 2004  41m D  0.0  0.1   0:00.01 httpd
31298 apache    17   0 51092 2004  41m D  0.0  0.1   0:00.00 httpd
31282 apache    16   0 51092 2084  41m D  0.0  0.1   0:00.00 httpd
31267 apache    18   0 51092 2056  41m D  0.0  0.1   0:00.01 httpd
31313 apache    18   0 51088 1512  41m D  0.0  0.1   0:00.00 httpd
31312 apache    16   0 51088 1508  41m D  0.0  0.1   0:00.00 httpd
31310 apache    17   0 51088 1512  41m D  0.0  0.1   0:00.00 httpd
31286 apache    16   0 51088 1680  41m D  0.0  0.1   0:00.01 httpd
31281 apache    15   0 51088 1268  41m D  0.0  0.1   0:00.00 httpd
31269 apache    18   0 51088 1824  41m D  0.0  0.1   0:00.00 httpd
31268 apache    17   0 51088 1776  41m D  0.1  0.1   0:00.04 httpd
31248 apache    16   0 51088 1600  41m S  0.1  0.1   0:00.02 httpd
31242 apache    16   0 51088 1336  41m D  0.0  0.1   0:00.00 httpd
31241 apache    15   0 51088 1636  41m S  0.0  0.1   0:00.01 httpd
31236 apache    18   0 51088 1752  41m D  0.0  0.1   0:00.00 httpd
31233 apache    16   0 51088 1376  41m S  0.0  0.1   0:00.00 httpd
31231 apache    16   0 51088 1196  41m D  0.0  0.1   0:00.00 httpd
31217 apache    16   0 51088 1636  41m S  0.0  0.1   0:00.01 httpd
31214 apache    16   0 51088 1428  41m S  0.0  0.1   0:00.01 httpd
31210 apache    16   0 51088 1320  41m S  0.0  0.1   0:00.00 httpd
31205 apache    18   0 51088 1648  41m D  0.0  0.1   0:00.01 httpd
31204 apache    16   0 51088 1268  41m S  0.0  0.1   0:00.00 httpd
31235 apache    16   0 51080 1364  41m D  0.0  0.1   0:00.00 httpd
31232 apache    16   0 51080 1484  41m D  0.0  0.1   0:00.03 httpd
31219 apache    18   0 51080 1800  41m D  0.0  0.1   0:00.01 httpd
31315 apache    18   0 51076 1384  41m D  0.0  0.1   0:00.00 httpd
31314 apache    16   0 51076 1316  41m D  0.0  0.1   0:00.00 httpd
31311 apache    18   0 51076 1464  41m D  0.0  0.1   0:00.01 httpd
31309 apache    18   0 51076 1384  41m D  0.0  0.1   0:00.00 httpd
31308 apache    18   0 51076 1304  41m D  0.0  0.1   0:00.00 httpd
31306 apache    17   0 51076 1420  41m D  0.0  0.1   0:00.00 httpd
31305 apache    18   0 51076 1320  41m D  0.0  0.1   0:00.01 httpd
31304 apache    18   0 51076 1280  41m D  0.0  0.1   0:00.00 httpd
31303 apache    18   0 51076 1380  41m D  0.0  0.1   0:00.00 httpd
31302 apache    17   0 51076 1308  41m D  0.0  0.1   0:00.00 httpd
31301 apache    15   0 51076 1292  41m D  0.0  0.1   0:00.00 httpd
31297 apache    16   0 51076 1348  41m D  0.0  0.1   0:00.00 httpd
31279 apache    16   0 51076 1292  41m S  0.0  0.1   0:00.00 httpd
31278 apache    15   0 51076 1204  41m D  0.0  0.1   0:00.00 httpd
31275 apache    15   0 51076 1196  41m D  0.0  0.1   0:00.00 httpd
31260 apache    16   0 51076 1548  41m S  0.0  0.1   0:00.02 httpd
31259 apache    18   0 51076 1536  41m S  0.0  0.1   0:00.00 httpd
31256 apache    18   0 51076 1444  41m S  0.0  0.1   0:00.00 httpd
31250 apache    16   0 51076 1484  41m S  0.0  0.1   0:00.00 httpd
31247 apache    16   0 51076 1292  41m D  0.0  0.1   0:00.01 httpd
31246 apache    16   0 51076 1296  41m S  0.0  0.1   0:00.01 httpd
31245 apache    18   0 51076 1172  41m D  0.0  0.1   0:00.00 httpd
31244 apache    15   0 51076 1412  41m S  0.0  0.1   0:00.00 httpd
31240 apache    16   0 51076 1500  41m S  0.0  0.1   0:00.01 httpd
31239 apache    15   0 51076 1548  41m D  0.0  0.1   0:00.01 httpd
31230 apache    18   0 51076 1300  41m D  0.0  0.1   0:00.00 httpd
31229 apache    18   0 51076 1304  41m D  0.0  0.1   0:00.00 httpd
31228 apache    16   0 51076 1424  41m S  0.0  0.1   0:00.00 httpd
31226 apache    16   0 51076 1760  41m D  0.0  0.1   0:00.01 httpd
31223 apache    18   0 51076 1216  41m D  0.0  0.1   0:00.00 httpd
31218 apache    18   0 51076 1704  41m D  0.0  0.1   0:00.01 httpd
31216 apache    18   0 51076 1208  41m D  0.0  0.1   0:00.00 httpd
31215 apache    16   0 51076 1240  41m D  0.0  0.1   0:00.00 httpd
31202 apache    17   0 51076 1620  41m D  0.0  0.1   0:00.01 httpd
31325 root      17   0 51064 1320  41m D  0.0  0.1   0:00.00 httpd
31324 root      17   0 51064 1320  41m D  0.0  0.1   0:00.00 httpd
31323 root      15   0 51064 1320  41m D  0.0  0.1   0:00.00 httpd
31322 root      15   0 51064 1320  41m D  0.0  0.1   0:00.00 httpd
31319 root      18   0 51064 1288  41m D  0.0  0.1   0:00.00 httpd
31318 root      17   0 51064 1312  41m D  0.0  0.1   0:00.00 httpd
31316 root      18   0 51064 1328  41m D  0.0  0.1   0:00.00 httpd
  794 root      17   0 51064 1192  41m S  0.1  0.1   0:01.67 httpd
23885 pricemat  16   0  5652 1124 4892 S  0.0  0.1   0:00.02 php
23980 pricemat  17   0  5648  652 4892 S  0.0  0.0   0:00.01 php
 1430 root      15   0  3780  260 3112 S  0.0  0.0   0:00.61 sshd
 8273 root      15   0  3716  468 3112 S  0.0  0.0   0:01.26 sshd
  994 root      16   0  3660  516 3112 S  0.0  0.0   0:10.24 sshd
 2147 root      15   0  3572  176 3112 S  0.0  0.0   0:00.12 sshd
 2129 root      16   0  3572  156 3112 S  0.0  0.0   0:00.76 sshd
 1919 root      15   0  3532  128 3112 S  0.0  0.0   0:00.11 sshd
 1480 root      16   0  3488   84 2224 S  0.0  0.0   0:00.83 bash
 2991 rathamah  16   0  3336  420 2052 S  0.0  0.0   0:00.04 bash
 1431 rathamah  16   0  2828  880 2052 S  0.0  0.0   0:00.04 bash
  770 dnscache  15   0  2712   24 1412 S  0.0  0.0   0:17.59 dnscache
  728 root      16   0  2672  176 2560 S  0.0  0.0   0:01.72 sshd
 1001 rathamah  16   0  2588   48 2052 S  0.0  0.0   0:00.03 bash
 2957 root      17   0  2388   40 1984 S  0.0  0.0   0:00.02 login
  846 root      20   0  2284  252 2120 S  0.0  0.0   0:00.02 mysqld_safe
  750 root      16   0  2212   44 1900 S  0.0  0.0   0:00.00 xinetd
 1478 root      16   0  2148  216 1788 S  0.0  0.0   0:00.00 su
 1062 rathamah  15   0  2132  508 1728 D  0.4  0.0   2:37.73 top
 8278 rathamah  15   0  2028  560 1728 R  0.2  0.0   0:18.48 top
31292 mobilius  18   0  1972  124 1884 S  0.0  0.0   0:00.00 lacheck.sh
31263 mobilius  18   0  1972  112 1884 S  0.0  0.0   0:00.01 sh
 2131 rathamah  15   0  1964   80 1884 S  0.0  0.0   0:04.17 proc_vmstat.sh
 1192 apache    16   0  1952   44 1816 S  0.0  0.0   0:00.60 cache_clean
  708 ntp       16   0  1936 1928 1792 S  0.0  0.1   0:00.10 ntpd
  619 root      15   0  1840  304 1624 S  0.0  0.0   0:06.43 syslogd
  837 root      15   0  1728  136 1536 S  0.0  0.0   0:00.14 crond
23884 root      16   0  1620  160 1536 S  0.0  0.0   0:00.00 crond
31264 root      18   0  1616  108 1536 S  0.0  0.0   0:00.00 crond
31262 root      17   0  1616   96 1536 S  0.0  0.0   0:00.00 crond
 1088 root      23   0  1616   84 1536 S  0.0  0.0   0:00.00 crond
  625 root      16   0  1532  188 1364 S  0.0  0.0   0:00.19 klogd
 2149 rathamah  15   0  1464   88 1404 S  0.0  0.0   0:00.02 vmstat
  863 qmails    15   0  1444  196 1388 S  0.0  0.0   0:45.57 qmail-send
31321 megashop  18   0  1436  200 1388 D  0.0  0.0   0:00.00 qmail-inject
31293 megashop  18   0  1436  200 1388 D  0.0  0.0   0:00.01 qmail-inject
23939 pricemat  16   0  1436    8 1388 S  0.0  0.0   0:00.00 qmail-inject
   23 root      17   0  1436  432 1392 S  0.0  0.0   0:00.66 devfsd
31317 rathamah  17   0  1432  124 1420 D  0.0  0.0   0:00.01 date
 1201 urs       15   0  1420  100 1392 D  0.0  0.0   0:00.54 tcpserver
 1187 urs       18   0  1420   44 1392 S  0.0  0.0   0:00.00 tcpserver
  767 root      15   0  1420   76 1356 S  0.0  0.0   0:00.12 svscan
    1 root      15   0  1420  424 1372 D  0.0  0.0   0:04.26 init
  866 qmaill    15   0  1412  292 1352 S  0.0  0.0   0:00.62 splogger
  867 root      15   0  1404   96 1360 S  0.0  0.0   0:00.15 qmail-lspawn
  868 qmailr    16   0  1400   96 1356 S  0.0  0.0   0:00.17 qmail-rspawn
  771 dnslog    15   0  1400   16 1368 S  0.0  0.0   0:10.64 multilog
 1261 root      16   0  1392   40 1352 S  0.0  0.0   0:00.00 mingetty
  919 root      16   0  1392   36 1352 S  0.0  0.0   0:00.00 mingetty
  916 root      16   0  1392   92 1352 S  0.0  0.0   0:00.00 mingetty
  915 root      16   0  1392   64 1352 S  0.0  0.0   0:00.00 mingetty
  914 root      16   0  1392   80 1352 S  0.0  0.0   0:00.00 mingetty
  913 root      16   0  1392   76 1352 S  0.0  0.0   0:00.00 mingetty
  869 qmailq    15   0  1388   84 1356 S  0.0  0.0   0:00.66 qmail-clean
  769 root      16   0  1388   12 1360 S  0.0  0.0   0:00.00 supervise
  768 root      16   0  1388   12 1360 S  0.0  0.0   0:00.00 supervise
31307 mobilius  18   0   376  116  348 D  0.0  0.0   0:00.00 awk
31320 root      15   0     0    0    0 D  0.0  0.0   0:00.00 pdflush
31222 root      15   0     0    0    0 D  0.0  0.0   0:00.01 pdflush
24026 root      15   0     0    0    0 D  0.0  0.0   0:05.24 pdflush
   18 root       5 -10     0    0    0 S  0.0  0.0   0:00.04 reiserfs/1
   17 root       5 -10     0    0    0 S  0.0  0.0   0:00.02 reiserfs/0
   16 root      18   0     0    0    0 S  0.0  0.0   0:00.15 kseriod
   15 root      15 -10     0    0    0 S  0.0  0.0   0:00.00 aio/1
   14 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0
   13 root      15   0     0    0    0 D  8.9  0.0   0:23.43 kswapd0
   10 root      15   0     0    0    0 S  0.0  0.0   0:00.00 kirqd
    9 root       5 -10     0    0    0 S  0.0  0.0   0:00.01 kblockd/1
    8 root       5 -10     0    0    0 S  0.0  0.0   0:00.01 kblockd/0
    7 root       5 -10     0    0    0 S  0.0  0.0   0:00.02 events/1
    6 root       5 -10     0    0    0 S  0.0  0.0   0:00.03 events/0
    5 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/1
    4 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/1
    3 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
    2 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/0

> 
> Also, run
> 
> 	while true
> 	do
> 		cat /proc/meminfo
> 		sleep 10
> 	done
> 
> and record the info which that leaves behind when the machine locks up. 
> This should tell us whether it is an application or kernel memory leak.  If
> it is indeed a leak.

Will do this next time.

> 
> 
> 

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
