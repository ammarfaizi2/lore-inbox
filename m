Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264398AbTCXSFE>; Mon, 24 Mar 2003 13:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264400AbTCXSFE>; Mon, 24 Mar 2003 13:05:04 -0500
Received: from packet.digeo.com ([12.110.80.53]:6034 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264398AbTCXSFD>;
	Mon, 24 Mar 2003 13:05:03 -0500
Date: Mon, 24 Mar 2003 10:16:05 -0800
From: Andrew Morton <akpm@digeo.com>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: ancient block_dev patch
Message-Id: <20030324101605.3736f870.akpm@digeo.com>
In-Reply-To: <200303241642.h2OGg735008305@deviant.impure.org.uk>
References: <200303241642.h2OGg735008305@deviant.impure.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2003 18:15:46.0057 (UTC) FILETIME=[63BEE790:01C2F231]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@codemonkey.org.uk wrote:
>
> Andrew,
>  What became of this patch ? Is it needed ?
> 
> 
> ...
>  	down(&bdev->bd_sem);
> -	switch (kind) {
> -	case BDEV_FILE:
> -	case BDEV_FS:
> -		sync_blockdev(bd_inode->i_bdev);
> -		break;
> -	}
>  	lock_kernel();
> -	if (!--bdev->bd_openers)
> +	if (!--bdev->bd_openers) {
> +		switch (kind) {
> +		case BDEV_FILE:
> +		case BDEV_FS:
> +			sync_blockdev(bd_inode->i_bdev);
> +			break;
> +		}
>  		kill_bdev(bdev);
> +	}

Seems so, yes.  Without it we sync the blockdev on every close rather
than on the final one.

It has scary potential to expose existing bugs.  I shall play with it,
thanks.
