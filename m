Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTJ2Uar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 15:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTJ2Uar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 15:30:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:29067 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261464AbTJ2Uaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 15:30:46 -0500
Date: Wed, 29 Oct 2003 12:31:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: lkml-031028@amos.mailshell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at
 fs/buffer.c:431"
Message-Id: <20031029123107.338796a4.akpm@osdl.org>
In-Reply-To: <20031029174419.5776.qmail@mailshell.com>
References: <20031028154920.1905.qmail@mailshell.com>
	<20031028141329.13443875.akpm@osdl.org>
	<20031029174419.5776.qmail@mailshell.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml-031028@amos.mailshell.com wrote:
>
> Here are the results (output of dmesg) from booting a kernel with this
> patch:
> 
> set_blocksize: size=1024
> set_blocksize: 1024 OK
> set_blocksize: size=1024
> set_blocksize: 1024 OK
> set_blocksize: size=1024
> set_blocksize: 1024 OK
> set_blocksize: size=1024
> set_blocksize: 1024 OK
> set_blocksize: size=4096
> buffer layer error at fs/buffer.c:431

hm, that didn't tell us much :(

Could you add Oleg's patch as well?

--- 25/fs/buffer.c~extra-buffer-diags	Wed Oct 29 12:13:40 2003
+++ 25-akpm/fs/buffer.c	Wed Oct 29 12:14:58 2003
@@ -428,6 +428,7 @@ __find_get_block_slow(struct block_devic
 	printk("block=%llu, b_blocknr=%llu\n",
 		(unsigned long long)block, (unsigned long long)bh->b_blocknr);
 	printk("b_state=0x%08lx, b_size=%u\n", bh->b_state, bh->b_size);
+	printk("device blocksize: %d\n", 1 << bd_inode->i_blkbits);
 out_unlock:
 	spin_unlock(&bd_mapping->private_lock);
 	page_cache_release(page);

_

