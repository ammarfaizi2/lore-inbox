Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbREOTjF>; Tue, 15 May 2001 15:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbREOTiz>; Tue, 15 May 2001 15:38:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:3846 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261306AbREOTif>; Tue, 15 May 2001 15:38:35 -0400
Message-ID: <3B018587.ACE8BC12@transmeta.com>
Date: Tue, 15 May 2001 12:37:43 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zb68-0002Fq-00@the-village.bc.nu>
		<Pine.LNX.4.21.0105150803230.1802-100000@penguin.transmeta.com>
		<20010515200202.A754@nightmaster.csn.tu-chemnitz.de> <200105151931.f4FJVL830847@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Ingo Oeser writes:
> > On Tue, May 15, 2001 at 08:10:29AM -0700, Linus Torvalds wrote:
> > > and I don't see why we couldn't expose the "driver
> > > name" for any file descriptor.
> >
> > Because we dont like to replace:
> >
> >    if (st.device == MAJOR_1)
> >       bla
> >    else if ...
> >
> > with
> >
> >    if (!strcmp(st.device,"driver_1") )
> >       bla
> >    else if ...
> >
> > ?
> >
> > There is no win doing it this way, because every time we add a
> > new driver that fits or change the name of one, we need add
> > support for it.
> 
> Now look at how we can already do these things with devfs. Let's say
> I've opened /dev/cdroms/cdrom0 and it's sitting on fd=3.
> % ls -lF /proc/self/fd/3
> lrwx------   1 root     root           64 May 15 13:24 /proc/self/fd/3 -> /dev/ide/host0/bus0/target1/lun0/cd
> 
> So, in my application I do:
>         len = readlink ("/proc/self/3", buffer, buflen);
>         if (strcmp (buffer + len - 2, "cd") != 0) {
>                 fprintf (stderr, "Not a CD-ROM! Bugger off.\n");
>                 exit (1);
>         }
>         if (strncmp (buffer, "/dev/ide", 8) == 0) do_ide (fd);
>         else if (strncmp (buffer, "/dev/scsi", 9) == 0) do_scsi (fd);
>         else do_generic (fd);
> 
> That's a lot cleaner than relying on magic numbers, IMNSHO.
> 

You know, Richard, this was an example on what *NOT* to do!

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
