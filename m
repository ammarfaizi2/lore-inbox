Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317814AbSFSIWq>; Wed, 19 Jun 2002 04:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317815AbSFSIWp>; Wed, 19 Jun 2002 04:22:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:2536 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317814AbSFSIWn>; Wed, 19 Jun 2002 04:22:43 -0400
Date: Wed, 19 Jun 2002 10:22:41 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Joseph Pingenot <trelane@digitasaru.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Build problem in sched.c in 2.5.23
In-Reply-To: <20020619031247.B5211@ksu.edu>
Message-ID: <Pine.NEB.4.44.0206191022030.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002, Joseph Pingenot wrote:

> make[1]: Entering directory `/usr/local/src/kernel/linux-2.5.23/kernel'
>   gcc -Wp,-MD,./.sched.o.d -D__KERNEL__ -I/usr/local/src/kernel/linux-2.5.23/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -fno-omit-frame-pointer -DKBUILD_BASENAME=sched   -c -o sched.o sched.c
> sched.c: In function `sys_sched_setaffinity':
> sched.c:1332: `cpu_online_map' undeclared (first use in this function)
> sched.c:1332: (Each undeclared identifier is reported only once
> sched.c:1332: for each function it appears in.)
> sched.c: In function `sys_sched_getaffinity':
> sched.c:1391: `cpu_online_map' undeclared (first use in this function)
> make[1]: *** [sched.o] Error 1
> make[1]: Leaving directory `/usr/local/src/kernel/linux-2.5.23/kernel'
> make: *** [kernel] Error 2
>
> Need any more details?


The following patch that is already in Linus' BK repository fixes it:


--- a/include/linux/smp.h	Wed Jun 19 00:00:41 2002
+++ b/include/linux/smp.h	Wed Jun 19 00:00:41 2002
@@ -86,6 +86,7 @@
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
+#define cpu_online_map				1
 #define cpu_online(cpu)				1
 #define num_online_cpus()			1
 #define __per_cpu_data

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

