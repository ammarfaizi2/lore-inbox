Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932841AbWFMDwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932841AbWFMDwD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 23:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932850AbWFMDwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 23:52:01 -0400
Received: from ns.suse.de ([195.135.220.2]:14568 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932843AbWFMDvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 23:51:47 -0400
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] tmpfs: time granularity fix for [acm]time going backwards
Date: Tue, 13 Jun 2006 05:38:33 +0200
User-Agent: KMail/1.9.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Robin H. Johnson" <robbat2@gentoo.org>,
       Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060611115421.GE26475@curie-int.vc.shawcable.net> <Pine.LNX.4.64.0606122011020.18760@blonde.wat.veritas.com> <Pine.LNX.4.64.0606122146090.23556@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0606122146090.23556@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606130538.33160.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch should probably be included for 2.6.17, despite how long the
> bug has been around. It's a one-liner, with no side-effects.

Agreed - it's obviously correct and a nasty little problem.
Should be in 2.6.17.

-Andi

> 
>  mm/shmem.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- 2.6.17-rc6-git/mm/shmem.c
> +++ linux/mm/shmem.c
> @@ -2102,6 +2102,7 @@ static int shmem_fill_super(struct super
>  	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
>  	sb->s_magic = TMPFS_MAGIC;
>  	sb->s_op = &shmem_ops;
> +	sb->s_time_gran = 1;
>  
>  	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
>  	if (!inode)
> 
