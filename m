Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbREYVLf>; Fri, 25 May 2001 17:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbREYVLZ>; Fri, 25 May 2001 17:11:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1545 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261903AbREYVLS>;
	Fri, 25 May 2001 17:11:18 -0400
Date: Fri, 25 May 2001 23:11:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add missing spin_unlock_irq to ide.c (244ac16)
Message-ID: <20010525231123.C22714@suse.de>
In-Reply-To: <20010525225934.K851@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010525225934.K851@jaquet.dk>; from rasmus@jaquet.dk on Fri, May 25, 2001 at 10:59:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25 2001, Rasmus Andersen wrote:
> (I forgot to cc l-k on this one when it went to andre.)
> 
> Hi.
> 
> This patch adds a spin_unlock_irqsave to ide_spin_wait_hwgroup as
> reported by the Stanford team way back. It applies against 244ac16.
> 
> 
> --- linux-244-ac16-clean/drivers/ide/ide.c	Fri May 25 21:11:08 2001
> +++ linux-244-ac16/drivers/ide/ide.c	Fri May 25 22:46:43 2001
> @@ -2362,6 +2362,8 @@
>  		__restore_flags(lflags);	/* local CPU only */
>  		spin_lock_irq(&io_request_lock);
>  	}
> +
> +        spin_unlock_irq(&io_request_lock);
>  	return 0;
>  }

This isn't right. Granted the locking isn't straight forward here, but
take a look at ide_write_setting -> ide_spin_wait_hwgroup and the
latters return value.

BTW, also try and follow local style when making such changes.

-- 
Jens Axboe

