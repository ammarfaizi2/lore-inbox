Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262483AbSI2OK5>; Sun, 29 Sep 2002 10:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262485AbSI2OK5>; Sun, 29 Sep 2002 10:10:57 -0400
Received: from mail-3.tiscali.it ([195.130.225.149]:22099 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S262483AbSI2OKz> convert rfc822-to-8bit;
	Sun, 29 Sep 2002 10:10:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>
Organization: -ENOENT
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: qsbench, interesting results
Date: Sun, 29 Sep 2002 16:15:24 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209291615.24158.l.allegrucci@tiscalinet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


qsbench is a VM benchmark based on sorting a large array
by quick sort.
http://web.tiscali.it/allegrucci/qsbench-1.0.0.tar.gz

Below are some results of qsbench sorting a 350Mb array
on a 256+400Mb RAM+swap machine.
Tested kernels: 2.4.19, 2.5.38 and 2.5.39
All runs made with the same default seed, to compare
apples with apples :)
I used /usr/bin/time because it gives better statistics
such as major and minor page faults etc.
(Sorry for >72 cols).


2.4.19
bash-2.05# /usr/bin/time ./qsbench -m 350
46.29user 3.54system 2:34.66elapsed 32%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (24739major+370199minor)pagefaults 0swaps
bash-2.05# /usr/bin/time ./qsbench -m 350
46.57user 3.27system 2:35.73elapsed 32%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (24493major+370706minor)pagefaults 0swaps
bash-2.05# /usr/bin/time ./qsbench -m 350
46.61user 3.09system 2:35.91elapsed 31%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (24560major+370571minor)pagefaults 0swaps

Perfectly reproducible performance.


2.5.38
bash-2.05# /usr/bin/time ./qsbench -m 350
ERROR: i = 7766682
 *** WARNING ***  1 errors.
47.11user 3.57system 3:42.19elapsed 22%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (39875major+439626minor)pagefaults 0swaps
bash-2.05# /usr/bin/time ./qsbench -m 350
46.80user 3.68system 3:42.20elapsed 22%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (39336major+441350minor)pagefaults 0swaps
bash-2.05# /usr/bin/time ./qsbench -m 350
46.87user 3.70system 3:44.50elapsed 22%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (39926major+440091minor)pagefaults 0swaps

This is interesting, qsbench got an array not "quite" sorted.
I have run qsbench a lot of times in the past on many kernels
and I have never seen such error.
I don't think it's my hardware fault so I would like to know
if somebody can reproduce it.
Performance is worse than 2.4.19


2.5.39
bash-2.05# /usr/bin/time ./qsbench -m 350
46.94user 4.41system 8:17.94elapsed 10%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (66343major+455167minor)pagefaults 0swaps
bash-2.05# /usr/bin/time ./qsbench -m 350
46.74user 4.64system 8:45.03elapsed 9%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (68600major+454782minor)pagefaults 0swaps
bash-2.05# /usr/bin/time ./qsbench -m 350
46.81user 4.31system 8:37.07elapsed 9%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (69090major+454355minor)pagefaults 0swaps

Big performance drop.


Comments?

