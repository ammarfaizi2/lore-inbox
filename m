Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268756AbUJKKS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268756AbUJKKS1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 06:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268762AbUJKKS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 06:18:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64716 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268756AbUJKKSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 06:18:25 -0400
Date: Mon, 11 Oct 2004 12:18:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>
Subject: Re: Totally broken PCI PM calls
Message-ID: <20041011101824.GC26677@atrey.karlin.mff.cuni.cz>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102115410.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410102115410.3897@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Maybe the real problem is that we are trying to use the device suspend
> > functions for suspend-to-disk, when we don't really want to change the
> > device's power state at all.
> 
> An acceptable solution is certainly to instead of passing down "go to D3",
> just not do anything at all. HOWEVER, I doubt that is actually all that 
> good a solution either: devices quite possibly do want to save state 
> and/or set wake-on-events. 

And DMA needs to be stopped, or it is "bye bye data" situation.

> Which is why I suggested making it a separate type that is _not_ a normal 
> number. Exactly so that you cannot think it's a PCI state by mistake, when 
> clearly drivers _do_ think that. And force people to verify it.
> 
> You could do it with "sparse" and "bitwise" types too. Sparse will
> complain if you use the type in an inappropriate manner. But the basic
> issue remains: there are PCI power states, and there are "suspend" power
> states, and they are different. And right now people _are_ confused about
> them.

Does sparse now have typechecking on enums? Solution that was in -mm
was basically "put enums there so drivers can't be confused" + "signal
global state out-of-band in global variable". It was not too nice, but
it certainly was working.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
