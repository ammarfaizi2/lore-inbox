Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261695AbREOXTD>; Tue, 15 May 2001 19:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261694AbREOXSw>; Tue, 15 May 2001 19:18:52 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:10749 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261693AbREOXSp>; Tue, 15 May 2001 19:18:45 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105152317.f4FNHsY3022099@webber.adilger.int>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <045a01c0dd8d$6377d9a0$6800000a@brownell.org> "from David Brownell
 at May 15, 2001 03:21:28 pm"
To: David Brownell <david-b@pacbell.net>
Date: Tue, 15 May 2001 17:17:53 -0600 (MDT)
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Bronwell writes:
> Linus writes:
> > Now, if we just fundamentally try to think about any device as being 
> > hot-pluggable, you realize that things like "which PCI slot is this device 
> > in" are completely _worthless_ as device identification, because they 
> > fundamentally take the wrong approach, and they don't fit the generic 
> > approach at all. 
> 
> The reason is that such "physical" identifiers (or "device topology" IDs)
> may be all that's available to distinguish some devices.  For example,
> network adapters (no major/minor numbers :) and parallel/printer/serial
> ports may have no better "stable" (over reboots) identifier available.

I would have to agree that "stable" is critical to not driving people
crazy.  In the case of AIX, once a device is enumerated, it will retain
the same name across reboots.  Enough information is kept about each
device to determine if it has already been enumerated (i.e. same I/O
port address for serial devices, MAC address for ethernet cards, etc),
or if it is a new device and should get a new name.

> Without "stable" names, it's too easy to have bad things happen, like
> your "confidential materials" printer output get redirected into the
> lobby printer, or trust your network DMZ as if it were the internal
> network.

Without stable names it is basically impossible to make any sort of
reasonable configuration decision, unless the configuration can be
stored on the device itself.  That works for disks, and not much else.

> Given hotplugging, I think the best solution to such issues
> does involve exposing topological IDs such as PCI slot names.
> (What IDs the different applications use is a different issue.)

I disagree here.  In many cases you only have a very limited number of
devices of each type (or only 1), so you don't want to be bogged down
with physical device naming.  If you have lots of a given type of device
(e.g. disks), you _also_ don't want to be bogged down with physical
device naming, because it will NOT be consistent across different physical
access methods.  In both cases, you want a generic name PLUS a way to
find out the physical characteristics (attributes) of the device to do
INITIAL configuration.  If the device keeps a constant name across
reboots, you don't care how it is accessed after the first configuration.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
