Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVGLBvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVGLBvC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 21:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVGLBsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 21:48:43 -0400
Received: from kanga.kvack.org ([66.96.29.28]:42636 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261693AbVGLBrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 21:47:46 -0400
Date: Mon, 11 Jul 2005 21:48:45 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Wendy Cheng <wcheng@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add ENOSYS into sys_io_cancel
Message-ID: <20050712014845.GA11916@kvack.org>
References: <42D2C34C.4040406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D2C34C.4040406@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wendy,

Two things: your patch needs to be properly signed off on.  Read 
Documentation/SubmittingPatches for a description of what that entials.  
Secondly, your patch adds whitespace on the end of the else.  Aside 
from that, the printk should be removed -- just replace it with the 
ret = -ENOSYS.

Also, please cc linux-aio@kvack.org on future aio patches.  Cheers,

		-ben 

On Mon, Jul 11, 2005 at 03:06:52PM -0400, Wendy Cheng wrote:
> Previously sent via private mail that doesn't seem to go thru - resend 
> via office mailer.
> 
> Note that other than few exceptions, most of the current filesystem 
> and/or drivers do not have aio cancel specifically defined 
> (kiob->ki_cancel field is mostly NULL). However, sys_io_cancel system 
> call universally sets return code to -EGAIN. This gives applications a 
> wrong impression that this call is implemented but just never works. We 
> have customer inquires about this issue.
> 
> Upload a trivial patch to address this confusion.
> 
> -- Wendy
> 
> 

> --- linux-2.6.12/fs/aio.c	2005-06-17 15:48:29.000000000 -0400
> +++ linux/fs/aio.c	2005-07-10 12:48:14.000000000 -0400
> @@ -1641,8 +1641,9 @@ asmlinkage long sys_io_cancel(aio_contex
>  		cancel = kiocb->ki_cancel;
>  		kiocb->ki_users ++;
>  		kiocbSetCancelled(kiocb);
> -	} else
> +	} else 
>  		cancel = NULL;
> +	 
>  	spin_unlock_irq(&ctx->ctx_lock);
>  
>  	if (NULL != cancel) {
> @@ -1659,8 +1660,10 @@ asmlinkage long sys_io_cancel(aio_contex
>  			if (copy_to_user(result, &tmp, sizeof(tmp)))
>  				ret = -EFAULT;
>  		}
> -	} else
> +	} else {
> +		ret = -ENOSYS;
>  		printk(KERN_DEBUG "iocb has no cancel operation\n");
> +	} 
>  
>  	put_ioctx(ctx);
>  


-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
