Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbUJ2MyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUJ2MyD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 08:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbUJ2MyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 08:54:03 -0400
Received: from mail.renesas.com ([202.234.163.13]:54988 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S263309AbUJ2Mw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 08:52:57 -0400
Date: Fri, 29 Oct 2004 21:52:45 +0900 (JST)
Message-Id: <20041029.215245.596522040.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc1] [m32r] Fix ELF_CORE_COPY_REGS macro to generate
 a correct "core" file
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here is a patch for include/asm-m32r/elf.h.

This patch fixes ELF_CORE_COPY_REGS() macro in order to dump
register information into "core" files correctly, 
because both parameters pr_reg and regs are passed as pointers
to "elf_gregset_t" and "struct pt_regs", respectively.

I've tested it by using a native m32r GNU debugger.

Thanks.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/elf.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -ruNp a/include/asm-m32r/elf.h b/include/asm-m32r/elf.h
--- a/include/asm-m32r/elf.h	2004-10-19 06:54:37.000000000 +0900
+++ b/include/asm-m32r/elf.h	2004-10-29 15:18:48.000000000 +0900
@@ -154,7 +154,7 @@ typedef elf_fpreg_t elf_fpregset_t;
    now struct_user_regs, they are different) */
 
 #define ELF_CORE_COPY_REGS(pr_reg, regs)  \
-	memcpy((char *)&pr_reg, (char *)&regs, sizeof (struct pt_regs));
+	memcpy((char *)pr_reg, (char *)regs, sizeof (struct pt_regs));
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports.  */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
