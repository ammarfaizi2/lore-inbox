Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268951AbUHMCkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268951AbUHMCkD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 22:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268956AbUHMCkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 22:40:03 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:46003 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S268951AbUHMCjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 22:39:49 -0400
Date: Fri, 13 Aug 2004 04:39:46 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <20040812185302.GA18126@suse.de>
Message-ID: <Pine.LNX.4.44.0408130433350.22953-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, Jens Axboe wrote:

> On Thu, Aug 12 2004, Robert M. Stockmann wrote:
> > On Thu, 12 Aug 2004, Jens Axboe wrote:
> > 
> > > On Thu, Aug 12 2004, Robert M. Stockmann wrote:
> > > > On Thu, 12 Aug 2004, Jens Axboe wrote:
> > > > 
> > > > > On Thu, Aug 12 2004, Robert M. Stockmann wrote:
> > > > > > On Thu, 12 Aug 2004, Frank Steiner wrote:
> > > > > > 
> > > > > > > Robert M. Stockmann wrote:
> > > > > > > 
> > > > > > > > i must agree here that getting cdrecord/cdrtools-2.0x going on the latest
> > > > > > > > SuSE 9.x editions has been extremely tiresome. 
> > > > > > > 
> > > > > > > Because of what? We are running the cdrecord versions that SuSE
> > > > > > > shipped with 9.0 and 9.1, and there hasn't been a single problem
> > > > > > > for over 8 months now with three different cd and dvd burners.
> > > > > > > So where's the problem?
> > > > > > 
> > > > > > I posted this on comp.os.linux.advocacy some time ago :
> > > > > > 
> > > > > > "SuSE 9.1 : i'm not impressed, its a drama"
> > > > > > http://groups.google.com/groups?as_umsgid=pan.2004.07.03.05.05.30.79714@stokkie.net
> > > > > > 
> > > > > > There's a small typo inside and that is that :
> > > > > > 
> > > > > > "Not only did the suse9.1 kernel 2.4.5 ..
> > > > > > 
> > > > > > should read
> > > > > > 
> > > > > > "Not only did the suse9.1 kernel 2.6.5 ..
> > > > > 
> > > > > If you had bothered to read this thread, you'd know that you are the one
> > > > > doing something wrong - cdrecord ATAPI driver should not be used, it
> > > > > does not support DMA in earlier 2.6 (or 2.4) kernels. Use ATA.
> > > > 
> > > > 
> > > > Ok thank you for the swift reply..
> > > > 
> > > > To be honest, the default 2.6.5 kernel from SuSE 9.1 fails anyway to
> > > > switch on DMA on my used DVD-burner. Maybe you can give an advice
> > > > which kernel upgrade to install on SuSE 9.1, in order to get DMA for
> > > > high-speed DVD Burners switched on anyway.
> > > 
> > > Send me the dmesg from the booted system.
> > > 
> > > > Allthough i have heard other people say to use the dev=ATAPI device names, i
> > > > surely will test the above, but then replacing ATAPI with ATA. If this will
> > > > improve performance and stability dramaticly i don't know. However when
> > > > comparing ATAPI to the ATA mechanism :
> > > > ( http://crashrecovery.org/oss-dvd/HOWTO-ossdvd.html )
> > > 
> > > It will, it's much better.
> > > 
> > > > method B:
> > > > ATA Packet specific SCSI transport omitting linux sg transport
> > > > thus using : # cdrecord dev=ATAPI ...
> > > >   Warning: Using ATA Packet interface.
> > > >    Warning: The related libscg interface code is in pre alpha.
> > > >    Warning: There may be fatal problems.
> > > >    Using libscg version 'schily-0.8'.
> > > > 
> > > > method C:
> > > > ATA Packet specific SCSI transport using scsi-linux-sg interface:
> > > > thus using : # cdrecord dev=ATA ..
> > > >    Warning: Using badly designed ATAPI via /dev/hd* interface.
> > > >    Linux sg driver version: 3.5.27
> > > >    Using libscg version 'schily-0.8'.
> > > >    cdrecord: Warning: using inofficial libscg transport code version (schily -
> > > >    Red Hat-scsi-linux-sg.c-1.80-RH '@(#)scsi-linux-sg.c        1.80 04/03/08
> > > >    Copyright 1997 J. Schilling').
> > > > 
> > > > Nothing tells me here that method C is superior to method B :) I tested the
> > > > above already on mandrake 10.0, and with both methods i could succesfully read
> > > > and burn a dvd iso. For SuSE 9.1 I indeed only tested method B. I stopped of
> > > > course, because SuSE 9.1 failed bitterly. So some results are due.
> > > 
> > > You are specifying a specific driver, it wont tell you that it's a bad
> > > choice. You should know better. Don't specify a driver and it'll chose
> > > the right one.
> > 
> > I might as well start burning on Win XP, sorry...
> 
> What does that have to do with it? You complain that it doesn't use DMA
> when you force the ATAPI driver, that's about as close to 'doctor it
> hurts' as it gets. Don't do that, then. If you specify a driver, you
> should know what you are doing. That cdrecord should _not_ include the
> sucky ATAPI driver is a different matter, one that I have no influence
> over.
> 
> Default should work ok, which it does.
> 
Now listen up Jens, i don't do default, i like to know what went
wrong. And if you don't change your tone, your SuSE company of 
grundliche engineerung, should certainly know more about this also.

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

