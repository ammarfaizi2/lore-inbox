Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbTBBSuB>; Sun, 2 Feb 2003 13:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbTBBSuB>; Sun, 2 Feb 2003 13:50:01 -0500
Received: from h-64-105-35-85.SNVACAID.covad.net ([64.105.35.85]:8660 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265480AbTBBSt6>; Sun, 2 Feb 2003 13:49:58 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 2 Feb 2003 10:59:18 -0800
Message-Id: <200302021859.KAA11878@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: futimes()?
Cc: abramo.bagnara@libero.it, hpa@zytor.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Abramo Bagnara wrote:
>"H. Peter Anvin" wrote:
>> 
>> In the general vein of avoiding security holes by using file
>> descriptors when doing repeated operations on the same filesystem
>> object, I have noticed that there doesn't seem to be a way to set
>> mtime using a file descriptor.  Do we need a futimes() syscall?
>
>Parallel to that, there is the long time needed lutimes() syscall.
>
>Who has never been annoyed that restoring a backup there's no way to
>restore former symlink mtime?

	I wonder if we could have an open flags similar to O_NOFOLLOW
that would allow a symbolic link to be "opened" just so it could
be referred to by f{stat,chown,chmod} so that programs that use this
style handle symbolic links the same way.

	Also, if you want to add another system call for setting stat
information, perhaps we could take the opportunity to reduce the
number of system calls per file being restored by programs like tar by
creating an fsetstat() system call that would take some kind of
extensible flags field so that programs like tar could do their
business in a single system call.  The kernel already seems to do this
internally through inode_operations.setattr.  (sys_chown -->
chown_common --> notify_change --> inode_setattr).  That way it
would be less likely that we'd have to add a new system calls again
if people think of new file attributes.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
