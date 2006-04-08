Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWDHLrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWDHLrB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 07:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWDHLrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 07:47:01 -0400
Received: from soohrt.org ([85.131.246.150]:36766 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S964937AbWDHLrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 07:47:00 -0400
Date: Sat, 8 Apr 2006 13:46:59 +0200
From: Horst Schirmeier <horst@schirmeier.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH] trivial fs/select.c compiler warning fix
Message-ID: <20060408114659.GT2335@quickstop.soohrt.org>
Mail-Followup-To: Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org, trivial@kernel.org
References: <20060408112859.GS2335@quickstop.soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408112859.GS2335@quickstop.soohrt.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops. Looks like Russell King already created a more elaborate patch
for this problem yesterday (20060407153715.GA31458@flint.arm.linux.org.uk).

On Sat, 08 Apr 2006, Horst Schirmeier wrote:
> This trivial patch fixes
> fs/select.c: In function `core_sys_select':
> fs/select.c:339: warning: assignment from incompatible pointer type
> fs/select.c:376: warning: comparison of distinct pointer types lacks a cast
> by casting to (char *) when accessing stack_fds.
> 
> Signed-off-by: Horst Schirmeier <horst@schirmeier.com>
> 
> ---
> 
> diff --git a/fs/select.c b/fs/select.c
> index 071660f..3025cec 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -336,7 +336,7 @@ static int core_sys_select(int n, fd_set
>  	ret = -ENOMEM;
>  	size = FDS_BYTES(n);
>  	if (6*size < SELECT_STACK_ALLOC)
> -		bits = stack_fds;
> +		bits = (char *) stack_fds;
>  	else
>  		bits = kmalloc(6 * size, GFP_KERNEL);
>  	if (!bits)
> @@ -373,7 +373,7 @@ static int core_sys_select(int n, fd_set
>  		ret = -EFAULT;
>  
>  out:
> -	if (bits != stack_fds)
> +	if (bits != (char *) stack_fds)
>  		kfree(bits);
>  out_nofds:
>  	return ret;
> 

-- 
PGP-Key 0xD40E0E7A
