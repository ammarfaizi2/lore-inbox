Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbTDETqF (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 14:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbTDETqF (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 14:46:05 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:37392
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262637AbTDETqB (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 14:46:01 -0500
Date: Sat, 5 Apr 2003 11:52:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Mudama, Eric" <eric_mudama@maxtor.com>
cc: "'Chuck Ebbert '" <76306.1226@compuserve.com>,
       "'linux-kernel '" <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: Fixes for ide-disk.c
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D066@mcoexc04.mlm.maxtor.com>
Message-ID: <Pine.LNX.4.10.10304051146440.29290-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Eric,

Ask Leroy in Longmont how it should behave.

6-10 seconds is a nice idea, the reality as we both know it is up to 30
seconds to return because of OOB seeks to write on reallocations.

FLUSH CACHE/FLUSH CACHE EXT ...

If you have a drive that is not larger than 28-bit in geometry regardless
if it supports the 48-bit feature set, if it fails to comply with 28-bit
flush cache it is a "BAD DEVICE", period.  You will not be allowed to push
off the 48-bit feature set rules.  Regardless if the new smart data is
set the the GPL and not Smart Logs.

If you are suggesting a pole for completion on the FLUSH, say so.
Otherwise, standard non-data INTQ completion is default.

Cheers,

On Sat, 5 Apr 2003, Mudama, Eric wrote:

> 
> If you guys see a problem with how the bits are set on a Maxtor drive,
> please let me know so I can fix them.
> 
> If you try to spin down, the drive shouldn't allow that to happen with dirty
> write data, period.
> 
> To ensure the cache is flushed, you must issue FLUSH CACHE (EXT).  That is
> the only "according to spec" method.  I know of other things you can do (on
> a Maxtor drive) that have cache flush as a side effect, but that is the only
> specified way.
> 
> Once the flush cache has returned 0x50 status, there can be no dirty data
> left in the drive.  Note that this FLUSH CACHE can easily take 6-10 seconds
> depending on drive cache size and workload pattern.
> 
>  
> 
> -----Original Message-----
> From: Andre Hedrick
> To: Chuck Ebbert
> Cc: linux-kernel
> Sent: 4/5/03 4:30 AM
> Subject: Re: PATCH: Fixes for ide-disk.c
> 
> 
> If the drive is compliant it will issue an abort if not supported.
> Otherwise one should check the identify page; however, there are several
> cases where the bits are improperly set.  Another double edge sword to
> make the driver more interesting.
> 
> Cheers,
> 
> On Sat, 5 Apr 2003, Chuck Ebbert wrote:
> 
> > 
> > John Bradford wrote:
> > 
> > 
> > >Did we ever establish what the best way to ensure
> > >that the write cache is flushed, is?  An explicit
> > >cache flush and spin down are both necessary, but
> > >I had problems with drives spinning back up when
> > >we did the spindown first.
> > 
> > 
> > Disks that don't support flush should be sent an IDLE command, IIRC.
> > 
> > 
> > 
> > --
> >  Chuck
> >  I am not a number!
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

