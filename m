Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbTAOQAT>; Wed, 15 Jan 2003 11:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbTAOQAT>; Wed, 15 Jan 2003 11:00:19 -0500
Received: from air-2.osdl.org ([65.172.181.6]:55788 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266609AbTAOQAS>;
	Wed, 15 Jan 2003 11:00:18 -0500
Date: Wed, 15 Jan 2003 08:03:59 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Russell King <rmk@arm.linux.org.uk>
cc: John Bradford <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>
Subject: Re: [RFC] add module reference to struct tty_driver
In-Reply-To: <20030115104016.E31372@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33L2.0301150803440.6909-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2003, Russell King wrote:

| On Wed, Jan 15, 2003 at 10:30:03AM +0000, John Bradford wrote:
| > > > Woah!  Hm, this is going to cause lots of problems in drivers that have
| > > > been assuming that the BKL is grabbed during module unload, and during
| > > > open().  Hm, time to just fallback on the argument, "module unloading is
| > > > unsafe" :(
| > >
| > > Note that its the same in 2.4 as well.  iirc, the BKL was removed from
| > > module loading/unloading sometime in the 2.3 timeline.
| >
| > Surely no recent code should be making that assumption anyway - the
| > BKL is being removed all over the place.
|
| The TTY layer isn't "recent code", its "very old code", and (IMO)
| removing the BKL from the TTY layer is a far from trivial matter.
|
| I believe at this point in the 2.5 cycle, we should not be looking
| to remove the BKL.  We should be looking to fix the problems we know
| about.  That basically means:
|
| - module refcounting
| - interrupt races
| - any other races (eg, tty_register_driver / tty_unregister_driver)

such as in http://bugme.osdl.org/show_bug.cgi?id=54

-- 
~Randy

