Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWEDBgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWEDBgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 21:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWEDBgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 21:36:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750837AbWEDBgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 21:36:09 -0400
Date: Wed, 3 May 2006 18:35:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] symlink nesting level change
Message-Id: <20060503183554.87f0218d.akpm@osdl.org>
In-Reply-To: <20060503030849.GZ27946@ftp.linux.org.uk>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B309B@chicken.machinevisionproducts.com>
	<44580CF2.7070602@tlinx.org>
	<e3966u$dje$1@terminus.zytor.com>
	<20060503030849.GZ27946@ftp.linux.org.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006 04:08:49 +0100
Al Viro <viro@ftp.linux.org.uk> wrote:

> No.  It's way past time to bump it to 8.  Everyone had been warned - for
> months now.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ----
> --- a/include/linux/namei.h	2006-03-31 20:08:42.000000000 -0500
> +++ b/include/linux/namei.h	2006-05-02 23:06:46.000000000 -0400
> @@ -11,7 +11,7 @@
>  	struct file *file;
>  };
>  
> -enum { MAX_NESTED_LINKS = 5 };
> +enum { MAX_NESTED_LINKS = 8 };
>  
>  struct nameidata {
>  	struct dentry	*dentry;

It's a non-back-compatible change which means that people will install
2.6.18+, will set stuff up which uses more that five nested links and some
will discover that they can no longer run their software on older kernels.

It'll only hurt a very small number of people, but for those people, it
will hurt a lot.  And I can't really think of anything we can do to help
them, apart from making the new behaviour runtime-controllable, defaulting
to "off", but add a once-off printk when we hit MAX_NESTED_LINKS, pointing
them at a document which tells them how to turn on the new behaviour and
which explains the problems.  Which sucks.

But I guess as major distros are 2.6.16-based, this is a good time to make
this change.
