Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVAGHBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVAGHBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVAGHBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:01:14 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:45482 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261283AbVAGHAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:00:52 -0500
Date: Fri, 7 Jan 2005 12:40:25 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix double sync_page_range() in generic_file_aio_write()
Message-ID: <20050107071025.GA5498@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <41DAAA93.F96EAED7@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DAAA93.F96EAED7@tv-sign.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry I missed this one - Thanks for spotting it !

Regards
Suparna

On Tue, Jan 04, 2005 at 05:39:15PM +0300, Oleg Nesterov wrote:
> Hello.
> 
> generic_file_aio_write():
> 	generic_file_aio_write_nolock():
> 		if (SYNC) sync_page_range_nolock();
> 	if (SYNC) sync_page_range();
> 
> I think that generic_file_aio_write() should use
> __generic_file_aio_write_nolock() instead.
> 
> Oleg.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.10/mm/filemap.c~	2004-11-15 17:12:21.000000000 +0300
> +++ 2.6.10/mm/filemap.c	2005-01-04 20:20:42.068803912 +0300
> @@ -2149,7 +2149,7 @@ ssize_t generic_file_aio_write(struct ki
>  	BUG_ON(iocb->ki_pos != pos);
>  
>  	down(&inode->i_sem);
> -	ret = generic_file_aio_write_nolock(iocb, &local_iov, 1,
> +	ret = __generic_file_aio_write_nolock(iocb, &local_iov, 1,
>  						&iocb->ki_pos);
>  	up(&inode->i_sem);

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

