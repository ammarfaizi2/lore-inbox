Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbTB0Uoe>; Thu, 27 Feb 2003 15:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTB0Uoe>; Thu, 27 Feb 2003 15:44:34 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:53123 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S266952AbTB0UoU>;
	Thu, 27 Feb 2003 15:44:20 -0500
Subject: pdflush behaving weirdly in 2.5.63 with firewire disk.
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046379276.709.159.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 27 Feb 2003 21:54:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.

Here's the results from my very small tests regarding the pdflush issue
I told you about.

normal desktop activities performed during these tests, surfing the net,
using evolution for mail...
All tests performed against a firewire disk.


vfat
----
for i in `seq 1 50`; do cat /dev/zero > /mnt/whiplash/testfile$i; done
(vfat's filesize limit is 4GB so start over with a new file)

root      1335  1.6  0.0     0    0 ?        DW   00:57   0:46 [pdflush]
root      1447  1.3  0.0     0    0 ?        DW   01:07   0:31 [pdflush]
root      1505  1.1  0.0     0    0 ?        DW   01:13   0:22 [pdflush]
root      1616  1.0  0.0     0    0 ?        DW   01:26   0:11 [pdflush]
root      1620  0.7  0.0     0    0 ?        DW   01:28   0:08 [pdflush]
root      1622  0.2  0.0     0    0 ?        DW   01:29   0:02 [pdflush]
root      1624  0.7  0.0     0    0 ?        DW   01:29   0:07 [pdflush]
root      1632  0.3  0.0     0    0 ?        DW   01:29   0:03 [pdflush]

they all get some cputime

root      1335  1.6  0.0 DW   [pdflush]        schedule_timeout
root      1447  1.3  0.0 DW   [pdflush]        schedule_timeout
root      1505  1.1  0.0 DW   [pdflush]        schedule_timeout
root      1616  1.0  0.0 DW   [pdflush]        schedule_timeout
root      1620  0.7  0.0 DW   [pdflush]        schedule_timeout
root      1622  0.2  0.0 DW   [pdflush]        schedule_timeout
root      1624  0.7  0.0 DW   [pdflush]        schedule_timeout
root      1632  0.3  0.0 DW   [pdflush]        schedule_timeout

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  9   1496   4068   1336 479348    0    0     4 19389 1690  2098  3 34  0 63
15  8   1496   2604   1332 480820    0    0     5 17547 1717  2267  2 38  0 60
 0 10   1496   4012   1332 479356    0    0     4 19201 1695  2137  4 36  0 60
 1  9   1496   4140   1332 479228    0    0   133 17863 1696  2123  4 37  0 59
 3  9   1496   4076   1328 479412    0    0     9 18312 1701  2187  3 42  0 55
 2 10   1496   3564   1332 479864    0    0     4 18752 1685  1987  3 33  0 64
18  8   1496   2220   1328 481256    0    0     5 18184 1728  2288  3 41  0 56
 3  9   1496   3284   1332 479760    0    0    23 19329 1699  2227  5 34  0 61
 2  9   1496   4076   1292 479348    0    0     5 17927 1695  2254  6 46  0 48
 3  9   1496   3884   1288 479580    0    0   133 18452 1698  2259  5 40  0 55



during mke2fs
-------------
root      1799  0.0  0.0     0    0 ?        DW   01:55   0:00 [pdflush]
root      1810  0.0  0.0     0    0 ?        DW   01:55   0:00 [pdflush]
root      2088  0.0  0.0     0    0 ?        DW   02:25   0:00 [pdflush]
root      2093  0.0  0.0     0    0 ?        DW   02:26   0:00 [pdflush]
root      2112  0.0  0.0     0    0 ?        DW   02:26   0:00 [pdflush]
root      2117  0.0  0.0     0    0 ?        DW   02:26   0:00 [pdflush]
root      2138  0.0  0.0     0    0 ?        DW   02:27   0:00 [pdflush]

No cputime

root      1799  0.0  0.0 DW   [pdflush]        schedule_timeout
root      1810  0.0  0.0 DW   [pdflush]        schedule_timeout
root      2088  0.0  0.0 DW   [pdflush]        schedule_timeout
root      2093  0.0  0.0 DW   [pdflush]        schedule_timeout
root      2112  0.0  0.0 DW   [pdflush]        schedule_timeout
root      2117  0.0  0.0 DW   [pdflush]        schedule_timeout
root      2138  0.0  0.0 DW   [pdflush]        schedule_timeout

 0  9  20972   3836 439856  56848    0    0     0 19472 1421  1798  3 21  0 76
 2  9  20972   4332 439240  56852    0    0   132 19094 1437  2487 11 21  0 68
 2  8  20972   3884 439680  56848    0    0     0 19096 1420  1866  3 20  0 77
 5  8  20972   3052 440572  56848    0    0     0 20320 1425  2828 18 25  0 57
 1  8  20972   3108 440448  56904    0    0    68 19472 1443  1900  7 25  0 69
 2  8  20972   2276 441204  56904    0    0     0 18432 1422  1778  1 22  0 77
 0  9  20972   2284 441196  56904    0    0   132 20984 1425  1822  2 24  0 74
 1  9  20972   4188 439052  56904    0    0     0 19850 1420  1805  3 19  0 78
 1  9  20972   4284 439272  56904    0    0     0 19724 1426  1920  4 24  0 72
 1  8  20972   4220 439296  56904    0    0     0 19062 1428  1923  2 18  0 80
 1  8  20972   4220 439316  56908    0    0     4 19854 1426  1896  2 22  0 76
 4  8  20972   4156 439404  56908    0    0   128 19206 1440  1928  1 21  0 78
 0  9  20972   2308 442776  56908   32    0    32 20352 1428  1810  2 24  0 74

a lot more in buffers now



ext2
----
cat /dev/zero > /mnt/whiplash/testfile

root      1799  0.0  0.0     0    0 ?        DW   01:55   0:00 [pdflush]
root      1810  0.0  0.0     0    0 ?        DW   01:55   0:00 [pdflush]

no cputime here either

root      1799  0.0  0.0 DW   [pdflush]        schedule_timeout
root      1810  0.0  0.0 DW   [pdflush]        schedule_timeout

the write has been going on for a while, the testfile is 24GB now.

 0  4  19648   2196   2664 514188    0    0     0 19696 1444  1814  2 21  0 77
 2  4  19648   6204   2668 510140    0    0   136 20740 1433  2188  7 21  0 72
 2  3  19648   4220   2688 512172    0    0     0 19968 1436  1759  1 15  0 84
 0  3  19648   4220   2756 512072    0    0    72 18760 1462  1889  2 21  0 77
 2  3  19648   3260   2760 513004    0    0     4 19704 1428  1807  2 19  0 79
 0  4  19648   2180   2748 514196    0    0     0 19200 1428  1780  2 18  0 80
 0  4  19648   2244   2748 514096    0    0     4 19872 1455  1855  3 19  0 78
 0  4  19648   2196   2748 514232    0    0   128 19628 1437  1756  2 18  0 80
 2  3  19648   6164   2756 510208    0    0     0 20208 1442  1987  1 17  0 82
 0  4  19648   4180   2752 512220    0    0     0 18764 1429  1818  3 19  0 78
 0  3  19648   6164   2752 510248    0    0     0 19756 1421  1783  1 16  0 83
 2  3  19648   6100   2752 510284    0    0     0 19512 1424  1798  2 19  0 79

ext2 uses about half the cpu compared to vfat and is a bit faster (and
better in all ways of course)

I have about twice the buffers as vfat when using ext3.


I didn't manage to provoke the kernel into executing more than two
pdflush's when using ext2 and those two never used any cpu it seems,
with vfat they did. The mke2fs made it execute more pdflush's but they
didn't use any cpu here either. It seems it's not only vfat that can
trigger all the pdflush's but it's only vfat that makes them use cpu.

The mke2fs results were obtained after the ext2 results, I saw the exact
same thing when I formatted it before the ext2 test but forgot to save
the data.

I even tried to start a second write to another disk (IDE) using ext3
but that didn't produce any more pdflush's.
I don't have another disk to try this same test on :(

The firewire disk is still unused so I can run more tests if neccessary
but it might not be unused for very long :(

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
