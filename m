Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262714AbREOJte>; Tue, 15 May 2001 05:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262718AbREOJtX>; Tue, 15 May 2001 05:49:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50408 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262714AbREOJtK>;
	Tue, 15 May 2001 05:49:10 -0400
Date: Tue, 15 May 2001 05:49:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zb68-0002Fq-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105150532150.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, Alan Cox wrote:

> to
> 
> 	/* Use scsi if possible [scsi, ide-scsi, usb-scsi, ...] */
> 	if(HAS_FEATURE_SET(fd, "scsi-tape"))
> 		...
> 	else if(HAS_FEATURE_SET(fd, "floppy-tape"))
> 		..

Alan, if we are doing that we might as well use saner interface than
ioctl(2). In case you've mentioned we don't want "make device SYS$FOO17
do special action OP$LOUD$BARF4269". We want "make device rewind the tape".
Or "tell us geometry". Or "eject the media". Application doesn't
_care_ whether it is ejecting floppy on Sun or IDE CD, or SCSI
CD or ZIP disk sitting on parallel port. The fact that currently it
has to know is a Bad Thing(tm).

At the very least we need ioctls sorted by function, not by device.

