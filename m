Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVHOM3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVHOM3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 08:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVHOM3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 08:29:12 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:41046 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932242AbVHOM3L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 08:29:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pqbz8/PSa5g3cKksOM/SMpJ3qzuF4Cir2t+YLd/dGED1RLBw4HrJhKbvbycL1A5AKzsfskSRf8EJCzVMC9Xex7ELxerBh7nU3xkOOE5p497062wKmbXPMDXEXtL2h5WZMivjALK85LZJ4hFWbova0wtk78dBHYM8Efgs7SOqKi8=
Message-ID: <6bffcb0e05081505291806f529@mail.gmail.com>
Date: Mon, 15 Aug 2005 14:29:09 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43001E18.8020707@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43001E18.8020707@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here are my benchmarks (part1):

I 2.6.12 kernel compilation. (make allyesconfig, time make all -j8)
1 cpusched=ingosched:
ng02:/usr/src/linux-2.6.12# time make all -j8
[..]
real    51m11.775s
user    77m3.995s
sys     6m21.558s

ng02:/usr/src/linux-2.6.12# cat /proc/scheduler
ingosched
ng02:/usr/src/linux-2.6.12# cat /proc/schedstat
version 12
timestamp 3032625
cpu0 0 0 56 65 20056 725377 39367 284634 251542 2852663 5866282 686010
domain0 3 247201 246814 9 8659 441 6 0 246814 253551 100978 2 9880755 1035237 0
0 100978 56894 38212 317 1194388 130553 0 0 38212 0 0 0 0 0 0 0 0 0 49185 21965
0
cpu1 2 2 28 34 10794 687909 19756 270097 220910 2489156 9673341 668153
domain0 3 425955 425489 64 10086 457 8 0 425489 234999 74921 0 10732594 1104706
0 0 74921 30461 19020 483 557020 74888 9 0 19020 4 0 4 0 0 0 0 0 0 33092 10911 0

(make clean, reboot)
2 cpusched=staircase:
ng02:/usr/src/linux-2.6.12# time make all -j8
[..]
real    51m18.411s
user    77m4.466s
sys     6m21.088s

ng02:/usr/src/linux-2.6.12# cat /proc/scheduler
staircase
ng02:/usr/src/linux-2.6.12# cat /proc/schedstat
version 12
timestamp 2923620
cpu0 0 0 0 32 0 782321 37599 249838 224187 2957912 6792042 744722
domain0 3 226474 226228 4 5382 275 0 0 226228 157369 126383 0 1440936
183339 0 0 126383 43535 37555 78 330840 43099 0 0 37555 0 0 0 0 0 0 0
0 0 42881 13959 0
cpu1 3 0 0 72 0 699310 20803 236306 193423 2374305 7938461 678507
domain0 3 483209 482873 121 7208 243 12 0 482873 156215 125870 0 1429078 180874
0 0 125870 27530 20855 46 369006 48271 1 0 20855 4 0 4 0 0 0 0 0 0 25651 11318 0

(make clean, reboot)
3 cpusched=spa_no_frills
ng02:/usr/src/linux-2.6.12# time make all -j8
[..]
real    50m55.473s
user    76m37.758s
sys     6m28.895s

ng02:/usr/src/linux-2.6.12# cat /proc/scheduler
spa_no_frills
ng02:/usr/src/linux-2.6.12# cat /proc/schedstat
version 12
timestamp 2937236
cpu0 5 0 0 43 0 294382 64307 124942 93409 2898955 6299327 230075
domain0 3 175751 175318 259 15589 798 43 0 175318 283864 76797 19
18350668 1902854 13 0 76797 56909 34856 317 1822133 191112 32 0 34856
0 0 0 0 0 0 0 0 0 60170
27084 0
cpu1 18 0 0 51 0 286827 37498 147460 87288 2413151 15080787 249329
domain0 3 416870 416337 185 13183 551 6 0 416337 258093 42302 13
19731454 2011581 0 0 42302 33769 20992 194 946407 111465 1 0 20992 2 0
2 0 0 0 0 0 0 31533 7681 0

(make clean, reboot)
4 cpusched=zaphod
ng02:/usr/src/linux-2.6.12# time make all -j8
[..]
real    53m52.574s
user    73m48.596s
sys     5m48.853s

ng02:/usr/src/linux-2.6.12# cat /proc/scheduler
zaphod
ng02:/usr/src/linux-2.6.12# cat /proc/schedstat
version 12
timestamp 4225577
cpu0 5 0 0 49 0 733488 392118 161151 120811 2581159 9380273 341370
domain0 3 865850 839777 260 2757754 249142 47 0 839777 279540 88009 6
14491544 1528097 14 0 88009 75719 47779 147 2020247 225972 24 0 47779
1 0 1 0 0 0 0 0 0 61390 26258 0
cpu1 4 0 0 48 0 695373 430877 116017 54625 2544636 10606413 264496
domain0 3 874315 843625 139 3248637 293896 4 0 843625 278969 89887 12
14529334 1516782 0 0 89887 47183 21936 155 1534811 194774 0 0 21936 1
0 1 0 0 0 0 0 0 40340 15338 0

(make clean, reboot)
5 cpusched=nicksched
ng02:/usr/src/linux-2.6.12# time make all -j8
[..]
real    51m7.138s
user    76m56.308s
sys     6m19.034s

ng02:/usr/src/linux-2.6.12# cat /proc/scheduler
nicksched
ng02:/usr/src/linux-2.6.12# cat /proc/schedstat
version 12
timestamp 2906283
cpu0 0 0 0 21239 7936 743207 36340 327597 275502 2919856 6547949 706867
domain0 3 150416 150094 12 6743 323 4 0 150094 229533 133380 2 5508151 586701 0
0 133380 45177 36163 177 530914 60273 1 0 36163 0 0 0 0 0 0 0 0 0 68129 20393 0
cpu1 0 0 0 184829 6024 702056 18740 308406 240275 2402475 6774197 683316
domain0 3 406135 405705 75 9009 366 17 0 405705 196899 102154 6
5480289 580930 0 0 102154 29084 18532 208 631650 71026 1 0 18532 1 0 1
0 0 0 0 0 0 52095 15986 0

info:
distro: debian 3.1
cpu: pentium 4 (ht enabled)

In next parts:
- time make all -j64
- time make all -j512 (it maybe very high load ;))
- interbench-0.29 tests

Suggestions, criticism are welcome.

Regards,
Michal Piotrowski
