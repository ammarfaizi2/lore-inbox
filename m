Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265826AbUAEAea (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 19:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUAEAea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 19:34:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56205 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265826AbUAEAe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 19:34:28 -0500
Date: Mon, 5 Jan 2004 00:34:26 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny1 tree for small systems
Message-ID: <20040105003426.GZ4176@parcelfarce.linux.theplanet.co.uk>
References: <20040103030814.GG18208@waste.org> <m13cawi2h8.fsf@ebiederm.dsl.xmission.com> <20040104084005.GU18208@waste.org> <m1ekufgt72.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ekufgt72.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 05:00:49PM -0700, Eric W. Biederman wrote:

1) make block-based filesystems dependent on CONFIG_BLOCK

> --- linux-2.6.1-rc1-tiny1.eb1/fs/super.c	Wed Dec 17 19:58:48 2003
> +++ linux-2.6.1-rc1-tiny1.eb2/fs/super.c	Sun Jan  4 15:18:28 2004
> @@ -473,8 +473,10 @@
>  {
>  	int retval;
>  	
> +#ifdef CONFIG_BLOCK_DEVICES
>  	if (!(flags & MS_RDONLY) && bdev_read_only(sb->s_bdev))
>  		return -EACCES;
> +#endif
>  	if (flags & MS_RDONLY)
>  		acct_auto_close(sb);
>  	shrink_dcache_sb(sb);
> @@ -588,6 +590,7 @@
>  	return (void *)s->s_bdev == data;
>  }

Tons of stuff here make sense only for block-based filesystems (e.g. the
function immediately above ;-).  Ifdef, or, better yet, move to fs/block_dev.c

> +cond_syscall(sys_fsync)
> +cond_syscall(sys_fdatasync)

Huh?  They should work for network filesystems.
