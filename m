Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274162AbRJFMUQ>; Sat, 6 Oct 2001 08:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275122AbRJFMUG>; Sat, 6 Oct 2001 08:20:06 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:57101 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S274162AbRJFMTx>; Sat, 6 Oct 2001 08:19:53 -0400
Date: Sat, 6 Oct 2001 13:20:23 +0100 (BST)
From: <chris@scary.beasts.org>
X-X-Sender: <cevans@sphinx.mythic-beasts.com>
To: <linux-kernel@vger.kernel.org>
Subject: VM: 2.4.10ac4 vs. 2.4.11pre2
Message-ID: <Pine.LNX.4.33.0110061252450.17262-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here are some test results. Results are averaged over multiple runs.
Comments and conclusions below.

                     2.4.11pre2        2.4.10ac4
dbench 8             34Mbyte/sec       40Mbyte/sec
dbench 32            7.7Mbyte/sec      14Mbyte/sec
bonnie++ write       17.5Mbyte/sec     18Mbyte/sec
bonnie++ rewrite     5.6Mbyte/sec      5.8Mbyte/sec
bonnie++ read        24Mbyte/sec       24.5Mbyte/sec
kernel stress build  212min24s         229m54s
linear swap test     1m30s             2m15s
bonnie++ creat()     7200              9600  [*]
bonnie++ stat()      2100              9000  [*]
bonnie++ unlink()    5300              30000 [*]

[*] either the ext2 directory optimization in 2.4.10ac is influencing the
test, or 2.4.11pre2 VM has a problem caching inodes.

Comments + conclusions
----------------------

- The 2.4.11pre2 VM is considerably more stable, where "stable" is defined
as repeatable test scores and consistent performance. The 2.4.10ac4 VM is
all over the place.

- Both kernels exhibit similar interactive response under load.

- The 2.4.11pre2 VM performs substantially better in tests which invoke
swapping.

- Surprisingly, the 2.4.10ac4 kernel does much much better at dbench. The
2.4.11pre2 performance is alleged to have regressed since 2.4.10pre10?

- I have not tried 2.4.11pre4, but the report of streaming i/o causing
swapping is concerning.


Note that the above results were generated using a very simple (and
extensible) script. VM developers would do well to spend the 30 seconds
writing a similar script, and post results along with proposed VM patches.

Cheers
Chris

