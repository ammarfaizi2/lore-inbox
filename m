Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbVHOWmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbVHOWmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbVHOWmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:42:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965023AbVHOWmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:42:01 -0400
Date: Mon, 15 Aug 2005 15:41:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
cc: Arjan van de Ven <arjan@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
 between /dev/kmem and /dev/mem)
In-Reply-To: <20050815193307.GA11025@aepfle.de>
Message-ID: <Pine.LNX.4.58.0508151540230.3553@g5.osdl.org>
References: <1123796188.17269.127.camel@localhost.localdomain>
 <1123809302.17269.139.camel@localhost.localdomain> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
 <1123951810.3187.20.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0508130955010.19049@g5.osdl.org>
 <1123953924.3187.22.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org>
 <20050815193307.GA11025@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Aug 2005, Olaf Hering wrote:
> 
> ARCH=um doesnt like your version, but mine.

Yours is broken. As is arch-um.

The fix would _seem_ to be something like the appended. Can you verify?

		Linus
----
diff --git a/include/asm-um/page.h b/include/asm-um/page.h
--- a/include/asm-um/page.h
+++ b/include/asm-um/page.h
@@ -104,8 +104,8 @@ extern void *to_virt(unsigned long phys)
  * casting is the right thing, but 32-bit UML can't have 64-bit virtual
  * addresses
  */
-#define __pa(virt) to_phys((void *) (unsigned long) virt)
-#define __va(phys) to_virt((unsigned long) phys)
+#define __pa(virt) to_phys((void *) (unsigned long) (virt))
+#define __va(phys) to_virt((unsigned long) (phys))
 
 #define page_to_pfn(page) ((page) - mem_map)
 #define pfn_to_page(pfn) (mem_map + (pfn))
