Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWBFJ2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWBFJ2l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWBFJ2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:28:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8854 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750839AbWBFJ2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:28:41 -0500
Date: Mon, 6 Feb 2006 01:28:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: bcrl@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, V2] i386: instead of poisoning .init zone, change
 protection bits to force a fault
Message-Id: <20060206012809.3045207c.akpm@osdl.org>
In-Reply-To: <43E7108A.8030001@cosmosbay.com>
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>
	<m17j8jfs03.fsf@ebiederm.dsl.xmission.com>
	<20060128235113.697e3a2c.akpm@osdl.org>
	<200601291620.28291.ioe-lkml@rameria.de>
	<20060129113312.73f31485.akpm@osdl.org>
	<43DD1FDC.4080302@cosmosbay.com>
	<20060129200504.GD28400@kvack.org>
	<43DD2C15.1090800@cosmosbay.com>
	<20060204144111.7e33569f.akpm@osdl.org>
	<43E7108A.8030001@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> >  #ifdef CONFIG_DEBUG_INITDATA
>  > +		/*
>  > +		 * Unmap the page, and leak it.  So any further accesses will
>  > +		 * oops.
>  > +		 */
>  >  		change_page_attr(virt_to_page(addr), 1, __pgprot(0));
>  >  #else
>  >  		memset((void *)addr, 0xcc, PAGE_SIZE);
>  > -#endif
>  >  		free_page(addr);
>  > +#endif
>  >  		totalram_pages++;
>  >  	}
>  >  	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
> 
>  I wonder if you dont have to move the 'totalram_pages++;' next to the 
>  free_page(addr) call (ie inside the #else/#endif block)
> 

yup, thanks.

But I'm inclined to drop the whole patch - I don't see how it can detect
any bugs which CONFIG_DEBUG_PAGEALLOC won't find.

