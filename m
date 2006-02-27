Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWB0V7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWB0V7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWB0V7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:59:30 -0500
Received: from smtp.enter.net ([216.193.128.24]:5643 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932345AbWB0V73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:59:29 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Chris Adams <cmadams@hiwaay.net>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 27 Feb 2006 16:47:48 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <fa.deNPP6WI8uOxYJJt5IRsDHJHqNc@ifi.uio.no> <20060227212141.GA1334769@hiwaay.net>
In-Reply-To: <20060227212141.GA1334769@hiwaay.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602271647.48600.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 16:21, Chris Adams wrote:
> Once upon a time, Bill Davidsen  <davidsen@tmr.com> said:
> >> Which is bad, as it is incomplete and requires the kernel be updated to
> >> know about every format just to document them.
> >
> >Document them where? In the kernel Documentation directory? I believe
> >those strings come back from the drive, as long as the human or
> >application can parse them the kernel operationally needs only what you
> >mentioned below.
>
> I wasn't aware those strings actually came from the devices.  What I
> meant was if that file is to be the documentation of the drive
> capabilities, it needs to be updated to list all known capabilities (and
> be updated promptly when new capabilities are created).  It currently
> has many missing formats.

No, the strings do not come from the drive. Those capabilities, IIRC, are 
presented as a series of bitflags packed into a 32 bit integer. This is 
described in the MMC spec for the "capabilities mode page". The drive _does_ 
supply the information as to what formats it understands, but in this case 
the kernel translates it into a human readable format.

> >> - What is "drive speed" (no units); also most drives do different speeds
> >>   for different modes/media.
> >
> >Presumably the max speed mechanically possible, in the units of "x"
> >which are used to identify both media and burners and have been since
> >"2x" was the fast burner.
>
> I've got a burner that has the following burn speeds (from memory): 16x
> DVD+/-R, 8x DVD+RW, 6x DVD-RW, 4x DVD+/-R DL, 48x CD-R, and 24x CD-RW.
> I don't even remember what the max read speeds are.  Which is the "max"?
> The 16x DVD speed or the 48x CD speed?  Why?

This value is also reported by the drive. I don't know about DVD drives, but 
for CD drives it is a multiplier. 1x == 256K/sec transfer off the disc, 52x 
is 13M/sec transfer off the disc. However, in the case of all discs, all 
speeds beyond a certain cut-off value (I forget what the number is) the 
number is "Maximum/Variable" because the polycarbonate the discs are made 
from will deform and shatter from the centrifugal forces above a certain RPM.

(And this I have witness three times myself with a 52x drive and old discs. 
It's a real bitch to have to take apart a CD drive and clean out the 
fragments of the disc.)

> The "x" unit is only meaningful with an associated format (since "1x" is
> different for different formats) and with "read" or "write" specified.
>
> Without units, the number is meaningless.

It's in units as specified by the specification. The redbook spec for CDROM 
drives states the minimum spin speed for stable reading and that roughly 
translates to a 256K/sec read rate.

I haven't had time to look into the DVD specification, but I'm guessing that 
the DVD speed is about 3x what the CDROM speed is.

> >> - if the drive can handle rewritable formats (for UDF support)
> >
> >CD-RW seems to cover that.
>
> Not for DVD+RW, DVD-RW, and DVD-RAM (which is the only one there).
> Sometime down the road, HD-DVD and Blu-Ray versions of rewritable will
> also exist.

Exactly. And these are all covered in the file. And as more formats are added 
the currently unused bits in the capabilities mode page will come into use. 
It will, at some point, be used up - and then I have a feeling a new mode 
page will be introduced so that the current one isn't changed in a way that 
would break legacy applications.

DRH
