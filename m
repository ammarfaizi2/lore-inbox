Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314282AbSEBIt4>; Thu, 2 May 2002 04:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314283AbSEBItz>; Thu, 2 May 2002 04:49:55 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:23614 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314282AbSEBIty>; Thu, 2 May 2002 04:49:54 -0400
Message-Id: <5.1.0.14.2.20020502094535.04261b70@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 02 May 2002 09:49:11 +0100
To: vda@port.imtp.ilyichevsk.odessa.ua
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [prepatch] address_space-based writeback
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <200205011416.g41EFnX04718@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:18 01/05/02, Denis Vlasenko wrote:
>On 30 April 2002 11:40, Keith Owens wrote:
> > On Tue, 30 Apr 2002 23:15:23 +1000,
> > john slee <indigoid@higherplane.net> wrote:
> > >probably because there is software out there relying on them being
> > >numbers and being able to do 'if(inum_a == inum_b) { same_file(); }'
> > >as appropriate.  i can't think of a use for such a construct other than
> > >preserving hardlinks in archives (does tar do this?) but i'm sure there
> > >are others
> >
> > Any program that tries to preserve or detect hard links.  cp, mv (files
> > a and b are the same file).  tar, cpio, rsync -H, du, etc.
> >
> > The assumption that inode numbers are unique within a mount point is
> > one of the reasons that NFS export does not cross mount points by
> > default.  man exports, look for 'nohide'.
>
>And I recently moved my /usr/src to separate partition.
>That is, /usr/src is now a mount point.
>I have to export it in NFS exports *and* mount it *on every workstation*
>(potentially thousands of wks!).

Yes, edit /etc/fstab. My file server has loads of partitions and it exports 
them all and /etc/fstab on all clients just mounts them all. Problem being?

>I'll repeat myself. What if some advanced fs has no sensible way of
>generating inode? Does it have to 'fake' it, just like [v]fat does it now?
>(Yes, vfat is not 'advanced' fs, let's not discuss it...)

They have to fake it yes. Otherwise all existing userspace utilities will 
break. Anod no they cannot be changed otherwise they would no longer work 
on non-Linux platforms and most utilities are UNIX utilities which work on 
everything including Linux. You don't want to break that.

>The fact that minix,ext[23],etc has inode #s is an *implementation detail*.
>Historically entrenched in Unix.
>
>Bad:
>inum_a = inode_num(file1);
>inum_b = inode_num(file2);
>if(inum_a == inum_b) { same_file(); }
>
>Better:
>if(is_hardlinked(file1,file2) { same_file(); }
>
>Yes, new syscal, blah, blah, blah... Not worth the effort, etc...
>lets start a flamewar...

That would break UNIX semantics. Which it seems is exactly what you want to 
do... I don't think you will find many supporters of that idea... As Linus 
pointed out to me the inode is the basic i/o entity in UNIX and hence 
Linux. And that is not going to change...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

