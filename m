Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947390AbWKLB3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947390AbWKLB3z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 20:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947392AbWKLB3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 20:29:55 -0500
Received: from terminus.zytor.com ([192.83.249.54]:62667 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1947390AbWKLB3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 20:29:54 -0500
Message-ID: <45567868.8020405@zytor.com>
Date: Sat, 11 Nov 2006 17:27:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net>
In-Reply-To: <200611111541.34699.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> 
>   - Only intended for use with "real" GPIOs that work from IRQ context;
>     e.g. pins on a SOC that are controlled by chip register access.
> 
>   - Doesn't handle I2C or SPI based GPIOs.  I think we actually need
>     a different API for those "message based" GPIOs, where synchronous
>     get/set requires sleeping (and is thus unusable from IRQ context).
>     That API could be used for "real" GPIOs; the converse is not true.
> 
>   - No IORESOURCE_GPIO resource type (could be added though).
> 
>   - Can be trivially implemented today, on many systems (see partial
>     list above) ... no "provider" or gpiochip API necessary.
> 
>   - Provided in the form of a working patch, with sample implementation;
>     known to be viable on multiple architectures and platforms.
> 
>   - Includes Documentation/gpio.txt
> 
> Comments?
> 

If this is done, I think it's essential that a "high-level" API (one 
that supports message-based GPIO) is provided at the same time.  The 
"high-level" API should be able to address the GPIOs addressed by the 
low-level API.  What we do *not* want is a bunch of stuff using the 
low-level API when the high-level API would work.

	-hpa
