Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWIFUW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWIFUW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 16:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWIFUW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 16:22:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44236 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751572AbWIFUW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 16:22:27 -0400
Date: Wed, 6 Sep 2006 13:20:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kirill Korotaev <dev@openvz.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, stable@kernel.org, xemul@openvz.org,
       devel@openvz.org
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
In-Reply-To: <44FC193C.4080205@openvz.org>
Message-ID: <Pine.LNX.4.64.0609061314430.27779@g5.osdl.org>
References: <44FC193C.4080205@openvz.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Sep 2006, Kirill Korotaev wrote:
> 
> +#ifdef __KERNEL__
> +#define arch_mmap_check	ia64_mmap_check
> +#ifndef __ASSEMBLY__
> +int ia64_mmap_check(unsigned long addr, unsigned long len,
> +		unsigned long flags);
> +#endif
> +#endif

Btw, is there some reason for the __ASSEMBLY__ check?

I'm not seeing any kernel users that could care, a quick

	git grep 'mman\.h' -- '*.[sS]'

doesn't trigger anything, and the other header files that include this 
seem to all either be mman.h themselves, or have things like structure 
declarations etc that wouldn't work for any non-C source anyway.

But maybe I missed some.

I'd rather not have more of those '#ifndef __ASSEMBLY__' than necessary.

		Linus
