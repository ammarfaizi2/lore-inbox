Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVKGIZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVKGIZL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 03:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVKGIZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 03:25:10 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:56214 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751316AbVKGIZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 03:25:09 -0500
Date: Mon, 7 Nov 2005 09:24:55 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm1
Message-ID: <20051107082455.GA20374@ens-lyon.fr>
References: <20051106182447.5f571a46.akpm@osdl.org> <436ED3C7.8090006@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436ED3C7.8090006@reub.net>
X-Sieve: CMU Sieve 2.2
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, Reuben Farrelly <reuben-lkml@reub.net> wrote:
> Hi,
>
> Ok a couple of things so far:
>
> Firstly:
>
> CC [M]  drivers/edac/edac_mc.o
> drivers/edac/edac_mc.c: In function 'edac_mc_scrub_block':
> drivers/edac/edac_mc.c:647: error: syntax error before 'asm'
> drivers/edac/edac_mc.c:647: error: void value not ignored as it ought to be
> drivers/edac/edac_mc.c:653: warning: passing argument 1 of 'page_zone' makes
> pointer from integer without a cast
> drivers/edac/edac_mc.c:653: error: syntax error before 'do'
> drivers/edac/edac_mc.c:653: error: '__dummy' undeclared (first use in this function)
> drivers/edac/edac_mc.c:653: error: (Each undeclared identifier is reported only once
> drivers/edac/edac_mc.c:653: error: for each function it appears in.)
> drivers/edac/edac_mc.c: At top level:
> drivers/edac/edac_mc.c:653: error: syntax error before 'while'
> make[2]: *** [drivers/edac/edac_mc.o] Error 1
> make[1]: *** [drivers/edac] Error 2
> make: *** [drivers] Error 2
>
The following patch fixes it

Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

Index: linux/include/linux/highmem.h
===================================================================
--- linux.orig/include/linux/highmem.h
+++ linux/include/linux/highmem.h
@@ -21,7 +21,7 @@ unsigned int nr_free_highpages(void);
  */
 #define kmap_atomic_maybe_irqsave(page, idx, flags)		\
 	({						\
-		if (PageHighMem(page)			\
+		if (PageHighMem(page))			\
 			local_irq_save(flags);		\
 		kmap_atomic(page, idx);			\
 	})
@@ -29,7 +29,7 @@ unsigned int nr_free_highpages(void);
 #define kunmap_atomic_maybe_irqrestore(addr, idx, flags)		\
 	({						\
 		kunmap_atomic(addr, idx);		\
-		if (PageHighMem(page)			\
+		if (PageHighMem(page))			\
 			local_irq_restore(flags);	\
 	})
 
