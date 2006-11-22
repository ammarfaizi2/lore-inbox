Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967082AbWKVD4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967082AbWKVD4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 22:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967083AbWKVD4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 22:56:38 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:65487 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S967082AbWKVD4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 22:56:37 -0500
Date: Wed, 22 Nov 2006 12:55:17 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Bill Gatliff <bgat@billgatliff.com>
Cc: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Message-ID: <20061122035517.GA8790@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Bill Gatliff <bgat@billgatliff.com>,
	David Brownell <david-b@pacbell.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611202135.39970.david-b@pacbell.net> <20061121060918.GA2033@linux-sh.org> <200611211013.19127.david-b@pacbell.net> <4563C5B1.2040304@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4563C5B1.2040304@billgatliff.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 09:36:17PM -0600, Bill Gatliff wrote:
> David Brownell wrote:
> >I know some folk say they "need" to remux after boot in
> >non-exceptional cases, but the ability to do that (or not) really
> >seems like a separate discussion.
> 
> I don't need to REmux, but I don't want to bother setting up the routing 
> manually at all.  I think the GPIO management stuff can do it properly 
> on my behalf, given the information we have to acquire to get the GPIO 
> API to work in the first place.
> 
You can't really have one without the other, and if you're going to add
that sort of functionality, it's not strictly tied to the GPIOs.

> Kind of like with request_irq() and enable_irq().  The driver is saying, 
> "I don't care what's actually behind this interrupt source X, I just 
> want it routed over to me".  If we commit to hiding the muxing behind 
> the API, instead of defining a new, parallel API,  we get that kind of 
> mentality for GPIO as well.
> 
As soon as a driver comes along and says that it wants, say, GPIO 42,
which happens to be an alternate pin function for pin #128, you've
effectively coupled the two, especially since the underlying refcounting
is more applicable to the pin function than the GPIO itself.

And this is something where you will have to remux, or at least force
that GPIOs availability through the board setup code, but there's little
point in dealing with mux issues in the board setup code at all if this
is done dynamically based off of the driver requirements and subsequent
refcounting.

Static muxing is something that no longer makes any sense. Devices are
piling more and more desired functions under mux, and that's not going
away.
