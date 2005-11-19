Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbVKSBH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVKSBH0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVKSBH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:07:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751293AbVKSBHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:07:25 -0500
Date: Fri, 18 Nov 2005 17:07:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile fix 2.6.15-rc1-mm1 + EXPERIMENTAL+  CONFIG_SPARSEMEM +
 X86_PC
Message-Id: <20051118170744.2c852d25.akpm@osdl.org>
In-Reply-To: <437D79F3.9070301@jp.fujitsu.com>
References: <437D79F3.9070301@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> Hi,
> 
> This is a compile fix for
> X86_PC && EXPERIMENTAL && CONFIG_SPARSEMEM=y && !CONFIG_NEED_MULTIPLE_NODES
> 
> BTW, on x86, it looks I can select CONFIG_NUMA=y but will not set
> CONFIG_NEED_MULTIPLE_NODES. It this expected ?
> 

This patch is difficult for me to handle, because I don't know which
patches it fixes - probably it fixes two separate ones and needs to become
two patches.  Usually it's obvious which patches are being fixed. 
Sometimes reporters will tell me which patch is being fixed (extra nice!). 
In this case, it's unobvious.

Please always include the text of the error messages when fixing compile
errors.

Please send me the .config.

> --
> Index: linux-2.6.15-rc1-mm1/include/linux/mmzone.h
> ===================================================================
> --- linux-2.6.15-rc1-mm1.orig/include/linux/mmzone.h
> +++ linux-2.6.15-rc1-mm1/include/linux/mmzone.h
> @@ -596,12 +596,13 @@ static inline int pfn_valid(unsigned lon
>   		return 0;
>   	return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
>   }
> -
> +#ifdef CONFIG_NEED_MULTIPLE_NODES
>   #define pfn_to_nid(pfn)							\
>   ({									\
>    	unsigned long __pfn = (pfn);                                    \
>   	page_to_nid(pfn_to_page(pfn));					\
>   })
> +#endif
> 
>   #define early_pfn_valid(pfn)	pfn_valid(pfn)
>   void sparse_init(void);
> Index: linux-2.6.15-rc1-mm1/drivers/base/memory.c
> ===================================================================
> --- linux-2.6.15-rc1-mm1.orig/drivers/base/memory.c
> +++ linux-2.6.15-rc1-mm1/drivers/base/memory.c
> @@ -25,7 +25,7 @@
> 
>   #define MEMORY_CLASS_NAME	"memory"
> 
> -static struct sysdev_class memory_sysdev_class = {
> +struct sysdev_class memory_sysdev_class = {
>   	set_kset_name(MEMORY_CLASS_NAME),
>   };
>   EXPORT_SYMBOL(memory_sysdev_class);
