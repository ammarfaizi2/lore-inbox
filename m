Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130030AbQLFWEp>; Wed, 6 Dec 2000 17:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLFWEg>; Wed, 6 Dec 2000 17:04:36 -0500
Received: from 208-48-236-144.dsl1.ROC.gblx.net ([208.48.236.144]:7673 "EHLO
	suzaku.fynet.org") by vger.kernel.org with ESMTP id <S130516AbQLFWEW>;
	Wed, 6 Dec 2000 17:04:22 -0500
Message-ID: <3A2EB071.2CD7D01D@fsc-usa.com>
Date: Wed, 06 Dec 2000 16:32:33 -0500
From: Brian Kress <kressb@fsc-usa.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Peter Samuelson <peter@cadcamlab.org>,
        Roberto Ragusa <robertoragusa@technologist.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel panic in SoftwareRAID autodetection
In-Reply-To: <14893.25967.936504.881427@notabene.cse.unsw.edu.au>
		<yam8375.1358.149393648@a4000>
		<20001205183657.J6567@cadcamlab.org>
		<3A2E3C39.B96B9516@fsc-usa.com> <14894.42901.943835.494412@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> On Wednesday December 6, kressb@fsc-usa.com wrote:
> > Peter Samuelson wrote:
> > >
> > > [Roberto Ragusa]
> > > > BTW, here is a little patch regarding a silly problem I found
> > > > about RAID partitions naming (/proc/partitions).
> > > > No more "md8" "md9" "md:" "md;" ... but "md8" "md9" "md10" "md11" ...
> > > > Well, this patch should work up to "md99".
> > >
> > > This stuff *really* should be split out into the drivers.  Brian Kress
> > > had a patch against test11 for this.  Brian?  You want to fold in this
> > > fix?
> >
> >       Sure.  I got resounding silence to posting the patch last time,
> > so I'm not sure if anyone actually wants this patch, but here it is
> > again with this fix (the non ugly version) folded in.
> >
> 
> Have you ever noticed that bad patches get a lot more response than
> good patches?  I think people like having something useful to say and
> a simple "I like it" often doesn't seem worth it, though in reality is
> very valuable.
> 
> Mayge the thing to do is include a few obvious but not very
> significant errors like:
>   - initialise a static variable to 0
>   - use /** to introduce a comment that isn't in the right format for
>     the auto-documentation stuff
>   - uses lines wider than 80 characters
>   - use unnecessary extra parentheses
>   - use non-standard indenting
> 
> that way people will respond because they think they have something to
> say, and will hopefully comment further... :-)
> 

	Perhaps this should be in the Linus-HOWTO.  :)

>
> But I see that you have done that .... a simple compiler error (I
> think).
> 
> > diff -u --recursive linux-2.4.0-test11/fs/partitions/check.c
> > linux-2.4.0-test11-ppfix/fs/partitions/check.c
> > --- linux-2.4.0-test11/fs/partitions/check.c  Mon Nov 20 15:17:27 2000
> > +++ linux-2.4.0-test11-ppfix/fs/partitions/check.c    Thu Nov 23 14:30:45
> > 2000
> > @@ -83,11 +83,10 @@
> >   */
> >  char *disk_name (struct gendisk *hd, int minor, char *buf)
> >  {
> > -     unsigned int part;
> >       const char *maj = hd->major_name;
> >       int unit = (minor >> hd->minor_shift) + 'a';
> > +     unsigned int part = minor & ((1 << hd->minor_shift) - 1);
> >
> > -     part = minor & ((1 << hd->minor_shift) - 1);
> 
> here we have lost the "part" automatic variable in disk_name but ....
> 

	I don't think so.  Look again.  I deleted the declaration and
the assignment and replaced it with a declare and assign all at once.
The other pieces were like that and that one being inconsisent 
offended me.  :)  This does compile, and seems to work.

> 
> But apart from this, I like it, and I think that it would be good if
> it went into 2.4.
> 
> Maybe do one more iteration (or convince me that the above isn't a
> bug), and ask for comment.  I promise to test and respond.
> Then send it to Linus, and explain what it does, and mention that it
> fixes a real issue in lvm (I assume it does as someone said so. I
> haven't actually looked into that) and leave it to him.
> 

	If you want to test it, get the version I posted later
in this thread.  It has some fixes like declaring some functions
static and my mailer not eating it.  If you'd like that version
mailed to you, let me know.
	Let me know how it works.


Brian Kress
kressb@fsc-usa.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
