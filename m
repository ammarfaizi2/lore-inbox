Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSEFR6p>; Mon, 6 May 2002 13:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314635AbSEFR6o>; Mon, 6 May 2002 13:58:44 -0400
Received: from pD952A9B9.dip.t-dialin.net ([217.82.169.185]:20104 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314634AbSEFR6n>; Mon, 6 May 2002 13:58:43 -0400
Date: Mon, 6 May 2002 11:58:42 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: gzip vs. bzip2 (mainly de-)compression "benchmark"
Message-ID: <Pine.LNX.4.44.0205061152480.19017-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

gzipping, bzip2ing a solaris disk image from my old sparc64 under alpha
(approx. 2 GiB) and relative load.
This has been done for testing purposes for those fiddling around with the 
kernel compression algorithms.

# ls -l ; ls -lh
-rw-r--r--    1 root     root   2164082688 May  5 04:41 old-root
-rw-r--r--    1 root     root         2.0G May  5 04:41 old-root

# time gzip -9n old-root
9035.15user 119.40system 11:38:12elapsed 21%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (166major+112minor)pagefaults 0swaps

# ls -l ; ls -lh
-rw-r--r--    1 65534    65534   546148165 May  2 11:30 old-root.gz
-rw-r--r--    1 65534    65534        521M May  2 11:30 old-root.gz

# time gzip -cd old-root.gz > /dev/null
134.11user 66.22system 10:42.91elapsed 31%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (102major+37minor)pagefaults 0swaps

# time bzip2 -9z old-root
(Unfortunately crashed shortly after completion when I modprobed khttpd and
tried to make a connection. I can redo that if you are interested in the
results, but I tell you it took some time... user was in the 11,000 I 
remember.)

# ls -l ; ls -lh
-rw-r--r--    1 root     root    496780930 May  5 04:41 old-root.bz2
-rw-r--r--    1 root     root         474M May  5 04:41 old-root.bz2

# time bzip2 -cdk old-root.bz2 > /dev/null
1010.44user 33.15system 58:12.14elapsed 29%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (117major+914minor)pagefaults 0swaps

Penguin: Linux 2.4.8 (didn't have time to compile the latest here) on an
	 Alpha 300, 384 MiB RAM. Meanwhile someone was compiling Redhat
	 Package Manager v4.1, later the Linux Kernel v2.4 repository.

Regards,
Thunder
-- 
if (errno == ENOTAVAIL)
    fprintf(stderr, "Error: Talking to Microsoft server!\n");

