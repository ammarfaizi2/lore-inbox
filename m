Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312317AbSDEFie>; Fri, 5 Apr 2002 00:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312308AbSDEFiZ>; Fri, 5 Apr 2002 00:38:25 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:27017 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312314AbSDEFiT>; Fri, 5 Apr 2002 00:38:19 -0500
Date: Thu, 4 Apr 2002 22:38:04 -0700
Message-Id: <200204050538.g355c4v02240@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bcrl@redhat.com (Benjamin LaHaise), akpm@zip.com.au (Andrew Morton),
        joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <E16tKI6-0007TJ-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > I find that on heavily scsi systems: one machine spins each of 13 disks 
> > up sequentially.  This makes the initial boot take 3-5 minutes before 
> > init even gets its foot in the door.  If someone made a patch to spin 
> > up scsi disks on the first access, I'd gladly give it a test. ;-)
> 
> Ditto. Especially if it spun them down again when idle for a while. 

Be careful here. I did this for a while with a Maxtor 80 GB IDE drive,
and after a few months, it started making unpleasant noises when
spinning up (lots of clicking and clacking). I went back to continuous
spinning. I'm not in the mood for replacing my drives every few
months :-(

> The scsi layer does several things serially it could parallelise. It
> isnt just disk spin up its also things like initialising all scsi
> controllers in parallel.

Indeed. However, the business of spin-up should be handled either in
the SCSI BIOS extension, or better yet, using auto-start delay. If the
kernel spins up all drives in parallel, in effect that means they all
spin up at the same time. Which in turn means that you have a large
current spike as all the motors start up, stressing the power supply
and possibly blowing your circuit breaker as 10 machines all come on
after the blackout...

Not spinning up at power on is supposed to avoid this very problem. So
spinning up in parallel might not be a brilliant idea. But if we could
put a few seconds between each spin-up command, that would make sense.

Still, auto-start delay is the best, IMO. 6*ID seconds after power up,
a drives spins up (ID is the SCSI ID). By the time you've finished the
BIOS memory test, most/all of your drives have been spun up.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
