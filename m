Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbREOP3c>; Tue, 15 May 2001 11:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262785AbREOP3W>; Tue, 15 May 2001 11:29:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:43170 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262784AbREOP3M>;
	Tue, 15 May 2001 11:29:12 -0400
Date: Tue, 15 May 2001 11:29:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105150803230.1802-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105151112410.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, Linus Torvalds wrote:

> What is the horrible app that does something like this? 

eject(1), for one thing. And yes, it's ugly beyond belief - don't read
without a barfbag. BTW, LILO is not better, to put it _very_ mildly.

> > 	/* Use scsi if possible [scsi, ide-scsi, usb-scsi, ...] */
> > 	if(HAS_FEATURE_SET(fd, "scsi-tape"))
> > 		...
> > 	else if(HAS_FEATURE_SET(fd, "floppy-tape"))
> > 		..
> 
> doesn't look horrible, and I don't see why we couldn't expose the "driver
> name" for any file descriptor. We already do for some: "fstatfs()" is
> largely the same thing on another level.

Well, yes, if you can extract fs type from fstatfs() output. I don't
think that ->s_magic (i.e. ->f_type) is a good way to do that, though.
We have unused space in struct statfs and IMO putting the name there
is a good idea. Has an additional nice property of killing the crap
like switch by magic numbers.

