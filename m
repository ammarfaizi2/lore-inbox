Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVEaXcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVEaXcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 19:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVEaXcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 19:32:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:36536 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261191AbVEaXcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 19:32:09 -0400
Subject: Re: [linux-pm] [RFC] Add some hooks to generic suspend code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050531212556.GA14968@elf.ucw.cz>
References: <1117524577.5826.35.camel@gaston>
	 <20050531101344.GB9614@elf.ucw.cz> <1117550660.5826.42.camel@gaston>
	 <20050531212556.GA14968@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 09:31:49 +1000
Message-Id: <1117582309.5826.60.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why do you need it? Do you initiate suspend without userland asking
> you to?

Because there is an existing API, via /dev/apm_bios, and that's all X
understands ! And because I've always done that ;)

> Anyway, it should not be arch-dependend. We need one good mechanism of
> notifying userland, not one per architecture.

We need to define a new mecanism, I think. In the meantime, my APM
emulation works though and I won't drop it. 

> > > > 	/* called after unfreezing userland */
> > > > 	void (*post_freeze)(suspend_state_t state);
> > > > 
> > > > That one is the mirror of pre-freeze, gets called after userland has been re-enabled,
> > > > it also calls my old-style notifiers, which includes APM emulation, which is important
> > > > for sending the APM wakeup events to things like X.
> > > 
> > > Could this be marked deprecated, too?
> > > 
> > > Alternatively, proper way of notifying X (etc) should be created, and
> > > done from generic code....
> > 
> > Sure, ideally. However, existing X knows how to deal with APM events,
> > and thus APM emulation is an important thing to get something that
> > works. Pne thing I should do is consolidate PPC APM emu with ARM one as
> > I think Russell improve my stuff significantly.
> 
> Perhaps we need apm emulation on i386, too?

Maybe. It may help in some cases.

Ben.


