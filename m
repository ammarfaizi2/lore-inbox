Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVHVVtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVHVVtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVHVVtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:49:22 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:34523 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750810AbVHVVtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:49:21 -0400
Subject: Re: [RFC] Cleanup line-wrapping in pgtable.h
From: Matthew Helsley <matthltc@us.ibm.com>
To: Adam Litke <agl@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1124300739.3139.16.camel@localhost.localdomain>
References: <1124300739.3139.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 22 Aug 2005 14:11:00 -0700
Message-Id: <1124745060.12346.599.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 12:45 -0500, Adam Litke wrote:
> The line-wrapping in most of the include/asm/pgtable.h pte test/set
> macros looks horrible in my 80 column terminal.  The following "test the
> waters" patch is how I would like to see them laid out.  I realize that
> the braces don't adhere to CodingStyle but the advantage is (when taking
> wrapping into account) that the code takes up no additional space.  How
> do people feel about making this change?  Any better suggestions?  I
> personally wouldn't like a lone closing brace like normal functions
> because of the extra lines eaten.  I volunteer to patch up the other
> architectures if we reach a consensus.
> 
> Signed-off-by: Adam Litke <agl@us.ibm.com>
> 
>  pgtable.h |   51 ++++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 34 insertions(+), 17 deletions(-)
> diff -upN reference/include/asm-i386/pgtable.h current/include/asm-i386/pgtable.h
> --- reference/include/asm-i386/pgtable.h
> +++ current/include/asm-i386/pgtable.h
> @@ -215,28 +215,45 @@ extern unsigned long pg0[];
>   * The following only work if pte_present() is true.
>   * Undefined behaviour if not..
>   */
> -static inline int pte_user(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
> -static inline int pte_read(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
> -static inline int pte_dirty(pte_t pte)		{ return (pte).pte_low & _PAGE_DIRTY; }
> -static inline int pte_young(pte_t pte)		{ return (pte).pte_low & _PAGE_ACCESSED; }
> -static inline int pte_write(pte_t pte)		{ return (pte).pte_low & _PAGE_RW; }
> +static inline int pte_user(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_USER; }
> +static inline int pte_read(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_USER; }
> +static inline int pte_dirty(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_DIRTY; }
> +static inline int pte_young(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_ACCESSED; }
> +static inline int pte_write(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_RW; }

	I think removing the whitespace preceding the opening braces is closer
to CodingStyle, allows for longer lines in the future (however gross
they may be), and does not alter the vertical space consumed on your
display.

>  /*
>   * The following only works if pte_present() is not true.
>   */
> -static inline int pte_file(pte_t pte)		{ return (pte).pte_low & _PAGE_FILE; }
> +static inline int pte_file(pte_t pte)
> +	{ return (pte).pte_low & _PAGE_FILE; }
>  
> -static inline pte_t pte_rdprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
> -static inline pte_t pte_exprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
> -static inline pte_t pte_mkclean(pte_t pte)	{ (pte).pte_low &= ~_PAGE_DIRTY; return pte; }
> -static inline pte_t pte_mkold(pte_t pte)	{ (pte).pte_low &= ~_PAGE_ACCESSED; return pte; }
> -static inline pte_t pte_wrprotect(pte_t pte)	{ (pte).pte_low &= ~_PAGE_RW; return pte; }

As long as this file is being polished, you might move pte_wrprotect()
up so it is between pte_rdprotect() and pte_exprotect().

> -static inline pte_t pte_mkread(pte_t pte)	{ (pte).pte_low |= _PAGE_USER; return pte; }
> -static inline pte_t pte_mkexec(pte_t pte)	{ (pte).pte_low |= _PAGE_USER; return pte; }
> -static inline pte_t pte_mkdirty(pte_t pte)	{ (pte).pte_low |= _PAGE_DIRTY; return pte; }
> -static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
> -static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
> -static inline pte_t pte_mkhuge(pte_t pte)	{ (pte).pte_low |= _PAGE_PRESENT | _PAGE_PSE; return pte; }
> +static inline pte_t pte_rdprotect(pte_t pte)
> +	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
> +static inline pte_t pte_exprotect(pte_t pte)
> +	{ (pte).pte_low &= ~_PAGE_USER; return pte; }
> +static inline pte_t pte_mkclean(pte_t pte)
> +	{ (pte).pte_low &= ~_PAGE_DIRTY; return pte; }
> +static inline pte_t pte_mkold(pte_t pte)
> +	{ (pte).pte_low &= ~_PAGE_ACCESSED; return pte; }
> +static inline pte_t pte_wrprotect(pte_t pte)
> +	{ (pte).pte_low &= ~_PAGE_RW; return pte; }
> +static inline pte_t pte_mkread(pte_t pte)
> +	{ (pte).pte_low |= _PAGE_USER; return pte; }
> +static inline pte_t pte_mkexec(pte_t pte)
> +	{ (pte).pte_low |= _PAGE_USER; return pte; }
> +static inline pte_t pte_mkdirty(pte_t pte)
> +	{ (pte).pte_low |= _PAGE_DIRTY; return pte; }
> +static inline pte_t pte_mkyoung(pte_t pte)
> +	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
> +static inline pte_t pte_mkwrite(pte_t pte)
> +	{ (pte).pte_low |= _PAGE_RW; return pte; }
> +static inline pte_t pte_mkhuge(pte_t pte)
> +	{ (pte).pte_low |= _PAGE_PRESENT | _PAGE_PSE; return pte; }
>  
>  #ifdef CONFIG_X86_PAE
>  # include <asm/pgtable-3level.h>

Cheers,
	-Matt Helsley

