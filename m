Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269009AbUHMGI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269009AbUHMGI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 02:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUHMGI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 02:08:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20183 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264903AbUHMGIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 02:08:52 -0400
Date: Fri, 13 Aug 2004 08:08:12 +0200
From: Jens Axboe <axboe@suse.de>
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040813060809.GA10450@suse.de>
References: <20040812185302.GA18126@suse.de> <Pine.LNX.4.44.0408130433350.22953-100000@hubble.stokkie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408130433350.22953-100000@hubble.stokkie.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13 2004, Robert M. Stockmann wrote:
> On Thu, 12 Aug 2004, Jens Axboe wrote:
> 
> > On Thu, Aug 12 2004, Robert M. Stockmann wrote:
> > > On Thu, 12 Aug 2004, Jens Axboe wrote:
> > > 
> > > > On Thu, Aug 12 2004, Robert M. Stockmann wrote:
> > > > > On Thu, 12 Aug 2004, Jens Axboe wrote:
> > > > > 
> > > > > > On Thu, Aug 12 2004, Robert M. Stockmann wrote:
> > > > > > > On Thu, 12 Aug 2004, Frank Steiner wrote:
> > > > > > > 
> > > > > > > > Robert M. Stockmann wrote:
> > > > > > > > 
> > > > > > > > > i must agree here that getting cdrecord/cdrtools-2.0x going on the latest
> > > > > > > > > SuSE 9.x editions has been extremely tiresome. 
> > > > > > > > 
> > > > > > > > Because of what? We are running the cdrecord versions that SuSE
> > > > > > > > shipped with 9.0 and 9.1, and there hasn't been a single problem
> > > > > > > > for over 8 months now with three different cd and dvd burners.
> > > > > > > > So where's the problem?
> > > > > > > 
> > > > > > > I posted this on comp.os.linux.advocacy some time ago :
> > > > > > > 
> > > > > > > "SuSE 9.1 : i'm not impressed, its a drama"
> > > > > > > http://groups.google.com/groups?as_umsgid=pan.2004.07.03.05.05.30.79714@stokkie.net
> > > > > > > 
> > > > > > > There's a small typo inside and that is that :
> > > > > > > 
> > > > > > > "Not only did the suse9.1 kernel 2.4.5 ..
> > > > > > > 
> > > > > > > should read
> > > > > > > 
> > > > > > > "Not only did the suse9.1 kernel 2.6.5 ..
> > > > > > 
> > > > > > If you had bothered to read this thread, you'd know that you are the one
> > > > > > doing something wrong - cdrecord ATAPI driver should not be used, it
> > > > > > does not support DMA in earlier 2.6 (or 2.4) kernels. Use ATA.
> > > > > 
> > > > > 
> > > > > Ok thank you for the swift reply..
> > > > > 
> > > > > To be honest, the default 2.6.5 kernel from SuSE 9.1 fails anyway to
> > > > > switch on DMA on my used DVD-burner. Maybe you can give an advice
> > > > > which kernel upgrade to install on SuSE 9.1, in order to get DMA for
> > > > > high-speed DVD Burners switched on anyway.
> > > > 
> > > > Send me the dmesg from the booted system.
> > > > 
> > > > > Allthough i have heard other people say to use the dev=ATAPI device names, i
> > > > > surely will test the above, but then replacing ATAPI with ATA. If this will
> > > > > improve performance and stability dramaticly i don't know. However when
> > > > > comparing ATAPI to the ATA mechanism :
> > > > > ( http://crashrecovery.org/oss-dvd/HOWTO-ossdvd.html )
> > > > 
> > > > It will, it's much better.
> > > > 
> > > > > method B:
> > > > > ATA Packet specific SCSI transport omitting linux sg transport
> > > > > thus using : # cdrecord dev=ATAPI ...
> > > > >   Warning: Using ATA Packet interface.
> > > > >    Warning: The related libscg interface code is in pre alpha.
> > > > >    Warning: There may be fatal problems.
> > > > >    Using libscg version 'schily-0.8'.
> > > > > 
> > > > > method C:
> > > > > ATA Packet specific SCSI transport using scsi-linux-sg interface:
> > > > > thus using : # cdrecord dev=ATA ..
> > > > >    Warning: Using badly designed ATAPI via /dev/hd* interface.
> > > > >    Linux sg driver version: 3.5.27
> > > > >    Using libscg version 'schily-0.8'.
> > > > >    cdrecord: Warning: using inofficial libscg transport code version (schily -
> > > > >    Red Hat-scsi-linux-sg.c-1.80-RH '@(#)scsi-linux-sg.c        1.80 04/03/08
> > > > >    Copyright 1997 J. Schilling').
> > > > > 
> > > > > Nothing tells me here that method C is superior to method B :) I tested the
> > > > > above already on mandrake 10.0, and with both methods i could succesfully read
> > > > > and burn a dvd iso. For SuSE 9.1 I indeed only tested method B. I stopped of
> > > > > course, because SuSE 9.1 failed bitterly. So some results are due.
> > > > 
> > > > You are specifying a specific driver, it wont tell you that it's a bad
> > > > choice. You should know better. Don't specify a driver and it'll chose
> > > > the right one.
> > > 
> > > I might as well start burning on Win XP, sorry...
> > 
> > What does that have to do with it? You complain that it doesn't use DMA
> > when you force the ATAPI driver, that's about as close to 'doctor it
> > hurts' as it gets. Don't do that, then. If you specify a driver, you
> > should know what you are doing. That cdrecord should _not_ include the
> > sucky ATAPI driver is a different matter, one that I have no influence
> > over.
> > 
> > Default should work ok, which it does.
> > 
> Now listen up Jens, i don't do default, i like to know what went
> wrong. And if you don't change your tone, your SuSE company of 
> grundliche engineerung, should certainly know more about this also.

So read the thread, it's been explained there several times. It's how
the whole thread started.

The case in a nutshell is that you say you use force for ATAPI driver
and burning runs slow because it doesn't use DMA. So I tell you that you
should not use the ATAPI driver, exactly _because it doesn't use DMA_. I
go on to say that if you don't know what you are doing, why are you
forcing the ATAPI driver? So now you tell me you don't do default, what
on earth does that mean? You're to elite to use the default? If you
force something else than the default you're expected to know what you
are doing, end of story.

And read up on netiquette, it's bad style to cc a public list on a
private mail. I find nothing in the above mail that's insulting to you
from my side, all I see is that you are refusing to listen to why you
had problems with DMA burning.

-- 
Jens Axboe

