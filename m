Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbTIDRhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbTIDRha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:37:30 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:13199 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S265188AbTIDRhR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:37:17 -0400
Date: Thu, 4 Sep 2003 19:37:09 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jamie Lokier <jamie@shareable.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <20030901101224.GB1638@mail.jlokier.co.uk>
Message-ID: <Pine.GSO.3.96.1030902185349.27216M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003, Jamie Lokier wrote:

> Please try the program below, which is the same as before but with
> test_l1_only hopefully improved, and it prints some more helpful
> numbers.

 A few MIPS systems:

1. An R3400-based DECstation 5000/240 -- the CPU has a 64kB I-cache and a
64kB D-cache, both are direct mapped, PIPT:

$ uname -a
Linux 3maxp 2.4.21 #3 Thu Aug 14 04:14:33 CEST 2003 mips unknown unknown GNU/Linux
$ time ./test
(256) [155,155,7] Test separation: 4096 bytes: pass
(256) [155,155,7] Test separation: 8192 bytes: pass
(256) [155,155,7] Test separation: 16384 bytes: pass
(256) [155,155,7] Test separation: 32768 bytes: pass
(256) [155,155,7] Test separation: 65536 bytes: pass
(256) [155,155,7] Test separation: 131072 bytes: pass
(256) [155,155,7] Test separation: 262144 bytes: pass
(256) [155,155,7] Test separation: 524288 bytes: pass
(256) [155,155,7] Test separation: 1048576 bytes: pass
(256) [155,155,7] Test separation: 2097152 bytes: pass
(256) [155,155,7] Test separation: 4194304 bytes: pass
(256) [155,155,7] Test separation: 8388608 bytes: pass
(256) [155,155,7] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed
1.01user 0.27system 0:01.33elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (135major+44minor)pagefaults 0swaps
$ cat /proc/cpuinfo
system type		: Digital DECstation 5000/2x0
processor		: 0
cpu model		: R3000A V3.0  FPU V4.0
BogoMIPS		: 39.90
wait instruction	: no
microsecond timers	: no
tlb_entries		: 64
extra interrupt vector	: no
hardware watchpoint	: no
VCED exceptions		: not available
VCEI exceptions		: not available

2. An R4400SC-based DECstation 5000/260 -- the CPU has a 16kB primary
I-cache and a 16kB primary D-cache, both are direct mapped, VIPT, and a
1024kB secondary joint (I+D) cache, direct mapped, PIPT:

$ uname -a
Linux 4maxp64 2.4.21 #19 Mon Aug 25 00:16:25 CEST 2003 mips64 unknown unknown GNU/Linux
$ time ./test
(64) [331,17,3] Test separation: 4096 bytes: FAIL - too slow
(64) [331,17,3] Test separation: 8192 bytes: FAIL - too slow
(128) [38,63,3] Test separation: 16384 bytes: pass
(128) [38,63,3] Test separation: 32768 bytes: pass
(128) [38,63,3] Test separation: 65536 bytes: pass
(128) [38,63,3] Test separation: 131072 bytes: pass
(128) [38,63,3] Test separation: 262144 bytes: pass
(128) [38,63,3] Test separation: 524288 bytes: pass
(128) [38,63,3] Test separation: 1048576 bytes: pass
(128) [38,63,3] Test separation: 2097152 bytes: pass
(128) [38,63,3] Test separation: 4194304 bytes: pass
(128) [38,63,3] Test separation: 8388608 bytes: pass
(128) [38,63,3] Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 16384 (4 pages)
0.34user 0.14system 0:00.53elapsed 89%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (135major+250minor)pagefaults 0swaps
$ cat /proc/cpuinfo
system type		: Digital DECstation 5000/2x0
processor		: 0
cpu model		: R4400SC V4.0  FPU V0.0
BogoMIPS		: 59.86
wait instruction	: no
microsecond timers	: yes
tlb_entries		: 48
extra interrupt vector	: no
hardware watchpoint	: yes
VCED exceptions		: 464662
VCEI exceptions		: 667534

3. A MIPS 5Kc-based Malta -- the CPU has a 16kB I-cache and a 16kB
D-cache, both are 4-way set associative, VIPT: 

$ uname -a
Linux malta 2.4.21 #5 Sun Aug 3 21:51:32 CEST 2003 mips unknown unknown GNU/Linux
$ time ./test
(128) [25,23,1] Test separation: 4096 bytes: pass
(128) [25,23,1] Test separation: 8192 bytes: pass
(128) [25,23,1] Test separation: 16384 bytes: pass
(128) [25,23,1] Test separation: 32768 bytes: pass
(256) [49,46,1] Test separation: 65536 bytes: pass
(128) [25,23,1] Test separation: 131072 bytes: pass
(128) [25,23,1] Test separation: 262144 bytes: pass
(256) [49,46,1] Test separation: 524288 bytes: pass
(256) [49,46,1] Test separation: 1048576 bytes: pass
(256) [49,46,1] Test separation: 2097152 bytes: pass
(256) [48,45,2] Test separation: 4194304 bytes: pass
(256) [49,46,1] Test separation: 8388608 bytes: pass
(128) [25,23,1] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed
0.22user 0.06system 0:00.30elapsed 93%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (135major+44minor)pagefaults 0swaps
$ cat /proc/cpuinfo
system type		: MIPS Malta
processor		: 0
cpu model		: MIPS 5Kc V0.1
BogoMIPS		: 159.74
wait instruction	: yes
microsecond timers	: yes
tlb_entries		: 32
extra interrupt vector	: yes
hardware watchpoint	: yes
VCED exceptions		: not available
VCEI exceptions		: not available

 The slowdown for the R4400SC processor is surely the result of Virtual
Coherency Exceptions (reported in cpuinfo for both primary caches) -- the
secondary cache (S-cache) remembers a few bits of the virtual address (VA)
and if there is a hit in the S-cache, but the VA bits don't match, an
exception is taken to write back and invalidate the old entry from the
respective primary cache (P-cache) and reset the VA bits to the new value.
Then a reexecution of the faulting instruction does a refill to the
P-cache from the S-cache.  This problem doesn't happen for the two other
processors as neither has an S-cache and also the R3400's P-cache is PIPT. 

 We avoid the hit resulting from cache aliasing for MIPS by aligning maps
appropriately. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

