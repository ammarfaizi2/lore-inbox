Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317287AbSG1S4x>; Sun, 28 Jul 2002 14:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSG1S4w>; Sun, 28 Jul 2002 14:56:52 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:225 "EHLO plum.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S317287AbSG1S4t>;
	Sun, 28 Jul 2002 14:56:49 -0400
Message-Id: <5.1.0.14.2.20020728195634.042be2a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 28 Jul 2002 20:00:35 +0100
To: ebiederm@xmission.com (Eric W. Biederman)
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BK PATCH 2.5] fs/ntfs/dir.c: use PAGE_CACHE_MASK_LL with
  64-bit values
Cc: torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <m1sn23hgru.fsf@frodo.biederman.org>
References: <E17YRtw-0006I7-00@storm.christs.cam.ac.uk>
 <E17YRtw-0006I7-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:03 28/07/02, Eric W. Biederman wrote:
>Anton Altaparmakov <aia21@cantab.net> writes:
>
> > Linus,
> >
> > Following from previous patch which introduced PAGE_CACHE_MASK_LL, this
> > one fixes a bug in fs/ntfs/dir.c which was using PAGE_CACHE_MASK
> > on 64-bit values... It now uses PAGE_CACHE_MASK_LL.
> >
> > Patch together with the other two patches available from:
> >
> >       bk pull http://linux-ntfs.bkbits.net/linux-2.5-pm
> >
> > Best regards,
> >
> >       Anton
> > --
> > Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
> > Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
> > WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/
> >
> > ===================================================================
> >
> > This will update the following files:
> >
> >  fs/ntfs/dir.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletion(-)
> >
> > through these ChangeSets:
> >
> > <aia21@cantab.net> (02/07/27 1.479)
> >    fs/ntfs/dir.c: Use PAGE_CACHE_MASK_LL() on 64-bit values.
> >
> >
> > diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> > --- a/fs/ntfs/dir.c   Sat Jul 27 14:24:09 2002
> > +++ b/fs/ntfs/dir.c   Sat Jul 27 14:24:09 2002
> > @@ -1232,7 +1232,8 @@
> >       ntfs_debug("Handling index buffer 0x%Lx.",
> >                       (long long)bmp_pos + cur_bmp_pos);
> >       /* If the current index buffer is in the same page we reuse the 
> page. */
> >
> > -     if ((prev_ia_pos & PAGE_CACHE_MASK) != (ia_pos & PAGE_CACHE_MASK)) {
> > +     if ((prev_ia_pos & PAGE_CACHE_MASK_LL) !=
> > +                     (ia_pos & PAGE_CACHE_MASK_LL)) {
> >               prev_ia_pos = ia_pos;
> >               if (likely(ia_page != NULL))
> >                       ntfs_unmap_page(ia_page);
>
>
>Hmm.  Wouldn't
>prev_ia_pos >> PAGE_CACHE_SHIFT != ia_pos >> PAGE_CACHE_SHIFT
>work just as well?  And be some safer as the result could be stored in
>32bits?

No it couldn't necessarily. (Althought we would have refused to open the 
directory if it would be but I would like to see those kinds of limits 
removed.)

Yes, the shifts would do the same but they would generate more inefficient 
code (this is a completely unverified and possibly wild assumption).

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

