Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbUAPIpW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 03:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbUAPIpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 03:45:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:24516 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265325AbUAPIpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 03:45:20 -0500
Date: Fri, 16 Jan 2004 00:45:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: marcelo.tosatti@cyclades.com, davem@redhat.com,
       linux-kernel@vger.kernel.org, sim@netnation.com,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Linux 2.4.25-pre5
Message-Id: <20040116004516.5fea2995.akpm@osdl.org>
In-Reply-To: <1074239098.31120.27.camel@imladris.demon.co.uk>
References: <Pine.LNX.4.58L.0401151816320.17528@logos.cnet>
	<20040115145519.79beddc3.davem@redhat.com>
	<Pine.LNX.4.58L.0401152110020.17528@logos.cnet>
	<1074239098.31120.27.camel@imladris.demon.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> ===== fs/inode.c 1.48 vs edited =====
>  --- 1.48/fs/inode.c	Wed Jan 14 20:51:18 2004
>  +++ edited/fs/inode.c	Fri Jan 16 07:43:14 2004
>  @@ -96,6 +96,7 @@
>   	if (inode) {
>   		struct address_space * const mapping = &inode->i_data;
>   
>  +		init_waitqueue_head(&inode->i_wait);
>   		inode->i_sb = sb;
>   		inode->i_dev = sb->s_dev;
>   		inode->i_blkbits = sb->s_blocksize_bits;
>  @@ -147,7 +148,6 @@
>   
>   void __inode_init_once(struct inode *inode)
>   {
>  -	init_waitqueue_head(&inode->i_wait);
>   	INIT_LIST_HEAD(&inode->i_hash);
>   	INIT_LIST_HEAD(&inode->i_data.clean_pages);
>   	INIT_LIST_HEAD(&inode->i_data.dirty_pages);

Really, the init_waitqueue_head() should be done prior to putting the inode
back into slab.

