Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271613AbRIBMs1>; Sun, 2 Sep 2001 08:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271614AbRIBMsG>; Sun, 2 Sep 2001 08:48:06 -0400
Received: from mx1.port.ru ([194.67.57.11]:14599 "EHLO smtp1.port.ru")
	by vger.kernel.org with ESMTP id <S271613AbRIBMsA>;
	Sun, 2 Sep 2001 08:48:00 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109021710.f82HAbD00606@vegae.deep.net>
Subject: Rik`s ac12-pmap2 vs ac12-vanilla perfcomp
To: linux-kernel@vger.kernel.org
Date: Sun, 2 Sep 2001 17:10:35 +0000 (UTC)
Cc: riel@surriel.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

         Hello there, i just came with some benchmarks:
   Done on p166-24M
 
   No flames please - i know these were low VM loads, i did this just to know 
how big is test rmaps maitenance overhead. It shows us that even on low VM
load there is a huge win in using rmap. And the win increases with the VM load.
   Algo:
      - booted ac12
      - performed test A 7 times, then test B 7 times.
      - booted ac12-pmap2
      - performed test A 7 times, then test B 7 times.

      * each test was done 7 times, with the lowest and highest thrown away.
      * due to high values of data and streaming usage pattern caching was 
 unable to affect results, so it was ignored.

test A:
"time find / -xdev" + (standard junk eating ~6% cpu (top procinfo))
  descr: extremely low VM load, mostly IO dependent

test B:
"time find / -xdev | grep --regexp="\/" | xargs echo" + background mpg123 +
 + standard junk described above
  descr: low, although higher than A, vm load (nearly absolutely no swap)

Results:
        ac12            ac12-pmap2
===[ test A: find / -xdev
real    1m4.221s        0m56.916s
real    1m3.042s        0m57.275s
real    1m3.613s        0m57.606s
real    1m3.442s        0m57.166s
real    1m3.447s        0m56.895s
======================================
avg     63.553 sec      57.171 sec	11% win

sys     0m36.750s       0m31.980s
sys     0m37.190s       0m31.870s
sys     0m36.720s       0m32.300s
sys     0m36.650s       0m32.400s
sys     0m37.350s       0m32.270s
======================================
avg     36.93 sec       32.16 sec	13% win



===[ test B: find / -xdev | grep --regexp="\/" | xargs echo (with mpg123 in bgrnd
 eating 4M+ buf + 15-20% CPU)
real    0m38.720s       0m31.018s
real    0m38.061s       0m30.318s
real    0m38.075s       0m31.980s
real    0m37.626s       0m31.149s
real    0m38.431s       0m30.820s
======================================
avg     38.182 sec      31.057 sec	19% win

sys     0m16.090s       0m13.910s
sys     0m15.820s       0m13.610s
sys     0m15.750s       0m13.710s
sys     0m15.700s       0m13.780s
sys     0m15.750s       0m13.790s
======================================
avg     15.82 sec       13.76 sec	14% win



cheers,
 Sam
