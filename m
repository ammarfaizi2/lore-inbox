Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267000AbUBFA4w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267073AbUBFA4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:56:52 -0500
Received: from gprs146-127.eurotel.cz ([160.218.146.127]:49537 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267000AbUBFA4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:56:47 -0500
Date: Fri, 6 Feb 2004 01:56:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.2 extremely unresponsive after rsync backup
Message-ID: <20040206005633.GA1776@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I did 

rsync -zavP --exclude=/proc --exclude=/sys --delete -essh / root@hobit:/big/amd.backup/

(well, originally without those --excludes)

now that is half an hour in past, but system is still extremely
unresponsive. galeon is unusable, even emacs/mutt is slowed down
considerably. gpm is unusable (its timings are messed up so double
clicks no longer work, and for some reason pasting fails too)

vmstat shows (galeon is trying to close itself..., this is 256M machine)

 0  4  51652   1700   1620  10132    0    0  2704     0 1157   284  0  0  0 100
 0  6  51652   1828   1636   9956    0    0  2548     0 1151   325  1  0  0 99
 0  3  51652   1588   1624  10188    0    0  2996     4 1181   327  0  1  0 99
 0  7  51652   1868   1632   9884    0    0  3068     0 1160   311  0  1  0 99
 0  5  52004   1924   1640  10236    0  468  2856   468 1390   361  0  4  0 96
 0  5  52004   1524   1656  10648   28    0  3116     0 1175   305  0  5  0 95
 0  4  52004   1692   1640  10404    0    4  2300     4 1141   273  0  0  0 100
 0  6  52004   1524   1636  10568   20    0  3428     0 1537   397  1  0  0 99
 0  6  52004   1636   1632  10468   36    0  2080     0 1178   226  1  0  0 99
 0  6  52004   2196   1624   9804    0    0  3312     0 1349   352  0  1  0 99
 0  7  52004   1524   1628  10500    0    0  3180     0 1326   321  0  1  0 99
 0  2  52004   2308   1636   9632   28    0  2408     0 1198   288  0  1  0 99
 0  3  52004   1748   1628  10192    0    0  3252     0 1376   340  0  0  0 100
 0  4  52004   1972   1628   9968    4    0  3056     0 1234   378  0  1  0 99
 0  6  52004   1972   1644   9868   64    0  4316     0 1400   365  2  1  0 98
 0  2  52004   2140   1644   9708    0    0  2860    12 1212   263  0  1  0 99
 0  4  52004   1804   1648  10064    0    0  3460     0 1246   362  0  1  0 99
 0  5  52004   1972   1644   9940    0    0  3284     0 1314   341  0  1  0 99
 0  4  52004   1636   1644  10228    0    0  3076     0 1298   309  0  0  0 100
 0  6  52004   1916   1652   9980    0    0  3072    12 1396   338  0  6  0 94
 0  7  52016   2084   1624   9708   80  120  2832   120 1340   289  2  6  0 93
 0  6  52068   1628   1624  10544    0  192  2284   192 1657   241  1  1  0 98
 0  5  52068   1460   1628  10904    0    0  3200     0 1348   300  0  2  0 98
 0  4  52068   1852   1652  10524    0    0  3488    12 1431   328  0  2  0 98
 0  3  52068   1460   1648  10940    0    4  3140    16 1376   364  0  2  0 98
 0  5  52068   1628   1644  10804   24    0  2956     4 1384   344  0  2  0 98
 0  6  52068   1572   1656  10820    8    0  4160     4 1668   438  0  2  0 98
 0  4  52068   1532   1652  10848    0    0  3012    16 1335   336  0  6  0 94
 0  7  52068   1756   1648  10696    0    0  3048     0 1367   296  0 14  0 86
 0  8  52068   1924   1656  10424    0    0  3592     4 1323   365  1  1  0 98
 0  8  52068   1812   1652  10556    0    0  2740     0 1177   223  2 11  0 87
 1  6  52068   1540   1652  10780    0    0  2544     0 1394   312  0  1  0 99
 0  6  52068   1924   1652  10260    0    0  2612     0 1324   369  0  7  0 93
 0  4  52068   2260   1640   9992    8    0  2520     0 1261   283  0 14  0 86
 0  5  52068   2204   1644   9792   56    0  2356     4 1308   296  0  0  0 100
 0  4  52068   1812   1644  10284    8    0  2208     8 1214   259  0 11  0 89

Meanwhile:

cat /proc/slabinfo | grep ext2:

ext2_inode_cache  351853 351876    512    7    1 : tunables   54   27    0 : slabdata  50268  50268      0

Looks like 175MB is eaten by ext2 (do I read it correctly?)

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
