Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVBQIeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVBQIeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 03:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVBQIeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 03:34:05 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:35431 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262161AbVBQIeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 03:34:00 -0500
Message-ID: <421456F1.6090100@yahoo.com.au>
Date: Thu, 17 Feb 2005 19:33:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix possible race with 4level-fixup.h
References: <1108624747.5383.52.camel@gaston>
In-Reply-To: <1108624747.5383.52.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Hi !
> 
> When using 4level-fixup.h, a PMD page may end up beeing freed before the
> matching PGD entry is cleared due to the way the compatibility macros
> work. This can cause nasty races on some architectures.
> 
> This patch fixes it by defining pud_clear() to be pgd_clear(). That
> means we'll actually write 0 twice, a small price to pay here,
> especially seeing how easy it is to convert to the new headers anyway
> (hint hint, ppc & ppc64 patches as soon as 2.6.11 is out).
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Index: linux-work/include/asm-generic/4level-fixup.h
> ===================================================================
> --- linux-work.orig/include/asm-generic/4level-fixup.h	2005-01-24 17:09:49.000000000 +1100
> +++ linux-work/include/asm-generic/4level-fixup.h	2005-02-17 18:10:38.000000000 +1100
> @@ -24,7 +24,7 @@
>  #define pud_bad(pud)			0
>  #define pud_present(pud)		1
>  #define pud_ERROR(pud)			do { } while (0)
> -#define pud_clear(pud)			do { } while (0)
> +#define pud_clear(pud)			pgd_clear((pgd_t *)(pud))
>  

Just a small nit - no cast needed here.

