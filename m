Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbTFAPE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 11:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264642AbTFAPE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 11:04:26 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:48086 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S264639AbTFAPEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 11:04:24 -0400
To: Oliver Neukum <oliver@neukum.org>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 with 250Gb disk and insane loads
References: <3EDA0E5D.8080404@pacbell.net>
	<200306011653.47958.oliver@neukum.org>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 01 Jun 2003 17:17:47 +0200
In-Reply-To: <200306011653.47958.oliver@neukum.org>
Message-ID: <87k7c5g738.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Oliver Neukum <oliver@neukum.org> writes:

> Am Sonntag, 1. Juni 2003 16:31 schrieb David Brownell:
> > > I'm trying to nail own a problem here, with my shiny new Maxtor 250Gb
> > > USB 2.0 disk. Under 2.4 (vanilla, latest 21-preX and 21-preX-acY) the
> > > disk will mount and talk nicely. As soon as any load hits it, e.g. a
> > > single cp from my internal CD-ROM to the disk, the mahcine load will
> > > sky-rocket and at some point within a few minuter hang the machine.
> > >
> > > On 2.5 (vanilla and -mm) the load will show as i/o-wait and at some
> > > point hang any access to the drive, but the kernel will go on working.
> >
> > That's a big clue -- nothing in the USB code ever shows up
> > as "i/o wait".  It can't, since USB is usually built as
> > modules and things like io_schedule() are, for some odd
> > reason, never exported for use in modules.  So USB I/O
> > can't use them, and won't show up as "i/o" ... and that
> > load must come from some place other than USB.
> 
> Probably the block layer as it waits for free io slots.
> But that doesn't tell us why the requests are not executed.
> Where is SCSI timeout kicking in?

I'm not seeing any scsi timeouts in the logs.

> Have you tried enabling debugging in storage?

Have it compiled in now, just need to wait abotu an hour for seomthing
to finish before I can boot.

> Could you try on USB1.1 only?
> 

Stuck it in an older machine on USB 1.1 and it foudn the disk fine
(redhat 9, 2.4.20-13.9 kernel on that machine), and ditto result:

19:15:16  up 2 days, 20:23,  4 users,  load average: 6.02, 2.41, 0.89
58 processes: 55 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:   0.2% user   4.0% system   0.0% nice   0.0% iowait  95.8% idle
Mem:   385040k av,  380820k used,    4220k free,       0k shrd,   67368k buff
       224720k active,              69412k inactive
Swap:  521632k av,      80k used,  521552k free                  237452k cached
                                                                                
and generating about 2500 interrupts for the usb controller per 10
seconds and when i finally break it off and give it "sync" it uses
about two minutes with about 4500 per 10 seconds to get it all on
disk. On 2.4 the machine becomes more and more sluggish if I let it go
more than a short minute.

> 	Regards
> 		Oliver
> 

mvh,
A

- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+2hkXCQ1pa+gRoggRAuSRAKClouXqQkJZYmIN/DxFcoXvXd85yACghtTu
FaQRm6d9wqy4OxOpDG9zmWg=
=cFZM
-----END PGP SIGNATURE-----
