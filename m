Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTFSW6A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 18:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbTFSW57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 18:57:59 -0400
Received: from rj.sgi.com ([192.82.208.96]:43720 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261823AbTFSW55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 18:57:57 -0400
Date: Fri, 20 Jun 2003 09:11:17 +1000
From: Nathan Scott <nathans@sgi.com>
To: Chris Mason <mason@suse.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buffer_insert_list should use list_add_tail
Message-ID: <20030619231117.GB722@frodo>
References: <1056028538.6757.94.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056028538.6757.94.camel@tiny.suse.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 09:15:39AM -0400, Chris Mason wrote:
> Hello all,
> 
> buffer_insert_list puts buffers onto the head of bh->b_inode_buffers,
> which means that on fsync we are writing things out in reverse order.  I
> think we either want this patch, or we want to walk the list in reverse
> in fsync_buffers_list
> 
> (this has not been well tested, but I can't think of any problems it
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> would cause)


hi Chris,

We noticed this too and Christoph made this change in the
2.4 XFS tree a little while ago - let me check dates - ah,
9th May.  So, fair bit of testing here and we've not seen
any issues from this change either (we'd also like to see
it merged).

thanks.


> 
> -chris
> 
> --- linux.marcelo/fs/buffer.c	Thu Jun 19 09:09:28 2003
> +++ linux/fs/buffer.c	Thu Jun 19 09:04:17 2003
> @@ -591,7 +604,7 @@
>  	if (buffer_attached(bh))
>  		list_del(&bh->b_inode_buffers);
>  	set_buffer_attached(bh);
> -	list_add(&bh->b_inode_buffers, list);
> +	list_add_tail(&bh->b_inode_buffers, list);
>  	spin_unlock(&lru_list_lock);
>  }
>  
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Nathan
