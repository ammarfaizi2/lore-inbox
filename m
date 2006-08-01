Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbWHALG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbWHALG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWHALGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:06:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55004 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932629AbWHALF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:26 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/33] i386: define __pa_symbol
Date: Tue,  1 Aug 2006 05:03:17 -0600
Message-Id: <11544302293540-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64 we have to be careful with calculating the physical
address of kernel symbols.  Both because of compiler odditities
and because the symbols live in a different range of the virtual
address space.

Having a defintition of __pa_symbol that works on both x86_64 and
i386 simplifies writing code that works for both x86_64 and
i386 that has these kinds of dependencies.

So this patch adds the trivial i386 __pa_symbol definition.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/asm-i386/page.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-i386/page.h b/include/asm-i386/page.h
index f5bf544..eceb7f5 100644
--- a/include/asm-i386/page.h
+++ b/include/asm-i386/page.h
@@ -124,6 +124,7 @@ #define PAGE_OFFSET		((unsigned long)__P
 #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
 #define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
+#define __pa_symbol(x)		__pa(x)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
 #ifdef CONFIG_FLATMEM
-- 
1.4.2.rc2.g5209e

