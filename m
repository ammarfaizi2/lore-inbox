Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932218AbWFDJLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWFDJLS (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWFDJLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:11:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5058 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932218AbWFDJLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:11:17 -0400
Date: Sun, 4 Jun 2006 02:11:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [minor fix] radixtree: regulate tag get return value
Message-Id: <20060604021105.1ce7d727.akpm@osdl.org>
In-Reply-To: <349410738.29011@ustc.edu.cn>
References: <349410738.29011@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 16:45:48 +0800
Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:

> Andrew, this small patch makes the radixtree tester program from
>         http://www.zip.com.au/~akpm/linux/patches/stuff/rtth.tar.gz
> run OK, with the latest radix tree code in linux-2.6.17-rc5-mm2.
> 
> It regulates the return value to 0/1 for functions
> radix_tree_tag_get() and radix_tree_tagged().
> 

Well yes.  But it slows down the kernel.  It would be better to fix rtth.

> ---
> 
> --- linux.orig/lib/radix-tree.c
> +++ linux/lib/radix-tree.c
> @@ -156,7 +156,7 @@ static inline void tag_clear(struct radi
>  static inline int tag_get(struct radix_tree_node *node, unsigned int tag,
>  		int offset)
>  {
> -	return test_bit(offset, node->tags[tag]);
> +	return !! test_bit(offset, node->tags[tag]);
>  }

test_bit() is (sadly) defined to return 0 or 1.  Did this really make a difference?

>  static inline void root_tag_set(struct radix_tree_root *root, unsigned int tag)
> @@ -177,7 +177,7 @@ static inline void root_tag_clear_all(st
>  
>  static inline int root_tag_get(struct radix_tree_root *root, unsigned int tag)
>  {
> -	return root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT));
> +	return !! (root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT)));
>  }
>  

