Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWEYQev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWEYQev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWEYQev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:34:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44689 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030257AbWEYQeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:34:50 -0400
Date: Thu, 25 May 2006 09:33:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 08/33] readahead: common macros
Message-Id: <20060525093356.7010efa2.akpm@osdl.org>
In-Reply-To: <348469539.42623@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469539.42623@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> Define some common used macros for the read-ahead logics.
> 
> Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
> ---
> 
>  mm/readahead.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
> +++ linux-2.6.17-rc4-mm3/mm/readahead.c
> @@ -5,6 +5,8 @@
>   *
>   * 09Apr2002	akpm@zip.com.au
>   *		Initial version.
> + * 21May2006	Wu Fengguang <wfg@mail.ustc.edu.cn>
> + *		Adaptive read-ahead framework.
>   */
>  
>  #include <linux/kernel.h>
> @@ -14,6 +16,14 @@
>  #include <linux/blkdev.h>
>  #include <linux/backing-dev.h>
>  #include <linux/pagevec.h>
> +#include <linux/writeback.h>
> +#include <linux/nfsd/const.h>

Why on earth are we including that file?

Whatever goodies it contains should be moved into fs.h or mm.h or something.

> +
> +#define PAGES_BYTE(size) (((size) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT)
> +#define PAGES_KB(size)	 PAGES_BYTE((size)*1024)

These aren't proving popular.

> +#define next_page(pg) (list_entry((pg)->lru.prev, struct page, lru))
> +#define prev_page(pg) (list_entry((pg)->lru.next, struct page, lru))

hm.  Makes sense I guess, but normally we'll be iterating across lists with
the list_for_each*() helpers, so I'm a little surprised that the above are
needed.


