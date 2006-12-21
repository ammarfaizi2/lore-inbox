Return-Path: <linux-kernel-owner+w=401wt.eu-S1423090AbWLUUvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423090AbWLUUvh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423091AbWLUUvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:51:37 -0500
Received: from smtp2.mtco.com ([207.179.226.205]:44320 "EHLO smtp2.mtco.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423090AbWLUUvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:51:36 -0500
X-Greylist: delayed 1153 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 15:51:36 EST
Message-ID: <458AEF79.5030600@billgatliff.com>
Date: Thu, 21 Dec 2006 14:32:57 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicolas Pitre <nico@cam.org>
CC: pHilipp Zabel <philipp.zabel@gmail.com>,
       David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Kevin Hilman <khilman@mvista.com>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
References: <200611111541.34699.david-b@pacbell.net> <200612201312.36616.david-b@pacbell.net> <20061220221252.732f4e97.akpm@osdl.org> <200612202244.03351.david-b@pacbell.net> <Pine.LNX.4.64.0612210925130.18171@xanadu.home> <74d0deb30612210703y735e53kf14e7c800dae7140@mail.gmail.com> <Pine.LNX.4.64.0612211205530.18171@xanadu.home> <74d0deb30612211132j6186ad00te536eb420636e7c8@mail.gmail.com> <Pine.LNX.4.64.0612211457390.18171@xanadu.home>
In-Reply-To: <Pine.LNX.4.64.0612211457390.18171@xanadu.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys:

>>Probably? What I am wondering is this: can the compiler
>>optimize away the range check that is duplicated in GPSR/GPCR
>>and  GPIO_bit for __gpio_set/get_value? Or could we optimize
>>this case by expanding the macros in place (which would mean
>>duplicating code from pxa-regs.h)...
>>    
>>

Who cares?  :)

I don't think there's much point in optimizing here, since these 
functions won't be hot paths anyway.  Yes, they'll be called in 
interrupt handlers and so we don't want them to be _too_ heavy, but 
compared to the overhead of an interrupt handler, a few extra 
instructions in the GPIO access will get lost in the noise.

Inlines generally seem to be more maintainable, give you a symbol that 
you can disassemble and breakpoint, etc.  I'll take them over the macro 
implementations any day, in this case even if there's a cost of a few 
instructions.

All IMHO, of course.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

