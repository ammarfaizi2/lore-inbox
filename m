Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVCXDZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVCXDZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbVCXDXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:23:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:37052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261781AbVCXDWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:22:00 -0500
Date: Wed, 23 Mar 2005 19:18:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/attr.c: fix check after use
Message-ID: <20050324031845.GG28536@shell0.pdx.osdl.net>
References: <20050324011043.GI1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324011043.GI1948@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> --- linux-2.6.12-rc1-mm1-full/fs/attr.c.old	2005-03-23 04:44:40.000000000 +0100
> +++ linux-2.6.12-rc1-mm1-full/fs/attr.c	2005-03-23 04:45:40.000000000 +0100
> @@ -112,7 +112,7 @@
>  int notify_change(struct dentry * dentry, struct iattr * attr)
>  {
>  	struct inode *inode = dentry->d_inode;
> -	mode_t mode = inode->i_mode;
> +	mode_t mode;
>  	int error;
>  	struct timespec now = current_fs_time(inode->i_sb);

looks like same issue here too?

>  	unsigned int ia_valid = attr->ia_valid;
> @@ -120,6 +120,8 @@
>  	if (!inode)
>  		BUG();
>  
> +	mode = inode->i_mode;
> +
