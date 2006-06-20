Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWFTWeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWFTWeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWFTWeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:34:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:3810 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751428AbWFTWdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:33:47 -0400
From: Andi Kleen <ak@suse.de>
To: Greg KH <gregkh@suse.de>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilitiesKJ
Date: Wed, 21 Jun 2006 00:33:35 +0200
User-Agent: KMail/1.9.3
Cc: Dave Olson <olson@unixfolk.com>, discuss@x86-64.org,
       Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
       Greg Lindahl <greg.lindahl@qlogic.com>
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <200606200925.30926.ak@suse.de> <20060620212908.GA17012@suse.de>
In-Reply-To: <20060620212908.GA17012@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606210033.35409.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 23:29, Greg KH wrote:
> On Tue, Jun 20, 2006 at 09:25:30AM +0200, Andi Kleen wrote:
> > 
> > > Sure, that's true of almost everything new.   It remains broken until people
> > > start using it, complain, and get the bugs fixed.   Some of us have a vested
> > > interest in having MSI work, since it's the only way we can deliver interrupts.
> > > We've already worked with a few BIOS writers to get problems fixed, and we'll
> > > keep doing so as we find problems.   If enough hardware vendors and consumers
> > > do so, the broken stuff will get fixed, and stay fixed, because it will get
> > > tested.
> > 
> > Sometimes there are new things that work relatively well and only break occassionally
> > and then there are things where it seems to be the other way round.
> > 
> > My point was basically that every time we tried to turn on such a banana green feature
> > without white listing it was a sea of pain to get it to work everywhere
> > and tended to cause far too many non boots
> > 
> > (and any non boot is far worse than whatever performance advantage you get
> > from it) 
> > 
> > So if there are any more MSI problems comming up IMHO it should be
> > white list/disabled by default and only turn on after a long time when
> > Windows uses it by default or something. Greg, do you agree?
> 
> No, I don't want a whitelist, as it will be hard to always keep adding
> stuff to it (unless we can somehow figure out how to put a "cut-off"
> date check in there).  Yes, we do have a number of systems today that
> have MSI issues, but the newer ones all work properly, and we should
> continue on with the way we have today (blasklist problem boards, as the
> rest of the PCI subsystem works with the quirks).

On Intel chipsets just enabling it is fine - i haven't heard of a MSI problem
there so far. Detecting Intel chipsets can be tricky though - there are
AMD systems with Intel PCI bridges now. I suppose any blacklist will be 
per bridge.

Just on AMD there seems to be no PCI-X bridge that actually works with MSI without
hacks and PCI-E seems to be quite spotty too (e.g. BCM at least partly broken) 

Brice claims BCM can be fixed with a quirk and Petr claimed AMD 8132 can be fixed
with a quirk, but my personal feeling is that it is very risky to do so because
if these bits are not enabled by default they are likely unvalidated and might break
in subtle ways under high load (past experiences with forcing hardware features
on against BIOS wishes were usually negative) 

The good message is that AMD without quirk they don't do anything so it would just
not be enabled and at least not break anything.

BCM seems to need a blacklist to force MSI off (or at least tg3 is complaining
that MSI doesn't work). I guess we can try to contact someone at BCM
and ask them if they actually tested it. If they did then enabling it would
be fine.

NForce4 PCI Express is an unknown - we'll see how that works.

-Andi
