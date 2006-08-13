Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWHMPab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWHMPab (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 11:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWHMPab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 11:30:31 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22284 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751285AbWHMPab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 11:30:31 -0400
Date: Sun, 13 Aug 2006 17:30:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] arch/i386/mm/ioremap.c must #include <asm/cacheflush.h>
Message-ID: <20060813153029.GC3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc3-mm2:
>...
> +generic-ioremap_page_range-i386-conversion.patch
>...
>  Code consolidation

This gives the following compile error with 
-Werror-implicit-function-declaration:

<--  snip  -->

...
  CC      arch/i386/mm/ioremap.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/arch/i386/mm/ioremap.c: 
In function ‘ioremap_nocache’:
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/arch/i386/mm/ioremap.c:142: 
error: implicit declaration of function ‘change_page_attr’
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm1/arch/i386/mm/ioremap.c:146: 
error: implicit declaration of function ‘global_flush_tlb’

<--  snip  -->

If anyone with CONFIG_X86_PAE=y experiences runtime stack corruption, 
the patch below might help.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm1/arch/i386/mm/ioremap.c.old	2006-08-13 12:49:18.000000000 +0200
+++ linux-2.6.18-rc4-mm1/arch/i386/mm/ioremap.c	2006-08-13 12:49:40.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <asm/fixmap.h>
+#include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/pgtable.h>
 
