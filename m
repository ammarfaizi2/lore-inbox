Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVHOVZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVHOVZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbVHOVZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:25:50 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:16648 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S964980AbVHOVZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:25:49 -0400
Date: Mon, 15 Aug 2005 17:14:19 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference between /dev/kmem and /dev/mem)
Message-ID: <20050815211419.GA7348@ccure.user-mode-linux.org>
References: <1123796188.17269.127.camel@localhost.localdomain> <1123809302.17269.139.camel@localhost.localdomain> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org> <1123951810.3187.20.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0508130955010.19049@g5.osdl.org> <1123953924.3187.22.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org> <20050815193307.GA11025@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815193307.GA11025@aepfle.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 09:33:07PM +0200, Olaf Hering wrote:
> ARCH=um doesnt like your version, but mine.
> 
> drivers/char/mem.c:267: error: invalid operands to binary <<
> 
>         pfn = (__pa((u64)vma->vm_pgoff) << PAGE_SHIFT) >> PAGE_SHIFT;

My page.h was missing some parens.  Try the patch below.

				Jeff

Index: linux-2.6.13-rc6/include/asm-um/page.h
===================================================================
--- linux-2.6.13-rc6.orig/include/asm-um/page.h	2005-08-15 16:57:55.000000000 -0400
+++ linux-2.6.13-rc6/include/asm-um/page.h	2005-08-15 17:16:57.000000000 -0400
@@ -104,8 +104,8 @@
  * casting is the right thing, but 32-bit UML can't have 64-bit virtual
  * addresses
  */
-#define __pa(virt) to_phys((void *) (unsigned long) virt)
-#define __va(phys) to_virt((unsigned long) phys)
+#define __pa(virt) to_phys((void *) (unsigned long) (virt))
+#define __va(phys) to_virt((unsigned long) (phys))
 
 #define page_to_pfn(page) ((page) - mem_map)
 #define pfn_to_page(pfn) (mem_map + (pfn))
