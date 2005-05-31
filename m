Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVEaV2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVEaV2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVEaV2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:28:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32204 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261500AbVEaV0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:26:15 -0400
Date: Tue, 31 May 2005 23:25:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] Add some hooks to generic suspend code
Message-ID: <20050531212556.GA14968@elf.ucw.cz>
References: <1117524577.5826.35.camel@gaston> <20050531101344.GB9614@elf.ucw.cz> <1117550660.5826.42.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117550660.5826.42.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > While consolidating the powermac suspend to ram and suspend to disk
> > > implementations to properly use the new framework in kernel/power, among
> > > others, I ended up with the need of adding various callbacks to
> > > kernel/power/main.c. Here is a patch adding & documenting those.
> > > 
> > > The reasons I need them are:
> > > 
> > > 	/* Call before process freezing. If returns 0, then no freeze
> > > 	 * should be done, if 1, freeze, negative -> error
> > > 	 */
> > > 	int (*pre_freeze)(suspend_state_t state);
> > > 
> > > I'm using that one for calling my "old style" notifiers (they are beeing phased
> > > out but I still have a couple of drivers using them). The reason I do that here
> > > is because that's how my APM emulation hooks, and that code interacts with userland
> > > (to properly signal things like X of the suspend process), so I need to do that
> > > before we freeze processes.
> > 
> > This should not be needed in future, right? Could it be marked
> > deprecated or something?
> 
> Not really ... I need to notify userland before we freeze processes.

Why do you need it? Do you initiate suspend without userland asking
you to?

Anyway, it should not be arch-dependend. We need one good mechanism of
notifying userland, not one per architecture.

> > > 	/* called after unfreezing userland */
> > > 	void (*post_freeze)(suspend_state_t state);
> > > 
> > > That one is the mirror of pre-freeze, gets called after userland has been re-enabled,
> > > it also calls my old-style notifiers, which includes APM emulation, which is important
> > > for sending the APM wakeup events to things like X.
> > 
> > Could this be marked deprecated, too?
> > 
> > Alternatively, proper way of notifying X (etc) should be created, and
> > done from generic code....
> 
> Sure, ideally. However, existing X knows how to deal with APM events,
> and thus APM emulation is an important thing to get something that
> works. Pne thing I should do is consolidate PPC APM emu with ARM one as
> I think Russell improve my stuff significantly.

Perhaps we need apm emulation on i386, too?
									Pavel
