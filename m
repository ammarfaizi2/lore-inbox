Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270688AbTHEVIL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270691AbTHEVIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:08:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:39329 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270688AbTHEVIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:08:06 -0400
Date: Tue, 5 Aug 2003 14:07:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Andi Kleen <ak@colin2.muc.de>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export touch_nmi_watchdog
In-Reply-To: <20030805203137.E30256@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0308051402300.2835-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Aug 2003, Arjan van de Ven wrote:
> On Tue, Aug 05, 2003 at 01:25:09PM -0700, Linus Torvalds wrote:
> > 
> >  - either fix the driver
> > or
> >  - disable the watchdog entirely.
> 
> In principle you are soooo right. Just that it sometimes is HARD to fix
> such long delays...

That's why I said "disable the watchdog".

The thing is, if you start doing things like this in drivers, then you 
just hide the problem to the point where users end up not even being 
_aware_ of the problem. 

Do you _really_ think most users will think of "Oh, let's grep for
'touch_nmi_watchdog' in that driver" when they have latency issues?

No. Obviously they won't. Instead, they'll scratch their head about
occasional bad packet routing latency, report it as a networking bug, and
just generally look in the wrong place. And enabling lockup debugging will
do zero for them.

So this is a case of trying to paper over the symptoms. Which is perfectly 
ok in the sense that "we don't have the resources to fix it right now, so 
let's just give it two aspirins and ask it to call in the morning". That's 
fine.

But since the whole _point_ of watchdogging is to find places like this, 
when you paper over _these_ symptoms, you end up killing the whole idea.

Which is why I'd suggest making it a more conscious decision: just turn
off watchdog support. And if somebody needs watchdog support with a broken 
driver, maybe, just _maybe_, he'll find the energy to fix the frigging 
thing.

Otherwise this will just keep on expanding. 

		Linus

