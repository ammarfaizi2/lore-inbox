Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbTCQA6q>; Sun, 16 Mar 2003 19:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261680AbTCQA6q>; Sun, 16 Mar 2003 19:58:46 -0500
Received: from yossman.net ([209.162.234.20]:3845 "EHLO yossman.net")
	by vger.kernel.org with ESMTP id <S261679AbTCQA6p>;
	Sun, 16 Mar 2003 19:58:45 -0500
Message-ID: <3E75204F.1070603@yossman.net>
Date: Sun, 16 Mar 2003 20:09:35 -0500
From: Brian Davids <dlister@yossman.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-bk multiple oops on boot
References: <3E75138C.7030607@yossman.net> <20030316163444.4d495d59.akpm@digeo.com>
In-Reply-To: <20030316163444.4d495d59.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Does this help?
> 
> diff -puN fs/devfs/base.c~devfs-oops-fix fs/devfs/base.c
> --- 25/fs/devfs/base.c~devfs-oops-fix	2003-03-16 16:33:16.000000000 -0800
> +++ 25-akpm/fs/devfs/base.c	2003-03-16 16:33:49.000000000 -0800
> @@ -1802,8 +1802,11 @@ int devfs_generate_path (devfs_handle_t 
>  static struct file_operations *devfs_get_ops (devfs_handle_t de)
>  {
>      struct file_operations *ops = de->u.cdev.ops;
> -    struct module *owner = ops->owner;
> +    struct module *owner;
>  
> +    if (!ops)
> +	return NULL;
> +    owner = ops->owner;
>      read_lock (&de->parent->u.dir.lock);  /*  Prevent module from unloading  */
>      if ( (de->next == de) || !try_module_get (owner) )
>      {   /*  Entry is already unhooked or module is unloading  */

That fixed it for me... thanks!


Brian Davids

