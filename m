Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbWAGNEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbWAGNEX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 08:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWAGNEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 08:04:23 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:42909 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1030433AbWAGNEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 08:04:23 -0500
Date: Sat, 7 Jan 2006 08:06:52 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys	interface
Message-ID: <20060107130652.GB3972@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
	Andrew Morton <akpm@osdl.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net> <Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org> <20060107000826.GC20399@elf.ucw.cz> <20060107075851.GD3184@neo.rr.com> <20060107102013.GB9225@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107102013.GB9225@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 11:20:13AM +0100, Pavel Machek wrote:
> On So 07-01-06 02:58:51, Adam Belay wrote:
> > The driver core can provide some infustructure, but let's leave the states
> > up to the drivers.  Afterall, some drivers might only be interested in "on"
> > during runtime.  Also, drivers might support some sort of partial-off
> > but not "off".
> 
> Then they map "off" to "as much off as I can". Big deal.

Yes, but it may not be the kernel's place to make this generalization.

> 
> > And no, this does not allow us to experiment with PCI power
> > management.
> 
> Well, suse was already doing experiments with 2.6.14 sysfs...

Sure one can see how much power is saved by entering D3, but than can
even be done through userspace.  I think it's more important to
experiment with schemes that will actually be useful and reliable to the
end user.

> 
> > Also there's nothing "runtime" about the PCMCIA PM API.  It's much more
> > like calling ->remove() as it disabled the device all together.  
> 
> It looks enough runtime to me.

As was already discussed, we don't want to modify every userspace
application to check if the device it needs is "on" (resumed) or
"off" (suspended).  It's just two painful with third party apps etc.
Therefore, the kernel needs to handle this more seemlessly.  In my
opinion, this is what runtime power management is all about, saving
power without getting in the user's way.

> 
> > I'm more
> > interested in saving power without crippling functionality.
> 
> You are on wrong mailing list, then. Seriously. If you can save power
> without affecting functionality, then just doing, you don't need any
> userland interface.

Cool it, affecting functionality and disabling it are not the same
thing.  I'm fairly certain this mailing list is interested in exploring
more than suspend/resume (i.e. "on" and "off"), even if it can be hacked
to happen during runtime.

This issue depends on the platform and device class.  Some device
classes will have more user initiated power transitions than others.
With that in mind, even drivers with exclusively kernel-space control
will want to export knobs and tunables for timeout values etc.  A
userland interface if important regardless of kernel-side
implementation.

-Adam

