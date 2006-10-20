Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946156AbWJTEZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946156AbWJTEZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 00:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946191AbWJTEZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 00:25:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946156AbWJTEZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 00:25:52 -0400
Date: Thu, 19 Oct 2006 21:25:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [PATCH 07/11] NFS: fix minor bug in new NFS symlink code
Message-Id: <20061019212541.b2adc4b2.akpm@osdl.org>
In-Reply-To: <20061019170432.8171.49033.stgit@lade.trondhjem.org>
References: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
	<20061019170432.8171.49033.stgit@lade.trondhjem.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 13:04:32 -0400
Trond Myklebust <Trond.Myklebust@netapp.com> wrote:

> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 58d4405..c86a1ea 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1519,8 +1519,8 @@ static int nfs_symlink(struct inode *dir
>  	pagevec_init(&lru_pvec, 0);
>  	if (!add_to_page_cache(page, dentry->d_inode->i_mapping, 0,
>  							GFP_KERNEL)) {
> -		if (!pagevec_add(&lru_pvec, page))
> -			__pagevec_lru_add(&lru_pvec);
> +		pagevec_add(&lru_pvec, page);
> +		pagevec_lru_add(&lru_pvec);
>  		SetPageUptodate(page);
>  		unlock_page(page);
>  	} else

One could export add_to_page_cache_lru() to modules..
