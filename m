Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751801AbWHATGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWHATGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWHATGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:06:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:62888 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751801AbWHATG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:06:29 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 2/33] i386: define __pa_symbol
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302293540-git-send-email-ebiederm@xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 21:06:27 +0200
In-Reply-To: <11544302293540-git-send-email-ebiederm@xmission.com>
Message-ID: <p73lkq81djg.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> On x86_64 we have to be careful with calculating the physical
> address of kernel symbols.  Both because of compiler odditities
> and because the symbols live in a different range of the virtual
> address space.
> 
> Having a defintition of __pa_symbol that works on both x86_64 and
> i386 simplifies writing code that works for both x86_64 and
> i386 that has these kinds of dependencies.
> 
> So this patch adds the trivial i386 __pa_symbol definition.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  include/asm-i386/page.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-i386/page.h b/include/asm-i386/page.h
> index f5bf544..eceb7f5 100644
> --- a/include/asm-i386/page.h
> +++ b/include/asm-i386/page.h
> @@ -124,6 +124,7 @@ #define PAGE_OFFSET		((unsigned long)__P
>  #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
>  #define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
>  #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
> +#define __pa_symbol(x)		__pa(x)

Actually PAGE_OFFSET arithmetic on symbols is outside ISO C and gcc 
misoptimizes it occassionally. You would need to use HIDE_RELOC
or similar. That is why x86-64 has the magic.

-Andi
