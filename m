Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268686AbUJKE0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268686AbUJKE0q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 00:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUJKE0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 00:26:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:30907 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268686AbUJKE00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 00:26:26 -0400
Subject: Re: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.58.0410102104530.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston>
	 <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
	 <1097466354.3539.14.camel@gaston>
	 <Pine.LNX.4.58.0410102104530.3897@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1097468590.3249.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 14:23:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 14:08, Linus Torvalds wrote:
> On Mon, 11 Oct 2004, Benjamin Herrenschmidt wrote:
> > 
> > Disagreed. Sorry, but can you give me a good example ? The drivers still
> > do the broken assumptions of passing directly the state parameter to
> > pci_set_power_state() (or whatever we call this one these days) but this
> > is worked around by defining PM_SUSPEND_MEM to 3 in pm.h.
> 
> .. take a look at PM_SUSPEND_DISK for a moment.
> 
> If you only care about PM_SUSPEND_MEM, then what's your problem? You get 
> the right value already. 

How so ? I care about both. We had 2 different problems. One was
PM_SUSPEND_MEM would be defined to 2 which caused dumb drivers to try to
go to D2 instead of D3, and one is that some drivers are still mixing up
PM_SUSPEND_DISK, and I don't think the "fix" in pci-driver.c is any good
for that... 

> And if you _do_ care about PM_SUSPEND_DISK, then don't ignore it in the
> discussion. You can't have it both ways.

I'm not ignoring it. I pretend that it's wrong.

> The fact is, my laptop can now (finally) do suspend-to-disk. It never 
> could do that before. And yes, it does use radeonfb, so your arguments 
> hold no water with me. 

But radeonfb ends up suspending the display at a wrong time and you miss
half of the output, which makes any kind of debugging near to
impossible.

> I told you what can done to fix things up. Stop ignoring that reality.

I'm not ignoring that reality and I may well come up with a patch for
after 2.6.9 but I consider the current state of things broken.

Ben.


