Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTJIIJp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 04:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTJIIJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 04:09:45 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:60340 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261928AbTJIIIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 04:08:22 -0400
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <Pine.LNX.4.44.0310081947330.19510-100000@home.osdl.org>
References: <Pine.LNX.4.44.0310081947330.19510-100000@home.osdl.org>
Content-Type: text/plain
Message-Id: <1065686834.7081.83.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 10:07:15 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > ObOtherFun:  There's another bogosity in quoted ide-probe.c code, according
> > to dwmw2 - he says that there are PCI IDE cards that get IRQ 0, so the
> > test for hwif->irq is b0rken.  We probably should stop overloading
> > ->irq == 0 for "none given", but I'm not sure that we *have* a value
> > that would never be used as an IRQ number on all platforms...
> 
> The BIOS defines irq 0 in the PCI config space to be "no irq" as far as I
> know, and on all PC platforms I've ever heard of it's not a usable irq for
> generic PCI devices (it's wired to the timer thing). 
> 
> All PCI routing chipsets I know about also make "irq0" mean "disabled". 
> 
> Which is not to say that a badly configured setup might not do it, but it 
> really sounds fundamentally broken. 

Well, irq 0 is a perfectly valid IRQ on a number of non-x86 platforms,
some embedded platforms for example, and iirc, the Apple G5 even has
the serverworks IDE on IRQ 0 ;)

That's why we have defined IRQ_NONE a while ago (this was in 2.4, I
don'tk now if that made the trip to 2.6, I'm away from my sources
at the moment).

Ben.


