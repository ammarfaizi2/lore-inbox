Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275893AbSIULPi>; Sat, 21 Sep 2002 07:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275898AbSIULPi>; Sat, 21 Sep 2002 07:15:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38157 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S275893AbSIULPh>; Sat, 21 Sep 2002 07:15:37 -0400
Date: Sat, 21 Sep 2002 12:20:41 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux Hardened Device Drivers Project
Message-ID: <20020921122041.A27150@flint.arm.linux.org.uk>
References: <Pine.LNX.4.10.10209201753310.25090-100000@master.linux-ide.org> <E17shi3-00083J-00@sites.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17shi3-00083J-00@sites.inka.de>; from ecki-news2002-09@lina.inka.de on Sat, Sep 21, 2002 at 12:41:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 12:41:59PM +0200, Bernd Eckenfels wrote:
> In article <Pine.LNX.4.10.10209201753310.25090-100000@master.linux-ide.org> you wrote:
> > Regardless, it takes (fill in the blank) to boldly ask people to add APIs
> > for an industry who is only interested in using and not contributing.
> 
> There is more than one industry interested in it. It simply sucks if your
> kernel panic only because you remove a SCSI cable. IT also sucks if your
> kernel panics only vecause you have a bad block on a Disk.

Both of which I'd classify as bugs.  I recently submitted a few patches
that fix some of the idiotic or bad error handling in the 2.4 SCSI
layer.  Although they didn't completely fix some of the problems, it
did highlight some of the problem areas.

> On the other hand, the reason this has not
> happend just shows us, that it is not trivial to find a second person which
> understands hardware's error behaviour.

Or people with broken hardware don't report that the error paths are
broken; they just fix their hardware.

I have a Syquest 270MB drive here.  Bought from new, but it has never
worked 100% properly.  It mostly complains about media errors and the
like.  After several rounds with Syquest, I lost faith in it.  However,
I still have it.  Why?

I keep test filesystems on the cartridges.  Perfect when I want to run
some tests that could well take out a filesystem, or when I want to test
out the SCSI error handling.  That's how I found that the 2.4 SCSI error
handling code has the possibility to eat disks alive when it encounters
an error.

Would extra API's have helped find this?  Would it have made the driver
more stable?  Would it have caught the bug in my SCSI driver that caused
it not to request sense on error and therefore throw the SCSI subsystem
into a never-ending loop?  The answers are: no, no, no.

Would testing with broken hardware have found this?  Would it make the
driver more stable?  Yes, and yes.

IMO, driver stability comes with testing and review by people who know
both the hardware _and_ who know the kernel API inside out.  There seems
to be a lack the latter, and a lack of people with broken hardware for
the former.

So next time when your hard disk develops media errors, or your network
card starts corrupting data, think about whether it would be a useful
test device to someone.  (Obviously not if its completely 100% dead.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

