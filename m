Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbTJIQgy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTJIQgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:36:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6533 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262236AbTJIQgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:36:50 -0400
Date: Thu, 9 Oct 2003 18:36:49 +0200
From: Jan Kara <jack@suse.cz>
To: Youza Youzovic <youza@post.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Data writting over the quota chage inote time
Message-ID: <20031009163648.GF25594@atrey.karlin.mff.cuni.cz>
References: <fc5f185ffdd49f6f4444747a24368d79@www4.mail.post.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5f185ffdd49f6f4444747a24368d79@www4.mail.post.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

  the problem actually isn't in quota but in VFS layer (you'd get same
result if you just run out of empty space on disk).  I actually also
looked into fixing this but it showed up to require rewriting of code on
a lot of places and so I postponed the problem because I find the
problem more or less cosmetic... Or do you have some application failing
on this?

								Honza 


> I find this "small" problem:
> 
> I set quota fo user "test" to 204 blocks.
> and store one big file "test" with full size ( 204 blocks).
> quota -v test
> Disk quotas for user test (uid 1010): 
> Filesystem blocks quota limit grace files quota limit grace
> /dev/sdb1 204* 204 204 1 0 0 
> 
> and run command "stat test":
> File: "test"
> Size: 204800 Blocks: 408 IO Block: 
> 121234234 Regular File
> Device: 811h/2065d Inode: 6300 Links: 1 
> Access: (0644/-rw-r--r--) Uid:(1010/test) Gid:(0/root)
> Access: Wed Aug 13 16:10:21 2003
> Modify: Wed Aug 13 16:12:43 2003
> Change: Wed Aug 13 16:12:43 2003
> 
> next I run command
> 
> echo "s" >> test; stat test 
> File: "test"
> Size: 204800 Blocks: 408 IO Block: 
> 121234234 Regular File
> Device: 811h/2065d Inode: 6300 Links: 1 
> Access: (0644/-rw-r--r--) Uid: (1010/test) Gid:(0/root)
> Access: Wed Aug 13 16:10:21 2003
> Modify: Wed Aug 13 16:14:38 2003
> Change: Wed Aug 13 16:14:38 2003
> 
> the size is not change - this is OK !!
> But Modify, and Change time is modified !!!
> 
> My system:
> Linux kernel 2.4.21 from www.kernel.org
> 
> Thanx
> youza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
