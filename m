Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWJQQHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWJQQHk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWJQQHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:07:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:53687 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751268AbWJQQHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:07:39 -0400
Message-ID: <4534FFCA.2070707@fr.ibm.com>
Date: Tue, 17 Oct 2006 18:07:38 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org> <4534E773.9060600@shadowen.org>
In-Reply-To: <4534E773.9060600@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> Seeing this on a couple of x86_64's so far, probabally widespread:
> 
> BUG: warning at fs/inode.c:1389/i_size_write()
> 
> elm3b6:
> 
> Call Trace:
>  [<ffffffff8028207d>] i_size_write+0x51/0x73
>  [<ffffffff8028ddfb>] generic_commit_write+0x35/0x49
>  [<ffffffff802e78d1>] ext2_commit_chunk+0x32/0x6d
>  [<ffffffff802e86a0>] ext2_make_empty+0x160/0x179
>  [<ffffffff802eb734>] ext2_mkdir+0xb5/0x121
>  [<ffffffff80278926>] vfs_mkdir+0x6a/0xaa
>  [<ffffffff80278a12>] sys_mkdirat+0xac/0xfd
>  [<ffffffff80272607>] vfs_stat+0x14/0x16
>  [<ffffffff8021b703>] sys32_stat64+0x1a/0x34
>  [<ffffffff80278a76>] sys_mkdir+0x13/0x15
>  [<ffffffff8021b212>] ia32_sysret+0x0/0xa
> 
> This first one does not look so unreasonable, the inode is new and has
> not yet been instantiated?  But I'm no fs locking expert ...

I get something similar on x86 : 

 BUG: warning at fs/inode.c:1389/i_size_write()
 [<c0102eb1>] dump_trace+0x63/0x1bf
 [<c010301f>] show_trace_log_lvl+0x12/0x25
 [<c0103559>] show_trace+0xd/0x10
 [<c01035d0>] dump_stack+0x16/0x18
 [<c0156c6f>] i_size_write+0x39/0x54
 [<c0162050>] generic_commit_write+0x55/0x6b
 [<c018fd0f>] ext2_commit_chunk+0x20/0x55
 [<c018ffc6>] ext2_make_empty+0x14b/0x161
 [<c0192d1d>] ext2_mkdir+0xa0/0xfe
 [<c014db69>] vfs_mkdir+0x5a/0x9d
 [<c014fb43>] sys_mkdirat+0x85/0xbb
 [<c014fb89>] sys_mkdir+0x10/0x12
 [<c01027fc>] syscall_call+0x7/0xb
DWARF2 unwinder stuck at syscall_call+0x7/0xb

It happens only once, when a first directory is created on / (ext2). 

C,
