Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263123AbSJBNEH>; Wed, 2 Oct 2002 09:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263124AbSJBNEH>; Wed, 2 Oct 2002 09:04:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:59913 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263123AbSJBNEG>; Wed, 2 Oct 2002 09:04:06 -0400
Date: Wed, 2 Oct 2002 15:09:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Swsusp updates, do not thrash ide disk on suspend
Message-ID: <20021002130933.GA18829@atrey.karlin.mff.cuni.cz>
References: <20021001224740.GA30488@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.10.10210011827551.3976-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10210011827551.3976-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > This cleans up swsusp a little bit and fixes ide disk corruption on
> > > > suspend/resume. Please apply,
> > > 
> > > It also seems to be doing things with the device manager. Mind explaining 
> > > those changes too?
> > 
> > Those are forward port of what we had there already. I make IDE child
> > of PCI device with the controller (in cases its on PCI). That seems
> > logical place for it and we had it like that in 2.5.30 or
> > so. ide-disk.c is there to make disk sleep before we go
> > suspend. Without that, data corruption happens.
> 
> I pointed out to you various other device other than disk support
> DMA, and

Well, if even this patch is hard to push through, how hard would it be
to push patch that touches also cdroms etc?

> moving the suspend point up to the mainloop away from the
> subdrivers.

Are you trying to say that you believe that idedisk_suspend could be
same as idecdrom_suspend and idefloppy_suspend?

> This would insure the entire sub-system is out.  Why are we block
             ~~~~~~ do you mean ensure?
> after
> the request has been sent to the sub-driver?  

We are not block. Certainly *I* am not block ;-). Do you mean "why do
we block"? Which "block" do you have in mind?

> Why do you see this the
> preferred location and not before it enters the system?  Given that you
> have stated it does not parse the difference between S3 v/s S4, I am
> graveful concerned.  

What problem do you have with no difference between S3 and S4?
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
