Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271077AbTGPTlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271074AbTGPTlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:41:09 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:15625 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S271089AbTGPTkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:40:55 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Con Kolivas <kernel@kolivas.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O6int for interactivity
Date: Wed, 16 Jul 2003 21:55:06 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <200307170030.25934.kernel@kolivas.org> <1058368952.873.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1058368952.873.1.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307162142.29821.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 July 2003 17:22, Felipe Alfaro Solana wrote:

Hi Con,

> > This one makes a massive difference... Please test this to death.
> Oh, my god... This is nearly perfect! :-)
> On 2.6.0-test1-mm1 with o6int.patch, I can't reproduce XMMS initial
> starvation anymore and X feels smoother under heavy load.
> Nice... ;-)
hmm, I really wonder why I don't see any difference for my box.

1. "make -j2 bzImage modules" slows down my box alot.

2. kmail is slow like a dog while make -j2

3. xterm needs ~5seconds while make -j2 to open up

4. xmms does not skip

5. I've tried Felipe's suggestions, they are:
	#define PRIO_BONUS_RATIO        45
	#define INTERACTIVE_DELTA       4
	#define MAX_SLEEP_AVG           (HZ)
	#define STARVATION_LIMIT        (HZ)
   At least with these changes kmail is much much faster but still not
   as fast as w/o the compilation. Xterm needs ~5seconds to open up.

6. Xterm: "ls -lsa" in a directory with ~1200 files

	2.6.0-test1-mm1 + O6int:
	------------------------
	real    0m12.468s
	user    0m0.170s
	sys     0m0.057s

	2.4.20-wolk4.4: O(1) from latest -aa tree
	-----------------------------------------
	real    0m0.689s
	user    0m0.031s
	sys     0m0.011s

7. playing an mpeg with mplayer while "make -j2 bzImage modules" let the movie
   skip some frames every ~10 seconds.

8. I've also tried min_timeslice == max_timeslice (10) w/o much difference :-(
   I remember that this helped alot in earlier 2.5 kernels.


I have to say that the XMMS issue is really less important for me. I want a 
kernel where I can "make -j<huge number> bzImage modules" and don't notice 
that compilation w/o renicing all the gcc instances.

Machine:
--------
Celeron 1,3GHz
512MB RAM
2x IDE (UDMA100) 60/40 GB
1GB SWAP, 512MB on each disk (same priority)
ext3fs (data=ordered)
anticipatory I/O scheduler
XFree 4.3
WindowMaker 0.82-CVS


Is my box the only one on earth which don't like the scheduler fixups? ;)

ciao, Marc

