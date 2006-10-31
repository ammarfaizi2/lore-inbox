Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422985AbWJaIvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422985AbWJaIvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422987AbWJaIvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:51:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:732 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422985AbWJaIvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:51:49 -0500
Subject: Re: [PATCH 4/4] gfs2: ->readpages() fixes
From: Steven Whitehouse <swhiteho@redhat.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, cluster-devel@redhat.com, akpm@osdl.org
In-Reply-To: <87slh5lgbo.fsf@duaron.myhome.or.jp>
References: <87slh5lgbo.fsf@duaron.myhome.or.jp>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 31 Oct 2006 08:56:45 +0000
Message-Id: <1162285005.27980.278.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-10-31 at 05:05 +0900, OGAWA Hirofumi wrote:
> This just ignore the remaining pages, and remove unneeded unlock_pages().
> 
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Acked-by: Steven Whitehouse <swhiteho@redhat.com>

Thanks for fixing this,

Steve.


> ---
> 
>  fs/gfs2/ops_address.c |    7 -------
>  1 file changed, 7 deletions(-)
> 
> diff -puN fs/gfs2/ops_address.c~readpages-fixes-gfs2 fs/gfs2/ops_address.c
> --- linux-2.6/fs/gfs2/ops_address.c~readpages-fixes-gfs2	2006-10-31 04:26:20.000000000 +0900
> +++ linux-2.6-hirofumi/fs/gfs2/ops_address.c	2006-10-31 04:26:20.000000000 +0900
> @@ -337,13 +337,6 @@ out:
>  out_noerror:
>  	ret = 0;
>  out_unlock:
> -	/* unlock all pages, we can't do any I/O right now */
> -	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
> -		struct page *page = list_entry(pages->prev, struct page, lru);
> -		list_del(&page->lru);
> -		unlock_page(page);
> -		page_cache_release(page);
> -	}
>  	if (do_unlock)
>  		gfs2_holder_uninit(&gh);
>  	goto out;
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

