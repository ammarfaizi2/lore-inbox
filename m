Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161540AbWJDQgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161540AbWJDQgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161577AbWJDQgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:36:39 -0400
Received: from mail.parknet.jp ([210.171.160.80]:27144 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1161540AbWJDQgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:36:37 -0400
X-AuthUser: hirofumi@parknet.jp
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch] Remove unnecessary check in fs/fat/inode.c
References: <1159979000.15934.7.camel@alice>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 05 Oct 2006 01:36:28 +0900
In-Reply-To: <1159979000.15934.7.camel@alice> (Eric Sesterhenn's message of "Wed\, 04 Oct 2006 18\:23\:20 +0200")
Message-ID: <87ven0avhv.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sesterhenn <snakebyte@gmx.de> writes:

> since all callers dereference sb, and this function
> does so earlier too, we dont need the check.
>
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
>
> --- linux-2.6.18-git21/fs/fat/inode.c.orig	2006-10-04 18:21:03.000000000 +0200
> +++ linux-2.6.18-git21/fs/fat/inode.c	2006-10-04 18:21:22.000000000 +0200
> @@ -1472,7 +1472,7 @@ int fat_flush_inodes(struct super_block 
>  		ret = writeback_inode(i1);
>  	if (!ret && i2)
>  		ret = writeback_inode(i2);
> -	if (!ret && sb) {
> +	if (!ret) {
>  		struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
>  		ret = filemap_flush(mapping);
>  	}

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
