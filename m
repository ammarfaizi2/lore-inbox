Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVDEBSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVDEBSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 21:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVDEBSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 21:18:23 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:5000 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261494AbVDEBSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 21:18:16 -0400
Date: Mon, 4 Apr 2005 18:10:08 -0400
From: Christopher Li <lkml@chrisli.org>
To: Vineet Joglekar <vintya@excite.com>
Cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org,
       adilger@clusterfs.com
Subject: Re: Adding a field to ext2_dir_entry_2
Message-ID: <20050404221008.GA8390@64m.dyndns.org>
References: <20050405000857.0C26B8AEAC@xprdmailfe2.nwk.excite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405000857.0C26B8AEAC@xprdmailfe2.nwk.excite.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That design sounds bad.

Anyway, I guess the error you are getting might have some thing to do with
the "." and ".." entry. Your current directory need to in the same
format as well. That is the price you pay for breaking the compatibility.

Chris


On Mon, Apr 04, 2005 at 08:08:57PM -0400, Vineet Joglekar wrote:
> 
> Hi Andreas,
> 
> I have created another file system - copied everything from ext2, renaming it as some different file system and doing some experiments on that.
> 
> Let me be more clear about what I am trying to do. In my masters project, I am encrypting inodes along with the data part of the file. Keys of different users are different. In the same directory, if there are 2 files stored by different users, their inodes will be encrypted with different keys. If user1 is doing "ls" on that directory, the inode of the other file - which is encrypted by user2, will be decrypted by using user1's key, resulting into garbage. To avoid this, I am trying to store the uid in the directry entry, so that  I can match it with current->fsuid and skip decrypting the inode if the file doesn't belong to the current user. (assuming user1 doesnt want to share that file and different users can store different files under same directory.)
> 
> Thanks and regards,
> 
> Vineet
> 
>  --- On Mon 04/04, Andreas Dilger < adilger@clusterfs.com > wrote:
> From: Andreas Dilger [mailto: adilger@clusterfs.com]
> To: vintya@excite.com
>      Cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
> Date: Mon, 4 Apr 2005 17:17:59 -0600
> Subject: Re: Adding a field to ext2_dir_entry_2
> 
> On Apr 04, 2005  18:54 -0400, Vineet Joglekar wrote:<br>> I working with linux kernel 2.4.28. I want to add 1 more field to<br>> ext2_dir_entry_2 - the new version of directory entry for ext2fs.<br>> <br>> I did add the __u32 field to the struct ext2_dir_entry_2 defined in<br>> ext2_fs.h I also modified the EXT2_DIR_REC_LEN macro to:<br>> <br>> (((name_len) + 12 + EXT2_DIR_ROUND) & ~EXT2_DIR_ROUND)<br>> <br>> (+12 instead of +8) to incorporate newly added 4 bytes field.<br>> <br>> I made the similar changes to the mke2fs utility also.<br><br>This means your filesystem will not be mountable by any other version of<br>Linux.  What is more important is why you want to do this - there are<br>other mechanisms that may be more appropriate depending on what you are<br>doing.<br><br>Cheers, Andreas<br>--<br>Andreas Dilger<br>Principal Software Engineer<br>Cluster File Systems, Inc.<br><br>Attachment: Attachment  (0.19KB)<br>
> 
> _______________________________________________
> Join Excite! - http://www.excite.com
> The most personalized portal on the Web!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
