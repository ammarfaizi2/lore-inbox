Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVFSUrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVFSUrW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 16:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVFSUrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 16:47:22 -0400
Received: from mail.dif.dk ([193.138.115.101]:62909 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262272AbVFSUrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 16:47:14 -0400
Date: Sun, 19 Jun 2005 22:52:41 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Joe Perches <joe@perches.com>
Subject: Re: [PATCH] modules, small codingstyle cleanup, one statement/expression
 pr line
In-Reply-To: <Pine.LNX.4.62.0506192138110.2832@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0506192249180.2832@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506192138110.2832@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2005, Jesper Juhl wrote:

> Small patch to make kernel/module.c a little more readable and a little 
> more CodingStyle conforming.
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> ---
> 
>  kernel/module.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.12-orig/kernel/module.c	2005-06-17 21:48:29.000000000 +0200
> +++ linux-2.6.12/kernel/module.c	2005-06-19 21:24:26.000000000 +0200
> @@ -1731,8 +1731,10 @@ static struct module *load_module(void _
>  	kfree(args);
>   free_hdr:
>  	vfree(hdr);
> -	if (err < 0) return ERR_PTR(err);
> -	else return ptr;
> +	if (err < 0)
> +		return ERR_PTR(err);
> +	else
> +		return ptr;
>  
>   truncated:
>  	printk(KERN_ERR "Module len %lu truncated\n", len);
> 
> 
Joe Perches suggested we use 

	if (err < 0)
		return ERR_PTR(err);
	return ptr;

instead.  The behaviour of the code is the same, but it is of course a bit 
shorter, so here's an alternative patch - pick the one you prefer.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

--- linux-2.6.12-orig/kernel/module.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/kernel/module.c	2005-06-19 22:48:41.000000000 +0200
@@ -1731,9 +1731,9 @@ static struct module *load_module(void _
 	kfree(args);
  free_hdr:
 	vfree(hdr);
-	if (err < 0) return ERR_PTR(err);
-	else return ptr;
-
+	if (err < 0)
+		return ERR_PTR(err);
+	return ptr;
  truncated:
 	printk(KERN_ERR "Module len %lu truncated\n", len);
 	err = -ENOEXEC;



