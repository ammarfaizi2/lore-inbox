Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315258AbSDWRPR>; Tue, 23 Apr 2002 13:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315263AbSDWRPQ>; Tue, 23 Apr 2002 13:15:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:35015 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315258AbSDWRPP>; Tue, 23 Apr 2002 13:15:15 -0400
Date: Tue, 23 Apr 2002 19:11:43 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.9-dj1
In-Reply-To: <20020423144527.GA12925@suse.de>
Message-ID: <Pine.NEB.4.44.0204231907170.11258-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

it doesn't compile for me when CONFIG_SMP is set:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.9/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6
-nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o sched.c
sched.c: In function `migration_thread':
sched.c:1685: `bind_cpu' undeclared (first use in this function)
sched.c:1685: (Each undeclared identifier is reported only once
sched.c:1685: for each function it appears in.)
sched.c: At top level:
sched.c:1681: warning: `migration_mask' defined but not used
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.9/kernel'

<--  snip  -->


It's the following part of the -dj1 patch (I've skipped the rest of the
sched.c changes):


--- linux-2.5.9/kernel/sched.c	Mon Apr 22 23:28:20 2002
+++ linux-2.5/kernel/sched.c	Tue Apr 23 11:43:38 2002
@@ -1672,7 +1678,9 @@
 	preempt_enable();
 }

-static int migration_thread(void * bind_cpu)
+static volatile unsigned long migration_mask;
+
+static int migration_thread(void * unused)
 {
 	int cpu = cpu_logical_map((int) (long) bind_cpu);
 	struct sched_param param = { sched_priority: 99 };





The problem seems to be that "bind_cpu" is renamed to "unused" but it is
used two lines later.



cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

