Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbTLIXrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 18:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTLIXrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 18:47:41 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:50445 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263345AbTLIXrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 18:47:40 -0500
Date: Wed, 10 Dec 2003 10:46:55 +1100
From: Nathan Scott <nathans@sgi.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/4] fs.h: b_journal_head
Message-ID: <20031209234655.GF783@frodo>
References: <20031209115806.GA472@reti> <20031209122418.GC472@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209122418.GC472@reti>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Dec 09, 2003 at 12:24:18PM +0000, Joe Thornber wrote:
> Add a new member to struct buffer_head called b_journal_head.  This is
> for jbd to use, rather than have it peeking at b_private for in flight
> ios.
> ...
> --- diff/include/linux/fs.h	2003-12-09 10:25:27.000000000 +0000
> +++ source/include/linux/fs.h	2003-12-09 10:32:41.000000000 +0000
> @@ -265,7 +265,7 @@
>  	struct page *b_page;		/* the page this bh is mapped to */
>  	void (*b_end_io)(struct buffer_head *bh, int uptodate); /* I/O completion */
>   	void *b_private;		/* reserved for b_end_io */
> -
> + 	void *b_journal_head;		/* ext3 journal_heads */
>  	unsigned long b_rsector;	/* Real buffer location on disk */
>  	wait_queue_head_t b_wait;
>  

Could you explain a bit more about when b_private should and
shouldn't be used with this change?  We make use of b_private
within XFS, I'm just wondering if we will be stepping on each
others toes here?  And if XFS does need to use b_journal_head
instead of b_private with DM, maybe a more generic name like
"b_fsprivate" or something would be clearer?

thanks.

-- 
Nathan
