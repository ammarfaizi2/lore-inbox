Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263099AbTCLItL>; Wed, 12 Mar 2003 03:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263100AbTCLItL>; Wed, 12 Mar 2003 03:49:11 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13572
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263099AbTCLItK>; Wed, 12 Mar 2003 03:49:10 -0500
Date: Wed, 12 Mar 2003 00:59:48 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: scott thomason <scott-kernel@thomasons.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
In-Reply-To: <20030312084710.GA4816@win.tue.nl>
Message-ID: <Pine.LNX.4.10.10303120058050.391-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well that is the first complete explaination of the 255 limit.
That belongs in a simple dirty drive list in ide-probe.c (or whatever the
latest filename is) and then dump this issue for good.

Cheer,

On Wed, 12 Mar 2003, Andries Brouwer wrote:

> > On Tue, 11 Mar 2003, scott thomason wrote:
> > 
> > > I frequently receive this message in my syslog, apparently 
> > > whenever there are periods of significant write activity:
> > > 
> > >     bio too big device ide0(3,7) (256 > 255)
> > >     bio too big device ide1(22,6) (256 > 255)
> 
> On Tue, Mar 11, 2003 at 09:01:25PM -0800, Andre Hedrick wrote:
> 
> > That has to be a BIO bug or IDE setup bug.
> > 
> > 256 sectors is legal and correct for 28-bit addressing.
> 
> Yes, it is. However, Paul Gortmaker reported on his old 700MB
> Maxtor 7850 AV that would give errors with 256-sector requests
> and work well with 255-sector requests. In a later post he
> added that one has to work hard to evoke this error - usually
> 256-sector requests are fine, but after torturing the disk with
> an hour of simultaneous untar and make, an error occurred.
> 
> Maybe that is the only disk that gives problems.
> 
> Jens replied:
> 
> = The 256 is _not_ a bug in the driver, it's more likely a bug in your
> = drive. 256 is a perfectly legal transfer size. That said, maybe it is
> = a good idea to leave it at 255 just for safety
> 
> So that is how this length was limited.
> 
> In short: 256 is legal, has always been legal, nothing wrong with it.
> But at least one old disk has been discovered that was happier with 255.
> 
> Andries
> 

Andre Hedrick
LAD Storage Consulting Group

