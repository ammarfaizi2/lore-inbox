Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKAGA6>; Wed, 1 Nov 2000 01:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbQKAGAr>; Wed, 1 Nov 2000 01:00:47 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:40929 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S129130AbQKAGAh>;
	Wed, 1 Nov 2000 01:00:37 -0500
Date: Wed, 1 Nov 2000 15:00:34 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: test10 compile fails on alpha
Message-ID: <Pine.LNX.4.10.10011011439380.372-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe -mno-fp-regs -ffixed-8
-mcpu=ev6 -Wa,-mev6    -c -o binfmt_elf.o binfmt_elf.c
binfmt_elf.c: In function `create_elf_tables':
binfmt_elf.c:166: `CLOCKS_PER_SEC' undeclared (first use in this function)
binfmt_elf.c:166: (Each undeclared identifier is reported only once
binfmt_elf.c:166: for each function it appears in.)

Um, is there any reason why you don't just use HZ instead of
CLOCKS_PER_SEC (which is pretty much Hz by definition)?
All the arches seem to define it as HZ anyway.

--- linux/include/asm-alpha/#param.h    Wed Nov  1 14:11:11 2000
+++ linux/include/asm-alpha/param.h     Wed Nov  1 14:54:59 2000
@@ -26,5 +26,9 @@
 #endif
 
 #define MAXHOSTNAMELEN 64      /* max length of hostname */
+
+#ifdef __KERNEL__
+# define CLOCKS_PER_SEC HZ      /* frequency at which times() counts */
+#endif
 
 #endif /* _ASM_ALPHA_PARAM_H */


Also CONFIG_ALPHA_LARGE_VMALLOC is not recognized by "make xconfig".

Dr. Tom Holroyd
"I am, as I said, inspired by the biological phenomena in which
chemical forces are used in repetitious fashion to produce all
kinds of weird effects (one of which is the author)."
	-- Richard Feynman, _There's Plenty of Room at the Bottom_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
