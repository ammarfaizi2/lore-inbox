Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992899AbWJUHWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992899AbWJUHWU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992896AbWJUHWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:22:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46732 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992837AbWJUHWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:22:17 -0400
Date: Sat, 21 Oct 2006 00:22:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       torvalds@osdl.org, viro@ftp.linux.org.uk, hch@infradead.org,
       jack@suse.cz
Subject: Re: [PATCH 01 of 23] VFS: change struct file to use struct path
Message-Id: <20061021002200.4731cdeb.akpm@osdl.org>
In-Reply-To: <b212ecc85fa3ad0382f6.1161411446@thor.fsl.cs.sunysb.edu>
References: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
	<b212ecc85fa3ad0382f6.1161411446@thor.fsl.cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2006 02:17:26 -0400
Josef "Jeff" Sipek <jsipek@cs.sunysb.edu> wrote:

> From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> 
> This patch changes struct file to use struct path instead of having
> independent pointers to struct dentry and struct vfsmount, and converts all
> users of f_{dentry,vfsmnt} in fs/ to use f_path.{dentry,mnt}.
> 

why?

> @@ -723,8 +724,9 @@ struct file {
>  		struct list_head	fu_list;
>  		struct rcu_head 	fu_rcuhead;
>  	} f_u;
> -	struct dentry		*f_dentry;
> -	struct vfsmount         *f_vfsmnt;
> +	struct path		f_path;
> +#define f_dentry	f_path.dentry
> +#define f_vfsmnt	f_path.mnt
>  	const struct file_operations	*f_op;
>  	atomic_t		f_count;
>  	unsigned int 		f_flags;
