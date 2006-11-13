Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755310AbWKMSVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbWKMSVR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755311AbWKMSVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:21:16 -0500
Received: from smtp2.mtco.com ([207.179.226.205]:51329 "EHLO smtp2.mtco.com")
	by vger.kernel.org with ESMTP id S1755310AbWKMSVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:21:15 -0500
Message-ID: <4558B71F.9020502@billgatliff.com>
Date: Mon, 13 Nov 2006 12:19:11 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>
CC: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net> <20061113173800.GA19553@linux-sh.org>
In-Reply-To: <20061113173800.GA19553@linux-sh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul:

Paul Mundt wrote:

>I'm not convinced that exposing the pin number to drivers is the way to
>go. The pin numbers themselves are rarely portable across "similar" CPUs
>with identical peripherals, while the pin function itself may be
>portable (or simply unecessary). Pin muxing also needs to be handled in a
>much more transparent and intelligent fashion, which is something else
>that is fairly easy to do when looking at a symbolic name for the pin
>function rather than the pin # itself.
>  
>

I don't think he's exporting pin numbers per se.  It's more like an 
enumeration that comes in from the platform data that the driver passes 
back to the GPIO (and, indirectly, the IRQ) API.

>Any API also needs to allow for multiple GPIO controllers, as it's rarely
>just the CPU that has these or needs to manipulate them.
>  
>


True, but right now if the "multiple GPIO controllers" are on something 
like i2c/spi, they have the synch/asynch issues that Jamey mentioned and 
so are by definition out of scope for this proposal.  If the GPIO lines 
are in an MMIO controller (PLD/FPGA, perhaps), then there's no reason 
that the board implementer couldn't address that in their implementation 
of the proposed functions.

... except that I bet David is thinking that the implementations will be 
in arch/arm/irq-at91rm9200.c or something, and not in 
asm/arm/board-xyz.c, so it's the arch implementer's responsibility and 
not the platform author's.  Yea, I see your point now.

I say that we go with David's proposal for 2.6.19 anyway, and maybe by 
2.6.20 we'll have a consensus on how to address that with some 
behind-the-API magic.  :)  (functions added to the machine descriptor, 
maybe?)


b.g. , who can't post to the lists at the moment because his ISP is 
having a sudden fit of outbound email filter mania.

-- 
Bill Gatliff
bgat@billgatliff.com

