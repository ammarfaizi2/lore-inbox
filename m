Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275108AbTHGCb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 22:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275109AbTHGCb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 22:31:28 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12541 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S275108AbTHGCb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 22:31:26 -0400
Date: Thu, 7 Aug 2003 04:31:08 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Erik Andersen <andersen@codepoet.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
In-Reply-To: <20030807011146.GB5454@win.tue.nl>
Message-ID: <Pine.SOL.4.30.0308070347540.20650-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Aug 2003, Andries Brouwer wrote:

> On Wed, Aug 06, 2003 at 08:32:23PM +0200, Bartlomiej Zolnierkiewicz wrote:
>
> > diff -puN drivers/ide/ide-disk.c~ide-disk-capacity-init-cleanup drivers/ide/ide-disk.c
> > --- linux-2.6.0-test2-bk5/drivers/ide/ide-disk.c~ide-disk-capacity-init-cleanup	2003-08-06 02:48:33.000000000 +0200
>
> Ha - and you didnt even tell me you had this patch out.

:-)

> Looks good.
> You forgot to correct the do_div.

Yep, Erik noticed this already.

> The part I most object to are things like
>
> > +	id->lba_capacity_2 = capacity_2 = set_max_ext;
>
> There have been many problems in the past, and it is a bad idea to add
> more of this. We should be eliminating all cases.

What problems?  This reflects real change in drive's identify
and I think should be replaced by rereading drive->id from a drive.

> I mean:
>
> We have info from BIOS, user, disk etc and conclude to a certain geometry.

I can't spot place when we get info from a BIOS.
If we get it from a user, user should know what she/he is doing.

We can deal with HPA before our geometry info is set
(by moving code that is in idedisk_setup() right before call to
init_idedisk_capacity()).

> Sneakily changing what the disk reported is very ugly. I recall a case
> where a disk bounced between two capacities because the value that this
> computation concluded to was not a fixed point. Also, the user gets an
> incorrect report from HDIO_GET_IDENTITY.

User gets correct report from HDIO_GET_IDENTIFY as drive's identify was
really changed.  Moreover HDIO_GET_IDENTIFY needs fixing to actually
reread drive->id from a drive (similarly like /proc identify was fixed).

> So, the clean way is to examine what the disk reported, never change it

Even if disk's info changes?  I don't think so.
--
Bartlomiej

