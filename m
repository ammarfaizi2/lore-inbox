Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWEKUao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWEKUao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 16:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWEKUao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 16:30:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25812 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750769AbWEKUan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 16:30:43 -0400
Date: Thu, 11 May 2006 13:33:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] fs/compat.c: fix 'if (a |= b )' typo
Message-Id: <20060511133313.7e3764a4.akpm@osdl.org>
In-Reply-To: <20060511193754.GD11194@mipter.zuzino.mipt.ru>
References: <20060511193754.GD11194@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Mentioned by Mark Armbrust somewhere on Usenet.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
> --- a/fs/compat.c
> +++ b/fs/compat.c
> @@ -1913,7 +1913,7 @@ asmlinkage long compat_sys_ppoll(struct
>  	}
>  
>  	if (sigmask) {
> -		if (sigsetsize |= sizeof(compat_sigset_t))
> +		if (sigsetsize != sizeof(compat_sigset_t))
>  			return -EINVAL;
>  		if (copy_from_user(&ss32, sigmask, sizeof(ss32)))
>  			return -EFAULT;

Oh wow.  I can only assume that this code leg hasn't been exercised at all.

(I'm a bit surprised that the compiler doesn't warn and demand another set
of parentheses, actually.  I guess they decided not to do that for some
reason).

I'll tag this for a 2.6.16 backport, but I'm worried that what we have here
is a pretty significant codepath which just hasn't been executed.


