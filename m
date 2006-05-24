Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWEXOBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWEXOBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 10:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbWEXOBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 10:01:46 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:55924 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932295AbWEXOBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 10:01:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:organization:user-agent;
        b=WY4p7+sNprHgGatIl1KPTKLL4JcgtlhaN77Odu0gxdKPptAglSMnjcdFJf7UAnapDuQw2QOWlIPTDc6kmwvGP7RSMIpJq/j9smFDlpGdvIp/O9cJCkR6iNwtDBhg4MlqnepK9aX7EvYbIhDFi6LF0Na6buaqw6wVTdMhqJLuk1g=
Date: Wed, 24 May 2006 22:01:35 +0800
From: Limin Wang <lance.lmwang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/33] readahead: loop case
Message-ID: <20060524140135.GA19663@laptop.exavio.cn>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <20060524111911.032100160@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524111911.032100160@localhost.localdomain>
Organization: Exavio.Inc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the loopback files is bigger than the memory size, it may cause miss again and
may better to turn on the read ahead?


Regards,
Limin
* Wu Fengguang <wfg@mail.ustc.edu.cn> [2006-05-24 19:13:14 +0800]:

> Disable look-ahead for loop file.
> 
> Loopback files normally contain filesystems, in which case there are already
> proper look-aheads in the upper layer, more look-aheads on the loopback file
> only ruins the read-ahead hit rate.
> 
> Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
> ---
> 
> I'd like to thank Tero Grundstr?m for uncovering the loopback problem.
> 
>  drivers/block/loop.c |    6 ++++++
>  1 files changed, 6 insertions(+)
> 
> --- linux-2.6.17-rc4-mm3.orig/drivers/block/loop.c
> +++ linux-2.6.17-rc4-mm3/drivers/block/loop.c
> @@ -779,6 +779,12 @@ static int loop_set_fd(struct loop_devic
>  	mapping = file->f_mapping;
>  	inode = mapping->host;
>  
> +	/*
> +	 * The upper layer should already do proper look-ahead,
> +	 * one more look-ahead here only ruins the cache hit rate.
> +	 */
> +	file->f_ra.flags |= RA_FLAG_NO_LOOKAHEAD;
> +
>  	if (!(file->f_mode & FMODE_WRITE))
>  		lo_flags |= LO_FLAGS_READ_ONLY;
>  
> 
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
