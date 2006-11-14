Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966284AbWKNTYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966284AbWKNTYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966283AbWKNTYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:24:21 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1555 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S966284AbWKNTYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:24:21 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm2
Date: Tue, 14 Nov 2006 20:23:53 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114084130.68721fcd.akpm@osdl.org> <20061114090932.50a9917c.akpm@osdl.org>
In-Reply-To: <20061114090932.50a9917c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611142023.53639.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hm, but that breaks x86.   Maybe this..
>
>
>  arch/i386/kernel/alternative.c   |    5 -----
>  include/asm-i386/alternative.h   |    4 ++++
>  include/asm-x86_64/alternative.h |    4 ++++
>  3 files changed, 8 insertions(+), 5 deletions(-)
>
> diff -puN
> arch/i386/kernel/alternative.c~fix-x86_64-mm-patch-inline-replacements-for
> arch/i386/kernel/alternative.c ---
> a/arch/i386/kernel/alternative.c~fix-x86_64-mm-patch-inline-replacements-fo
>r +++ a/arch/i386/kernel/alternative.c
> @@ -380,11 +380,6 @@ void apply_paravirt(struct paravirt_patc
>  }
>  extern struct paravirt_patch __start_parainstructions[],
>  	__stop_parainstructions[];
> -#else
> -void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch
> *end) -{
> -}
> -extern struct paravirt_patch *__start_parainstructions,
> *__stop_parainstructions; #endif	/* CONFIG_PARAVIRT */
>
>  void __init alternative_instructions(void)
> diff -puN
> include/asm-i386/alternative.h~fix-x86_64-mm-patch-inline-replacements-for
> include/asm-i386/alternative.h ---
> a/include/asm-i386/alternative.h~fix-x86_64-mm-patch-inline-replacements-fo
>r +++ a/include/asm-i386/alternative.h
> @@ -119,6 +119,10 @@ static inline void alternatives_smp_swit
>  #endif
>
>  struct paravirt_patch;
> +#ifdef CONFIG_PARAVIRT
>  void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch
> *end); +#else
> +#define apply_paravirt(start, end) do { } while (0)
> +#endif
>
>  #endif /* _I386_ALTERNATIVE_H */
> diff -puN
> include/asm-x86_64/alternative.h~fix-x86_64-mm-patch-inline-replacements-fo
>r include/asm-x86_64/alternative.h ---
> a/include/asm-x86_64/alternative.h~fix-x86_64-mm-patch-inline-replacements-
>for +++ a/include/asm-x86_64/alternative.h
> @@ -134,6 +134,10 @@ static inline void alternatives_smp_swit
>  #endif
>
>  struct paravirt_patch;
> +#ifdef CONFIG_PARAVIRT
>  void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch
> *end); +#else
> +#define apply_paravirt(start, end) do { } while (0)
> +#endif
>
>  #endif /* _X86_64_ALTERNATIVE_H */
> _
>
>
> Unpleasant duplication there.  Perhaps we should have linux/alternative.h

Thanks. It compiled fine with this patch.

-- 
Regards,

	Mariusz Kozlowski
