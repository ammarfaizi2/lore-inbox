Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUEBAiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUEBAiR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 20:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUEBAiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 20:38:17 -0400
Received: from main.gmane.org ([80.91.224.249]:23445 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262837AbUEBAiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 20:38:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.6.6-rc3-mm1
Date: Sun, 2 May 2004 00:38:04 +0000 (UTC)
Message-ID: <slrnc98gnc.cgh.psavo@varg.dyndns.org>
References: <20040430014658.112a6181.akpm@osdl.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc3/2.6.6-rc3-mm1/

I'm having severe interactivity problems with 2.6 tree on a dual Athlon system.
I mostly get 'X screen freezes/mouse pointer immovable for a several
seconds' and rather often audio skips.

I can't really pinpoint it on some activity, but I can trigger this easily
just by switching working desktops. Applications I use are not really
anything special (sorted by virtual memory usage):

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 1352 root      15   0  144m  43m  65m S  1.3  8.6 109:24.39 XFree86
31502 pvsavola  15   0  142m  32m  66m S  0.3  6.4   1:58.98 opera
31707 pvsavola  15   0  101m  29m  30m S  0.0  5.9   3:05.41 firefox-bin
31040 pvsavola  15   0 63216 8572  20m S  0.7  1.7   0:28.09 xmms
31805 pvsavola  15   0 42012  14m  21m S  0.0  2.9   0:16.30 straw
 4466 pvsavola  15   0 39800  34m  13m S  0.0  6.9   0:04.01 gimp-2.0
31508 privoxy   16   0 36180  896 1904 S  0.0  0.2   0:00.09 privoxy

Most degenerate case comes however when _closing_ some application,
especially if it has been dropped into swap. Below is 'vmstat 1' of my
shutting down (swapped-out) GIMP2.0 after I load some other memory-hungry
applications. 'freeze' and 'unfreeze' mark points at which vmstats
output really comes onto terminal.

-I really pushed 'close' on GIMP half-a minute earlier-
         procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
timestamp r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
03:27:39  0  2 381196   4416    320  21836 1744    0  1768     0 1615  2798  3  3 37 58
03:27:40  0  2 381196   3120    328  21896 1224    0  1240    44 1654  2812  3  3 50 43
03:27:41  0  2 381192   4276    296  22844  116    0  2312     4 1778  2907  4  4 32 60
03:27:42  0  1 381024   3584    304  23288  372    0   912    16 1668  2707 10  3 32 56
03:27:43  0  1 381024   3904    292  23288  896    0   920     4 1651  1244  3  3 49 45
03:27:44  0  2 381024   4112    296  23492  724    0   848     0 1628  1069  3  2 32 64
03:27:45  0  2 381024   3248    308  23476  548    0   632    12 1639  1391  4  2 34 61
03:27:46  0  2 381020   3952    312  24552   56    0  2312    28 1737  2993  5  5 25 66
03:27:47  1  3 381020   2976    316  25076  356    0  1004    12 1749  2756  5  4 14 77
03:27:48  1  2 380308   3864    324  25164 1244    0  1276     4 1684  2821  5  4 38 55
03:27:49  0  3 380116   3224    324  25160 1312    0  1356     0 1659  2561 10  3 38 50
03:27:50  0  3 380116   3408    332  24408  880    0   904    40 1656  1106  4  1 28 66
03:27:51  1  2 380116   3104    388  24420  448    0   968     4 1639  2078  4  3 34 60
03:27:52  0  2 378492   3400    424  24888  640    0  1376    16 1719  2773  8  5 27 60
03:27:53  0  3 378484   4112    400  24296 1304    0  1328     0 1686  1626  5  2 34 60
03:27:54  0  4 378484   3224    404  24232 1536    0  1624     0 1693  1006  4  2 40 54
03:27:55  1  0 378484   3680    428  23624 1048    0  1116     0 1688  2772  9  3 48 39
03:27:56 procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
03:27:56  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
03:27:56  1  3 378484   3896    404  23680  200    0  1364   436 1731  2914 11  5 24 60
03:27:57  0  2 378484   3272    452  23816   88    0   604     0 1640  2810  6  3 45 46
-freeze-
03:27:58  0  2 258376 106600    456  24128  216    0  1188     4 1637  2311  4  5 40 51
03:27:59  0  2 258376 105400    464  24156 1120    0  1120    48 1702  1018  1  2 50 47
03:28:00  0  1 258360 104776    464  23384 1188    0  1188     0 1675   880  0  2 50 49
03:28:01  0  2 258360 103432    472  23360 1240    0  1240    16 1707   940  0  1 25 73
03:28:02  0  1 258360 102216    472  23392  988    0   988     0 1675   748  0  1 50 49
03:28:03  0  1 258360 101132    472  23368  908    0   908     0 1667   706  1  1 50 49
03:28:04  0  1 258360  99920    472  23320 1136    0  1136     0 1637   744  1  1 50 49
03:28:05  0  1 258360  98752    472  23312 1028    0  1028     0 1635   743  0  2 50 49
03:28:06  0  1 258360  97280    488  23360 1228    0  1228    28 1703   822  0  1 26 73
03:28:07  0  1 258360  95936    488  23324 1124    0  1124     0 1669   741  1  2 50 49
03:28:08  0  1 258360  94784    488  23336 1008    0  1008     0 1672   726  0  1 50 49
03:28:09  0  1 258360  93616    488  23340 1220    0  1220     0 1677   726  0  0 50 49
03:28:10  0  1 258360  92464    488  23332 1096    0  1096     0 1673   736  0  2 50 48
03:28:11  0  2 258360  91376    492  23320  960    0   960    12 1649   691  0  1 33 65
03:28:12  0  2 258360  90544    504  23340  716    0   716    16 1635   741  0  1 16 83
03:28:13  0  1 258360  89432    504  23312 1048    0  1048     0 1631   585  0  2 50 47
03:28:14  0  1 258360  88408    504  23276  988    0   988     0 1609   616  0  1 50 49
03:28:15  0  4 258360  88860    524  23872  472    0   856     0 1608   800  8  2 33 57
03:28:16  0  4 258360  84428    552  28124  208    0  4700    12 1606   593  1  2 49 48
03:28:17 procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
03:28:17  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
03:28:17  1  1 258360  82764    560  28812 1004    0  1692     4 1735  1736  5  2 34 59
03:28:18  0  0 258360  82508    568  28872    0    0     0    52 1560  2844  5  2 90  2
-unfreeze-
03:28:19  1  0 258360  82516    568  28872    0    0     0     0 1553  2770  5  3 93  0
03:28:20  0  0 258360  82516    568  28872    0    0     0     0 1550  2793  5  2 93  0
03:28:21  0  0 258360  82604    576  28864    0    0     8     0 1458  2635  4  2 94  1
03:28:22  0  0 258360  82604    584  28856    0    0     0    16 1551  2674  4  2 93  0


I've also wondered a bit about slabtop, is this really OK for half-a-day
uptime and not really changing since?:

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
348220 348135  99%    0.19K  17411       20     69644K dentry_cache
313138 313049  99%    0.50K  44734        7    178936K ext3_inode_cache
 10530   7354  69%    0.05K    135       78       540K buffer_head


This machine is rather standard 2xAthlon/512MB, 1G swap/UDMA2 disk.

Is there anything I can do to help solve this?


Thanks.
-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

