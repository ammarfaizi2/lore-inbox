Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWHASur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWHASur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWHASur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:50:47 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:61331 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751786AbWHASuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:50:46 -0400
Subject: Re: [PATCH] fs.h: ifdef security fields
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060801155305.GA6872@martell.zuzino.mipt.ru>
References: <20060801155305.GA6872@martell.zuzino.mipt.ru>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 01 Aug 2006 14:53:15 -0400
Message-Id: <1154458395.3582.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 19:53 +0400, Alexey Dobriyan wrote:
> Chop 4 bytes from struct inode et al here.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  fs/inode.c         |    2 ++
>  include/linux/fs.h |    7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -133,7 +133,9 @@ #endif
>  		inode->i_bdev = NULL;
>  		inode->i_cdev = NULL;
>  		inode->i_rdev = 0;
> +#ifdef CONFIG_SECURITY
>  		inode->i_security = NULL;
> +#endif

Possibly this should just be moved inside the security_inode_alloc
static inlines?

>  		inode->dirtied_when = 0;
>  		if (security_inode_alloc(inode)) {
>  			if (inode->i_sb->s_op->destroy_inode)
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -552,7 +552,9 @@ struct inode {
>  	unsigned int		i_flags;
>  
>  	atomic_t		i_writecount;
> +#ifdef CONFIG_SECURITY
>  	void			*i_security;
> +#endif
>  	union {
>  		void		*generic_ip;
>  	} u;
> @@ -688,8 +690,9 @@ struct file {
>  	struct file_ra_state	f_ra;
>  
>  	unsigned long		f_version;
> +#ifdef CONFIG_SECURITY_SELINUX

This should just be CONFIG_SECURITY.

>  	void			*f_security;
> -
> +#endif
>  	/* needed for tty driver, and maybe others */
>  	void			*private_data;
>  
> @@ -877,7 +880,9 @@ struct super_block {
>  	int			s_syncing;
>  	int			s_need_sync_fs;
>  	atomic_t		s_active;
> +#ifdef CONFIG_SECURITY_SELINUX

Likewise.

>  	void                    *s_security;
> +#endif
>  	struct xattr_handler	**s_xattr;
>  
>  	struct list_head	s_inodes;	/* all inodes */
> 

-- 
Stephen Smalley
National Security Agency

