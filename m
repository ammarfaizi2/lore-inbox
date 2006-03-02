Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWCBBta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWCBBta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWCBBt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:49:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751349AbWCBBt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:49:29 -0500
Date: Wed, 1 Mar 2006 17:51:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] change buffer_head.b_size to size_t
Message-Id: <20060301175135.4cd0a74e.akpm@osdl.org>
In-Reply-To: <1141075361.10542.21.camel@dyn9047017100.beaverton.ibm.com>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
	<1141075361.10542.21.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> +	size_t b_size;			/* size of mapping */
> +	char *b_data;			/* pointer to data within the page */
>  
>  	struct block_device *b_bdev;
>  	bh_end_io_t *b_end_io;		/* I/O completion */
>   	void *b_private;		/* reserved for b_end_io */
>  	struct list_head b_assoc_buffers; /* associated with another mapping */
> +	atomic_t b_count;		/* users using this buffer_head */
>  };
>  
>  /*
> Index: linux-2.6.16-rc5/fs/buffer.c
> ===================================================================
> --- linux-2.6.16-rc5.orig/fs/buffer.c	2006-02-26 21:09:35.000000000 -0800
> +++ linux-2.6.16-rc5/fs/buffer.c	2006-02-27 08:22:37.000000000 -0800
> @@ -432,7 +432,8 @@ __find_get_block_slow(struct block_devic
>  		printk("__find_get_block_slow() failed. "
>  			"block=%llu, b_blocknr=%llu\n",
>  			(unsigned long long)block, (unsigned long long)bh->b_blocknr);
> -		printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
> +		printk("b_state=0x%08lx, b_size=%lu\n", bh->b_state,
> +				(unsigned long)bh->b_size);

We print size_t with `%z'.  Hence the cast isn't needed.

(I'll edit the diff..)
