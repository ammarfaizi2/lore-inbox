Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbSADUUM>; Fri, 4 Jan 2002 15:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284755AbSADUUC>; Fri, 4 Jan 2002 15:20:02 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:15096 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S284728AbSADUTy>; Fri, 4 Jan 2002 15:19:54 -0500
Date: Fri, 4 Jan 2002 21:19:48 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Ingo Molnar <mingo@elte.hu>
cc: Andrey Nekrasov <andy@spylog.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, 2.4.17-A1, 2.5.2-pre7-A1.
In-Reply-To: <Pine.LNX.4.33.0201042056150.11338-100000@localhost.localdomain>
Message-ID: <Pine.NEB.4.43.0201042111580.19208-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Ingo Molnar wrote:

> On Fri, 4 Jan 2002, Andrey Nekrasov wrote:
>
> > ipconfig.c: In function `ip_auto_config':
> > ipconfig.c:1148: `UNNAMED_MAJOR' undeclared (first use in this function)
> > ipconfig.c:1148: (Each undeclared identifier is reported only once
> > ipconfig.c:1148: for each function it appears in.)
>
> > ps. vanilla kernel compile ok.
>
> hm, the patch does not change ipconfig.c.

It seems the following part of your patch broke it (net/ipv4/ipconfig.c
includes include/linux/sched.h; linux/tty.h includes linux/major.h that
defines UNNAMED_MAJOR):

--- linux/include/linux/sched.h.orig    Thu Jan  3 18:49:58 2002
+++ linux/include/linux/sched.h Fri Jan  4 15:27:20 2002
@@ -21,7 +21,6 @@
 #include <asm/mmu.h>

 #include <linux/smp.h>
-#include <linux/tty.h>
 #include <linux/sem.h>
 #include <linux/signal.h>
 #include <linux/securebits.h>



The right solution is perhaps for ipconfig.c to include major.h directly?

--- net/ipv4/ipconfig.c.old	Fri Jan  4 21:14:50 2002
+++ net/ipv4/ipconfig.c	Fri Jan  4 21:15:39 2002
@@ -32,6 +32,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/major.h>
 #include <linux/sched.h>
 #include <linux/random.h>
 #include <linux/init.h>


> 	Ingo

cu
Adrian



