Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263491AbUJ3Gjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbUJ3Gjf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 02:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbUJ3Gjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 02:39:35 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:23301 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263491AbUJ3Gjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 02:39:31 -0400
Date: Sat, 30 Oct 2004 07:39:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill fatfs_syms.c
Message-ID: <20041030063925.GB22838@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, hirofumi@mail.parknet.co.jp,
	linux-kernel@vger.kernel.org
References: <20041030014522.GH6677@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030014522.GH6677@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- /dev/null	2004-08-23 02:01:39.000000000 +0200
> +++ linux-2.6.10-rc1-mm2-full/fs/fat/init.c	2004-10-30 02:08:11.000000000 +0200
> @@ -0,0 +1,33 @@
> +/*
> + * linux/fs/fat/init.c
> + *
> + * init/exit functions for FAT
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +
> +int __init fat_cache_init(void);
> +void __exit fat_cache_destroy(void);
> +int __init fat_init_inodecache(void);
> +void __exit fat_destroy_inodecache(void);
> +
> +static int __init init_fat_fs(void)
> +{
> +	int ret;
> +
> +	ret = fat_cache_init();
> +	if (ret < 0)
> +		return ret;
> +	return fat_init_inodecache();
> +}
> +
> +static void __exit exit_fat_fs(void)
> +{
> +	fat_cache_destroy();
> +	fat_destroy_inodecache();
> +}
> +
> +module_init(init_fat_fs)
> +module_exit(exit_fat_fs)


just move this to inode.c

