Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030641AbWKUDMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030641AbWKUDMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 22:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030666AbWKUDMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 22:12:05 -0500
Received: from smtp1.mtco.com ([207.179.226.202]:42669 "EHLO smtp1.mtco.com")
	by vger.kernel.org with ESMTP id S1030641AbWKUDMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 22:12:03 -0500
Message-ID: <45626E7F.8000100@billgatliff.com>
Date: Mon, 20 Nov 2006 21:11:59 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       jamey.hicks@hp.com, Kevin Hilman <khilman@mvista.com>,
       Nicolas Pitre <nico@cam.org>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH] arch-neutral GPIO calls: AVR32 implementation
References: <200611111541.34699.david-b@pacbell.net> <20061116155455.3833f3a4@cad-250-152.norway.atmel.com> <200611201347.10331.david-b@pacbell.net>
In-Reply-To: <200611201347.10331.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>That's different from pin mux setup, which for most embedded
>systems is just making sure the SOC is configured to match
>what Linux expects.  The boot loader usualy does some of that,
>but it's probably not validated to do more than reliably boot
>an operating system ... so pin muxing can't realistically
>report anything as an error.  At best, it's a suggestion to
>update the bootloader someday.
>  
>

The ARM platforms I've worked with provide enough read-only information 
to allow you to report the status/assignment of a GPIO line, be it 
input, output, or assigned to one of several peripheral functions.  So 
you definitely want to read that stuff and report from it rather than 
just the state of a static array somewhere.

In fact, at least at first glance there's really no need for a static 
array at all on many chips that I can think of.  At most, the 
gpio_request() function should build up a temporary bitmask using 
information read from the hardware, then discard that temporary bitmask 
after the request is completed and the hardware actually configured.

>No, but letting the second one report the fatal error is a big help.
>And heck, you've got reasonable chance the first driver will work,
>if the second doesn't interfere with it!  (Or maybe it's the other
>way around.  At least you'd have logged a fatal error message ...)
>  
>

If the gpio_request() is reading from the hardware, it could determine 
that a GPIO line was assigned to a peripheral function by the 
bootloader; then it could refuse that request to the caller.  The fact 
that we don't have an API to assign the pin to a peripheral function 
would be even less of a concern then, because ordinary GPIO users of the 
pin could still avoid accidentally assigning a peripheral function pin 
to themselves as GPIO.

>Admittedly, the GPIO controller in those Atmel chips (AVR32,
>AT91) does have a one-to-one mapping for muxable pins and GPIOs,
>but that's not a portable notion.
>  
>

Can you refer me to a specific chip that is contrary to the AVR32/AT91 
notion, so that I can be sure I'm understanding what you're saying?




b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

