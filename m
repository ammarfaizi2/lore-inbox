Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280257AbRJaPEp>; Wed, 31 Oct 2001 10:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280258AbRJaPEe>; Wed, 31 Oct 2001 10:04:34 -0500
Received: from uphill.barcelo.com ([195.57.250.32]:27398 "HELO
	uphill.barcelo.com") by vger.kernel.org with SMTP
	id <S280257AbRJaPEY>; Wed, 31 Oct 2001 10:04:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Joan Batet <j.batet@barcelo.com>
Organization: Viajes Barcelo
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HIGMEM, SMP, 2.4.13 and Cerberus
Date: Wed, 31 Oct 2001 16:06:31 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011031150453.52C3D52DF0@uphill.barcelo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As you suggested, I ran the test again with Linux-2.4.12-ac6, 
Linux-2.4.13-ac4 and Linux-2.4.13, this time with ext2 filesystem (the 
previous cerberus run was run on ext3 partitions).

We've been unable to reproduce the system freeze with these kernels. Even
2.4.13 has remained stable, so we're again running ceberus on 2.4.13 and
ext3 partitions. If the machine stops again perhaps this is an ext3 related
problem or a bad interaction between the SCSI driver and ext3.

With respect to the differents VM in Linus and Alan trees, vmstat shows very
different numbers with respect to I/O block processes, bi and bo, and the
"jittering" of the VM. In Linus tree blocked processes and bi numbers
remains stable, while in Alan tree this values change a lot more.

Another point is that while Linus tree almost never touches swap, Alan tree
uses it right from the beginning.


The computer:

- Dell PowerEdge 2550
- Dual PIII 1Ghz
- 2Gb ECC SDRAM
- 2 x 36Gb RAID1 (AACRAID scsi driver)


Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11f
mount                  2.11f
modutils               2.4.5
e2fsprogs              1.24
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded

Note: the patch linux-2.4.11-aacraid-20011010.patch is due to Dell.

Test finished after 16 without problems.
Kernel 2.4.12-ac6 - ext2 filesystem - linux-2.4.11-aacraid-20011010.patch

 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 9  8  0 1638596   6004 579248   1428 2734 1978  9062  1978  404  1183   2
57  41
 0 17  0 1638596   5144 584460   1428 1884  50  6704    50  343  1109   1
19
 80
 0 17  0 1638596   9240 578388   1424 2376 134 10056   134  372  1283   2
58
 40
 0 17  0 1638596   7612 576880   1424 2364 234 10136   234  368  1389   4
55
 40
 9  8  0 1638596   5772 580020   1424 468 274 14680   282  437  1481  16  73
11
15  2  1 1644948   5196 581244   1428  90 294 10956   300  343  1143  24  59
17
 5 13  1 1638596   5700 580208   1704 608   2 11136    24  347  1084  13  68
19
 0 17  0 1638596   5936 587324   2556 1326  90  9646    90  394  1427   7
36
 57
17  0  1 1647216   6956 586108   2556 158   0 10674    36  333  1084  20  64
16
17  0  0 1638596   8820 584924   2552   0   0 11112     0  313   920  22  70
 8
15  2  1 1638596   8876 589364   2456   0 1926 12164  1926  422  1064  23
68
  9
15  2  1 1643092   8984 589692   2352  24 162 15212   190  418  1112  15  84
 1
 7 10  1 1641488   9476 587324   2312 1040  10 10718    14  361  1196   6
70
 24
 0 17  0 1638576   8344 586016   2312 1868 10554  7524 10576  558  1141   2
45  53
 0 17  0 1638576   7220 586240   2312 448 282  1148   282  324   165   0   6
94
 0 17  0 1638576   5108 596840   2300 1942   0  7242     0  504  1282   2
16
 82
 1 16  2 1638860   9732 593184   2256 2704 4566  8488  4566  446 16623   1
55  43
15  2  1 1653268   8856 597204   2276 1650   0  5704     0  355   821   2
32
 66
 0 17  0 1642440   9184 594052   2276 1902 1664  8876  1664  373  1396   1
45  54
 2 17  0 1638592   8876 594888   2280 1936   0  8222     0  410  1112   3
39
 57
 0 17  1 1639596   9020 593788   2284 842 2060  6720  2074  409  1238   1
54
 45

Test finished after 8 hours without problems.
Kernel 2.4.13-ac4 - ext2 filesystem - linux-2.4.11-aacraid-20011010.patch

 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0 17  0 1638596   5100 506888 4294462068 1242   0  7478     0  371  1273
5
 45  50
 3 14  0 1638596   9720 504188 4294464772 2292  60  9854    64  406  1371
3
 54  43
 0 17  0 1641360   5160 506708 4294462240 1718 680  9514   702  489  1564
4
 52  44
 0 17  1 1639240   9700 501588 4294467332 2286   4  7850     4  358  1244
1
 44  55
 0 17  0 1638708   7376 500976 4294467944 2704   0  8760     0  363  1136
2
 49  50
 7 10  0 1638596   8744 498656 4294470208 2026 322  9302   322  419  1557
1
 47  52
17  0  1 1644004   9088 500128 4294468736 1752   4  8898     4  461  1634
1
 47  52
 0 17  1 1640044   9768 497524 4294471336 2286 122  7716   122  372  1291
1
 44  55
 7 10  0 1638592   5376 499216 4294469664 2542   0  8028     0  362  1273
1
 28  71
 3 14  0 1638596   5104 501268 4294467600 2034 5802  5658  5818  508   773
2  33  65
 0 17  0 1638596   5104 508920 4294459948 2156   0  5984     0  301  1001
3
 10  86
 1 16  1 1638596   9596 504088 4294464780 1680   4  8036    14  384  1362
3
 50  47
 1 16  0 1642104   5104 506576 4294462292 1836 102  7096   102  363  1208
1
 46  53
 0 17  0 1639868   5396 502784 4294466084 2092   2  6896     2  352  1180
1
 35  64
12  5  1 1638596   9328 500612 4294468256 2446   0  9718     0  396  1444
1
 52  47
 0 17  0 1643432   7416 499428 4294469440 2150 102  7878   102  374  1277
1
 41  57
 0 17  0 1643564   8924 495780 4294473096 1882 222  8812   226  393  1353
0
 58  42
 2 15  1 1638604   9032 493140 4294475736 2070 168  9497   180  440  1607
2
 51  47
 0 17  0 1640508   8212 492768 4294476108 942 6960  5170  6972  470   872
2
 38  60
 0 18  0 1640468   8628 492324 4294476572   2 5654   208  5654  317    71
0
  4  96
 0 17  0 1638596   5104 497320 4294471640 708   0  3236     0  401   622   1
 7  92

Test finished after 17 hours without problems.
Kernel 2.4.13 - ext2 filesystem - linux-2.4.11-aacraid-20011010.patch

 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 1 16  0    900 750420    420 591156   0   0 24276    11  542  2219  51  23
26
 2 15  0    900 505664    420 655032   0   0 21292     0  495  1732  42  31
27
 1 16  0    900 425644    436 717364   0   0 20777    13  490  2247  52  12
36
 5 12  0    900 420400    192 722236   0   0 24023    11  542  1715  49  31
21
 2 15  0    900 235932    196 722252   0   0 26628    20  585  1929  37  43
20
 3 14  0    900 235800    144 722436   0   0 22487     0  516  2084  50  20
30
 2 15  0    900 235776    168 722432   0   0 25004    12  557  1872  50  30
20
 3 14  0    900 236280    196 721928   0   0 27572     8  574  1643  46  39
15
 2 15  0    900  52136    188 721572   0   0 25604     5  565  2034  38  37
24
 8  9  0    900  51776    188 721952   0   0 24404     0  548  2226  49  26
25
 4 13  0    900  52260    196 721452   0   0 25217    11  579  1822  39  46
15
 4 13  0    900  52168    180 721592   0   0 25513     0  561  1657  42  42
16
 4 13  0    900   4580    192 588264   0   0 25273    24  555  1819  36  43
21
 3 14  0    900   5184    192 592492   0   0 21548     0  515  2079  51  20
30
 3 15  0    900   4192    192 595980   0   0 22064    11  543  2002  49  22
29
 5 12  0    900   5116    192 597856   0   0 25641     5  600  1624  47  35
18
 4 13  0    900   5088    164 597924   0   0 25771     4  554  1695  48  35
17
 1 16  0    900   4304    192 432596   0   0 27156    15  599  1967  35  44
20
 2 15  0    900   5040    164 431856   0   0 25643     1  571  2130  50  24
26
 2 15  0    900   4388    164 432500   0   0 25388     9  568  2142  50  22
28
 1 16  0    900   4604    152 266208   0   0 25172     1  563  2021  51  23
27


Comments?

Best regards,
	Joan
