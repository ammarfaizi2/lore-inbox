Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUBEV32 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266863AbUBEV3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:29:04 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:14720 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266883AbUBEV11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:27:27 -0500
Date: Thu, 5 Feb 2004 21:36:50 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402052136.i15LaoGw000342@81-2-122-30.bradfords.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Jens Axboe <axboe@suse.de>, Tomas Zvala <tomas@zvala.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040205210623.GA1541@elf.ucw.cz>
References: <20040203131837.GF3967@aurora.fi.muni.cz>
 <Pine.LNX.4.53.0402030839380.31203@chaos>
 <401FB78A.5010902@zvala.cz>
 <20040203152805.GI11683@suse.de>
 <20040205182335.GB294@elf.ucw.cz>
 <200402052004.i15K4Bqx000266@81-2-122-30.bradfords.org.uk>
 <20040205210623.GA1541@elf.ucw.cz>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Pavel Machek <pavel@suse.cz>:
> Hi!
> 
> > > mount
> > > umount
> > > cdrecord -blank
> > > mount
> > > see old data
> > > 
> > > That looks pretty bad. If there's no other solution, we might just
> > > document it, but...
> > 
> > I think cdrecord should be hacked to complain loudly if the device is
> > already mounted.  Regardless of the device cache not being cleared,
> > (which is a firmware bug, in my opinion), blanking a mounted device is
> > usually not what the user intended.  This is not a kernel problem as
> > such, and should be dealt with in userspace.
> 
> But it is _not_ mounted at that point. User did no mistake.

OK, then this proves that this thread has been going on _way_ too
long, because not only have we discussed both scenarios during the
course of it, but I have managed to confuse both of them in the same
post :-).

In the scenario you describe, where the disc is unmounted, there is
nothing for cdrecord to complain about.  All that could really be done
is to hack cdrecord to reset the device afterwards for broken devices,
which would presumably flush the device's own cache.  However, even
this may not be sufficient, as from reading another post in this
thread, it seems that we need to force the drive to report that the
media has changed before the kernel will flush _it's_ buffers.

Obviously, that could be worked around in the kernel, but I would
expect the device to report media changed if it's been erased,
(although whether that is part of the spec or not, I have no idea).

John.
