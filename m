Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318296AbSGYCHi>; Wed, 24 Jul 2002 22:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318300AbSGYCHi>; Wed, 24 Jul 2002 22:07:38 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:65179 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318296AbSGYCHh>; Wed, 24 Jul 2002 22:07:37 -0400
Message-Id: <5.1.0.14.2.20020725030051.02114cb0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 25 Jul 2002 03:11:03 +0100
To: Alexander Viro <viro@math.psu.edu>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: 2.5.28 and partitions
Cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0207241925450.14656-100000@weyl.math.psu.edu
 >
References: <UTC200207242242.g6OMglA23855.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 00:42 25/07/02, Alexander Viro wrote:
>On Thu, 25 Jul 2002 Andries.Brouwer@cwi.nl wrote:
> > Just saw some new partition code in 2.5.28. Good!
> > I like almost all I see, except for one thing:
> >
> > +struct parsed_partitions {
> > +       char name[40];
> > +       struct {
> > +               unsigned long from;
> > +               unsigned long size;
> > +               int flags;
> > +       } parts[MAX_PART];
> > +       int next;
> > +       int limit;
> > +};
> >
> > and I object to the long instead of u64 or so.
>
>Separate set of patches.  As it is, struct hd_struct is still there and
>still not modified.  And it has unsigned long.  It will become sector_t.
>
>Actually, I'm not all that sure that we want u64 here.  The thing being,
>start_sect shouldn't be bigger than sector_t (see how it's used).  And
>64bit arithmetics on 32bit boxen sucks big way.  I'm not too concerned
>about adding start_sect per se - it's done once per request and it's
>noise compared to the rest of work.  However, long long for sector_t
>will hit in a lot of more interesting code paths.
>
>That stuff becomes an issue for 2Tb disks.  Do we actually have something
>that large attached to 32bit boxen?

Not right now perhaps, but we may well do in a year or two. E.g. in the 
department, we just bought a Dual Athlon 2000+, 3G RAM, and attached it to 
a new 1.4TiB RAID array. We only need HDs to double in size and that array 
could easily become 2.8TiB... And the whole fun costs less than US$15,000 
at present so it is quite affordable for smaller institutions/companies.

OTOH, we are going to be using 32-bit systems for quite a few years to come...

> > With 2^32 sectors one can handle up to 2^41 bytes, 2 TiB.
> > Already today people want RAIDs that are larger, and
> > few years from now we'll have single disks that are larger.
>
>... and still use i386 with these disks?

Yes, definitely. Why pay for some stupidly expensive 64-bit computer when 
you only want large storage?

>ia64 is stillborn, but x86-64 promises to be more useful than Itanic.

We shall see once it comes on the market... And we will then see the price 
tag it will bring with it, too...

>u64 for sector_t doesn't change anything for 64bit boxen that might be
>interested in really large disks and screws 32bit ones that shouldn't
>have to pay for that...

True. That's why sector_t should be a compile time option in the kernel 
"Enable large device support > 2TiB:  Y/N". Then I am happy and loads of 
other people because we can use large raid arrays without having to buy the 
latest expensive system and other people are happy for having faster 32-bit 
code... Surely we can write robust enough code which will work with either 
sector_t size...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

