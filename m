Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTH1HX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 03:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbTH1HX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 03:23:27 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:19461 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263751AbTH1HX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 03:23:26 -0400
Date: Thu, 28 Aug 2003 08:23:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miles Bader <miles@gnu.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v850]  Guard some symbol exports with #ifdef CONFIG_MMU
Message-ID: <20030828082324.A32093@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miles Bader <miles@gnu.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20030828051553.8E6203718@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030828051553.8E6203718@mcspd15.ucom.lsi.nec.co.jp>; from miles@lsi.nec.co.jp on Thu, Aug 28, 2003 at 02:15:53PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 02:15:53PM +0900, Miles Bader wrote:
> Linus, please apply.
> 
> diff -ruN -X../cludes linux-2.6.0-test4-uc0/kernel/ksyms.c linux-2.6.0-test4-uc0-v850-20030827/kernel/ksyms.c
> --- linux-2.6.0-test4-uc0/kernel/ksyms.c	2003-08-25 13:23:54.000000000 +0900
> +++ linux-2.6.0-test4-uc0-v850-20030827/kernel/ksyms.c	2003-08-26 11:43:52.000000000 +0900
> @@ -120,7 +120,9 @@
>  EXPORT_SYMBOL(max_mapnr);
>  #endif
>  EXPORT_SYMBOL(high_memory);
> +#ifdef CONFIG_MMU
>  EXPORT_SYMBOL_GPL(invalidate_mmap_range);
> +#endif
>  EXPORT_SYMBOL(vmtruncate);
>  EXPORT_SYMBOL(find_vma);
>  EXPORT_SYMBOL(get_unmapped_area);
> @@ -198,7 +200,9 @@
>  EXPORT_SYMBOL(invalidate_inode_pages);
>  EXPORT_SYMBOL_GPL(invalidate_inode_pages2);
>  EXPORT_SYMBOL(truncate_inode_pages);
> +#ifdef CONFIG_MMU
>  EXPORT_SYMBOL(install_page);
> +#endif

What about moving the exports to the definitions instead?

