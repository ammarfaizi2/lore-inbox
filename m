Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131680AbQKZU0N>; Sun, 26 Nov 2000 15:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132787AbQKZU0C>; Sun, 26 Nov 2000 15:26:02 -0500
Received: from jalon.able.es ([212.97.163.2]:15325 "EHLO jalon.able.es")
        by vger.kernel.org with ESMTP id <S131680AbQKZUZv>;
        Sun, 26 Nov 2000 15:25:51 -0500
Date: Sun, 26 Nov 2000 20:55:40 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Olaf Dietsche <olaf.dietsche@gmx.net>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.2-51 is buggy
Message-ID: <20001126205540.A8066@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <Pine.LNX.4.21.0011251805340.8818-100000@duckman.distro.conectiva> <87ofz2lpdm.fsf@tigram.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <87ofz2lpdm.fsf@tigram.bogus.local>; from olaf.dietsche@gmx.net on Sun, Nov 26, 2000 at 16:33:25 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 26 Nov 2000 16:33:25 Olaf Dietsche wrote:
> 
> A simple `gcc -march=i686' or `gcc -mpentiumpro' does fix it as
> well. So, if you configure your kernel with `CONFIG_M686=y' the problem
> should be gone.
> 

That does not work for 2.2 kernels. Always compile for -m486. To use
the -march flag you need to modify arch/i386/kernel/Makefile. Patch
follows:

================= PATCH patch-gcc-arch:
--- linux-2.2.17/arch/i386/Makefile.orig        Wed Nov 22 20:42:49 2000
+++ linux-2.2.17/arch/i386/Makefile     Wed Nov 22 20:44:40 2000
@@ -24,23 +24,23 @@
 CFLAGS := $(CFLAGS) $(CFLAGS_PIPE) $(CFLAGS_NSR)
 
 ifdef CONFIG_M386
-CFLAGS := $(CFLAGS) -m386 -DCPU=386
+CFLAGS := $(CFLAGS) -march=i386 -DCPU=386
 endif
 
 ifdef CONFIG_M486
-CFLAGS := $(CFLAGS) -m486 -DCPU=486
+CFLAGS := $(CFLAGS) -march=i486 -DCPU=486
 endif
 
 ifdef CONFIG_M586
-CFLAGS := $(CFLAGS) -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2
-DCPU=586
+CFLAGS := $(CFLAGS) -march=i586 -malign-loops=2 -malign-jumps=2
-malign-functions=2 -DCPU=586
 endif
 
 ifdef CONFIG_M586TSC
-CFLAGS := $(CFLAGS) -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2
-DCPU=586
+CFLAGS := $(CFLAGS) -march=i586 -malign-loops=2 -malign-jumps=2
-malign-functions=2 -DCPU=586
 endif
 
 ifdef CONFIG_M686
-CFLAGS := $(CFLAGS) -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2
-DCPU=686
+CFLAGS := $(CFLAGS) -march=i686 -malign-loops=2 -malign-jumps=2
-malign-functions=2 -DCPU=686
 endif
 
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o


-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre23-vm #3 SMP Wed Nov 22 22:33:53 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
