Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWIETHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWIETHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWIETHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:07:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030225AbWIETHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:07:17 -0400
Date: Tue, 5 Sep 2006 12:07:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Access Control Lists for tmpfs
Message-Id: <20060905120700.4f778843.akpm@osdl.org>
In-Reply-To: <20060901221458.148480972@winden.suse.de>
References: <20060901221421.968954146@winden.suse.de>
	<20060901221458.148480972@winden.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Sep 2006 00:14:23 +0200
Andreas Gruenbacher <agruen@suse.de> wrote:

> --- linux-2.6.18-rc5.orig/mm/shmem.c
> +++ linux-2.6.18-rc5/mm/shmem.c
> @@ -26,6 +26,8 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/fs.h>
> +#include <linux/xattr.h>
> +#include <linux/generic_acl.h>
>  #include <linux/mm.h>
>  #include <linux/mman.h>
>  #include <linux/file.h>
> @@ -176,6 +178,7 @@ static const struct address_space_operat
>  static struct file_operations shmem_file_operations;
>  static struct inode_operations shmem_inode_operations;
>  static struct inode_operations shmem_dir_inode_operations;
> +static struct inode_operations shmem_special_inode_operations;
>  static struct vm_operations_struct shmem_vm_ops;
>  
>  static struct backing_dev_info shmem_backing_dev_info  __read_mostly = {
> @@ -630,13 +633,15 @@ static void shmem_truncate(struct inode 
>  	shmem_truncate_range(inode, inode->i_size, (loff_t)-1);
>  }
>  
> +extern struct generic_acl_operations shmem_acl_ops;

Can we move this declaration into a header file please?
