Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbTHERod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 13:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbTHERod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 13:44:33 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:27273
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S267186AbTHERoc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 13:44:32 -0400
Date: Tue, 5 Aug 2003 13:44:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rddunlap@osdl.org>, Leann Ogasawara <ogasawara@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] revert to static = {0}
Message-ID: <20030805174429.GA26933@gtf.org>
References: <Pine.LNX.4.44.0308051638040.1471-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308051638040.1471-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 04:48:02PM +0100, Hugh Dickins wrote:
> Please revert to static zero initialization of a const: when thus
> initialized it's linked into a readonly cacheline shared between cpus;
> otherwise it's linked into bss, likely to be in a dirty cacheline
> bouncing between cpus.
> 
> --- 2.6.0-test2-bk/mm/shmem.c	Tue Aug  5 15:57:31 2003
> +++ linux/mm/shmem.c	Tue Aug  5 16:16:55 2003
> @@ -296,7 +296,7 @@
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>  	struct page *page = NULL;
>  	swp_entry_t *entry;
> -	static const swp_entry_t unswapped;
> +	static const swp_entry_t unswapped = {0};
>  
>  	if (sgp != SGP_WRITE &&
>  	    ((loff_t) index << PAGE_CACHE_SHIFT) >= i_size_read(inode))
> 

If it's const, it shouldn't be linked into anything at all... right?

	Jeff



