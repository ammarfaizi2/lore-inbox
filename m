Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbREOTcF>; Tue, 15 May 2001 15:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261301AbREOTbz>; Tue, 15 May 2001 15:31:55 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:64667 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261295AbREOTbj>; Tue, 15 May 2001 15:31:39 -0400
Date: Tue, 15 May 2001 13:31:21 -0600
Message-Id: <200105151931.f4FJVL830847@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <20010515200202.A754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <E14zb68-0002Fq-00@the-village.bc.nu>
	<Pine.LNX.4.21.0105150803230.1802-100000@penguin.transmeta.com>
	<20010515200202.A754@nightmaster.csn.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser writes:
> On Tue, May 15, 2001 at 08:10:29AM -0700, Linus Torvalds wrote:
> > and I don't see why we couldn't expose the "driver
> > name" for any file descriptor.
> 
> Because we dont like to replace:
> 
>    if (st.device == MAJOR_1)
>       bla
>    else if ...
> 
> with
> 
>    if (!strcmp(st.device,"driver_1") )
>       bla
>    else if ...
> 
> ?
> 
> There is no win doing it this way, because every time we add a
> new driver that fits or change the name of one, we need add
> support for it.

Now look at how we can already do these things with devfs. Let's say
I've opened /dev/cdroms/cdrom0 and it's sitting on fd=3.
% ls -lF /proc/self/fd/3
lrwx------   1 root     root           64 May 15 13:24 /proc/self/fd/3 -> /dev/ide/host0/bus0/target1/lun0/cd

So, in my application I do:
	len = readlink ("/proc/self/3", buffer, buflen);
	if (strcmp (buffer + len - 2, "cd") != 0) {
		fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
		exit (1);
	}
	if (strncmp (buffer, "/dev/ide", 8) == 0) do_ide (fd);
	else if (strncmp (buffer, "/dev/scsi", 9) == 0) do_scsi (fd);
	else do_generic (fd);

That's a lot cleaner than relying on magic numbers, IMNSHO.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
