Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVENFn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVENFn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 01:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVENFn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 01:43:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:43440 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262542AbVENFny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 01:43:54 -0400
Date: Fri, 13 May 2005 22:40:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] ext2: make ext2_count_free a static inline
Message-Id: <20050513224004.3f68a1e8.akpm@osdl.org>
In-Reply-To: <20050513004731.GU3603@stusta.de>
References: <20050513004731.GU3603@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
>  --- linux-2.6.12-rc2-mm3-full/fs/ext2/ext2.h.old	2005-04-20 23:08:52.000000000 +0200
>  +++ linux-2.6.12-rc2-mm3-full/fs/ext2/ext2.h	2005-04-20 23:14:21.000000000 +0200
>  @@ -1,5 +1,6 @@
>   #include <linux/fs.h>
>   #include <linux/ext2_fs.h>
>  +#include <linux/buffer_head.h>
>   
>   /*
>    * second extended file system inode data in memory
>  @@ -79,6 +80,22 @@
>   	return container_of(inode, struct ext2_inode_info, vfs_inode);
>   }
>   
>  +static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
>  +

This will cause a copy of `nibblemap' to be included in each compilation
unit which uses ext2.h.  Unless the compiler is sufficiently smart to elide
it, which it might be.  But then it might be sufficiently smart to generate
a "you're not usig this" warning too.

If it's only needed for EXT2_DEBUG then I'd be inclined to move it into one
of the other .c files, inside EXT2_DEBUG.  Or just leave it as-is.
