Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbWHJIKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWHJIKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 04:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbWHJIKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 04:10:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161130AbWHJIKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 04:10:22 -0400
Date: Thu, 10 Aug 2006 01:10:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: zam@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix error case in fuse_readpages
Message-Id: <20060810011006.45ba6eb7.akpm@osdl.org>
In-Reply-To: <E1GB5Pu-0002TI-00@dorka.pomaz.szeredi.hu>
References: <E1GB5Pu-0002TI-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 09:57:22 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:

> Thanks Alex.
> 
> -mm also needs s/page_cache_release/read_cache_pages_release_page/ on patch
> 
> --
> From: Alexander Zarochentsev <zam@namesys.com>
> 
> Don't let fuse_readpages leave the @pages list not empty when exiting
> on error.
> 

hm, OK.

> +extern void readpages_cleanup_helper(struct list_head *);

Can we think of a better name?  I mean, all it does is throw away a list of
pages.  The caller doesn't _have_ to be using it within the context of
read_cache_pages().  put_pages()?  put_pages_list()?

And if we do make this a more generic thing, it'd be better off living in
mm/swap.c, which is really mm/mm-library-stuff.c nowadays.

>  /**
> + * may be useful in foo_fs_readpages method for the page pool cleanup
> + * before exiting on error.
> + */

"/**" introduces a kerneldoc comment, but that isn't a kerneldoc comment.
It would be best to turn it into a kerneldoc comment.


