Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUCIP6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUCIP6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:58:42 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14599
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262009AbUCIP6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:58:37 -0500
Date: Tue, 9 Mar 2004 16:59:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [lockup] Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309155917.GH8193@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu> <20040309110233.GA3819@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309110233.GA3819@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 12:02:33PM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > To reproduce, run the attached, very simple test-mmap.c code (as
> > unprivileged user) which maps 80MB worth of shared memory in a
> > finegrained way, creating ~19K vmas, and sleeps. Keep this process
> > around.
> 
> or run the attached test-mmap2.c code, which simulates a very small DB
> app using only 1800 vmas per process: it only maps 8 MB of shm and
> spawns 32 processes. This has an even more lethal effect than the
> previous code.

this use more cpu than the previous one, but no other differences.

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 8  1  14660 978284    972  17016  387  350   453   353  308  1129  1 12 48 40
33  1  14660 759788    972 231692    0    0     0     0 1087 16282 12 88  0  0
40  2  14660 655220    972 332332    0    0     0     0 1087    96 15 85  0  0
47  0  14660 562372    972 421208    0    0     0     0 1086    97 15 85  0  0
52  0  14660 476412   1048 502656   76    0   300     0 1119   267 17 83  0  0
55  0  14660 397092   1064 578256    0    0     0   112 1089    97 15 85  0  0
62  1  14660 332844   1064 638436    0    0    40     0 1088    95 17 83  0  0
68  0  14648 260072   1072 707732    0    0    76     0 1093   179 15 85  0  0
68  0  14648 198184   1072 765804    0    0     0     0 1088    82 16 84  0  0
75  0  14648 136496   1072 823468    0    0     0     0 1086    84 16 84  0  0
75  0  14648  98544   1072 857604    0    0     0     0 1087    71 17 83  0  0
82  0  14648  30732   1084 921376    0    0     0    76 1089    90 16 84  0  0
84  5  14648   2104    444 947844    0   76     0   192 1130    76 15 85  0  0
83 27  18028   2464    228 944140  428 3216   428  3216 1142   577 10 90  0  0
71 75  22800   3744    224 943120  912 5560  1168  5560 1502  3351  6 91  0  3
82 55  25424   3464    236 940624  760 2848   856  2848 1222   764 12 88  0  0
84 59  27012   2104    240 939040 1128 1796  1172  1796 1182   762 10 90  0  0
73 80  29308   2480    164 938476 2364 3212  2364  3236 1526  5685  4 74  0 21
81 81  33296   2656    144 937492 2456 4920  3356  4920 2275  7953  2 62  0 36
81 81  36172   2576    144 935168 3300 4484  4364  4484 1751  5622  5 86  0  9
88 83  38828   2884    136 933532 2592 3828  3376  3828 1690  8162  1 57  0 42
62 84  42196   3368    132 932992 1472 3864  2136  3864 1291  4127  4 78  0 18
74 71  46624   3660    112 929492 1828 4972  2916  4972 1395  3104  6 83  0 11
 1 89  48572   2920    112 929436 2036 2852  2752  2852 1355  5284  8 76  0 16
31 86  52428   3588    104 926436 1416 4432  1620  4432 1253  4271  0 43  0 57
46 86  58288   1988    108 926460 1740 6644  2872  6644 1309  5233  9 88  0  3
56 87  61452   2376     96 927664 2332 4032  3460  4032 1443  9227  1 73  0 26
 3 118  73588   2484     88 924492 4128 14928  5576 14928 2357 33401  0 59  1 40
36 137  78656   2532     88 925692 1804 4356  2520  4356 1420 29642  0 60  2 37
 1 153  80380   2180     88 926112 2676 5644  3700  5644 1798 17355  0 77  0 22
90 170  86396   2588     88 925000 3104 4208  3872  4208 2179 33189  0 76  0 24
58 174  90768   2172     88 925016 4816 5624  6600  5624 2884 31681  0 75  0 24
82 179  94680   2912     88 923424 8772 10016 10568 10016 2625 30269  0 74  0 26
14 184 101480   2260     84 923388 4752 5992  6456  5992 4369 49544  0 70  0 30
 3 206 110620   2208     92 921608 8396 12016 11276 12016 4993 81573  0 71  0 29
 2 207 114788   2984     88 921720 2196 5180  3348  5180 1423 18939  0 62  0 38
13 204 117344   2348     88 923060 3960 3608  5276  3608 2807 20612  0 90  0 10
145 202 123920   2092     88 922752 9108 11316 12584 11316 3131 34221  0 72  0 28
 3 206 131008   2024     84 920800 7948 10888  9828 10888 5424 57225  0 78  0 21
 2 207 140124   2144     88 922312 8968 9368 12512  9368 6789 75225  0 71  0 28
37 208 148108   2468     80 921396 14540 15120 20632 15120 8226 74565  0 82  0 18
 4 205 157620   2184    108 921120 5592 7908  8468  7908 5713 56264  0 72  0 28
 2 206 160540   2792    100 920836 2132 3736  4312  3736 1752 13193  0 79  0 21
 2 207 168176   2564     96 920332 10680 14340 14300 14340 5805 46868  0 81  0 19
195 207 183436   2684     88 919632 9056 13756 14824 13756 7322 73112  0 74  0 26
 1 210 188696   2152    108 920092 5620 8792  9124  8816 2539 30646  0 65  0 35
 2 205 196888   2760     92 918844 4584 6512  6128  6512 3842 47524  0 69  0 31
123 203 198992   2648     92 919996 2776 3292  3564  3292 1637 17687  0 77  0 23
 2 204 203276   2100     92 919012 2848 5100  4092  5100 1682 20360  0 57  0 42
 2 206 206956   2244     84 921068 6724 7744 10060  7744 3257 25261  0 80  0 20
 4 205 218928   2612     96 917692 10124 13580 13968 13580 6812 57570  0 79  0 20
 1 205 226656   1948     96 919004 7460 10504  9888 10504 4342 78518  0 62  0 38
 2 204 235688   2292     96 918884 4640 7472  6540  7472 2570 31259  0 63  0 37
 1 206 239712   2244     92 919104 2348 3436  3060  3436 1542 12147  0 69  0 30

no lockup at all. swap rate wasn't horrible either.

anyways we should try again after we made the code smarter, there's some
room for improvements. and if page_referenced is being hitten more frequently,
there may be a fundamental issue in the caller not in the method.  Could be we
call it too frequently. We can also join the two things into one single pass,
so we don't call it twice if none of the pte is young.  Currently we'd call it
twice before we run the unmap pass, if we free with two passes we would reduce
the overhead of 33%.

overall this is just working not too bad for me, I can stop any task
fine and things keeps running. As soon as the swap load stops cpu goes
back idle.

Note that most of the time even if we have to swap several gigabytes,
the time we "swap" those gigabytes is pretty small. A machine swapping
constantly several gigabytes in a loop would be hardly usable, what
matters is that the box is fast on the _workingset_ after the not used
part of the memory is being moved into swap, and wasting gigs of ram in
pte_chains will be worse in 64bit than using more cpu while moving the
not used part of ram into swap. If moving into swap is slow, it's not a
big problem. If the machines trashes all the time like in the above,
then there's little hope that it will perform well, w/ or w/o cpu system
load. The important thing is that this cpu load during swap doesn't
destroy all the address space in a flood like with the pagetable walk,
so the machine remains responsive even if we hit a long vma walk once in
a while to swap 1M.
