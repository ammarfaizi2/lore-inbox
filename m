Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292612AbSCDUJc>; Mon, 4 Mar 2002 15:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292609AbSCDUJX>; Mon, 4 Mar 2002 15:09:23 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:55334 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S292555AbSCDUJC>; Mon, 4 Mar 2002 15:09:02 -0500
Date: Mon, 4 Mar 2002 14:08:46 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200203042008.OAA00849@tomcat.admin.navo.hpc.mil>
To: jstrand1@rochester.rr.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ext3 and undeletion
In-Reply-To: <1015269436.17583.25.camel@hedwig.strandboge.cxm>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James D Strandboge <jstrand1@rochester.rr.com>:
> On Mon, 2002-03-04 at 10:12, Alan Cox wrote:
> > > Modifying unlink will probably suffice.
> I am working on a preliminary patch that does this.  My current
> implementaion (which is not ready to submit-- but works) added a line to
> sys_unlink in fs/namei.c that calls my vfs_undel_link().  The
> vfs_undel_link() function is based on the logic of sys_link, and creates
> a hard link from the deleted file to one in the "stuff we deleted"
> directory.  Then vfs_undel_link returns to sys_unlink and original link
> is deleted, leaving only the one in the "stuff we deleted" directory.
> 
> > You would need to hook the truncate/unlink paths in the file system. If=20
> > you are doing it within the fs it becomes cheap (at least for ext2) - as
> > you can simply reassign the data blocks to a new inode, stuff the new ino=
> de
> > into the magic "stuff we deleted" directory and continue.
> After much consideration, my implementation does not deal with
> truncate/overwrite because it would fill up the filesystem and be very
> slow in VFS since there would have to be a full copy.  Also, staying
> high level in VFS makes the patch work over any fs that uses VFS.
> 
> When I submit, I will make sure to add RFC to get more input on the
> implementation, and possibly dealing with truncate.
> 
> Jamie Strandboge

How do you handle "rm dir1/main.c dir2/main.c" ??? Both files have the
same name. And how about VFAT (no inode numbers...).

If you create a shadow directory tree, how do you handle the quota problem?

What happens to files deleted by fsck? (which depends on the disk
implementation of the FS and not the VFS)

Is there a design document or FAQ somewhere ?

(I did have to deal with VMS for a while - our solution: Don't do that...
recovery was just too much of a hassle)
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
