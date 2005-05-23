Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVEWOIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVEWOIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 10:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEWOIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 10:08:17 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:8089 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261669AbVEWOIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:08:09 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net, eric.begot@gmail.com
Subject: Re: [uml-devel] [PATCH] UML - 2.6.12-rc4-mm2 Compile error
Date: Mon, 23 May 2005 16:09:47 +0200
User-Agent: KMail/1.7.2
Cc: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org> <4290E1C6.9070709@gmail.com>
In-Reply-To: <4290E1C6.9070709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505231609.48425.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 May 2005 21:47, Eric BEGOT wrote:
> Here is a patch to correct a compile error on linux 2.6.12-rc4-mm2 for uml.
> At the compilation of init/main.c, it complains because it doens't find
> the 2 constants FIXADDR_USER_START and FIXADDR_USER_END
Why deleting FIXADDR_START? Also FIXADDR_USER_* are defined, just in a 
different way (and the patch below is IIRC uncorrect).
>
> --- linux-2.6.12-rc4-mm2/include/asm/fixmap.h.orig 2005-05-22
> 21:37:13.000000000 +0200
> +++ linux-2.6.12-rc4-mm2/include/asm/fixmap.h 2005-05-22
> 21:38:17.000000000 +0200
> @@ -60,7 +60,8 @@ extern unsigned long get_kmem_end(void);
>
> #define FIXADDR_TOP (get_kmem_end() - 0x2000)
> #define FIXADDR_SIZE (__end_of_fixed_addresses << PAGE_SHIFT)
> -#define FIXADDR_START (FIXADDR_TOP - FIXADDR_SIZE)
> +#define FIXADDR_USER_START (FIXADDR_TOP - FIXADDR_SIZE)
> +#define FIXADDR_USER_END FIXADDR_TOP
>
> #define __fix_to_virt(x) (FIXADDR_TOP - ((x) << PAGE_SHIFT))
> #define __virt_to_fix(x) ((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
> @@ -91,7 +92,7 @@ static inline unsigned long fix_to_virt(
>
> static inline unsigned long virt_to_fix(const unsigned long vaddr)
> {
> - BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
> + BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_USER_START);
> return __virt_to_fix(vaddr);
> }

-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

