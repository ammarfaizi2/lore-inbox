Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261298AbSJPSuV>; Wed, 16 Oct 2002 14:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSJPSuU>; Wed, 16 Oct 2002 14:50:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26896 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261298AbSJPSuT>;
	Wed, 16 Oct 2002 14:50:19 -0400
Message-ID: <3DADB656.7080105@pobox.com>
Date: Wed, 16 Oct 2002 14:56:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] default VM flags for upwards-growing stacks
References: <20021016194238.O15163@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> diff -urpNX build-tools/dontdiff linus-2.5/include/linux/mm.h parisc-2.5/include/linux/mm.h
> --- linus-2.5/include/linux/mm.h	Tue Oct  8 10:54:13 2002
> +++ parisc-2.5/include/linux/mm.h	Tue Oct  8 16:49:15 2002
> @@ -106,7 +106,11 @@ struct vm_area_struct {
>  #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
>  #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
>  
> -#define VM_STACK_FLAGS	(0x00000100 | VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT)
> +#ifdef ARCH_STACK_GROWSUP
> +#define VM_STACK_FLAGS	(VM_GROWSUP | VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT)
> +#else
> +#define VM_STACK_FLAGS	(VM_GROWSDOWN | VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT)
> +#endif


is it worth it to crease a VM_GROW_DIR define instead?

then there is no ifdef in linux/mm.h, just an arch-dependent define.

