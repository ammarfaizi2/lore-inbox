Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVCDCuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVCDCuc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbVCDCtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:49:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:65227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262314AbVCCXkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:40:51 -0500
Date: Thu, 3 Mar 2005 15:40:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: paulus@samba.org, geert@linux-m68k.org, linuxppc-dev@ozlabs.org,
       linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.11] gcc4 fix for <asm-m68k/setup.h>
Message-Id: <20050303154013.4790be3b.akpm@osdl.org>
In-Reply-To: <16935.14471.919379.826792@alkaid.it.uu.se>
References: <16935.14471.919379.826792@alkaid.it.uu.se>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@user.it.uu.se> wrote:
>
> gcc4 generates compile errors when it sees declarations
> of arrays of incomplete element types. <asm-m68k/setup.h>
> has one such declaration, which unfortunately breaks ppc32
> since <asm-ppc/setup.h> #includes <asm-m68k/setup.h>.
> 
> The fix in this case is to simply move the array declaration
> to after the corresponding element type declaration.
> 
> Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

Thanks, I'll merge that up.

> diff -rupN linux-2.6.11/include/asm-m68k/setup.h linux-2.6.11.gcc4-fixes-v2/include/asm-m68k/setup.h
> --- linux-2.6.11/include/asm-m68k/setup.h	2004-12-25 12:16:22.000000000 +0100
> +++ linux-2.6.11.gcc4-fixes-v2/include/asm-m68k/setup.h	2005-03-02 19:36:26.000000000 +0100
> @@ -362,12 +362,13 @@ extern int m68k_is040or060;
>  #ifndef __ASSEMBLY__
>  extern int m68k_num_memory;		/* # of memory blocks found (and used) */
>  extern int m68k_realnum_memory;		/* real # of memory blocks found */
> -extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
>  
>  struct mem_info {
>  	unsigned long addr;		/* physical address of memory chunk */
>  	unsigned long size;		/* length of memory chunk (in bytes) */
>  };
> +
> +extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
>  #endif
>  
>  #endif /* __KERNEL__ */

