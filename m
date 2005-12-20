Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbVLTKwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbVLTKwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 05:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVLTKwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 05:52:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750910AbVLTKwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 05:52:38 -0500
Date: Tue, 20 Dec 2005 02:52:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: bug in get_name of export operations?
Message-Id: <20051220025209.df6d5c81.akpm@osdl.org>
In-Reply-To: <43A6CA3A.5010905@namesys.com>
References: <43A6CA3A.5010905@namesys.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vladimir V. Saveliev" <vs@namesys.com> wrote:
>
> Hello
> 
> Please point my error if I am wrong:
> 
> fs/exportfs/expfs.c:get_name() opens a directory with:
> file = dentry_open(dget(dentry), NULL, O_RDONLY);
> which results in file where file->f_vfsmnt == NULL.
> 
> Then fs/readdir.c:vfs_readdir() and, therefore,
> include/linux/fs.h:file_accessed(file) are called.
> file_accessed() calls fs/inode.c:touch_atime() which tryies to dereference mnt
> which is NULL.
> 

I think you're looking at the -mm tree, in which Christoph changed all that
stuff.

