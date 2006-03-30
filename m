Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWC3UTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWC3UTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWC3UTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:19:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750817AbWC3UTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:19:43 -0500
Date: Thu, 30 Mar 2006 12:19:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: neilb@suse.de, linux-kernel@vger.kernel.org, drepper@redhat.com,
       mtk-manpages@gmx.net, nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
Message-Id: <20060330121903.643352ac.akpm@osdl.org>
In-Reply-To: <87d5g4rlth.fsf@duaron.myhome.or.jp>
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
	<17451.36790.450410.79788@cse.unsw.edu.au>
	<20060330003246.31216ff2.akpm@osdl.org>
	<87d5g4rlth.fsf@duaron.myhome.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > +	if ((s64)offset < 0)
> > +		goto out;
> > +	if ((s64)endbyte < 0)
> > +		goto out;
> 
> loff_t is long long on all arch. This is not need?

True, the casts happen to be unneeded.  But they do set the reader's mind
at ease.

> > +	if (S_ISFIFO(file->f_dentry->d_inode->i_mode)) {
> > +		ret = -ESPIPE;
> > +		goto out_put;
> > +	}
> 
> How about to check "if (!file->f_op || !file->f_op->fsync)" or something?

This syscall won't call ->fsync.

> For chrdev is also strange, and in the case of fsync(), it returns -EINVAL.
> IMHO it seems there is consistency.
> 

I guess so.   Perhaps it should be S_ISREG|S_ISBLK|S_ISDIR|S_ISLNK.
