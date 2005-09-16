Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161249AbVIPSlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161249AbVIPSlK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbVIPSlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:41:09 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:44411 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161249AbVIPSlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:41:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=fZVtUjX47i6u431Tezzt0MlqLrjCyoUZ3+LecEaBRiqgCGySK8B6HmC7zJZh8v2aRe8Fq1xCEj9Gi2i0ETH5A7j7k0OeXsLBr+iARNIJNRYTW3TPkWk7YaEec7wDkxo1kGycWGtz+AvDhdLPKk2K21pK37d23EI1MJv9seyCqXY=
Date: Fri, 16 Sep 2005 22:51:20 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ram <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@ftp.linux.org.uk, miklos@szeredi.hu, mike@waychison.com,
       bfields@fieldses.org, serue@us.ibm.com
Subject: Re: [RFC PATCH 1/10] vfs: Lindentified namespace.c
Message-ID: <20050916185120.GA4461@mipter.zuzino.mipt.ru>
References: <20050916182619.GA28428@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916182619.GA28428@RAM>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 11:26:19AM -0700, Ram wrote:
> Lindentified fs/namespace.c
> 
> Signed by Ram Pai (linuxram@us.ibm.com)

Signed-off-by: ... <...>

> --- 2.6.13.sharedsubtree.orig/fs/namespace.c
> +++ 2.6.13.sharedsubtree/fs/namespace.c

> -	unsigned long tmp = ((unsigned long) mnt / L1_CACHE_BYTES);
> -	tmp += ((unsigned long) dentry / L1_CACHE_BYTES);
> +	unsigned long tmp = ((unsigned long)mnt / L1_CACHE_BYTES);
> +	tmp += ((unsigned long)dentry / L1_CACHE_BYTES);

Could you do it by hand? In the folllowing case indent made code look
worse. In particular, all labels are moved to column 7.

> -static void *m_start(struct seq_file *m, loff_t *pos)
> +static void *m_start(struct seq_file *m, loff_t * pos)

*pos

>  	list_for_each(p, &n->list)
> -		if (!l--)
> -			return list_entry(p, struct vfsmount, mnt_list);
> +	    if (!l--)
> +		return list_entry(p, struct vfsmount, mnt_list);

> -static void *m_next(struct seq_file *m, void *v, loff_t *pos)
> +static void *m_next(struct seq_file *m, void *v, loff_t * pos)

>  struct seq_operations mounts_op = {
> -	.start	= m_start,
> -	.next	= m_next,
> -	.stop	= m_stop,
> -	.show	= show_vfsmnt
> +	.start = m_start,
> +	.next = m_next,
> +	.stop = m_stop,
> +	.show = show_vfsmnt

> -repeat:
> +      repeat:
>  	next = this_parent->mnt_mounts.next;

> -	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
> -		;
> +	while (d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry)) ;

> -	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
> -		;
> +	while (d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry)) ;

> -exact_copy_from_user(void *to, const void __user *from, unsigned long n)
> +exact_copy_from_user(void *to, const void __user * from, unsigned long n)

> -int copy_mount_options(const void __user *data, unsigned long *where)
> +int copy_mount_options(const void __user * data, unsigned long *where)

> -	
> +

> -	} while_each_thread(g, p);
> +	}
> +	while_each_thread(g, p);

> -		goto out2; /* loop, on the same file system  */
> +		goto out2;	/* loop, on the same file system  */

> -		goto out2; /* not a mountpoint */
> +		goto out2;	/* not a mountpoint */

> -		goto out2; /* not a mountpoint */
> -	tmp = old_nd.mnt; /* make sure we can reach put_old from new_root */
> +		goto out2;	/* not a mountpoint */
> +	tmp = old_nd.mnt;	/* make sure we can reach put_old from new_root */

> -				goto out3; /* already mounted on put_old */
> +				goto out3;	/* already mounted on put_old */

> -	attach_mnt(user_nd.mnt, &old_nd);     /* mount old root on put_old */
> -	attach_mnt(new_nd.mnt, &root_parent); /* mount new_root on / */
> +	attach_mnt(user_nd.mnt, &old_nd);	/* mount old root on put_old */
> +	attach_mnt(new_nd.mnt, &root_parent);	/* mount new_root on / */

> -	} while_each_thread(g, p);
> +	}
> +	while_each_thread(g, p);

>  	mount_hashtable = (struct list_head *)
> -		__get_free_page(GFP_ATOMIC);
> +	    __get_free_page(GFP_ATOMIC);

