Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268408AbUKAX4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268408AbUKAX4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S276009AbUKAXra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:47:30 -0500
Received: from unicorn.sch.bme.hu ([152.66.208.4]:28859 "EHLO
	unicorn.sch.bme.hu") by vger.kernel.org with ESMTP id S277034AbUKAXoX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 18:44:23 -0500
Date: Tue, 2 Nov 2004 00:44:09 +0100
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
Message-ID: <20041101234409.GA21234@unicorn.sch.bme.hu>
References: <10993462752309@kroah.com> <10993462761688@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10993462761688@kroah.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 01:57:56PM -0800, Greg KH wrote:
> diff -Nru a/fs/sysfs/bin.c b/fs/sysfs/bin.c
> --- a/fs/sysfs/bin.c	2004-11-01 13:37:18 -08:00
> +++ b/fs/sysfs/bin.c	2004-11-01 13:37:18 -08:00
> @@ -160,24 +160,26 @@
>  {
>  	struct dentry * dentry;
>  	struct dentry * parent;
> +	umode_t mode = (attr->attr.mode & S_IALLUGO) | S_IFREG;
                        ^^^^^^^^^^^^^^^
>  	int error = 0;
>  
> -	if (!kobj || !attr)
> -		return -EINVAL;
> +	BUG_ON(!kobj || !kobj->dentry || !attr);
                                         ^^^^^

attr is already dereferenced, maybe this check should be moved before 
it.



-- 
pozsy
