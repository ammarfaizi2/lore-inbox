Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755268AbWKMU11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbWKMU11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755269AbWKMU11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:27:27 -0500
Received: from smtp1.mtco.com ([207.179.226.202]:47495 "EHLO smtp1.mtco.com")
	by vger.kernel.org with ESMTP id S1755268AbWKMU10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:27:26 -0500
Message-ID: <4558D4E6.4020601@billgatliff.com>
Date: Mon, 13 Nov 2006 14:26:14 -0600
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
References: <200611111541.34699.david-b@pacbell.net> <200611131121.23944.david-b@pacbell.net> <4558CAE4.1020202@billgatliff.com> <200611131215.39888.david-b@pacbell.net>
In-Reply-To: <200611131215.39888.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Monday 13 November 2006 11:43 am, Bill Gatliff wrote:
>  
>
>>Maybe we should codify an approach for that now, i.e. add to the 
>>reference implementation some code that hands off out-of-range GPIO 
>>lines to a function in the machine descriptor:
>>
>>
>>+static inline int gpio_direction_input(unsigned gpio)
>>+	{ if (gpio < OMAP_MAX_ARCH_GPIO) return __gpio_set_direction(gpio, 1);
>>+	  else if(mdesc->platform_gpio_set_direction) platform_gpio_set_direction(gpio, 1); }
>>
>>
>>... conveniently neglecting the way you find mdesc.  :)
>>    
>>
>
>Nah; look at arch/arm/plat-omap/gpio.c and ignore the mess, but observe
>that what you see there is essentially a bunch of "gpio controller"
>classes using the ugly "switch(type)" dispatch scheme instead of the
>prettier "type->op()" dispatch scheme.  All that stuff needs to be
>cleaner, but for now it'd suffice to add a new FPGA typecode.
>  
>

Agreed.  But if we add to the machine descriptor, then not only do you 
not need to touch arch-omap/gpio.c, but you can take that switch 
statement out, too.  Just one less chunk of code to tweak when a new 
platform is supported.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

