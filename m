Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267660AbUHXNA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267660AbUHXNA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUHXNA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:00:26 -0400
Received: from painless.aaisp.net.uk ([217.169.20.17]:28072 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S267660AbUHXNAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:00:24 -0400
Subject: Re: XFS compilation warning in 2.6.9-rc1
From: Andrew Clayton <andrew@digital-domain.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040824133504.A28488@infradead.org>
References: <1093350616.2237.8.camel@alpha.digital-domain.net>
	 <20040824133504.A28488@infradead.org>
Content-Type: text/plain
Message-Id: <1093352423.2231.1.camel@alpha.digital-domain.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 24 Aug 2004 14:00:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 13:35, Christoph Hellwig wrote:


> --- 1.26/fs/xfs/xfs_bmap.c	2004-08-19 05:36:06 +02:00
> +++ edited/fs/xfs/xfs_bmap.c	2004-08-24 14:35:40 +02:00
> @@ -3431,15 +3431,16 @@
>  	* uninitialized br_startblock field.
>  	*/
>  
> -        got.br_startoff = 0xffa5a5a5a5a5a5a5;
> -        got.br_blockcount = 0xa55a5a5a5a5a5a5a;
> +        got.br_startoff = 0xffa5a5a5a5a5a5a5LL;
> +        got.br_blockcount = 0xa55a5a5a5a5a5a5aLL;
>          got.br_state = XFS_EXT_INVALID;
>  
> -	#if XFS_BIG_BLKNOS
> -        	got.br_startblock = 0xffffa5a5a5a5a5a5;
> -	#else
> -		got.br_startblock = 0xffffa5a5;
> -	#endif
> +#if XFS_BIG_BLKNOS
> +	got.br_startblock = 0xffffa5a5a5a5a5a5LL;
> +#else
> +	got.br_startblock = 0xffffa5a5;
> +#endif
> +
>  	if (lastx != NULLEXTNUM && lastx < nextents)
>  		ep = base + lastx;
>  	else
> 



Yep, that sorted it.


Cheers,


