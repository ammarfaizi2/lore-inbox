Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267014AbUBEXbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267053AbUBEXbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:31:24 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:1713 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id S267014AbUBEXbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:31:21 -0500
Date: Fri, 6 Feb 2004 00:31:13 +0100
From: Eduard Bloch <edi@gmx.de>
To: John Bradford <john@grabjohn.com>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       alan@redhat.com
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040205233113.GA10254@zombie.inka.de>
References: <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk> <yw1xsmhsf882.fsf@kth.se> <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk> <20040203174606.GG3967@aurora.fi.muni.cz> <200402031853.i13Ir1e0003202@81-2-122-30.bradfords.org.uk> <yw1xn080m1d2.fsf@kth.se> <Pine.LNX.4.53.0402031509100.32547@chaos> <20040203224021.GK11683@suse.de> <1075849526.11322.9.camel@nosferatu.lan> <200402040737.i147bJqq000455@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402040737.i147bJqq000455@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moin John!
John Bradford schrieb am Wednesday, den 04. February 2004:

> > > This whole discussion is silly and pointless.
> > 
> > I am assuming its cdrecord's responsibility to check if the device is
> > not in use?  How difficult will it be to add a kernel side stopper to
> > this (as it will after all also stop this thread) ?
> 
> The problem you are discussing now is completely different to what we
> were originally discussing, and almost completely pointless.

Yep, the first part (overwritting mounted media) is pointless, the
second IS NOT.

> Of course you get problems if a raw devices changes underneath a
> mounted filesystem, I would expect that.  That is _NOT_ what we were
> talking about _AT ALL_.  The point is that the device itself caches
> the state of the disc over an erase, so even if the device is
> unmounted before an erase, when it is re-mounted, the stale data is
> read from the device's own cache, which should have been invalidated
> by the erase.

Is it realy a hardware issue? We have a very similar bug in the Debian
BTS (ping-pong issue between kernel and cdrtools maintainers). The
problem there is: 

 you have a session
 you umount the iso9660 there
 you write a second session
 you mount the media without ejecting it
 AND you see the OLD filesystem. And it is large, IMHO this does NOT
 come from the cache. I think there is an ugly bug in kernel's CDROM
 TOC/session management, it caches the TOC data and does not invalidate
 it on mount calls.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=93633

Oh, and it is very simple to shout on anyone "Just eject and reload,
there is no issue, everything pointless".

This sucks. It is not a solution, it is a an admited failure. In
most notebooks, the media cannot be reloaded, and in normal PC boxes
with closed front door, you always risk mechanical damage if the door is
closed and you did not notice it.

Regards,
Eduard.
-- 
Du wirst in einer Onlinedatenbank alles finden, nur nicht das, was du suchst.
