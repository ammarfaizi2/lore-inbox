Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261746AbSJMVRZ>; Sun, 13 Oct 2002 17:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbSJMVRZ>; Sun, 13 Oct 2002 17:17:25 -0400
Received: from packet.digeo.com ([12.110.80.53]:13218 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261746AbSJMVRW>;
	Sun, 13 Oct 2002 17:17:22 -0400
Message-ID: <3DA9E439.3613F889@digeo.com>
Date: Sun, 13 Oct 2002 14:23:05 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: James Simmons <jsimmons@infradead.org>, Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [BK PATCH] console changes 1
References: <20021012014332.GA7050@krispykreme> <Pine.LNX.4.33.0210131338400.6800-100000@maxwell.earthlink.net> <20021013220041.G23142@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2002 21:23:06.0236 (UTC) FILETIME=[B87E9BC0:01C272FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Sun, Oct 13, 2002 at 01:40:50PM -0700, James Simmons wrote:
> > Ugh!!! The reason I reworked the console system is because over the years
> > hack after hack has been added. It now has lead to this twisted monster.
> > Take a look at the fbdev driver codes in 2.4.X. Instead of another hack
> > the console system should be cleaned up with a well thought out design to
> > make the code base smaller and more effiencent.
> 
> There is a very good reason why stuff like this is needed.  Its to get
> the boot messages out of a non-booting box, when you know that its oopsed
> before fbcon can be initialised.
> 
> fbcon can't be initialised before PCI setup on many systems because the
> PCI bus may not be setup, and therefore the VGA card may very well not
> be accessible.
> 
> I think you'll find that virtually every architecture has some method
> to get real early boot time messages out of the box in some way (on ARM,
> it involves enabling CONFIG_DEBUG_LL and adding a function call into
> printk.c, and attaching a machine to a serial port - this works from
> the moment that we start executing any kernel image.)
> 
> You're not going to be able to design something to cover all cases.
> Especially the ones where the normal C environment isn't up and running
> yet. 8)

Yes, there are a number of rude hacks down there to handle oopses
and early startup.  It's just a messy problem, and no solution to
it will be a thing of beauty.

And early printk is obviously a useful thing to have when the
machine won't start.

I think what we need James is just the low-level hook in printk.c which
the various platforms and boards can plug into.  The one in Martin's
patch (module some cleanups, docco, conversion to C, etc) looks
suitable to me.  The actual early console drivers don't appear to have
much relationship at all to the console layer really.  They're just
minimal-code busy-wait port banging.

The patch needs to be split.

- Generic part in printk.c. Make sure that it suits all users

- ia32 serial early console driver

- ia32 VGA early console driver.

What else?

And who's going to do it?
