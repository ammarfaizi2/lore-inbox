Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269649AbRHSAY6>; Sat, 18 Aug 2001 20:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269693AbRHSAYu>; Sat, 18 Aug 2001 20:24:50 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30560 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269649AbRHSAYh>; Sat, 18 Aug 2001 20:24:37 -0400
Date: Sun, 19 Aug 2001 02:25:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: first benchmark results of mmap-rb-4 [Re: 2.4.9aa2 and please test mmap-rb-4]
Message-ID: <20010819022500.O1719@athlon.random>
In-Reply-To: <20010818060615.A1719@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010818060615.A1719@athlon.random>; from andrea@suse.de on Sat, Aug 18, 2001 at 06:06:15AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2001 at 06:06:15AM +0200, Andrea Arcangeli wrote:
> Only in 2.4.9aa1: 70_mmap-rb-3
> Only in 2.4.9aa2: 70_mmap-rb-4
> 
> 	Fixed severe bug that caused mm corruption and crashes. (splitted a
> 	__vma_link_file off __vma_link_rb, build_mmap_rb must not mess with
> 	anything but the rb itself) Improved other bits to cover all the
> 	merging cases and some minor optimization.
> 
> 	Since I couldn't find other issues in my workloads I'd now ask
> 	everybody who complained about the lack of vma merging in 2.4 to test
> 	this patch on their systems and to report the performance difference
> 	while running their vma intensive applications. Thanks!
> 
> 	You don't need to use the -aa tree to test this patch, I ported it
> 	on top of 2.4.9 vanilla too, you can find it here:
> 
> 		ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.9/mmap-rb-4

I benchmarked it a little bit here.

Test run on a PII SMP 450mhz on top of 2.4.9aa2.

---------------------------------------------------------------------------
With_out_ the mmap-rb-4 patch applied:

GROWSDOWNMERGE:

andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownmerge

real    0m0.230s
user    0m0.020s
sys     0m0.210s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownmerge

real    0m0.230s
user    0m0.030s
sys     0m0.200s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownmerge

real    0m0.230s
user    0m0.030s
sys     0m0.200s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownmerge

real    0m0.231s
user    0m0.010s
sys     0m0.220s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownmerge

real    0m0.231s
user    0m0.030s
sys     0m0.200s
andrea@laser:/misc/andrea-athlon/vma-merging > 

GROWSDOWNNOMERGE:

andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownnomerge

real    0m0.231s
user    0m0.040s
sys     0m0.190s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownnomerge

real    0m0.228s
user    0m0.030s
sys     0m0.190s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownnomerge

real    0m0.230s
user    0m0.050s
sys     0m0.180s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownnomerge

real    0m0.230s
user    0m0.010s
sys     0m0.220s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownnomerge

real    0m0.230s
user    0m0.010s
sys     0m0.220s
andrea@laser:/misc/andrea-athlon/vma-merging > 

GROWSUPMERGE:

andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupmerge

real    0m0.096s
user    0m0.010s
sys     0m0.090s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupmerge

real    0m0.096s
user    0m0.010s
sys     0m0.080s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupmerge

real    0m0.096s
user    0m0.040s
sys     0m0.050s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupmerge

real    0m0.096s
user    0m0.020s
sys     0m0.070s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupmerge

real    0m0.096s
user    0m0.030s
sys     0m0.070s
andrea@laser:/misc/andrea-athlon/vma-merging > 

GROWSUPNOMERGE:

andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupnomerge

real    0m0.229s
user    0m0.040s
sys     0m0.190s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupnomerge

real    0m0.229s
user    0m0.030s
sys     0m0.200s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupnomerge

real    0m0.229s
user    0m0.020s
sys     0m0.210s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupnomerge

real    0m0.229s
user    0m0.030s
sys     0m0.200s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupnomerge

real    0m0.229s
user    0m0.040s
sys     0m0.190s
andrea@laser:/misc/andrea-athlon/vma-merging > 

GROWSUPDOWN:

andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupdown

real    0m0.241s
user    0m0.010s
sys     0m0.220s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupdown

real    0m0.240s
user    0m0.030s
sys     0m0.210s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupdown

real    0m0.240s
user    0m0.040s
sys     0m0.200s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupdown

real    0m0.240s
user    0m0.050s
sys     0m0.190s
andrea@laser:/misc/andrea-athlon/vma-merging > 

---------------------------------------------------------------------------

With the mmap-rb-4 patch applied:

GROWSDOWNMERGE:

andrea@laser:/misc/andrea-athlon/vma-merging > time growsdownmerge

real    0m0.096s
user    0m0.030s
sys     0m0.070s
andrea@laser:/misc/andrea-athlon/vma-merging > time growsdownmerge

real    0m0.096s
user    0m0.030s
sys     0m0.070s
andrea@laser:/misc/andrea-athlon/vma-merging > time growsdownmerge

real    0m0.096s
user    0m0.020s
sys     0m0.080s
andrea@laser:/misc/andrea-athlon/vma-merging > time growsdownmerge

real    0m0.096s
user    0m0.050s
sys     0m0.050s
andrea@laser:/misc/andrea-athlon/vma-merging > time growsdownmerge

real    0m0.096s
user    0m0.030s
sys     0m0.070s
andrea@laser:/misc/andrea-athlon/vma-merging > 

GROWSDOWNNOMERGE:

andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownnomerge 

real    0m0.220s
user    0m0.030s
sys     0m0.190s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownnomerge 

real    0m0.220s
user    0m0.020s
sys     0m0.200s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownnomerge 

real    0m0.220s
user    0m0.020s
sys     0m0.200s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsdownnomerge 

real    0m0.221s
user    0m0.040s
sys     0m0.190s
andrea@laser:/misc/andrea-athlon/vma-merging > 

GROWSUPMERGE:

andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupmerge

real    0m0.096s
user    0m0.020s
sys     0m0.080s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupmerge

real    0m0.096s
user    0m0.020s
sys     0m0.080s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupmerge

real    0m0.096s
user    0m0.020s
sys     0m0.080s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupmerge

real    0m0.096s
user    0m0.010s
sys     0m0.090s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupmerge

real    0m0.096s
user    0m0.040s
sys     0m0.060s
andrea@laser:/misc/andrea-athlon/vma-merging > 

GROWSUPNOMERGE:

andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupnomerge

real    0m0.218s
user    0m0.010s
sys     0m0.200s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupnomerge

real    0m0.217s
user    0m0.020s
sys     0m0.200s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupnomerge

real    0m0.216s
user    0m0.040s
sys     0m0.180s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupnomerge

real    0m0.216s
user    0m0.050s
sys     0m0.160s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupnomerge

real    0m0.215s
user    0m0.020s
sys     0m0.190s
andrea@laser:/misc/andrea-athlon/vma-merging > 

GROWSUPDOWN:

andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupdown

real    0m0.220s
user    0m0.040s
sys     0m0.180s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupdown

real    0m0.218s
user    0m0.030s
sys     0m0.200s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupdown

real    0m0.220s
user    0m0.030s
sys     0m0.190s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupdown

real    0m0.219s
user    0m0.030s
sys     0m0.190s
andrea@laser:/misc/andrea-athlon/vma-merging > time ./growsupdown

real    0m0.219s
user    0m0.010s
sys     0m0.210s
andrea@laser:/misc/andrea-athlon/vma-merging > 
---------------------------------------------------------------------------

End results of the mmap-rb-4 patch:

			without rb-tree-4	with rb-tree-4	% improvement
growsdownmerge		0.230			0.096		+139.58%
growsdownnomerge	0.230			0.220		+4.54%
growsupmerge		0.096			0.096		0%
growsupnomerge		0.229			0.218		+5.04%
growsupdown		0.240			0.216		+11.11%

I am *very* satisfied about those results (and it still runs rock solid
here, I didn't even rebooted my desktop yet since yesterday, running all
the time as usual kernel compiles, mutt, kde 2.2-pre, konqueror-2.2pre,
xmms etc...)

The test programs are a 5 minute hack and you can find them below for
completeness (they are not cleaned up, they're appended just so you can
see the exact workload I used for the benchmarks).

(btw, I could have splitted the growsupdown into growsupdownnomerge and
growsupdownmerge, but it was not interesting because I just know that if
math works I would have scored around + 139/2 % for the "merge" case, so
the actual growsupdown is really a growsupdownnomerge that was the only
one interesting and intended to stress another path of the rebalancing
algorithms of the trees [actually the growdownnomerge growsupnomerge
cases are the worst cases for the rb rebalancing and this is confirmed
by the improvement of the growsupdown, for the avl instead the
growsupnomerge and growsdownnomerge seems not the worst case, I'm not
sure but it could even be the best pattern for the avl rebalancing])

If somebody is willing to also write the benchmarks for the
mremap/mprotect vma merging cases he should get improvements of the
order of the +139% there too.

growsdownmerge.c

---------------------------------------------------------------------------
#include <sys/mman.h>

#define NR_MAPS 55000

main()
{
	void * p[NR_MAPS];
	int i;
	char * addr = (char *) 0xa0000000;
	for (i = 0; i < NR_MAPS; i++) {
#if 0
		p[i] = mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, -1, 0);
#else
		p[i] = mmap(addr, 4096, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE|MAP_FIXED, -1, 0);
#if 1
		addr -= 4096;
#else
		addr -= 8192;
#endif
#endif
		if ((unsigned long) p[i] == (unsigned long) -1)
			perror("mmap"), exit(1);
#if 0
		printf("%p\n", p[i]);
#endif
	}
#if 0
	pause();
#endif
}
---------------------------------------------------------------------------

growsdownnomerge.c

---------------------------------------------------------------------------
#include <sys/mman.h>

#define NR_MAPS 55000

main()
{
	void * p[NR_MAPS];
	int i;
	char * addr = (char *) 0xa0000000;
	for (i = 0; i < NR_MAPS; i++) {
#if 0
		p[i] = mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, -1, 0);
#else
		p[i] = mmap(addr, 4096, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE|MAP_FIXED, -1, 0);
#if 0
		addr -= 4096;
#else
		addr -= 8192;
#endif
#endif
		if ((unsigned long) p[i] == (unsigned long) -1)
			perror("mmap"), exit(1);
#if 0
		printf("%p\n", p[i]);
#endif
	}
#if 0
	pause();
#endif
}
---------------------------------------------------------------------------

growsupmerge.c:

---------------------------------------------------------------------------
#include <sys/mman.h>

#define NR_MAPS 55000

main()
{
	void * p[NR_MAPS];
	int i;
	char * addr = (char *) 0x50000000;
	for (i = 0; i < NR_MAPS; i++) {
#if 0
		p[i] = mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, -1, 0);
#else
		p[i] = mmap(addr, 4096, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE|MAP_FIXED, -1, 0);
#if 1
		addr += 4096;
#else
		addr += 8192;
#endif
#endif
		if ((unsigned long) p[i] == (unsigned long) -1)
			perror("mmap"), exit(1);
#if 0
		printf("%p\n", p[i]);
#endif
	}
#if 0
	pause();
#endif
}
---------------------------------------------------------------------------

growsupnomerge.c

---------------------------------------------------------------------------
#include <sys/mman.h>

#define NR_MAPS 55000

main()
{
	void * p[NR_MAPS];
	int i;
	char * addr = (char *) 0x50000000;
	for (i = 0; i < NR_MAPS; i++) {
#if 0
		p[i] = mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, -1, 0);
#else
		p[i] = mmap(addr, 4096, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE|MAP_FIXED, -1, 0);
#if 0
		addr += 4096;
#else
		addr += 8192;
#endif
#endif
		if ((unsigned long) p[i] == (unsigned long) -1)
			perror("mmap"), exit(1);
#if 0
		printf("%p\n", p[i]);
#endif
	}
#if 0
	pause();
#endif
}
---------------------------------------------------------------------------

growsupdown.c

---------------------------------------------------------------------------
#include <sys/mman.h>

#define NR_MAPS 55000

main()
{
	void * p[NR_MAPS];
	int i;
	int up = 1;
	int count = 0;
	char * addr = (char *) 0x50000000;
	for (i = 0; i < NR_MAPS; i++) {
#if 0
		p[i] = mmap(0, 4096, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, -1, 0);
#else
		p[i] = mmap(addr + (count * up), 4096, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE|MAP_FIXED, -1, 0);
#endif
		count += 4096;
		up = -up;
		if ((unsigned long) p[i] == (unsigned long) -1)
			perror("mmap"), exit(1);
#if 0
		printf("%p\n", p[i]);
#endif
	}
#if 0
	pause();
#endif
}
---------------------------------------------------------------------------

Andrea
