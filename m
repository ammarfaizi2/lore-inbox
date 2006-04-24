Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWDXTIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWDXTIj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWDXTIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:08:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751130AbWDXTIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:08:38 -0400
Date: Mon, 24 Apr 2006 12:08:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0604241203130.3701@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
 <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Apr 2006, Linus Torvalds wrote:
> 
> You can get an edge by having your driver make sure that it clears the 
> interrupt source at some point where it requires an edge.

Btw, this is why we do end up saying that having _two_ devices share 
an edge-triggered setup really is something we cannot necessarily 
fix. That said, it is better to limp along and work as well as you can 
than to just throw up your hands.

So even then, we should at least give the user the _chance_ of being able 
to log in and give a bug-report, rather than "oops, the harddisk won't 
work, because the BIOS sets it up to share an edge-triggered interrupt 
with the network".

However, I'm all for printing out a honking huge warning if we have two 
devices sharing the same edge-triggered interrupt. But a single device 
should work, or the driver should be considered broken.

[ Btw, the "disable_irq()/enable_irq()" subsystem has been written so that 
  when you disable an edge-triggered interrupt, and the edge happens while 
  the interrupt is disabled, we will re-play the interrupt at enable time. 
  Exactly so that drivers can have an easier time and don't have to 
  normally worry about whether something is edge or level-triggered.

  However, if you're within an interrupt, that doesn't mean that you can 
  just disable the irq and hope that it acts as if it was level-triggered 
  when you enable it again. ]

		Linus
