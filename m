Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266690AbUFYKFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266690AbUFYKFw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266696AbUFYKFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:05:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:19648 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266690AbUFYKFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:05:30 -0400
Date: Fri, 25 Jun 2004 03:04:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, sparclinux@vger.kernel.org
Subject: Re: [SPARC64] kernel 2.6.7+cset-20040625_0611 = ERROR
Message-Id: <20040625030430.4f494e43.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58L.0406251320310.6037@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.58L.0406251320310.6037@alpha.zarz.agh.edu.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl> wrote:
>
> make[1]: *** [arch/sparc64/kernel/process.o] Error 1
>  make: *** [arch/sparc64/kernel] Error 2

Here's one:



include/linux/cpumask.h: In function `__first_cpu':
include/linux/cpumask.h:210: warning: passing arg 1 of `find_next_bit' discards qualifiers from pointer target type
include/linux/cpumask.h: In function `__next_cpu':
include/linux/cpumask.h:216: warning: passing arg 1 of `find_next_bit' discards qualifiers from pointer target type

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-sparc64-akpm/arch/sparc64/lib/find_bit.c  |    5 +++--
 25-sparc64-akpm/include/asm-sparc64/bitops.h |    3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff -puN arch/sparc64/lib/find_bit.c~sparc64-find_next_bit-fix arch/sparc64/lib/find_bit.c
--- 25-sparc64/arch/sparc64/lib/find_bit.c~sparc64-find_next_bit-fix	2004-06-25 03:02:00.095102072 -0700
+++ 25-sparc64-akpm/arch/sparc64/lib/find_bit.c	2004-06-25 03:02:00.109099944 -0700
@@ -6,9 +6,10 @@
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-unsigned long find_next_bit(unsigned long *addr, unsigned long size, unsigned long offset)
+unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
+				unsigned long offset)
 {
-	unsigned long *p = addr + (offset >> 6);
+	const unsigned long *p = addr + (offset >> 6);
 	unsigned long result = offset & ~63UL;
 	unsigned long tmp;
 
diff -puN include/asm-sparc64/bitops.h~sparc64-find_next_bit-fix include/asm-sparc64/bitops.h
--- 25-sparc64/include/asm-sparc64/bitops.h~sparc64-find_next_bit-fix	2004-06-25 03:02:00.104100704 -0700
+++ 25-sparc64-akpm/include/asm-sparc64/bitops.h	2004-06-25 03:02:00.110099792 -0700
@@ -204,7 +204,8 @@ static __inline__ unsigned int hweight8(
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-extern unsigned long find_next_bit(unsigned long *, unsigned long, unsigned long);
+extern unsigned long find_next_bit(const unsigned long *, unsigned long,
+					unsigned long);
 
 /**
  * find_first_bit - find the first set bit in a memory region
_

