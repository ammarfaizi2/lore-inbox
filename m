Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVDLUlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVDLUlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVDLUj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:39:58 -0400
Received: from colo.lackof.org ([198.49.126.79]:27014 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262198AbVDLTUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:20:22 -0400
Date: Tue, 12 Apr 2005 13:22:29 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       parisc-linux@parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: kfree cleanup in arch/parisc/
Message-ID: <20050412192229.GA2743@colo.lackof.org>
References: <Pine.LNX.4.62.0504112249510.2480@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504112249510.2480@dragon.hyggekrogen.localhost>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 10:54:25PM +0200, Jesper Juhl wrote:
> Get rid of redundant NULL pointer checks before kfree() in arch/parisc/ as 
> well as a few blank lines.
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

thanks!
Commited to cvs.parisc-linux.org:
	http://lists.parisc-linux.org/pipermail/parisc-linux-cvs/2005-April/035542.html

I expect Matthew Wilcox will submit to linus with other parisc code changes
in the next RC release.

thanks,
grant

> 
> diff -upr linux-2.6.12-rc2-mm3-orig/arch/parisc/kernel/ioctl32.c linux-2.6.12-rc2-mm3/arch/parisc/kernel/ioctl32.c
> --- linux-2.6.12-rc2-mm3-orig/arch/parisc/kernel/ioctl32.c	2005-04-05 21:21:08.000000000 +0200
> +++ linux-2.6.12-rc2-mm3/arch/parisc/kernel/ioctl32.c	2005-04-11 22:48:03.000000000 +0200
> @@ -104,12 +104,9 @@ static int drm32_version(unsigned int fd
>  	}
>  
>  out:
> -	if (kversion.name)
> -		kfree(kversion.name);
> -	if (kversion.date)
> -		kfree(kversion.date);
> -	if (kversion.desc)
> -		kfree(kversion.desc);
> +	kfree(kversion.name);
> +	kfree(kversion.date);
> +	kfree(kversion.desc);
>  	return ret;
>  }
>  
> @@ -166,9 +163,7 @@ static int drm32_getsetunique(unsigned i
>  			ret = -EFAULT;
>  	}
>  
> -	if (karg.unique != NULL)
> -		kfree(karg.unique);
> -
> +	kfree(karg.unique);
>  	return ret;
>  }
>  
> @@ -265,7 +260,6 @@ static int drm32_info_bufs(unsigned int 
>  	}
>  
>  	kfree(karg.list);
> -
>  	return ret;
>  }
>  
> @@ -305,7 +299,6 @@ static int drm32_free_bufs(unsigned int 
>  
>  out:
>  	kfree(karg.list);
> -
>  	return ret;
>  }
>  
> @@ -494,15 +487,10 @@ static int drm32_dma(unsigned int fd, un
>  	}
>  
>  out:
> -	if (karg.send_indices)
> -		kfree(karg.send_indices);
> -	if (karg.send_sizes)
> -		kfree(karg.send_sizes);
> -	if (karg.request_indices)
> -		kfree(karg.request_indices);
> -	if (karg.request_sizes)
> -		kfree(karg.request_sizes);
> -
> +	kfree(karg.send_indices);
> +	kfree(karg.send_sizes);
> +	kfree(karg.request_indices);
> +	kfree(karg.request_sizes);
>  	return ret;
>  }
>  
> @@ -555,9 +543,7 @@ static int drm32_res_ctx(unsigned int fd
>  			ret = -EFAULT;
>  	}
>  
> -	if (karg.contexts)
> -		kfree(karg.contexts);
> -
> +	kfree(karg.contexts);
>  	return ret;
>  }
>  
> 
> 
> 
> 
> PS. If you reply to lists other than Linux-kernel, then please keep me on CC:
> 
> 
