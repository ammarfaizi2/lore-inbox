Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbREOKNM>; Tue, 15 May 2001 06:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262723AbREOKND>; Tue, 15 May 2001 06:13:03 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37767 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262722AbREOKMy>;
	Tue, 15 May 2001 06:12:54 -0400
Date: Tue, 15 May 2001 06:12:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zbU2-0002IF-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105150556120.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, Alan Cox wrote:

> > Alan, if we are doing that we might as well use saner interface than
> > ioctl(2). In case you've mentioned we don't want "make device SYS$FOO17
> > do special action OP$LOUD$BARF4269". We want "make device rewind the tape".
> > Or "tell us geometry". Or "eject the media". Application doesn't
> 
> Counter argument; We dont want the bloat of making a floppy tape have
> delusions of grandeur in kernel space when mt-st can do it in userspace.

Cost of adding IOCTL_REWIND_TAPE - two words in each tape driver. That
alone kills a bunch of crap in userland and makes _both_ sides more
maintainable.

Idea that ioctls belong to drivers is bogus. Some of them do, but that's
exactly the case when it's something deeply specific to the driver. As
in "make the printer puke on the top of next page". And even that might be
better off as IOCTL_LART.

IOW, even if we stay with ioctl(2) every place where we do the "if scsi tape
... else if floppy tape ..." is bogus.

