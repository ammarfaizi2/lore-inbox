Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbTIIV6M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264606AbTIIV6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:58:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:5350 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264605AbTIIV6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:58:00 -0400
Message-Id: <200309092157.h89Lvkm31595@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: joshk@triplehelix.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       akpm@osdl.org
Subject: Re: 2.6.0-test5-mm1 
In-Reply-To: Message from Joshua Kwan <joshk@triplehelix.org> 
   of "Tue, 09 Sep 2003 00:02:13 PDT." <20030909070213.GF7314@triplehelix.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Sep 2003 14:57:46 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OSDL's STP saw this problem, no tests ran on 2.6.0-test5-mm1

We've added this patch (PLM #2112) and are running tests now.
cliffw


> On Mon, Sep 08, 2003 at 11:50:28PM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm1/
> 
> Needs the following patch to compile:
> 
> --- mm/slab.c~	2003-09-08 23:58:31.000000000 -0700
> +++ mm/slab.c	2003-09-08 23:58:33.000000000 -0700
> @@ -2794,11 +2794,13 @@
>  		} else {
>  			kernel_map_pages(virt_to_page(objp), c->objsize/PAGE_SIZE, 1);
>  
> +#if DEBUG
>  			if (c->flags & SLAB_RED_ZONE)
>  				printk("redzone: 0x%lx/0x%lx.\n", *dbg_redzone1(c, objp), *dbg_redzone2(c, objp));
>  
>  			if (c->flags & SLAB_STORE_USER)
>  				printk("Last user: %p.\n", *dbg_userword(c, objp));
> +#endif
>  		}
>  		spin_unlock_irqrestore(&c->spinlock, flags);
>  
> -- 
> Joshua Kwan


