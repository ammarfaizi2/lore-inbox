Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbUDWXt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUDWXt5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 19:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUDWXt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 19:49:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:38618 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261766AbUDWXt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 19:49:56 -0400
Date: Fri, 23 Apr 2004 16:49:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       trondmy@trondhjem.org, neilb@cse.unsw.edu.au
Subject: Re: d_splice_alias() problem.
Message-Id: <20040423164936.390462fb.akpm@osdl.org>
In-Reply-To: <16521.5104.489490.617269@laputa.namesys.com>
References: <16521.5104.489490.617269@laputa.namesys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> wrote:
>
> for some time I am observing that during stress tests over NFS
> 
>     shrink_slab->...->prune_dcache()->prune_one_dentry()->...->iput()
> 
>  is called on inode with ->i_nlink == 0 which results in truncate and
>  file deletion. This is wrong in general (file system is re-entered), and
>  deadlock prone on some file systems.

The filesystem is only reentered if the caller of __alloc_pages() passed in
__GFP_FS, in which case the bug is in the caller, not in shrink_slab().

