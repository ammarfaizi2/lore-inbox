Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265025AbUF1PfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbUF1PfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265033AbUF1PfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:35:18 -0400
Received: from chnmfw01.eth.net ([202.9.145.21]:45839 "EHLO ETH.NET")
	by vger.kernel.org with ESMTP id S265025AbUF1PfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:35:04 -0400
Message-ID: <001c01c45d25$833358d0$118309ca@home>
From: "Amit Gud" <gud@eth.net>
To: "Lionel Bouton" <Lionel.Bouton@inet6.fr>, "V13" <v13@priest.com>
Cc: <linux-kernel@vger.kernel.org>
References: <20040624213041.GA20649@elf.ucw.cz> <20040624220318.GE20649@elf.ucw.cz> <40DBD9AD.8070503@inet6.fr> <200406272118.23510.v13@priest.com> <40DF231F.6090608@inet6.fr>
Subject: Re: Elastic Quota File System (EQFS)
Date: Mon, 28 Jun 2004 21:04:23 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 28 Jun 2004 15:27:15.0984 (UTC) FILETIME=[6484B100:01C45D24]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lionel Bouton wrote:

> V13 wrote the following on 06/27/2004 08:18 PM :
>
> >On Friday 25 June 2004 10:52, Lionel Bouton wrote:
> >
> >
> >>Pavel Machek wrote the following on 06/25/2004 12:03 AM :
> >>
> >>
> >>>Of course, if mozilla marked them "elastic" it should better be
> >>>prepared for they disappearance. I'd disappear them with simple
> >>>unlink(), so they'd physically survive as long as someone held them
> >>>open.
> >>>
> >>>
> >>Doesn't work reliably : the deletion is done in order to reclaim space
> >>that is needed now. You may want to retry unlinking files until you
> >>reach the free space needed, but this is clearly a receipe for famine :
> >>process can wait on writes an unspecified amount of time.
> >>
> >>
> >
> >This could be solved like OOM by killing all related processes.
> >
> >
>
> I don't want to see mozilla shut down because it was filling a cache
> file during a big download...
>
> Note :
> In practice I don't see it as a real problem with good-manered
> applications : as we are speaking of mutualised storage space,
> statistically the system should find files to remove unless it is
> burried under open filedescriptors for elastic files. But this is not
> really robust : a very simple DoS against this is to allocate all the
> available storage space in elastic files and maintain the
> filedescriptors open.
>
> To continue on the "kill process" subject : I think making aware the
> process of the problem is much more sane. I'd really like mozilla to
> tell me : "Sorry, my download cannot continue, the system removed the
> download file in order to free some disk space".
> IMHO one way to make this work *reliably* is to allow the fs to remove
> the files from disk directly and not simply unlink them and wait for the
> last fd to be closed. The fs must then return an EBADF (I don't know if
> a new error code tailored for this case is affordable) for subsequent
> read/writes and applications using elastic files must be written to
> gracefully recover from this.
> It seems much more logical to me to make applications aware of the
> exotic nature of elastic files and handle the associated behavior.
> Conceptually elastic files seem different enough from regular files that
> you would want to handle them separately at the application level. In
> fact I believe elastic files should be created by elastic aware
> applications and not by adventurous users/admins. For example I'd really
> prefer mozilla to choose to create elastic files when configured to do
> so and not have an admin make a chattr on the cache directory...
>

Right. For the moment its safe enough to allow only elastic-aware
applications to
create the elastic files. A new error code would ceratinly be helpful here.
Here we do take away user control of stating which files he don't want in
case the threshold is reached, but this would definately cause other
applications work smoothly provided there are no commonly shared files. But
once most applications become elastic-aware, he can comfortably do so. Also
we can even have a flag, something like -elas, in gcc for creating object
files as elastic.

AG






