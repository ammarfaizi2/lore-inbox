Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVHVV2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVHVV2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVHVV2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:28:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:36246 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751234AbVHVV2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:28:03 -0400
Date: Mon, 22 Aug 2005 16:27:49 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/2] external interrupts
In-Reply-To: <20050820222159.GP516@openzaurus.ucw.cz>
Message-ID: <20050822155852.N325@chenjesu.americas.sgi.com>
References: <20050819160716.U87000@chenjesu.americas.sgi.com>
 <20050820222159.GP516@openzaurus.ucw.cz>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2005, Pavel Machek wrote:

> > Here is a set of patches that implements an external interrupt capability
> > in Linux, along with a device driver for a specific hardware device.  I
> > submitted the patches several weeks ago, and they drew no comments, which
> > I take to be a good sign.  Anyway, I'm 
> It was not good sign in this particular case. My reaction was "this is _so_
> overengineered tjat he's probably joking".

Laughter was not wholly unexpected, though I wasn't joking.  I'm trying
to be realistic about the lifetime of any given hardware, and IOC4 is
several years old at this point.  Couple that with a sincere desire to
preserve application source compatability when (not if) new hardware
appears, and an abstraction layer seemed to be a logical choice.  I'm
more than happy to discuss problems in the abstraction layer's interface
and make appropriate changes -- I'm nothing if not obliging.

I do recognize that the code is a bit excessive given that there's
only one known device (IOC4) that is currently supported.  However,
the abstraction isn't really all that complicated.  The low-level
driver simply provides to the abstraction layer a structure containing
a handful of functions pointers: get/set output modes and timings,
get/set interrupt sources, get timing roundoff information and device
ID.  The abstraction layer provides a function to call whenever an
interrupt occurs.  Then add in a bit of registration/deregistration
glue so that kernel modules can load and unload.  That's pretty much it
-- nothing fancier than needed to decouple hardware implementation details
from the programming interface.

Yes, I suppose I could implement completely seperate hardware drivers
with a consistent interface, and do away with the abstraction layer.
However, that leads to code duplication, which has its own downfalls.
Personally, if I had to pick one poison or the other I'd take
overengineering over maintaining divergent implementations, but the
patch apparently made my predeliction obvious :).

Thanks,
Brent Casavant

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
