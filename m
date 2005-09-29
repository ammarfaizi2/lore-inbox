Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVI2Q2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVI2Q2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVI2Q2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:28:39 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:50848 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932236AbVI2Q2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:28:38 -0400
Date: Thu, 29 Sep 2005 12:28:36 -0400
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writer is burning with open tray
Message-ID: <20050929162836.GA20178@csclub.uwaterloo.ca>
References: <20050929141924.GA6512@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929141924.GA6512@kestrel>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 04:19:24PM +0200, Karel Kulhavy wrote:
> I ran cdrecord -tao dev=ATAPI:0,0,0 speed=8 /home/clock/cdrom.iso on
> 2.6.12-gentoo-r10 and it burned a good CD.
> 
> Then I repeated the same command (press up and enter) and it
> 1) Burned two bad CD's with a strip near the central area
> 2) Third CD burned bad
> 3) When rerun cdrecord says
> cdrecord: Drive does not support TAO recording.
> cdrecord: Illegal write mode for this drive.

Which model cd writer?

It was very common years ago that drives with phillips internals would
crash if you didn't include the --eject option to cdrecord to force it
to eject the disc when done so the drive would reinitialize when
inserting the disc again.  If you didn't you had to reboot the system
before you could burn another cd.  This was quite annoying, so I got
used to include --eject on old hp 2x writers since they used phillips
mechanisms inside.

> I should note here that I didn't hotplug the hardware - I can't
> understand how supported modes can change on the fly...

Firmware tells cdrecord what drive can do.  Garbage firmware produces
garbage output.

> Anyway the activity LED is now flashing (later shining) even when
> cdrecord is not running and I open the tray using emergency open
> (it cannot be opened by normal open). /dev/hdc (the CDROM) is not mounted.
> The mechanics inside is quite heated up.
> 
> The activity LED is flashing or shining even when the mechanics is open
> and I can look into the laser lens!  However I didn't see any dim red
> light - looks like the laser switches off when the tray is open.
> 
> Is it possible to get eye damage due to faulty kernel driver?

If you hit the emergency eject hole, you actually disengage the tray
from the tray motor.  The reason it won't open is that cd drives LOCK
the tray (by disableing the eject button) when they are busy, such as
when they are burning a cd, or the cd is mounted.  If you had managed to
get the cdwriter to finish burning (or it hadn't crashes itself) it
would have allowed you to open it.  Rebooting the machine would also
reset the drive and allow you to open it.  You should never need to use
the emergency eject option unless you have a power failure and need a
disc out badly, or the drive is broken and no longer installed in a
machine and you need a disc removed from it.  It should not be used
while the drive is powered.

> Is it possible to destroy the mechanics by overheating or mechanical
> damage due to faulty kernel driver?

Badly designed hardware may allow itself to be damaged by faulty
firmware and its interaction with applications.

> Is this intended behaviour of Linux kernel?

I didn't see anything that indicates the linux kernel did anything
wrong.  It passed data between cdrecord and your drive.  If they don't
like each other and the drive crashes, then the drive has crap for
firmware.  Go buy a better drive or get updated firmware.  I use
plextors and am very happy with them.

Your whole problem sounds like you have a drive with major firmware
bugs.

Len Sorensen
