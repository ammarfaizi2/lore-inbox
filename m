Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbUEFHnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUEFHnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 03:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUEFHnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 03:43:07 -0400
Received: from colin2.muc.de ([193.149.48.15]:8204 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261263AbUEFHnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 03:43:04 -0400
Date: 6 May 2004 09:43:02 +0200
Date: Thu, 6 May 2004 09:43:02 +0200
From: Andi Kleen <ak@muc.de>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: Andrew Morton <akpm@zip.com.au>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 does not build on AMD64 + essential patch is missing
Message-ID: <20040506074302.GA47323@colin2.muc.de>
References: <200405052210.18074.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405052210.18074.rjwysocki@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 10:13:52PM +0200, R. J. Wysocki wrote:
> Hi,
> 
> The 2.6.6-rc3-mm2 kernel does not buld on AMD64 w/ NUMA, it appears.  Here's 
> what the gcc says:
> 
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/x86_64/ia32/built-in.o(.text+0xa164): In function `ia32_setup_arg_pages':
> : undefined reference to `mpol_set_vma_default'
> kernel/built-in.o(.text+0x9ba0): In function `do_exit':
> : undefined reference to `mpol_free'
> make: *** [.tmp_vmlinux1] Error 1
> 
> (attached is the .config).  Also, IMHO, the patch:

Just revert the broken small-numa-api-fixups.patch patch,
which never seems to have been compile tested on anything.

> 
> --- include/asm-x86_64/processor.h.orig	2004-05-05 21:35:55.890656408 +0200
> +++ include/asm-x86_64/processor.h	2004-05-05 21:41:15.930003032 +0200
> @@ -20,6 +20,8 @@
>  #include <asm/mmsegment.h>
>  #include <linux/personality.h>
>  
> +#define ARCH_MIN_TASKALIGN 16
> +
>  #define TF_MASK		0x00000100
>  #define IF_MASK		0x00000200
>  #define IOPL_MASK	0x00003000
> 
> should be applied to it, so that it does not crash at init.

AFAIK Andrew fixed this in a different way.

-Andi
