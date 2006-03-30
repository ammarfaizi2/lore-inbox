Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWC3Pbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWC3Pbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 10:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWC3Pbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 10:31:36 -0500
Received: from mail.parknet.jp ([210.171.160.80]:15878 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1750896AbWC3Pbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 10:31:35 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       drepper@redhat.com, mtk-manpages@gmx.net, nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
	<17451.36790.450410.79788@cse.unsw.edu.au>
	<20060330003246.31216ff2.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 31 Mar 2006 00:31:22 +0900
In-Reply-To: <20060330003246.31216ff2.akpm@osdl.org> (Andrew Morton's message of "Thu, 30 Mar 2006 00:32:46 -0800")
Message-ID: <87d5g4rlth.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> +	if ((s64)offset < 0)
> +		goto out;
> +	if ((s64)endbyte < 0)
> +		goto out;

loff_t is long long on all arch. This is not need?

> +	if (S_ISFIFO(file->f_dentry->d_inode->i_mode)) {
> +		ret = -ESPIPE;
> +		goto out_put;
> +	}

How about to check "if (!file->f_op || !file->f_op->fsync)" or something?

For chrdev is also strange, and in the case of fsync(), it returns -EINVAL.
IMHO it seems there is consistency.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
