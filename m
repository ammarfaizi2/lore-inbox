Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbVHXPgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbVHXPgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVHXPgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:36:23 -0400
Received: from mail.suse.de ([195.135.220.2]:38367 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751076AbVHXPgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:36:22 -0400
From: Andreas Schwab <schwab@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc7 compile failures (was: Re: Fix up mmap of /dev/kmem)
References: <200508132201.j7DM1TAN031499@hera.kernel.org>
	<Pine.LNX.4.63.0508241410530.4356@anakin>
X-Yow: ..I must be a VETERINARIAN..
Date: Wed, 24 Aug 2005 17:36:21 +0200
In-Reply-To: <Pine.LNX.4.63.0508241410530.4356@anakin> (Geert Uytterhoeven's
	message of "Wed, 24 Aug 2005 14:12:46 +0200 (CEST)")
Message-ID: <jeacj7l53e.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Some (not all!) of my m68k test builds are now failing with:
>
> | linux-m68k-2.6.13-rc7/drivers/char/mem.c: In function `mmap_kmem':
> | linux-m68k-2.6.13-rc7/drivers/char/mem.c:267: warning: cast to pointer from integer of different size
> | linux-m68k-2.6.13-rc7/drivers/char/mem.c:267: invalid operands to binary <<

Try this:

Add parens around macro parameters.

Signed-off-by: Andreas Schwab <schwab@suse.de>

--- include/asm-m68k/page.h.~1.14.~	2004-05-26 20:10:15.000000000 +0200
+++ include/asm-m68k/page.h	2005-08-24 17:29:55.000000000 +0200
@@ -138,13 +138,13 @@ extern unsigned long m68k_memoffset;
 #define __pa(vaddr)		((unsigned long)(vaddr)+m68k_memoffset)
 #define __va(paddr)		((void *)((unsigned long)(paddr)-m68k_memoffset))
 #else
-#define __pa(vaddr)		virt_to_phys((void *)vaddr)
-#define __va(paddr)		phys_to_virt((unsigned long)paddr)
+#define __pa(vaddr)		virt_to_phys((void *)(vaddr))
+#define __va(paddr)		phys_to_virt((unsigned long)(paddr))
 #endif
 
 #else	/* !CONFIG_SUN3 */
 /* This #define is a horrible hack to suppress lots of warnings. --m */
-#define __pa(x) ___pa((unsigned long)x)
+#define __pa(x) ___pa((unsigned long)(x))
 static inline unsigned long ___pa(unsigned long x)
 {
      if(x == 0)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
