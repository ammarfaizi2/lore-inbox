Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319347AbSIEXTN>; Thu, 5 Sep 2002 19:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319350AbSIEXTM>; Thu, 5 Sep 2002 19:19:12 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:34695 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S319347AbSIEXTJ>; Thu, 5 Sep 2002 19:19:09 -0400
Message-Id: <5.1.0.14.2.20020906002019.00ac7290@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 06 Sep 2002 00:24:00 +0100
To: Daniel Phillips <phillips@arcor.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E17n5sj-0006CY-00@starship>
References: <5.1.0.14.2.20020905235933.04082dc0@pop.cus.cam.ac.uk>
 <Pine.SOL.3.96.1020904143824.7543A-100000@libra.cus.cam.ac.uk>
 <5.1.0.14.2.20020905235933.04082dc0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 00:17 06/09/02, Daniel Phillips wrote:
>On Friday 06 September 2002 01:06, Anton Altaparmakov wrote:
> > At 23:45 05/09/02, Daniel Phillips wrote:
> > >On Wednesday 04 September 2002 16:13, Anton Altaparmakov wrote:
> > > > Did you read my post which you can lookup on the below url?
> > > >
> > > > http://marc.theaimsgroup.com/?l=linux-kernel&m=103109165717636&w=2
> > > >
> > > > That explains what a single byte write to an uncached ntfs volume 
> entails.
> > > > (I failed to mention there that you would actually need to read the 
> block
> > > > first modify the one byte and then write it back but if you write
> > > > blocksize based chunks at once the RCW falls away.
> > > > And as someone else pointed out I failed to mention that the entire
> > > > operation would have to keep the entire fs locked.)
> > > >
> > > > If it still isn't clear let me know and I will attempt to explain 
> again in
> > > > simpler terms...
> > >
> > >Anton, it's clear he understands the concept, and doesn't care because
> > >he does not intend his application to access the data a byte at a time.
> > >
> > >Your points are correct, just not relevant to what he wants to do.
> >
> > Daniel,
> >
> > The procedure described is _identical_ if you want to access 1TiB at a
> > time, because the request is broken down by the VFS into 512 byte size
> > units and I think I explained that, too. And for _each_ 512 byte sized 
> unit
> > of those 1TiB you would have to repeat the _whole_ of the described
> > procedure.
>
>Well, remember, he was going to use o_direct, so he can get away with pretty
>crude locking.
>
> > It is not clear to me he understands the concept at all. He thinks that 
> you
> > need to read the disk inode just once and then you immediately read all 
> the
> > 1TiB of data and somehow all this magic is done by the VFS. This is
> > complete crap and is _NOT_ how the Linux kernel works. The VFS breaks 
> every
> > request into super block->s_blocksize sized units and _each_ and _every_
> > request is _individually_ looked up as to where it is on disk.
>
>He was going to go hack the vfs, so in his mind, practical issues of how the
>vfs works now aren't an obstacle.  The only mistake he's making is seriously
>underestimating how much effort is required to learn enough to do this kind
>of surgery and have a remote chance that the patient will survive.

Ok so he plans to rewrite the whole I/O subsystem starting from block up to 
FS drivers and VFS. Great. See him again in 10 years... And his changes 
probably will never reach the mainstream kernel because they will optimize 
for some unlikely application... And by then there won't be any need 
because we will have proper DFS solutions... Well if he wants to waste his 
time, that's fine. It's not my time...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

