Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318992AbSIDAOX>; Tue, 3 Sep 2002 20:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318993AbSIDAOX>; Tue, 3 Sep 2002 20:14:23 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:62906 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318992AbSIDAOW>; Tue, 3 Sep 2002 20:14:22 -0400
Message-Id: <5.1.0.14.2.20020904011108.00b083a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 04 Sep 2002 01:18:58 +0100
To: Daniel Phillips <phillips@arcor.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [RFC] mount flag "direct" (fwd)
Cc: ptb@it.uc3m.es, Lars Marowsky-Bree <lmb@suse.de>,
       "Peter T. Breuer" <ptb@it.uc3m.es>, root@chaos.analogic.com,
       Rik van Riel <riel@conectiva.com.br>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E17mMwu-0005mj-00@starship>
References: <5.1.0.14.2.20020903221201.00ac5770@pop.cus.cam.ac.uk>
 <20020903185344.GA7836@marowsky-bree.de>
 <5.1.0.14.2.20020903221201.00ac5770@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 00:19 04/09/02, Daniel Phillips wrote:
>On Tuesday 03 September 2002 23:54, Anton Altaparmakov wrote:
> > The difference between a DFS and your proposal is that a DFS maintains all
> > the caching benefits of a normal FS at the local node level, while your
> > proposal completely and entirely disables caching, which is debatably
> > impossible (due to need to load things into ram to read them and to modify
> > them and then write them back) and certainly no FS author will accept 
> their
> > FS driver to be crippled in such a way. The performance loss incurred by
> > removing caching completely is going to make sure you will only be 
> dreaming
> > of those 50GiB/sec. More likely you will be getting a few bytes/sec... 
> (OK,
> > I exaggerate a bit.) The seek times on the disks together with the
> > read/write timings are going to completely annihilate performance. A DFS
> > maintains caching at local node level, so you can still keep open 
> inodes in
> > memory for example (just don't allow any other node to open the same file
> > at the same time or you need to do some juggling via the "Master DFS 
> node").
>
>You're well wide of the mark here, in that you're relying on the assumption
>that caching is important to the application he has in mind.  The raw transfer
>bandwidth may well be sufficient, especially if it is unimpeded by being
>funneled through a bottleneck like our vfs cache.

I don't think I am. I think we just define "caching" differently. The "raw 
transfer bandwidth" will be close to zero if no caching happens at all. I 
agree with you if you define caching as data caching. But both Peter and I 
are talking about metadata caching + data caching. Sure, you can throw data 
caching out the window and actually gain performance. I would never dispute 
that. But if you throw away metadata caching you destroy performance. Maybe 
not on "simplistic" file systems like ext2 but certainly so on complex ones 
like ntfs... I described already what a single read in ntfs entails if no 
metadata caching happens. I doubt very much that there is a possible 
scenario where not doing any metadata caching would improve performance (on 
ntfs and at a guess many other fs). Even a sequential read or write from 
start of file to end of file would be really killed without caching of the 
logical to physical block mapping table for the inode being read/written on 
ntfs...

So we aren't in disagreement I think. (-:

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

