Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWA2LCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWA2LCu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 06:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWA2LCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 06:02:50 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:58534 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750901AbWA2LCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 06:02:50 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Sun, 29 Jan 2006 12:01:43 +0100
To: schilling@fokus.fraunhofer.de, bzolnier@gmail.com
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <43DCA097.nailGPD11GI11@burner>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
In-Reply-To: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> I address this to everybody not only to Joerg:
>
> [*] As this is my thread now discussing SG_IO on /dev/hd* vs /dev/sg*
> is BANNED.  Please continue discussing this in the old thread. :-)

If we also bann discussions that try to claim cdrecord -scanbus is
unneeded or unwanted, no problem.

> > Maybe (now that we did agree about the way to go) it makes sense to start
> > discussing which bugs in Linux need to be fixed in order to close e.g.
> > the Bugs in the Debian bug tracking system for cdrtools that are related to the
> > Linux kernel.
>
> Yes, lets talk about other problems, do you have pointers bugs handy?
> I'm not very familiar with Debian bug tracking system and I see there
> more than 3 bugs for cdrtools.

There unfortunately are many "Bugs" on Debian.
Most of the "Bugs" are either realls Linux bugs or just caused by the
modifications done by the Debian people.

You would need to read the reports and it makes sense to look for comments from 
me.

> > This are the three most important Linux kernel bugs:
> >
> > -       ide-scsi does not do DMA if the DMAsize is not a multiple of 512
> >         A person who knows internal Linux structures shoule be able
> >         to fix this (and allow any multiple of 4) in less than one hour.
>
> I'll take a look, it should be quite easy
> and I don't see a reason for this restriction.

Testing could be done the following way:

-	insert a blank CD into your writer and do an initial test burn.

	sdd -inull bs=2352 of= test.raw count=75x60x74
	cdrecord dev=ATA:b,t,0 -audio -sao -v test.raw

	Remember the speed that should be > 40x
	Remember the system cpu time that should be less than 5% of the 
	wall clock time.

-	Repeat the same test with ide-scsi
	Make sure ide-scsi is usable fo the drive, then call

	cdrecord dev=b,t,0 -audio -sao -v test.raw

	If the max speed is lower than 30x or the system cpu time
	ich significant more than 5% of the wall closk time you do not
	use DMA.




> >         If we sum up the time spend on this discussoion, I really cannot
> >         understand why this has not been fixed earlier.
>
> Because nobody cared and flamewaring is easy in contrast
> to doing some real work.
>
> > -       /dev/hd* artificially prevents the ioctls SCSI_IOCTL_GET_IDLUN
> >         SCSI_IOCTL_GET_BUS_NUMBER from returning useful values.
> >         As long as this bug is present, there is no way to see SG_IO
> >         via /dev/hd* as integral part of the Linux SCSI transport concept.
>
> What are the return values of SCSI_IOCTL_GET_IDLUN
> and SCSI_IOCTL_GET_BUS_NUMBER needed for?
>
> Please elaborate as:
>
> * SG_IO ioctl doesn't require lun and bus number for arguments
> * sg_io_hdr_t also doesn't contain/require these fields
>
> so I simply cannot see why they are needed by kernel.
>
> If lun and bus number are needed by cdrecord please explain why
> (if only for enumerating devices sorry but see [*]).

Well it is obvious that the numbers are present inside Linux, otherwise
Linux could not return useful numbers in case that ide-scsi is used.
Note that we are talking about SCSI devices (in case the actual user
of libscg is cdrecord, we talk about CD/DVD writers).

If you read the Debian bug reports, you will find that many users are confused 
because cdrecord -scanbus will not list all possible devices.


> > -       If sending SCSI sia ATAPI, Linux under certain unknown conditions
> >         bastardizes the content of SCSI commands. A possible reason may be
>
> Sorry but I can't do much about it without knowing more details.

I am sorry, but as nobody was interested on this when it was possible 
to tell more it did has been fogotten.


> Please provide some way to reproduce the problem
> ("certain unknown conditions" is not very useful).

Well if I remember  correclty, then the problem does not occur in case you
use a Plextor drive. It may IIRC make sense to try to reproduce with Pioneer 
or NEC drives.

I believe the best way to allow to reproduce the problem would be to search the 
web or the Debian bugtracking for related error reports. Unfortunately Debian 
seems to be down.

"invalid field in cdb" is the related error code from the drive

and this is most likely a result of this bug:

http://lists.debian.org/debian-user-german/2003/10/msg00058.html

I made the experience with 'Read Full Toc' and "readcd" while trying to
do a clone read. But this is something you will most likely not be able to 
find on the web as the related error is hidden because this is not a mandatory
command in SCSI.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
