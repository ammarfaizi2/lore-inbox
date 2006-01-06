Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752336AbWAFEWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbWAFEWZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 23:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbWAFEWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 23:22:25 -0500
Received: from havoc.gtf.org ([69.61.125.42]:57787 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751859AbWAFEWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 23:22:24 -0500
Date: Thu, 5 Jan 2006 23:22:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: State of the Union: Wireless
Message-ID: <20060106042218.GA18974@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



		State of the Union - Wireless
		      January 5, 2006


Another banner year has passed, with Linux once again proving
its superiority in the area of crappy wireless (WiFi) support.
Linux oldsters love the current state of wireless, because it hearkens
back to the heady days of Yuri Gagarin, Sputnik and Linux kernel 0.99,
when getting hardware to work under Linux required either engineering
knowledge or luck (or both).

Linux has made remarkable progress in the area of hardware support,
in the past five years, reaching a state where it is unusual for
mainstream hardware to -not- be supported by Linux as soon as it
is released.  Unfortunately, this does not extend to wireless.

Wireless drivers today are scattered to the four winds:  many
are in-tree, but for older hardware, and lack active maintainers.
They work.  A few drivers exist for "relatively" modern WiFi hardware
in-tree; they work, but they don't have active maintainers either.
Current hardware, many of it "softmac", is driven by a wild variety of
drivers, for a wide variety of wireless stacks, none of them in-tree.
Or, the in-tree drivers are simply out of date versions of actively
maintained out-of-tree drivers.  In one or two cases, users have turned
to awful emulation solutions like NdisWrapper.  But can you blame them?
They just want their hardware to work.

Twelve months ago, the community consensus was that the best basis for
a wireless stack was HostAP, or as it turned out, a HostAP derivative
whose sole users are the Intel ipw drivers.  So that got merged.
Now, twelve months later, fashion has changed, ieee80211 lost a lot of
momentum, and it seems that the DeviceScape wireless stack is all the
rage, and there are convincing arguments for merging the DeviceScape
code floating about.

But you -- I'm talking to all you wireless kernel hackers -- need to
come up with some solutions for some key issues:

* We really have no wireless maintainer.  I'm just the defacto guy,
  with no interest in the job.  The ideal maintainer knows 802.11 well,
  uses git, and isn't an asshole with no taste.  I'm just the guy who
  wants to make sure the net driver portion doesn't turn out to be a
  stinker (read: review and pass up the chain).

* Once you pick your favorite stack, STICK WITH IT.  In Linux, there
  is collectively very little patience with a rewrite every 12 months,
  particularly one that is dropped in out of the blue rather then
  evolved out of existing code.

In Linux, today's wireless code will probably live at least 10 years,
if not more.  Long term maintainability is paramount.  This is
why we prefer to evolve code, rather than constantly rewrite it.
Rewrites are often improvements, but bring in their own wave of
bugs and incompatibilities, while eliminating years of carefully
culminated knowledge buried in the existing code.  As a solution,
pragmatic users wind up running both the pre-rewrite code and the
new code -- duplicate code.  Code duplication in turn brings in its
own wave of bugs, and assaults on open source's economies of scale.

* Wireless drivers and the wireless stack need to be maintained IN-TREE
  as a COLLECTIVE ENTITY, not piecemeal maintenance as its done now.

The whole point of working in-tree, the whole point of this open source
thing is that everybody works on the same code, and the entire Internet
is your test bed.  Quality improves the more people work together.
The entire Linux kernel engineering process is focused on getting core
kernel code out to distributions (then to end users) and power users.
Out-of-tree code breaks that model, breaking the It Just Works(tm)
theme applicable to other Linux-supported hardware.

* Release early, release often.  Pushing from an external repository to
  the official kernel tree every few months creates more problems
  than it solves.  Out-of-tree drivers fail to take advantage of
  recent kernel changes and coding practices, which leads to bugs and
  incompatibilities.  Slow pushing leads to huge periodic updates,
  which are awful for debugging, testing, and general use.

* Wireless management, in particular the wireless kernel<->user
  interface, needs some thinking.  Wireless Extensions (WE) isn't
  cutting it, but I haven't seen any netlink work yet (or some
  other interface).  Whatever the userspace interface is, it will be
  basically carved in stone for years (unlike kernel APIs), so this
  needs a lot more thought than people have been giving it.

* ALL wireless stacks need work.  It is currently fashionable to laud
  DeviceScape and trash in-kernel ieee80211, but outside of the
  cheerleading, BOTH have real technical issues that need addressing.
  IOW, no matter what code is chosen, _somebody_ is on the hook for
  a fair amount of work.  A switch is not without its costs.

* I would prefer that people patch the in-tree ieee80211 code,
  probably in the direction of Jiri Benc's proposed ieee80211_device
  direction.  I take patches from all parties, not just Intel.

* However, if the engineering reasons for switching to DeviceScape
  or another wireless stack are powerful enough to overcome Linux's
  "no big patches, evolve it" maxim, great!  But make sure to work
  on converting drivers to this new stack.  The wireless drivers and
  wireless stack should evolve in tandem.  Otherwise, drivers get
  left behind, grow moldy, and Linux users suffer.

* Feel free to submit radical changes -- wireless is yet young --
  just make sure all drivers keep working from release to release.

* Long term, wireless should go from being a library of common code to a
  "real" wireless stack, as shown in the template developed by David Miller:
  http://kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/davem-p80211.tar.bz2
  Zhu Yi @ Intel and Vladmir @ somewhere both independently did some
  work in this area.

* Please CC wireless stack/driver discussions to netdev@vger.kernel.org
  mailing list, rather than everybody hiding in their own little
  corner.

* I prefer GPL-only code.  Dual licensing has proven in practice to
  be a logistical nightmare that concentrates power in the hands of
  a few.  Dual licensing, BSD licensing works for some, but GPL-only
  code is quite simply the least amount of flamewars, headaches
  and worry.  IOW, the P.I.T.A. level of GPL-only code is lowest.

Open source is about not only merit, but lack of control.  If I am
being a knucklehead, or you just don't like me, you can always go
through Andrew Morton, David Miller, Linus, ...  With dual licensed
code, engineers are really really really really encouraged to submit
code through a single channel for legal rather than merit reasons.

Dual licensed code gives kernel hackers yet more legal crapola to
worry about, which is never a good thing.



Patches welcome from all motivated, clueful parties.  Jiri Benc has a
long series of patches that looks nice.  Johannes Berg has done some
work on the ieee80211 softmac stuff and hw WEP.  But maybe DeviceScape
is what people like now.

So... there it is.  We suck.  There's hope.  No Luke Skywalker in sight.
I hope we can avoid being slaves to fashion, by merging a rewrite, but
that way be the way to go.

	Jeff



