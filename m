Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934315AbWKUGKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934315AbWKUGKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 01:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934317AbWKUGKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 01:10:39 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:34954 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S934315AbWKUGKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 01:10:37 -0500
Date: Tue, 21 Nov 2006 15:09:18 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: David Brownell <david-b@pacbell.net>
Cc: Bill Gatliff <bgat@billgatliff.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Message-ID: <20061121060918.GA2033@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	David Brownell <david-b@pacbell.net>,
	Bill Gatliff <bgat@billgatliff.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
	Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611202045.09760.david-b@pacbell.net> <45628A1A.8060101@billgatliff.com> <200611202135.39970.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611202135.39970.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 09:35:38PM -0800, David Brownell wrote:
> On Monday 20 November 2006 9:09 pm, Bill Gatliff wrote:
> > 	It seems like the point 
> > here is to help a driver find and assert their GPIO _pin_ so that the 
> > driver can can talk to the attached external hardware.
> 
> Updating the GPIO controller is always (all architectures!) done in terms
> of a number mapping to some controller and a bit number, not a pin.  The
> drivers never care about pins.
> 
> The only thing that cares about pins is board setup code -- briefly.
> 
That's rather simplifying things. The driver using the GPIO number isn't
going to care about the pin number that it's associated with, but that's
not to say that another driver won't have an interest in the alternate
function of the pin that the GPIO is tied to, while the first driver is
expecting it to be used as a GPIO.

There is a need to layer a pin mux API underneath the GPIO API to deal
with these sorts of things, but that's obviously up to the platform to
take care of, and I think your API is a fairly good staging ground for
building up the layering in the platform parts.

Claiming that we set the pins once in the board setup code and then
forget about it is not realistic. I can't imagine anyone with many
different pin functions under mux (OMAP2 does too) seriously taking that
position.

So given that, I would argue that drivers _do_ care about the pins, just
not through the GPIO API.
