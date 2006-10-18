Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423123AbWJRWuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423123AbWJRWuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423125AbWJRWuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:50:11 -0400
Received: from main.gmane.org ([80.91.229.2]:23776 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423123AbWJRWuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:50:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dylan Taft <soundmanok@yahoo.com>
Subject: Re: 2.6.19-rc2-mm1
Date: Wed, 18 Oct 2006 22:44:34 +0000 (UTC)
Message-ID: <loom.20061019T004316-648@post.gmane.org>
References: <20061016230645.fed53c5b.akpm@osdl.org> <4534E773.9060600@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 162.30.48.200 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw <at> shadowen.org> writes:

> 
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
> 
> BUG: warning at fs/inode.c:1389/i_size_write()
> 
> bl6-13:
> 
> Call Trace:
>  [<ffffffff80298a44>] i_size_write+0x45/0x57
>  [<ffffffff802a116b>] simple_commit_write+0x3b/0x47
>  [<ffffffff8028d96b>] __page_symlink+0xb5/0x150
>  [<ffffffff8030b742>] ramfs_symlink+0x4d/0xb7
>  [<ffffffff8028e547>] vfs_symlink+0xd4/0x144
>  [<ffffffff80290d4e>] sys_symlinkat+0x86/0xd2
>  [<ffffffff808e3c33>] do_header+0x70/0x1d2
>  [<ffffffff808e2bd5>] do_symlink+0x4b/0x7b
>  [<ffffffff808e2a55>] write_buffer+0x1d/0x2b
>  [<ffffffff808e2acf>] flush_window+0x6c/0xca
>  [<ffffffff808e3097>] inflate_codes+0x38f/0x3ec
>  [<ffffffff808e428a>] inflate_dynamic+0x4f5/0x541
>  [<ffffffff808e479a>] unpack_to_rootfs+0x4c4/0x923
>  [<ffffffff808e4c83>] populate_rootfs+0x8a/0xde
>  [<ffffffff8020715a>] init+0x114/0x346
>  [<ffffffff8020a925>] child_rip+0xa/0x15
>  [<ffffffff803e0d6e>] acpi_ds_init_one_object+0x0/0x82
>  [<ffffffff803e0d6e>] acpi_ds_init_one_object+0x0/0x82
>  [<ffffffff80207046>] init+0x0/0x346
>  [<ffffffff8020a91b>] child_rip+0x0/0x15
> 
> -apw
> 



I get this too, running an intel core duo on an asus p5b, but everything is 
running 32bit compiled programs., same kernel as well.

BUG: warning at fs/inode.c:1389/i_size_write()
 [<c017d450>] i_size_write+0x70/0x80
 [<c01ab051>] ext3_journalled_commit_write+0xf1/0x120
 [<c01aab80>] commit_write_fn+0x0/0x70
 [<c01aaf60>] ext3_journalled_commit_write+0x0/0x120
 [<c0171b50>] __page_symlink+0x90/0x170
 [<c01aed00>] ext3_symlink+0x80/0x1c0
 [<c012d298>] __capable+0x8/0x20
 [<c01aec80>] ext3_symlink+0x0/0x1c0
 [<c01726a0>] vfs_symlink+0x80/0xa0
 [<c01747e2>] sys_symlinkat+0xb2/0xe0
 [<c011cd2c>] do_page_fault+0x32c/0x630
 [<c0174830>] sys_symlink+0x20/0x30
 [<c0103252>] sysenter_past_esp+0x5f/0x85
 =======================





