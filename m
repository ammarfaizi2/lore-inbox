Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbTEHNYd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbTEHNYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:24:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:672 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261548AbTEHNYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:24:25 -0400
Date: Thu, 8 May 2003 15:37:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030508133702.GC823@suse.de>
References: <20030508132314.GZ823@suse.de> <Pine.SOL.4.30.0305081532170.12362-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0305081532170.12362-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> On Thu, 8 May 2003, Jens Axboe wrote:
> > On Thu, May 08 2003, Bartlomiej Zolnierkiewicz wrote:
> > >
> > > On Thu, 8 May 2003, Jens Axboe wrote:
> > >
> > > > n Thu, May 08 2003, Bartlomiej Zolnierkiewicz wrote:
> > > > > 	if (!hwif->rqsize)
> > > > > 		hwif->rqsize = hwif->addressing ? 65536 : 256;
> > > >
> > > > btw, you didn't get this right this time either :-)
> > >
> > > It is right.
> > > hwif->addressing means hwif supports 48-bit
> >
> > No it doesn't, that's what I keep saying:
> >
> > static int probe_lba_addressing (ide_drive_t *drive, int arg)
> > {
> >         drive->addressing =  0;
> >
> >         if (HWIF(drive)->addressing)
> >                 return 0;
> >
> > 	...
> >
> > so if hwif->addressing != 0, you will never allow 48-bit lba on any
> > units on this hardware interface. So the correct logic is:
> >
> > 	hwif->rqsize = hwif->addressing ? 256 : 65536;
> >
> > as in the patch.
> 
> Yep, you are right, hwif->addressing logic is reversed, what a mess.

Very much so...

> > > Patch still misses pdx202xx_old.c changes :-).
> >
> > Which?
> 
> Checking for taskfile requests.

Ah ok, same thing I complain about futher down :)

> > Ditto, cannot be reliable without the taskfile changes.
> >
> > I won't bother with anything new until the taskfile stuff is in.
> 
> Good decision.

So what's the time frame on that?

-- 
Jens Axboe

