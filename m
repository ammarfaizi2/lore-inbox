Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422931AbWBIR5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422931AbWBIR5V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422933AbWBIR5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:57:21 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:9313 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422931AbWBIR5U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:57:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uZ5fiJQL85lWs6a+7QLzvtgUxj1mOb6uSGwhJ3pCuyaAI99nnMJpktxtHzM0ZV62XnjKy73bREd4KU+kWkNt0eXdZZy9NRSE8iI4fAgfI+jXzlvs2Kn3ccxnOrPB7Yv8Zr74bJ/zY+JXpOKpz/N43m3BpPRpu0TV7gxrzYx3WCk=
Message-ID: <ef2d59350602090957o1a86757fk31c361e2e37f1e1f@mail.gmail.com>
Date: Thu, 9 Feb 2006 12:57:10 -0500
From: kapil a <kapilann@gmail.com>
To: Avishay Traeger <atraeger@cs.sunysb.edu>, lloyd@randombit.net,
       linux-kernel@vger.kernel.org
Subject: Re: file system question
In-Reply-To: <1139447727.4902.13.camel@rockstar.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ef2d59350602081539w7b6780e3mf6d8326f6d4963f2@mail.gmail.com>
	 <1139443268.4902.11.camel@rockstar.fsl.cs.sunysb.edu>
	 <ef2d59350602081611h4492bf47ne24e3d591efd29e7@mail.gmail.com>
	 <1139447727.4902.13.camel@rockstar.fsl.cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am only sending the relevant stuff.

My strace output :

fstat64(3, {st_mode=S_IFDIR|0755, st_size=48, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(3, /* 3 entries */, 4096)    = 80
getdents64(3, /* 0 entries */, 4096)    = 0
close(3)                                = 0
exit_group(0)

strace output on a partition under ext2

fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents64(3, /* 4 entries */, 4096)    = 104
getdents64(3, /* 0 entries */, 4096)    = 0
close(3)                                = 0
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ddc000
write(1, "kapil  out\n", 11)            = 11
munmap(0xb7ddc000, 4096)                = 0
exit_group(0)

We can see that my strace does not call the fstat, mmap, write and
munmap calls. It directly calls the exit_group call. This is what i
fail to understand. The getdents seems to be returning data correctly.
And filldir() called by  the readdir() seems to be working
correctly(am not sure).
So i fail to understand why the other calls are not performed.

I would like to remind you that i have not written all the calls. For
example i dont have my file systems implementation of the write call.
But atleast i shd be able to call the default.

any help would be appreciated. And can anybody think of an other way i
can test my filesystem with a smaller call. "ls" seems to be calling
way too many system calls. My filesystem is a disk based file system
with my superblock in a floppy.

kapil




On 2/8/06, Avishay Traeger <atraeger@cs.sunysb.edu> wrote:
> On Wed, 2006-02-08 at 19:11 -0500, kapil a wrote:
> > thanks for the reply and sorry for the unclear question.
> >
> > What i meant was when i do an "ls" in a directory that is part of the
> > ext2 filesystem, i can see a  "write" call in the strace output at the
> > end and it writes the directory contents to stdout. However when i
> > issue "ls" in the mount point of my file system, i dont have the
> > "write" call. The strace ends with the getdents64 call.
> >
> > When i did some debugging i found that filldir which is suppose to
> > fill the dirent with the directory entries does its job. My filesystem
> > currently has only one inode with one block of data where i have a
> > ".", ".." and "test" written into it.
> >
> > The problem is it does not go further to do some of the other calls as
> > in a mountpoint in ext2 file system.
> >
> > Hope i am clear now.
> >
> > kaps
>
> Can you send the strace output?
>
>
