Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030717AbWKUFJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030717AbWKUFJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 00:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966908AbWKUFJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 00:09:45 -0500
Received: from smtp2.mtco.com ([207.179.226.205]:34944 "EHLO smtp2.mtco.com")
	by vger.kernel.org with ESMTP id S966898AbWKUFJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 00:09:44 -0500
Message-ID: <45628A1A.8060101@billgatliff.com>
Date: Mon, 20 Nov 2006 23:09:46 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net> <200611201349.29999.david-b@pacbell.net> <4562760E.3000906@billgatliff.com> <200611202045.09760.david-b@pacbell.net>
In-Reply-To: <200611202045.09760.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Monday 20 November 2006 7:44 pm, Bill Gatliff wrote:
>  
>
>>So, you're saying that if GPIOA1 can come out on pins ZZ1 and BB6, then 
>>there would be two unique "GPIO numbers", one for each possibility?
>>    
>>
>
>No; one number, since it's controlled by the same set of bits in the GPIO
>controller (e.g. bit 12 in the registers of bank 3) regardless of how the
>signals are routed out through pins.  That's my point:  GPIO number need
>not imply a particular pin, and vice versa.
>  
>

Ok, thanks for the OMAP stuff.  I think I can understand now.

Why not have GPIO numbers refer to unique combinations of GPIO+pin?  If 
the GPIO line is tied to a piece of external hardware, that connection 
is surely through a specific pin.  So it seems like you'd need GPIO+pin 
every time there was an option.


>So regardless of whether GPIO_62 is routed to ball M7 or G20, it's still
>going to use number 62, which is bit 14 in various registers of the GPIO4
>module, starting at 0xfffbb400 ... and for good fun, the muxing API will
>refer to the balls on the (smaller) ZZG package even if your board uses
>the larger ZDY package (so your schematics might say J5 not M7, that table
>is very handy in such cases).
>  
>

Yikes!  :)

Explain to me why having GPIO enumerations map to unique GPIO+pin 
combinations would be a bad idea in this case?  It seems like the point 
here is to help a driver find and assert their GPIO _pin_ so that the 
driver can can talk to the attached external hardware.  Having an 
enumeration "GPIO62M7" would be a handy way to do that.  Maybe the 
enumeration is actually defined as ((0x400 << 16) | (14 << 8) | 4), or 
some other encoding that makes it easy in the implementation of 
gpio_XXX() to find the right registers and get the routing set up 
correctly.  It's just an opaque, magic number to the driver after all.

And since GPIOs are arch/mach/board-specific anyway, who would care if 
OMAP was the only system that had an enumeration called "GPIO62M7"?  
When other boards set up their platform_struct, they'd use the 
enumerations available for that platform.  "GPIOA1" in systems where 
that GPIO line could only go to one pin per the datasheet, for example.





b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

