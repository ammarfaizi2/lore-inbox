Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268781AbUJPQnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268781AbUJPQnu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 12:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUJPQnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 12:43:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14267 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268781AbUJPQns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 12:43:48 -0400
Date: Sat, 16 Oct 2004 18:43:47 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Stefan Seyfried <seife@suse.de>,
       ncunningham@linuxmail.org, pascal.schmidt@email.de
Subject: Re: swsusp: 8-order allocation failure on demand (update)
Message-ID: <20041016164347.GA2636@atrey.karlin.mff.cuni.cz>
References: <2HO0C-4xh-29@gated-at.bofh.it> <200410131929.11308.rjw@sisk.pl> <200410142347.51241.rjw@sisk.pl> <200410142354.25665.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410142354.25665.rjw@sisk.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > > > Ok... And I guess it is nearly impossible to trigger this on 
> demand,
> > > > > > > right?
> > > > > 
> > > > > I think it is possible.  Seemingly, on my box it's only a question of 
> > the 
> > > > > number of apps started.  I think I can work out a method to trigger it
> > > > > 90% of the time or so.  Please let me know if it's worthy of doing.
> > > > 
> > > > Yes, it would certainly help with testing...
> > 
> > Well, I can do that, it seems, 100% of the time.
> > 
> > The method is to do "init 5" (my default runlevel is 3, because vts become 
> > unreadable after I start X), log into KDE (as a non-root), start some X apps 
> > at random (eg. I run gkrellm, kmail, konqueror, Mozilla FireFox 32-bit w/ 
> > Flash plugin, and konsole with "su -") and run updatedb (as root, of
> > course). 
> 
> To be precise, the method always leads to a failure, but it seems to be either 
> 8-order or 9-order page allocation failure.

Okay, you could probably pre-allocate 512K block during bootup, then
just use that instead of allocating new one during suspend.

Unfortunately that's rather ugly. You'd ~32 bytes per 4K page, that's
almost 1% overhead, not nice. Better solution (but more work) is to
switch to link-lists or integrate swsusp2.
									Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
