Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318407AbSIFJEJ>; Fri, 6 Sep 2002 05:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSIFJEJ>; Fri, 6 Sep 2002 05:04:09 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:48786 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318407AbSIFJEI>; Fri, 6 Sep 2002 05:04:08 -0400
Message-Id: <5.1.0.14.2.20020906100358.03ed0bf0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 06 Sep 2002 10:08:47 +0100
To: ptb@it.uc3m.es
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Cc: Daniel Phillips <phillips@arcor.de>, "Peter T. Breuer" <ptb@it.uc3m.es>,
       Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200209060857.g868vqr05475@oboe.it.uc3m.es>
References: <5.1.0.14.2.20020906002019.00ac7290@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:57 06/09/02, Peter T. Breuer wrote:
>"Anton Altaparmakov wrote:"
> > [DanP]
> > >He was going to go hack the vfs, so in his mind, practical issues of 
> how the
> > >vfs works now aren't an obstacle.  The only mistake he's making is 
> seriously
> > >underestimating how much effort is required to learn enough to do this 
> kind
> > >of surgery and have a remote chance that the patient will survive.
> >
> > Ok so he plans to rewrite the whole I/O subsystem starting from block 
> up to
> > FS drivers and VFS. Great. See him again in 10 years... And his changes
>
>I've had a look now. I concur that e2fs at least is full of assumptions
>that it has various different sorts of metadata in memory at all times.
>I can't rewrite that, or even add a "warning will robinson" callback to
>vfs, as I intended. What I can do, I think, is ..

Oh, you saw the light. (-: I can assure you that most file systems make 
such assumptions. Certainly NTFS does... I designed the driver all around 
caching metadata to optimize access to actual data. Once I enable 
direct_IO, I plan to keep all metadata caching in place, just stop caching 
the actual file data. That should give maximum performance I think.

>.. simply do a dput of the fs root directory from time to time, from
>vfs - whenever I think it is appropriate. As far as I can see from my
>quick look that may cause the dcache path off that to be GC'ed. And
>that may be enough to do a few experiments for O_DIRDIRECT.

What does "GC" mean?

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

