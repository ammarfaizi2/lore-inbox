Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265531AbSJSEKn>; Sat, 19 Oct 2002 00:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbSJSEKn>; Sat, 19 Oct 2002 00:10:43 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:30861 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S265531AbSJSEKi>; Sat, 19 Oct 2002 00:10:38 -0400
Message-ID: <3DB0DCBD.7060008@quark.didntduck.org>
Date: Sat, 19 Oct 2002 00:17:01 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove __verify_write from sh arch
Content-Type: multipart/mixed;
 boundary="------------000008080109050909010206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000008080109050909010206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

(Resend)

It was copied from i386 and is unused.

--
				Brian Gerst


--------------000008080109050909010206
Content-Type: text/plain;
 name="sh-verify_write-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sh-verify_write-1"

diff -urN linux-2.5.42/arch/sh/mm/fault.c linux/arch/sh/mm/fault.c
--- linux-2.5.42/arch/sh/mm/fault.c	Sun Sep 15 22:18:24 2002
+++ linux/arch/sh/mm/fault.c	Sat Oct 12 10:39:38 2002
@@ -30,58 +30,6 @@
 extern void die(const char *,struct pt_regs *,long);
 
 /*
- * Ugly, ugly, but the goto's result in better assembly..
- */
-int __verify_write(const void * addr, unsigned long size)
-{
-	struct vm_area_struct * vma;
-	unsigned long start = (unsigned long) addr;
-
-	if (!size)
-		return 1;
-
-	vma = find_vma(current->mm, start);
-	if (!vma)
-		goto bad_area;
-	if (vma->vm_start > start)
-		goto check_stack;
-
-good_area:
-	if (!(vma->vm_flags & VM_WRITE))
-		goto bad_area;
-	size--;
-	size += start & ~PAGE_MASK;
-	size >>= PAGE_SHIFT;
-	start &= PAGE_MASK;
-
-	for (;;) {
-		if (handle_mm_fault(current->mm, vma, start, 1) <= 0)
-			goto bad_area;
-		if (!size)
-			break;
-		size--;
-		start += PAGE_SIZE;
-		if (start < vma->vm_end)
-			continue;
-		vma = vma->vm_next;
-		if (!vma || vma->vm_start != start)
-			goto bad_area;
-		if (!(vma->vm_flags & VM_WRITE))
-			goto bad_area;;
-	}
-	return 1;
-
-check_stack:
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, start) == 0)
-		goto good_area;
-
-bad_area:
-	return 0;
-}
-
-/*
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
  * routines.


--------------000008080109050909010206--

