Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbUK1Sh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbUK1Sh7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbUK1Sh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:37:59 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:9618 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261549AbUK1Sh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:37:56 -0500
Subject: Re: [PATCH][2/2] ide-tape: small cleanups - handle
	copy_to|from_user() failures
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Gadi Oxman <gadio@netvision.net.il>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0411281731050.3389@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411281731050.3389@dragon.hygekrogen.localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101663266.16761.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 28 Nov 2004 17:34:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-11-28 at 16:32, Jesper Juhl wrote:
>  #endif /* IDETAPE_DEBUG_BUGS */
>  		count = min((unsigned int)(bh->b_size - atomic_read(&bh->b_count)), (unsigned int)n);
> -		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
> +		if (copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count))
> +			return -EFAULT;
>  		n -= count;
>  		atomic_add(count, &bh->b_count);
>  		buf += count;

If you do this then you don't fix up tape->bh for further operations.
Have you tested these changes including the I/O errors ?

