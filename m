Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSGQQRw>; Wed, 17 Jul 2002 12:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSGQQRw>; Wed, 17 Jul 2002 12:17:52 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:14792 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315372AbSGQQRn>; Wed, 17 Jul 2002 12:17:43 -0400
Message-Id: <5.1.0.14.2.20020717171311.00b00380@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 17 Jul 2002 17:20:39 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [patch 13/13] lseek speedup
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D3598F0.FBBA9DB6@zip.com.au>
References: <3D35012B.EE9B1ABB@zip.com.au>
 <5.1.0.14.2.20020717103038.00a8c7a0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

At 17:18 17/07/02, Andrew Morton wrote:
>Anton Altaparmakov wrote:
> > At 06:31 17/07/02, Andrew Morton wrote:
> > >This is a fairly dopey patch to fix up the i_sem contention in lseek.
> > >Better ideas are welcome, but I'm offline until Monday so don't think
> > >I'm ignoring them...
> >
> > I am afraid I don't have any better ideas but I don't think your patch is
> > safe. )-:
>
>It wasn't a very good idea in the first place.  Forgot to take
>the new lock over in the updaters of f_pos.
>
>And it's attempting to cater for a buggy application on a 32-bit
>machine, SMP, where the fd is shared.  It's hard to justify
>putting any locking in lseek for that.  (Then again, people
>should use pread() more..)
>
>Except for readdir().  Now, why are we taking i_sem for lseek/readdir
>exclusion and not a per-file lock?

Because it also excludes against directory modifications, etc. Just imagine 
what "rm somefile" or "mv somefile otherfile" or "touch newfile" would do 
to the directory contents and what a concurrent readdir() would do... A 
very loud *BANG* is the only thing that springs to mind...

btw. the directory modification locking rules are written up in 
Documentation/filesystems/directory-locking by our very own VFS maintainer 
Al Viro himself... (-;

Cheers,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

