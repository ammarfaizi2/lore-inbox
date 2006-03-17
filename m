Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932787AbWCQVIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbWCQVIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 16:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932785AbWCQVIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 16:08:25 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:38094 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932781AbWCQVIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 16:08:24 -0500
Date: Fri, 17 Mar 2006 14:08:23 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]use kzalloc in vfs where appropriate
Message-ID: <20060317210823.GA8980@parisc-linux.org>
References: <Pine.LNX.4.58.0603172153160.30725@fachschaft.cup.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0603172153160.30725@fachschaft.cup.uni-muenchen.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 09:58:14PM +0100, Oliver Neukum wrote:
> --- a/fs/bio.c	2006-03-11 23:12:55.000000000 +0100
> +++ b/fs/bio.c	2006-03-17 16:44:49.000000000 +0100
> @@ -635,12 +635,10 @@
>  		return ERR_PTR(-ENOMEM);
>  
>  	ret = -ENOMEM;
> -	pages = kmalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
> +	pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);

Didn't we just discuss this one and conclude it needed to use kcalloc
instead?
