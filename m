Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133019AbRECT0w>; Thu, 3 May 2001 15:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133024AbRECT0j>; Thu, 3 May 2001 15:26:39 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:10500 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S133009AbRECT0G>;
	Thu, 3 May 2001 15:26:06 -0400
Message-ID: <20010502230357.A9507@bug.ucw.cz>
Date: Wed, 2 May 2001 23:03:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: Doug Ledford <dledford@redhat.com>,
        Max TenEyck Woodbury <mtew@cds.duke.edu>
Cc: Eric.Ayers@intec-telecom-systems.com,
        James Bottomley <James.Bottomley@steeleye.com>,
        "Roets, Chris" <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi
In-Reply-To: <200105011445.KAA01117@localhost.localdomain> <3AEEDFFC.409D8271@redhat.com> <15086.60620.745722.345084@gargle.gargle.HOWL> <3AF025AE.511064F3@redhat.com> <3AF04648.73F5BFCE@cds.duke.edu> <3AF0483C.49C8CF90@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3AF0483C.49C8CF90@redhat.com>; from Doug Ledford on Wed, May 02, 2001 at 01:47:40PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > ...
> > >
> > > If told to hold a reservation, then resend your reservation request once every
> > > 2 seconds (this actually has very minimal CPU/BUS usage and isn't as big a
> > > deal as requesting a reservation every 2 seconds might sound).  The first time
> > > the reservation is refused, consider the reservation stolen by another machine
> > > and exit (or optionally, reboot).
> > 
> > Umm. Reboot? What do you think this is? Windoze?
> 
> It's the *only* way to guarantee that the drive is never touched by more than
> one machine at a time (notice, I've not been talking about a shared use drive,
> only one machine in the cluster "owns" the drive at a time, and it isn't for
> single transactions that it owns the drive, it owns the drive for as long as
> it is alive, this is a limitation of the filesystes currently available in
> mainstream kernels).  The reservation conflict and subsequent reboot also
> *only* happens when a reservation has been forcefully stolen from a
>machine. 

I do not believe reboot from kernel is right approach. Tell init with
special signal, maybe; but do not reboot forcefully. This is policy;
doing reboot might be right answer in 90% cases; that does not mean
you should do it always.

How is "reservation error" different from any other error? What if
drive generates reservation error by mistake?

I believe drive should be considered dead until reboot after
"reservation error". That way you do not damage data by default, and
provide user option with doing whatever is appropriate.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
