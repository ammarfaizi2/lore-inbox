Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288879AbSAERMx>; Sat, 5 Jan 2002 12:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288880AbSAERMo>; Sat, 5 Jan 2002 12:12:44 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:56061 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S288879AbSAERMd> convert rfc822-to-8bit; Sat, 5 Jan 2002 12:12:33 -0500
Date: Sat, 5 Jan 2002 18:12:27 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Ingo Molnar <mingo@elte.hu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, 2.4.17-A1, 2.5.2-pre7-A1.
In-Reply-To: <20020104224505Z285720-13996+1136@vger.kernel.org>
Message-ID: <Pine.NEB.4.43.0201051808330.24096-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Dieter Nützel wrote:

> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=k6    -DEXPORT_SYMTAB -c filemap.c
> In file included from filemap.c:26:
> /usr/src/linux/include/linux/compiler.h:13: warning: likely' redefined
> /usr/src/linux/include/linux/sched.h:445: warning: this is the location of
> the previous definition
> /usr/src/linux/include/linux/compiler.h:14: warning: unlikely' redefined
> /usr/src/linux/include/linux/sched.h:444: warning: this is the location of
> the previous definition
>...

This warning is harmless but I'm wondering why sched.h adds a second
definition of likely/unlikely instead of using the one in compiler.h?

I'd suggest the following patch against 2.4.17-A2:

--- include/linux/sched.h.old	Sat Jan  5 18:03:41 2002
+++ include/linux/sched.h	Sat Jan  5 18:10:16 2002
@@ -7,6 +7,7 @@

 #include <linux/config.h>
 #include <linux/binfmts.h>
+#include <linux/compiler.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -441,8 +442,6 @@
  */
 #define _STK_LIM	(8*1024*1024)

-#define unlikely(x) x
-#define likely(x) x
 /*
  * The lower the priority of a process, the more likely it is
  * to run. Priority of a process goes from 0 to 63.

> -Dieter

cu
Adrian


