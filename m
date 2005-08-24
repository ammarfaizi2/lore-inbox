Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbVHXSqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbVHXSqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVHXSqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:46:43 -0400
Received: from pat.uio.no ([129.240.130.16]:16862 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751391AbVHXSqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:46:42 -0400
Subject: Re: [RFC][PATCH] VFS: update documentation (take #2)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1124908580.18800.2.camel@localhost>
References: <1124908580.18800.2.camel@localhost>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 11:46:30 -0700
Message-Id: <1124909191.8286.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.607, required 12,
	autolearn=disabled, AWL 1.39, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 24.08.2005 Klokka 21:36 (+0300) skreiv Pekka Enberg:
>  
>  struct file_system_type {
>  	const char *name;
>  	int fs_flags;
> -	struct super_block *(*read_super) (struct super_block *, void *, int);
> -	struct file_system_type * next;
> +        struct super_block *(*get_sb) (struct file_system_type *, int,
> +                                       const char *, void *);
> +        void (*kill_sb) (struct super_block *);
> +        struct module *owner;
> +        struct file_system_type * next;
> +        struct list_head fs_supers;
>  };
>  
>    name: the name of the filesystem type, such as "ext2", "iso9660",
> @@ -141,51 +141,96 @@ struct file_system_type {
>  
>    fs_flags: various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
>  
> -  read_super: the method to call when a new instance of this
> +  get_sb: the method to call when a new instance of this
>  	filesystem should be mounted
>  
> -  next: for internal VFS use: you should initialise this to NULL
> +  kill_sb: the method to call when an instance of this filesystem
> +	should be unmounted
> +
> +  owner: for internal VFS use: you should initialize this to NULL

owner should be set to THIS_MODULE in most cases...

Cheers,
  Trond

