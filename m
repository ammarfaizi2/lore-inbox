Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbUCOWKO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbUCOWKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:10:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:8092 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262775AbUCOWIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:08:05 -0500
Date: Mon, 15 Mar 2004 14:10:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04.1 3/5
Message-Id: <20040315141004.7b386661.akpm@osdl.org>
In-Reply-To: <20040315075814.GE31818@MAIL.13thfloor.at>
References: <20040315035506.GB30948@MAIL.13thfloor.at>
	<20040314201457.23fdb96e.akpm@osdl.org>
	<20040315042541.GA31412@MAIL.13thfloor.at>
	<20040314203427.27857fd9.akpm@osdl.org>
	<20040315075814.GE31818@MAIL.13thfloor.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:
>
> --- linux-2.6.4-20040314_2308/fs/ext2/xattr.c	2004-03-11 03:55:34.000000000 +0100
> +++ linux-2.6.4-20040314_2308-bme0.04.1/fs/ext2/xattr.c	2004-03-15 06:27:13.000000000 +0100
> @@ -496,7 +496,7 @@ ext2_xattr_set(struct inode *inode, int 
>  	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
>  		  name_index, name, value, (long)value_len);
>  
> -	if (IS_RDONLY(inode))
> +	if (IS_RDONLY_INODE(inode))

I do think that if we're going to do this thing it should have 100%
coverage, and not have little exceptions because the volume of changes got
too high.

The number of places where you need IS_RDONLY_INODE() are encouragingly
small.  It appears that all we need to do to get rid of it is to propagate
the file* down through the ext2 and ext3 xattr code.  A NULL value will
need to be permitted because ext2_new_inode doesn't have a file*, and we've
already performed the check.

Sure, it's a largeish patch but it is very safe: if it compiles, it works.

Could you please work that with Andreas?

IS_RDONLY_INODE() is also used in intermezzo, but that doesn't compile any
more anyway.
