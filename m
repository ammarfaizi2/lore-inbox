Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVIPV1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVIPV1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVIPV1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:27:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750869AbVIPV1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:27:08 -0400
Date: Fri, 16 Sep 2005 14:25:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: linuxram@us.ibm.com (Ram)
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com, viro@ftp.linux.org.uk, miklos@szeredi.hu,
       mike@waychison.com, bfields@fieldses.org, serue@us.ibm.com
Subject: Re: [RFC PATCH 1/10] vfs: Lindentified namespace.c
Message-Id: <20050916142557.691b055e.akpm@osdl.org>
In-Reply-To: <20050916182619.GA28428@RAM>
References: <20050916182619.GA28428@RAM>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linuxram@us.ibm.com (Ram) wrote:
>
> Lindentified fs/namespace.c

For something which is as already-close to CodingStyle as namespace.c it's
probably better to tidy it up by hand.  Lindent breaks almost as much stuff
as it fixes.

> -static void *m_start(struct seq_file *m, loff_t *pos)
> +static void *m_start(struct seq_file *m, loff_t * pos)

As Ben said.

>  	list_for_each(p, &n->list)
> -		if (!l--)
> -			return list_entry(p, struct vfsmount, mnt_list);
> +	    if (!l--)
> +		return list_entry(p, struct vfsmount, mnt_list);

Indenting with four spaces is a bit of a pain.  Presumably because Lindent
doesn't know what list_for_each() does.

> -static void *m_next(struct seq_file *m, void *v, loff_t *pos)
> +static void *m_next(struct seq_file *m, void *v, loff_t * pos)

Again.

>  struct seq_operations mounts_op = {
> -	.start	= m_start,
> -	.next	= m_next,
> -	.stop	= m_stop,
> -	.show	= show_vfsmnt
> +	.start = m_start,
> +	.next = m_next,
> +	.stop = m_stop,
> +	.show = show_vfsmnt
>  };

Arguable.

> -repeat:
> +      repeat:

Labels go in column zero.

> -dput_and_out:
> +      dput_and_out:

ugh, here it went and inserted spaces.

> -	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
> -		;
> +	while (d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry)) ;

Regression!

> -	error = __user_walk(new_root, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
> +	error =
> +	    __user_walk(new_root, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &new_nd);

ug.

> ...

etc.

One approach is to run Lindent, then go through the diff and fix it up by
hand.  Then apply the patch and fix up the remaining Lindent mistakes by
hand.  But the raw output of Lindent isn't right.
