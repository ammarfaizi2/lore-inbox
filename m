Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755346AbWKMU6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbWKMU6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755347AbWKMU6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:58:31 -0500
Received: from smtp1.mtco.com ([207.179.226.202]:44178 "EHLO smtp1.mtco.com")
	by vger.kernel.org with ESMTP id S1755346AbWKMU6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:58:30 -0500
Message-ID: <4558DC75.6040109@billgatliff.com>
Date: Mon, 13 Nov 2006 14:58:29 -0600
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
References: <200611111541.34699.david-b@pacbell.net> <200611131215.39888.david-b@pacbell.net> <4558D4E6.4020601@billgatliff.com> <200611131253.00828.david-b@pacbell.net>
In-Reply-To: <200611131253.00828.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Monday 13 November 2006 12:26 pm, Bill Gatliff wrote:
>
>  
>
>>>Nah; look at arch/arm/plat-omap/gpio.c and ignore the mess, but observe
>>>that what you see there is essentially a bunch of "gpio controller"
>>>classes using the ugly "switch(type)" dispatch scheme instead of the
>>>prettier "type->op()" dispatch scheme.  All that stuff needs to be
>>>cleaner, but for now it'd suffice to add a new FPGA typecode.
>>>      
>>>
>>Agreed.  But if we add to the machine descriptor, then not only do you 
>>not need to touch arch-omap/gpio.c, but you can take that switch 
>>statement out, too.  Just one less chunk of code to tweak when a new 
>>platform is supported.
>>    
>>
>
>Do non-ARM platforms have board/machine descriptors on Linux, though?
>I thought most didn't ...
>  
>


PPC does.  See arch/ppc/platforms/chestnut.c:platform_init().

>One could come up with an implementation that uses GPIO numbers
>as indices into a descriptor array, and using board-specific
>initialization of that array ... just like with IRQs and irq_chip.
>
>That could lead to heavier weight implementations than I'd prefer
>to see (since GPIOs are a very light weight notion!), but it'd
>certainly provide a more reusable way to add GPIO controllers.
>
>All behind the API I proposed, note -- no changes needed.
>  
>


Indeed.  I'm all for lightweight, but especially for nice and neat code.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

