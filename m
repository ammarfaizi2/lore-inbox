Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268805AbUJPTcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268805AbUJPTcq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268803AbUJPTcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:32:46 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:38852 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266683AbUJPT3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:29:43 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: swsusp: 8-order allocation failure on demand (update)
Date: Sat, 16 Oct 2004 21:31:19 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, ncunningham@linuxmail.org,
       pascal.schmidt@email.de, Pavel Machek <pavel@suse.cz>,
       Stefan Seyfried <seife@suse.de>
References: <2HO0C-4xh-29@gated-at.bofh.it> <200410142354.25665.rjw@sisk.pl> <20041016164347.GA2636@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20041016164347.GA2636@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410162131.19761.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 of October 2004 18:43, Pavel Machek wrote:
> Hi!
> 
> > > > > > > > Ok... And I guess it is nearly impossible to trigger this on 
> > > > > > > > demand, right?
> > > > > > 
> > > > > > I think it is possible.  Seemingly, on my box it's only a question 
> > > > > > of the number of apps started.  I think I can work out a method
> > > > > > to trigger it 90% of the time or so.  Please let me know if it's
> > > > > > worthy of doing. 
> > > > > 
> > > > > Yes, it would certainly help with testing...
> > > 
> > > Well, I can do that, it seems, 100% of the time.
> > > 
> > > The method is to do "init 5" (my default runlevel is 3, because vts
> > > become unreadable after I start X), log into KDE (as a non-root),
> > > start some X apps at random (eg. I run gkrellm, kmail, konqueror,
> > > Mozilla FireFox 32-bit w/ Flash plugin, and konsole with "su -") and
> > > run updatedb (as root, of course). 
> > 
> > To be precise, the method always leads to a failure, but it seems to
> > be either 8-order or 9-order page allocation failure.
> 
> Okay, you could probably pre-allocate 512K block during bootup, then
> just use that instead of allocating new one during suspend.
> 
> Unfortunately that's rather ugly. You'd ~32 bytes per 4K page, that's
> almost 1% overhead, not nice. Better solution (but more work) is to
> switch to link-lists or integrate swsusp2.

Well, I wonder if the page allocation failures are a swsusp problem, really.  
I've just tried it the other way around and ran updatedb _first_, then 
started X+KDE (no additional apps) and tried to suspend from under it.  Guess 
what: a 9-order page allocation failure, here you go.

It seems to me that updatedb leaves a mess in memory, which IMO should not 
happen or at least the kernel should be able to clean it, but apparently it 
is not.  I'd be grateful if someone could explain to me why that is so, 
please.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
