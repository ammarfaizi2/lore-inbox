Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKKWiH>; Sat, 11 Nov 2000 17:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQKKWh5>; Sat, 11 Nov 2000 17:37:57 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:18962 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S129057AbQKKWhr>; Sat, 11 Nov 2000 17:37:47 -0500
Date: Sat, 11 Nov 2000 23:36:50 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: Eric Reischer <emr@engr.de.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.4 test10 bug
In-Reply-To: <4.2.0.58.20001108233713.00a678d0@engr.de.psu.edu>
Message-ID: <Pine.LNX.4.21.0011112335210.11176-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2000, Eric Reischer wrote:

> When cross compiling a PowerPC kernel on an i386 machine, got the following 
> error:
> 
> binfmt_elf.c: In function 'create_elf_tables':
> binfmt_elf.c:166: 'CLOCKS_PER_SEC' undeclared (first use in this function)
> binfmt_elf.c:166: (Each undeclared identifier is reported only once
> binfmt_elf.c:166: for each function it appears in.)
> make[2]: *** [binfmt_elf.o] Error 1

This quick fix should help you:

--- linux-240t10/include/asm-ppc/param.h	Sat Nov 25 18:49:06 1995
+++ linux/include/asm-ppc/param.h	Sat Nov 11 17:18:50 2000
@@ -17,4 +17,8 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#ifdef __KERNEL__
+# define CLOCKS_PER_SEC	HZ	/* frequency at which times() counts */
+#endif
+
 #endif

--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
