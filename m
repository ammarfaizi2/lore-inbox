Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752141AbWJZLVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbWJZLVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 07:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbWJZLVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 07:21:14 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:55485 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1752141AbWJZLVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 07:21:13 -0400
Date: Thu, 26 Oct 2006 14:20:56 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: Michael Holzheu <holzheu@de.ibm.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, joern@wohnheim.fh-wedel.de,
       schwidefsky@de.ibm.com, ioe-lkml@rameria.de, minyard@acm.org
Subject: Re: [PATCH] strstrip remove last blank fix
In-Reply-To: <20061026130703.6f8cc0bd.holzheu@de.ibm.com>
Message-ID: <Pine.LNX.4.64.0610261420200.1223@sbz-30.cs.Helsinki.FI>
References: <20061026130703.6f8cc0bd.holzheu@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006, Michael Holzheu wrote:
> strstrip() does not remove the last blank from strings which only consist
> of blanks.

[snip]

> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
> 
> ---
> 
>  lib/string.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -Naurp linux-2.6.18/lib/string.c linux-2.6.18-strstrip-fix/lib/string.c
> --- linux-2.6.18/lib/string.c	2006-06-19 14:03:20.000000000 +0200
> +++ linux-2.6.18-strstrip-fix/lib/string.c	2006-10-25 18:36:08.000000000 +0200
> @@ -320,7 +320,7 @@ char *strstrip(char *s)
>  		return s;
>  
>  	end = s + size - 1;
> -	while (end != s && isspace(*end))
> +	while (end >= s && isspace(*end))
>  		end--;
>  	*(end + 1) = '\0';

Looks good, thanks!  Andrew, can you please pick up this patch?

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>
