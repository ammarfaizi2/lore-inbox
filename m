Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUGQW6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUGQW6l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUGQW6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:58:12 -0400
Received: from digitalimplant.org ([64.62.235.95]:33769 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262547AbUGQWfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:20 -0400
Date: Sat, 17 Jul 2004 15:35:14 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [10/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171529250.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1852, 2004/07/17 11:12:12-07:00, mochel@digitalimplant.org

[Power Mgmt] Remove arch/i386/power/pmdisk.S


 arch/i386/power/pmdisk.S |   56 -----------------------------------------------
 1 files changed, 56 deletions(-)


diff -Nru a/arch/i386/power/pmdisk.S b/arch/i386/power/pmdisk.S
--- a/arch/i386/power/pmdisk.S	2004-07-17 14:51:21 -07:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,56 +0,0 @@
-/* Originally gcc generated, modified by hand */
-
-#include <linux/linkage.h>
-#include <asm/segment.h>
-#include <asm/page.h>
-
-	.text
-
-ENTRY(pmdisk_arch_suspend)
-	cmpl $0,4(%esp)
-	jne .L1450
-
-	movl %esp, saved_context_esp
-	movl %ebx, saved_context_ebx
-	movl %ebp, saved_context_ebp
-	movl %esi, saved_context_esi
-	movl %edi, saved_context_edi
-	pushfl ; popl saved_context_eflags
-
-	call pmdisk_suspend
-	jmp .L1449
-	.p2align 4,,7
-.L1450:
-	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
-	movl %ecx,%cr3
-
-	movl	pagedir_nosave,%ebx
-	xorl	%eax, %eax
-	xorl	%edx, %edx
-	.p2align 4,,7
-.L1455:
-	movl	4(%ebx,%edx),%edi
-	movl	(%ebx,%edx),%esi
-
-	movl	$1024, %ecx
-	rep
-	movsl
-
-	movl	%cr3, %ecx;
-	movl	%ecx, %cr3;  # flush TLB
-
-	incl	%eax
-	addl	$16, %edx
-	cmpl	nr_copy_pages,%eax
-	jb .L1455
-	.p2align 4,,7
-.L1453:
-	movl saved_context_esp, %esp
-	movl saved_context_ebp, %ebp
-	movl saved_context_ebx, %ebx
-	movl saved_context_esi, %esi
-	movl saved_context_edi, %edi
-	pushl saved_context_eflags ; popfl
-	call pmdisk_resume
-.L1449:
-	ret
