Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317280AbSG1SwN>; Sun, 28 Jul 2002 14:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSG1SwM>; Sun, 28 Jul 2002 14:52:12 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:50911 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317287AbSG1SwG>; Sun, 28 Jul 2002 14:52:06 -0400
Message-Id: <5.1.0.14.2.20020728194633.04207dd0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 28 Jul 2002 19:55:51 +0100
To: ebiederm@xmission.com (Eric W. Biederman)
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BK PATCH 2.5] fs/binfmt_aout.c: Use PAGE_ALIGN_LL() on
  64-bit values
Cc: torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <m1wurfhgxd.fsf@frodo.biederman.org>
References: <E17YRsD-0006Hw-00@storm.christs.cam.ac.uk>
 <E17YRsD-0006Hw-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:59 28/07/02, Eric W. Biederman wrote:
>Anton Altaparmakov <aia21@cantab.net> writes:
> > Following from previous patch which introduced PAGE_ALIGN_LL, this
> > one fixes a bug in fs/binfmt_aout.c which was using PAGE_ALIGN
> > on 64-bit values... It now uses PAGE_ALIGN_LL.
> >
> > Patch together with the other two patches available from:
> >
> >       bk pull http://linux-ntfs.bkbits.net/linux-2.5-pm
>
>Huh?
>
>All virtual addresses on 32bit platforms are 32bit, as are all lengths
>of address space.

I thought (intel) CPUs did 48-bit addressing? How do we support 32GiB of 
RAM? With pure 32-bit addressing it would be limited to 4GiB only... No? 
(Of course I am probably confusing varius types of addresses...)

>Unless you are running a 32bit kernel with a 64bit user space,
>which is simply crazy, unless you are stuck doing it that way.

The code is still broken. The values ARE 64-bit (check the struct 
definitions if you don't believe me). This is just a matter of correctness. 
It is incorrect as it is right now and it will do Bad Things(tm) if the 
supplied values are > 32-bit. (Whether it is possible for a malicious user 
to supply them is beyond my knowledge.)

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

