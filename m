Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSFTM5e>; Thu, 20 Jun 2002 08:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSFTM5e>; Thu, 20 Jun 2002 08:57:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:43463 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314243AbSFTM5d>; Thu, 20 Jun 2002 08:57:33 -0400
Date: Thu, 20 Jun 2002 14:57:30 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Felipe Alfaro Solana <falfaro@borak.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.23 won't compile
In-Reply-To: <3D11CD63.70505@borak.es>
Message-ID: <Pine.NEB.4.44.0206201456240.22563-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Felipe Alfaro Solana wrote:

>   _Summary_
>
>     Can't get linux kernel 2.5.23 to compile with success using config
>     options in the attached file "config-2.5.23"
>
> _Full description_
>
>     When trying to compile the kernel using config options in
>     "config-2.5.13", I get the following erros during a "make bzImage":
>
>     make[1]: Entering directory `/usr/src/linux-2.5.23/kernel'
>       gcc -Wp,-MD,./.sched.o.d -D__KERNEL__
>     -I/usr/src/linux-2.5.23/include -Wall -Wstrict-prototypes
>     -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
>     -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc
>     -iwithprefix include    -fno-omit-frame-pointer
>     -DKBUILD_BASENAME=sched   -c -o sched.o sched.c
>     sched.c: In function `sys_sched_setaffinity':
>     sched.c:1332: `cpu_online_map' undeclared (first use in this function)
>...


This is a known problem. The following patch is already in Linus' BK
repository:


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

