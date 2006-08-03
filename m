Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWHCHlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWHCHlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWHCHlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:41:47 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:5062 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932375AbWHCHlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:41:46 -0400
Subject: [PATCH 1/4] Trivial pgtable.h __ASSEMBLY__ move
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 17:41:41 +1000
Message-Id: <1154590902.11423.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Set of trivial cleanups taken from paravirt_ops work, please merge ]

Parsing generic pgtable.h in assembler is simply crazy.  None of this file is
needed in assembler code, and C inline functions and structures routine break
one or more different compiles.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.18-rc2-mm1/include/asm-generic/pgtable.h working-2.6.18-rc2-mm1-zach-1/include/asm-generic/pgtable.h
--- linux-2.6.18-rc2-mm1/include/asm-generic/pgtable.h	2006-06-28 10:39:28.000000000 +1000
+++ working-2.6.18-rc2-mm1-zach-1/include/asm-generic/pgtable.h	2006-08-03 17:23:36.000000000 +1000
@@ -1,6 +1,8 @@
 #ifndef _ASM_GENERIC_PGTABLE_H
 #define _ASM_GENERIC_PGTABLE_H
 
+#ifndef __ASSEMBLY__
+
 #ifndef __HAVE_ARCH_PTEP_ESTABLISH
 /*
  * Establish a new mapping:
@@ -188,7 +190,6 @@ static inline void ptep_set_wrprotect(st
 })
 #endif
 
-#ifndef __ASSEMBLY__
 /*
  * When walking page tables, we usually want to skip any p?d_none entries;
  * and any p?d_bad entries - reporting the error before resetting to none.

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

