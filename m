Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVCEW7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVCEW7M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVCEW45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:56:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:23181 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261322AbVCEWxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:53:04 -0500
Subject: Re: [PATCH]
	ppc64-implement-a-vdso-and-use-it-for-signal-trampoline gas workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200503051830.j25IU4Vq007528@hera.kernel.org>
References: <200503051830.j25IU4Vq007528@hera.kernel.org>
Content-Type: text/plain
Date: Sun, 06 Mar 2005 09:49:27 +1100
Message-Id: <1110062967.13607.82.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-05 at 17:33 +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.2212, 2005/03/05 09:33:46-08:00, akpm@osdl.org
> 
> 	[PATCH] ppc64-implement-a-vdso-and-use-it-for-signal-trampoline gas workaround
> 	
> 	I cannot find a version of binutils which doesn't either do
> 	
> 	arch/ppc64/kernel/vdso32/gettimeofday.S: Assembler messages:
> 	arch/ppc64/kernel/vdso32/gettimeofday.S:33: Error: syntax error; found `@' but expected `,'

Ugh... Do that still happen once you finally get it to build with a 32
bits compiler and not a 64 bits one ? The @local is actually needed for
the 32 bits build.

> 	or
> 	
> 	arch/ppc64/kernel/vdso32/gettimeofday.S: Assembler messages:
> 	arch/ppc64/kernel/vdso32/gettimeofday.S:33: Internal error, aborting at ../../gas/config/tc-ppc.c line 2658 in md_assemble
> 	
> 	
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> 
> 
>  datapage.S     |    2 +-
>  gettimeofday.S |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> diff -Nru a/arch/ppc64/kernel/vdso32/datapage.S b/arch/ppc64/kernel/vdso32/datapage.S
> --- a/arch/ppc64/kernel/vdso32/datapage.S	2005-03-05 10:30:16 -08:00
> +++ b/arch/ppc64/kernel/vdso32/datapage.S	2005-03-05 10:30:16 -08:00
> @@ -56,7 +56,7 @@
>    .cfi_register lr,r12
>  
>  	mr	r4,r3
> -	bl	__get_datapage@local
> +	bl	__get_datapage
>  	mtlr	r12
>  	addi	r3,r3,CFG_SYSCALL_MAP32
>  	cmpli	cr0,r4,0
> diff -Nru a/arch/ppc64/kernel/vdso32/gettimeofday.S b/arch/ppc64/kernel/vdso32/gettimeofday.S
> --- a/arch/ppc64/kernel/vdso32/gettimeofday.S	2005-03-05 10:30:16 -08:00
> +++ b/arch/ppc64/kernel/vdso32/gettimeofday.S	2005-03-05 10:30:16 -08:00
> @@ -30,9 +30,9 @@
>  
>  	mr	r10,r3			/* r10 saves tv */
>  	mr	r11,r4			/* r11 saves tz */
> -	bl	__get_datapage@local	/* get data page */
> +	bl	__get_datapage		/* get data page */
>  	mr	r9, r3			/* datapage ptr in r9 */
> -	bl	__do_get_xsec@local	/* get xsec from tb & kernel */
> +	bl	__do_get_xsec		/* get xsec from tb & kernel */
>  	bne-	2f			/* out of line -> do syscall */
>  
>  	/* seconds are xsec >> 20 */
> -
> To unsubscribe from this list: send the line "unsubscribe bk-commits-head" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

