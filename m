Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271080AbTHQUQm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271091AbTHQUQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:16:42 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:24783 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S271080AbTHQUQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:16:38 -0400
Message-ID: <3F3FE375.7060309@terra.com.br>
Date: Sun, 17 Aug 2003 17:20:05 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Cc: Gobo-l <gobo-l@cscience.org>, linux-kernel@vger.kernel.org
Subject: Re: [gobo-l]Re: [PATCH] gobohide: avoid null pointer accesses
References: <200308140053.14005.lucasvr@gobolinux.org> <3F3D94DA.90805@terra.com.br> <200308170210.49719.lucasvr@gobolinux.org>
In-Reply-To: <200308170210.49719.lucasvr@gobolinux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Greetings,

Lucas Correia Villa Real wrote:
> Oops, sorry. 2.4.20 and/or 2.4.21.

	Ok, things are much clearer now :)

	But I still have some doubts..CC'ing LKML to see if any of those 
hackers can help us.

> int vfs_unlink(struct inode *dir, struct dentry *dentry)
> {
> 	...
> 	down(&dir->i_zombie);
> 	error = may_delete(dir, dentry, 0);
> 	if (!error) {
> 		...
> 		if (!error) {
> 			if (dentry->d_inode && S_ISLNK (dentry->d_inode->i_mode))
> 				if (gobolinux_hide(dentry->d_inode->i_ino) > 0)
> 					gobolinux_inode_del(dentry->d_inode->i_ino)


	Yeah, ok...but I still don't get when a dentry doesn't have a valid 
d_inode why we don't return ENOENT like in sys_unlink:


slashes:
         error = !dentry->d_inode ? -ENOENT :
                 S_ISDIR(dentry->d_inode->i_mode) ? -EISDIR : -ENOTDIR;


	Which, by the way, would be called _instead_ of calling vfs_unlink...so 
should we assume that the dentry _should_ have a valid dinode?

	You said that the kernel oops'ed when unlinking a symlink in a NFS 
partition, right?

	Does anybody know if, in this case (a symlink inside a NFS partition), 
the dentry really doesn't have a valid d_inode entry?

	Thanks,

Felipe
-- 
It's most certainly GNU/Linux, not Linux. Read more at
http://www.gnu.org/gnu/why-gnu-linux.html

