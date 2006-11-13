Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755341AbWKMUxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbWKMUxI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755340AbWKMUxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:53:08 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:35252 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1755341AbWKMUxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:53:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=O0UHx/NVbyHNNu6bRWYhTOPOoOuLgr/f/1k1ANie++vsqKai+bEUPvtJage/qV0GSKiSk9yTPteONtxbK+VdQhMzz7nh3OujkqxYAcdu06TReqcxunqIkb3KSYAKjLRdaX7+7C9rFP54g6Nf142Dp+yf/0Kh6ZaE0SMOo03dyIU=  ;
X-YMail-OSG: E.LT1OIVM1mXlfaH6BIebzVDTA3u8UTgZiOsKGUbd8TPg39k1u21N.RTZ5NLmveFp.30fXFrc0nb.7.atHn.kUok7UxJAYkMq62J6N7mBsx2GgcJuzigMxDixblUOastL86FIIzT9dHW_N9cRaNF9rmJZ45_d8Qcvlk-
From: David Brownell <david-b@pacbell.net>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Mon, 13 Nov 2006 12:53:00 -0800
User-Agent: KMail/1.7.1
Cc: Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611131215.39888.david-b@pacbell.net> <4558D4E6.4020601@billgatliff.com>
In-Reply-To: <4558D4E6.4020601@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131253.00828.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 12:26 pm, Bill Gatliff wrote:

> >Nah; look at arch/arm/plat-omap/gpio.c and ignore the mess, but observe
> >that what you see there is essentially a bunch of "gpio controller"
> >classes using the ugly "switch(type)" dispatch scheme instead of the
> >prettier "type->op()" dispatch scheme.  All that stuff needs to be
> >cleaner, but for now it'd suffice to add a new FPGA typecode.
> 
> Agreed.  But if we add to the machine descriptor, then not only do you 
> not need to touch arch-omap/gpio.c, but you can take that switch 
> statement out, too.  Just one less chunk of code to tweak when a new 
> platform is supported.

Do non-ARM platforms have board/machine descriptors on Linux, though?
I thought most didn't ...

One could come up with an implementation that uses GPIO numbers
as indices into a descriptor array, and using board-specific
initialization of that array ... just like with IRQs and irq_chip.

That could lead to heavier weight implementations than I'd prefer
to see (since GPIOs are a very light weight notion!), but it'd
certainly provide a more reusable way to add GPIO controllers.

All behind the API I proposed, note -- no changes needed.

- Dave


