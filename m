Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTKNKtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 05:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTKNKtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 05:49:23 -0500
Received: from nat4-068.rz.uni-karlsruhe.de ([129.13.251.68]:62130 "EHLO
	mail.karlsruhe.org") by vger.kernel.org with ESMTP id S262327AbTKNKtV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 05:49:21 -0500
Date: Fri, 14 Nov 2003 11:49:16 +0100
From: Sven Paulus <sven@karlsruhe.org>
To: linux-kernel@vger.kernel.org
Subject: How to tune swapping in 2.4.21?
Message-ID: <20031114104916.GA6715@karlsruhe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on a i386 SMP server with 2.5GB RAM I'm seeing permant swapping activity
during times with a lot of IO (many concurrent processes accessing the
RAID quite randomly). This is the output of "vmstat 10":

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  2  0  57108   9572 386592 1517792   0   0     0     0    3     0   1   3   2
 1  2  0  57092  11504 380084 1526244   0   0  3982   816 1610  1434  10   5  85
 0  0  0  57084   9728 379964 1514116   0   0  4376   755 1801  1615  13   7  80
 2  5  0  57044  10736 381272 1513240   2   0  4317   284 1565  1354  14   7  80
 8  3  0  57012   8492 383244 1498728  45   0  4166   828 1795  1738  15   8  77
 1  1  0  56180   9928 388664 1498920  74   0  6695   770 2136  2239  35  17  49
 0  3  0  56060   7736 393356 1507672 142   0  2922   752 2529  2478  21  10  69
 1  3  0  56092   8560 394020 1515752 216   0  5031   531 1867  1686  12   6  82
 5  2  0  56684   9452 395332 1520212 114   4  3974   357 1764  1538  10   5  84
 2  0  0  57172   9168 390048 1524348   1   9  4027  1290 1669  1546  14   7  79
[...]
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0  57172   9592 390064 1524364   0   0     0     0    3     0   1   3   2
 1  1  0  51884   8712 391392 1531232  35   3  2177   630 1554  1373   9   5  85
 1  3  0  51152   8836 389544 1528080  35   7  2497   538 2080  1836  10   6  84
 1  1  0  51256  11776 387724 1522688   0  10  5100   763 1980  1886  12   6  82
 2 12  2  49724   9912 388968 1489428  13  22  2673   537 1838  1711  22  10  67
 0  1  0  49836   8488 394824 1494352  12  21  6845  1020 2287  2190  21   9  69
 0  0  0  49940  10304 396400 1491932   0  17  3690   545 1674  1507  12   6  82
 2  3  0  50932   9664 392576 1472600   0  22  4846   352 1668  1660  24  10  66
 1  1  0  50896  15596 398612 1485900   0   3  4356  1103 2073  1903  19  10  72
 0  0  0  51004   8588 399684 1484036 145 135  3866   507 1796  1743  10   4  86

As you see, there's a large amount of cache available but the kernel decides
to swap in and out all the time.

I'd rather prefer to avoid swapping since the swap partition is on the same
RAID system as part of the application data. So valuable disk performance
is eaten by needless swapping.

Are there any parameters for tuning/optimizing the kernel's bevahiour
regarding this? /proc/sys/vm/kswapd seems to be only a fake interface
(documented, implemented, but the values contained therein aren't used
inside the kernel). Kernel 2.6 seems to add a parameter called "swappiness"
but is there a 2.4 counterpart? Or is there a backport to 2.4?

Any hints how to change this behaviour are appreciated :-)

Sven
