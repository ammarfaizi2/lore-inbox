Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932693AbWKMSjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbWKMSjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755320AbWKMSjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:39:16 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:52366 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1755319AbWKMSjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:39:15 -0500
Date: Tue, 14 Nov 2006 03:38:11 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Bill Gatliff <bgat@billgatliff.com>
Cc: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Message-ID: <20061113183811.GA19979@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Bill Gatliff <bgat@billgatliff.com>,
	David Brownell <david-b@pacbell.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
	Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <20061113173800.GA19553@linux-sh.org> <4558B71F.9020502@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4558B71F.9020502@billgatliff.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 12:19:11PM -0600, Bill Gatliff wrote:
> True, but right now if the "multiple GPIO controllers" are on something 
> like i2c/spi, they have the synch/asynch issues that Jamey mentioned and 
> so are by definition out of scope for this proposal.  If the GPIO lines 
> are in an MMIO controller (PLD/FPGA, perhaps), then there's no reason 
> that the board implementer couldn't address that in their implementation 
> of the proposed functions.
> 
They're something that has to be accounted for in any sort of API, or we
just end up throwing it all out and starting over again. I was thinking
more of the SuperIO or mfd device scope, where this _is_ a requirement.

> ... except that I bet David is thinking that the implementations will be 
> in arch/arm/irq-at91rm9200.c or something, and not in 
> asm/arm/board-xyz.c, so it's the arch implementer's responsibility and 
> not the platform author's.  Yea, I see your point now.
> 
The problem with this is that it gets in to something that's getting
close to static pin state configuration. Setting up the mux from platform
code is brain-damage, since it's ultimately up to the system and driver
inserted at the time to grab and configure the pin as necessary, the
board or CPU code is not going to have any notion of the "preferred" pin
state, especially in the heavily muxed case.

> I say that we go with David's proposal for 2.6.19 anyway, and maybe by 
> 2.6.20 we'll have a consensus on how to address that with some 
> behind-the-API magic.  :)  (functions added to the machine descriptor, 
> maybe?)
> 
This is all too late for 2.6.19 regardless. We've gone this long without
a generic API, I see no reason to merge a temporary hack now if it's not
going to be satisfactory for people and require us to throw it all out
and start over again anyways.

I have a real need for supporting multiple controllers and handling
muxing dynamically from various drivers on various architectures, and
anything that exposes the pin # higher than the controller mapping to
function level is never going to work. Drivers have _zero_ interest in
pin #, only in the desired function.
