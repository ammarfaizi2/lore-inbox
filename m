Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVIFPXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVIFPXV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 11:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVIFPXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 11:23:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52115 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750711AbVIFPXV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 11:23:21 -0400
Date: Tue, 6 Sep 2005 16:23:20 +0100
From: viro@ZenIV.linux.org.uk
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig fix (BLK_DEV_FD dependencies)
Message-ID: <20050906152320.GX5155@ZenIV.linux.org.uk>
References: <20050906004842.GP5155@ZenIV.linux.org.uk> <Pine.LNX.4.61.0509061205510.3743@scrub.home> <20050906134944.GV5155@ZenIV.linux.org.uk> <Pine.LNX.4.61.0509061701060.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509061701060.3743@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 05:05:33PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Tue, 6 Sep 2005 viro@ZenIV.linux.org.uk wrote:
> 
> > We could go for your "allow" form, but what else would need it?  USB gadget
> > stuff with its "must have at most one low-level driver, high-level drivers
> > should be allowed only if a low-level one is present"?  RTC mess is better
> > solved in other ways, PARPORT_PC is mostly solved by now, what's left?
> > VGA_CONSOLE?  I really don't see enough uses for such construct...
> 
> It would be mostly useful for arm/mips with their millions of 
> configurations. Adding or removing one of them would become easier if the 
> references to it aren't spread over the complete.
> Basically select is already used (and sometimes abused) this way.

One major problem with that: unless you accept bare allow and/or select
(not as part of config <something>), we _still_ get these noise symbols,
just to have some place where that "allow" clause could live.

IOW, you get something like

config I_DONT_WANT_TO_CALL_THAT_ARCH_HAS_SOMETHING
	bool
	default y
	allow BLK_DEV_FD

in the same places where I do

config ARCH_MIGHT_HAVE_PC_FDC
	default y

with the only difference being that in your variant symbol will be 100%
semantics-free - it's just a workaround for Kconfig syntax problem.

Are you up to such change?  If so, I'll just take current patch and do
pretty much a search-and-replace on it, turning unconditional instances
of these suckers (i.e. in absense of subarchitectures) into plain

# there's a glue for PC-like FDC
allow BLD_DEV_FD

If you insist on having dummy config around allow/select, I don't see any
real benefits in using "allow" form...
