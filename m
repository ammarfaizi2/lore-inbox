Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUIKJyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUIKJyz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 05:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268075AbUIKJyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 05:54:55 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:11907 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268074AbUIKJyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 05:54:53 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp: kill crash when too much memory is free
Date: Sat, 11 Sep 2004 11:50:28 +0200
User-Agent: KMail/1.6.2
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz> <200409101926.30902.rjw@sisk.pl> <20040910222915.GC1347@elf.ucw.cz>
In-Reply-To: <20040910222915.GC1347@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409111150.28457.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 of September 2004 00:29, Pavel Machek wrote:
> Hi!
> 
> > > Can you try my "bigdiff"? Also, does it work okay in 32-bit mode?
> > 
> > Well, the good news is that it sort of works.  Still, there are some bad 
news, 
> > as usual. ;-)
> 
> So it sort-of-works, 32-bit and 64-bit mode? Good.
> 
> > First, to make the box wake up, I have to unload ohci_hcd and everything 
that 
> > sits on IRQ11 before suspending (on my system that is sk98lin, 
yenta_socked, 
> > and ohci1394).  If you want me to show what happens if I don't unload 
these 
> > modules, I'll be able to grab some traces in a couple of hours. ;-)  Also, 
I 
> > have to compile out the frequency scaling, because otherwise it hangs 
solid 
> > at some time after wake-up.
> > 
> > Second, after it's woken up, it seems to be very, _very_ slow, and the 
reason 
> > is indicated by this:
> 
> Hmm, I do not know what nForce3 is (it should use better name at the
> minimum), but that driver probably needs some work.

It is the sound chip (ie snd-intel8x0).  If I unload it after resume, 
everything's fine and dandy.  Moreover, if I unload it before suspend, the 
box wakes up with no problems (of course, I have to unload the other modules 
too, as I said before).

However, I think the problem is with the hardware, not with the driver: if the 
sound driver is unloaded before suspend and loaded again after resume, the 
box behaves as though it were loaded all the time (ie IRQ #5 goes mad).  Are 
there any boot options that may help get around this?

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
