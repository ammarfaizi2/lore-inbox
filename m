Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVI2Cy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVI2Cy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 22:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVI2Cy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 22:54:57 -0400
Received: from mx1.rowland.org ([192.131.102.7]:11271 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751317AbVI2Cy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 22:54:57 -0400
Date: Wed, 28 Sep 2005 22:54:54 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: David Brownell <david-b@pacbell.net>, <rjw@sisk.pl>, <torvalds@osdl.org>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <hugh@veritas.com>, <akpm@osdl.org>
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
In-Reply-To: <200509290032.26815.daniel.ritz@gmx.ch>
Message-ID: <Pine.LNX.4.44L0.0509282209110.11976-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Daniel Ritz wrote:

> USB ohci controller having no handler. yenta shares the line, has the
> correct handler installer, sees the interrupt, does not handle it since
> it was not the cardbus bridge generating the interrupt but ohci.
> nobody cares about the interrupt, nobody tells the hardware to stop.
> hello interrupt storm. and during reesume...boom.

Does this occur during resume from disk?  Most likely the controller was
enabled by the BIOS.  Try passing the "usb-handoff" parameter to the boot
kernel when you resume.

> btw. i'm still suggesting not doing that free_irq() thing in suspend, at
> least not short-term. i was thinking that it is a good idea in the beginning,
> but Linus changed my mind...[ patch for usb ready ]

I think that calling free_irq during suspend is a good thing in general, 
for the reason Adam Belay mentioned: It reduces interrupt overhead for 
runtime power management, where a few devices may be suspended while the 
rest of the system stays awake.

Of course, that doesn't mean I advocate going around right away and adding 
those free_irq/request_irq pairs to every driver.

Alan Stern

