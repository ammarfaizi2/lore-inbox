Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbVI1Veh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVI1Veh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVI1Veh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:34:37 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:34007 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750949AbVI1Veg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:34:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Date: Wed, 28 Sep 2005 23:34:57 +0200
User-Agent: KMail/1.8.2
Cc: torvalds@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, daniel.ritz@gmx.ch,
       akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org> <200509282237.12750.rjw@sisk.pl> <20050928205609.77623E371B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
In-Reply-To: <20050928205609.77623E371B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509282334.58365.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 28 of September 2005 22:56, David Brownell wrote:
> > On Wednesday, 28 of September 2005 22:23, David Brownell wrote:
> > > > > > > BTW, please have a look at:
> > > > > > > http://bugzilla.kernel.org/show_bug.cgi?id=4416#c36
> > > > > > > and
> > > > > > > http://bugzilla.kernel.org/show_bug.cgi?id=4416#c37
> > > 
> > > What's with the bogus dates in those reports ... claiming some of you
> > > were testing 2.6.13-rc2-mm2 more than two months ago, mid-July ?????
> >
> > Nothing. :-)  2.6.13-rc2-mm2 was out exactly on July 12, and that's when
> > I tested it ...
> 
> OK, sorry; pardon me!  Then the right question to ask is more like
> "So does this still happen in **2.6.14-rc2** ??".  2.6.13-rc is
> marginally more recent than 2.4.20, but it still feels old. :)
> 
> 
> My other point still stands though.  The IRQ for all HCDs _are_ freed
> on suspend, and re-requested on resume ... so lack of such free/request
> calls can't possibly be an issue.

Yes it can.  Apparently on my box the call to request_irq() from a USB HCD
driver (OHCI or EHCI) causes a screaming interrupt to be generated,
which kills any other driver that shares the IRQ with the USB and has not
called free_irq() on suspend.  Of course this only happens with the patch
at http://www.ussg.iu.edu/hypermail/linux/kernel/0507.3/2234.html
unapplied, as it masks the problem.  Actually it also depends on the
order in which the drivers' resume routines are called, but unfortunately
on my box the USB drivers' are called first.

Still, if _none_ of the drivers (including USB HCD) calls request_irq() on resume,
the box survives _even_ _without_ the above-mentioned patch.

> The old rule of thumb with USB does still apply though:  be sure to
> test with BIOS support for it disabled.

AFAICT, in this particular case it doesn't matter.

Greetings,
Rafael
