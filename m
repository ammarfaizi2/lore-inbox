Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbVCJRfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbVCJRfk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVCJRdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:33:33 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:65272 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262829AbVCJRYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:24:00 -0500
Message-ID: <423082BF.6060007@comcast.net>
Date: Thu, 10 Mar 2005 12:24:15 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: binary drivers and development
References: <423075B7.5080004@comcast.net>
In-Reply-To: <423075B7.5080004@comcast.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've done more thought, here's a small list of advantages on using
binary drivers, specifically considering UDI.  You can consider a
different implementation for binary drivers as well, with most of the
same advantages.

 - Smaller kernel tree
   The kernel tree would no longer contain all of the drivers; they'd
   slowly have to bleed into UDI until most were there
 - Better focused development
   The kernel's core would be the core.  Driver code would be isolated,
   so work on the kernel would affect the kernel only and not any
   drivers.  UDI is a standard interface that shouldn't be broken.  This
   means that work on the high-level drivers will not need to be sanity
   checked a thousand times against the PCI Bus interface or the USB
   host controler API or whatnot.
 - Faster rebuilding for developers
   The isolation between drivers and core would make rebuilding involve
   the particular component (driver, core).  A "broken driver" would
   just require recoding and rebuilding the driver; a "broken kernel"
   would require building pretty much a skeletal core
 - UDI supplies SMP safety
   The UDI page brags[1]:

   "An advanced scheduling model. Multiple driver instances can be run
    in parallel on multiple processors with no lock management performed
    by the driver. Free paralllism and scalability!"

   Drivers can be considered SMP safe, apparently.  Inside the same
   driver, however, I have my doubts; I can see a driver maintaining a
   linked list that needs to be locked during insertions or deletions,
   which needs lock managment for the driver.  Still, no consideration
   for anything outside the driver need be made, apparently.
 - Vendor drivers and religious issues
   Vendors can supply third party drivers until there are open source
   alternatives, since they have this religious thing where they don't
   want people to see their driver code, which is kind of annoying and
   impedes progress

Disadvantages:

 - Preemption
   Is it still possible to implement a soft realtime kernel that
   responds to interrupts quickly?
 - Performance
   UDI's developers claim that the performance overhead is negligible.
   It's still added work, but it remains to be seen if it's significant
   enough to degrade performance.
 - Religious battles
   People have this religious thing about binary drivers, which is kind
   of annoying and impedes progress
 - Constriction
   This would of course create an abstraction layer that constricts the
   driver developer's ability to do low level complex operations for any
   portable binary driver

A Linux specific binary driver format might be more useful, but wouldn't
potentially allow for sharing the drivers across operating systems

[1] http://projectudi.sourceforge.net/about.php
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCMIK8hDd4aOud5P8RAo+EAJwIF7zEmiyxKzRJJ037TQ2FhYG5bACffTBX
JLhXPcidbQbf18LyTmjHgh0=
=gbyB
-----END PGP SIGNATURE-----
