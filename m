Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262773AbREOPLm>; Tue, 15 May 2001 11:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262774AbREOPLb>; Tue, 15 May 2001 11:11:31 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:40970 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262773AbREOPLV>; Tue, 15 May 2001 11:11:21 -0400
Date: Tue, 15 May 2001 08:10:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Neil Brown <neilb@cse.unsw.edu.au>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zb68-0002Fq-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105150803230.1802-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Alan Cox wrote:
> 
> Given a file handle 'X' how do I find out what ioctl groups I should apply to
> it. So we can go from
> 
> 	if(MAJOR(st.st_rdev) == ST_MAJOR)
> 		issue_scsi_ioctls
> 	else if(MAJOR(st.st_rdev) == FTAPE_MAJOR)
> 		issue_ftape_ioctls
> 	else ..
> 	else
> 		error

Ugh. You do this?

And you don't realize that the whole system is too broken for words?

What is the horrible app that does something like this? 

The fix, I think, is to make the ioctl commands much more regular. That is
probably true in general, and fixing that would hopefully fix the need for
horrible code like the above.

That said:

> 	/* Use scsi if possible [scsi, ide-scsi, usb-scsi, ...] */
> 	if(HAS_FEATURE_SET(fd, "scsi-tape"))
> 		...
> 	else if(HAS_FEATURE_SET(fd, "floppy-tape"))
> 		..

doesn't look horrible, and I don't see why we couldn't expose the "driver
name" for any file descriptor. We already do for some: "fstatfs()" is
largely the same thing on another level.

		Linus

