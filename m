Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbSJLOjS>; Sat, 12 Oct 2002 10:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSJLOjS>; Sat, 12 Oct 2002 10:39:18 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:25843 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S261228AbSJLOjP>; Sat, 12 Oct 2002 10:39:15 -0400
Message-ID: <3DA83599.5090604@quark.didntduck.org>
Date: Sat, 12 Oct 2002 10:45:45 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove __verify_write from sh arch
Content-Type: multipart/mixed;
 boundary="------------090408050708070407050901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090408050708070407050901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It was copied from i386 and is unused.

--
				Brian Gerst

--------------090408050708070407050901
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

--------------090408050708070407050901--

