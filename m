Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbWEYNMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWEYNMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 09:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWEYNMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 09:12:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:53961 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965168AbWEYNMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 09:12:54 -0400
Date: Thu, 25 May 2006 15:12:15 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: sho@tnes.nec.co.jp
cc: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [UPDATE][7/24]several messages
In-Reply-To: <20060525214605sho@rifu.tnes.nec.co.jp>
Message-ID: <Pine.LNX.4.61.0605251510000.4289@yvahk01.tjqt.qr>
References: <20060525214605sho@rifu.tnes.nec.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Summary of this patch:
>  [7/24]  modify format strings in print(bfs)
>          - As i_blocks of VFS inode gets 8 byte variable, change its
>            string format to %lld.
>
>-        if (inode->i_size || inode->i_blocks) dprintf("Registered inode with %lld size, %ld blocks\n", inode->i_size, inode->i_blocks);
>+        if (inode->i_size || inode->i_blocks) dprintf("Registered inode with %lld size, %lld blocks\n", inode->i_size, inode->i_blocks);

Does gcc automatically promote/demote the arguments according to the % 
specifier? Otherwise, you should add an explicit cast to (long) or 
(long long) with varargs functions, since you cannot be sure that 
->i_blocks (blkcnt_t) is the same as long/long long.

>Summary of this patch:
>  [8/24]  modify format strings in print(efs)
>          - As i_blocks of VFS inode gets 8 byte variable, change its
>            string format to %lld.
>
>@@ -22,7 +22,7 @@ int efs_get_block(struct inode *inode, s
> 		/*
> 		 * i have no idea why this happens as often as it does
> 		 */
>-		printk(KERN_WARNING "EFS: bmap(): block %d >= %ld (filesize %ld)\n",
>+		printk(KERN_WARNING "EFS: bmap(): block %d >= %lld (filesize %ld)\n",



Jan Engelhardt
-- 
