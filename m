Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269610AbUJLKtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269610AbUJLKtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269608AbUJLKtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:49:19 -0400
Received: from mail.renesas.com ([202.234.163.13]:42960 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S269610AbUJLKtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:49:11 -0400
Date: Tue, 12 Oct 2004 19:49:01 +0900 (JST)
Message-Id: <20041012.194901.838023079.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc4-mm1] [m32r] Update arch/m32r/mm/fault.c to fix a
 compile error
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to update arch/m32r/mm/fault.c in order to fix
a compile error of -mm kernel for m32r.

Please apply.

	* arch/m32r/mm/fault.c:
	- Add the third parameter of expand_stack().
	  This modification is derived from 
	  enforce-a-gap-between-heap-and-stack.patch;

	  "heap-stack-gap for 2.6" (Sep. 25, 2004)
	  http://www.uwsg.iu.edu/hypermail/linux/kernel/0409.3/0435.html

Regards,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/mm/fault.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -ruNp a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
--- a/arch/m32r/mm/fault.c	2004-10-12 09:34:39.000000000 +0900
+++ b/arch/m32r/mm/fault.c	2004-10-12 10:35:21.000000000 +0900
@@ -182,7 +182,7 @@ asmlinkage void do_page_fault(struct pt_
 			goto bad_area;
 	}
 #endif
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
