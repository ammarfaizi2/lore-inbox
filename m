Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVCUAuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVCUAuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 19:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVCUAtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 19:49:40 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:56333 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S261404AbVCUAtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 19:49:19 -0500
Message-ID: <423E032C.4020103@lougher.demon.co.uk>
Date: Sun, 20 Mar 2005 23:11:40 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Function stack size usage (was [PATCH][1/2] SquashFS)
References: <4235BAC0.6020001@lougher.demon.co.uk> <20050314165117.1c5068b7.akpm@osdl.org>
In-Reply-To: <20050314165117.1c5068b7.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
>>
>>+static struct inode *squashfs_iget(struct super_block *s, squashfs_inode inode)
>>+{
>>+	struct inode *i;
>>+	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
>>+	squashfs_super_block *sBlk = &msBlk->sBlk;
>>+	unsigned int block = SQUASHFS_INODE_BLK(inode) +
>>+		sBlk->inode_table_start;
>>+	unsigned int offset = SQUASHFS_INODE_OFFSET(inode);
>>+	unsigned int ino = SQUASHFS_MK_VFS_INODE(block
>>+		- sBlk->inode_table_start, offset);
>>+	unsigned int next_block, next_offset;
>>+	squashfs_base_inode_header inodeb;
> 
> 
> How much stack space is being used here?  Perhaps you should run
> scripts/checkstack.pl across the whole thing.
> 

A lot of the functions use a fair amount of stack (I never thought it 
was excessive)...  This is the result of running checkstack.pl against 
the code on Intel.

0x00003a3c get_dir_index_using_name:                    596
0x00000d80 squashfs_iget:                               488
0x000044d8 squashfs_lookup:                             380
0x00003d00 squashfs_readdir:                            372
0x000020fe squashfs_fill_super:                         316
0x000031b8 squashfs_readpage:                           308
0x00002f5c read_blocklist:                              296
0x00003634 squashfs_readpage4K:                         284

A couple of these functions show a fair amount of stack use.  What is 
the maximum acceptable usage, i.e. do any of the above functions need 
work to reduce their stack usage?

Thanks

Phillip
