Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUCZVKe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUCZVKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:10:34 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:970 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261262AbUCZVKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:10:22 -0500
Message-ID: <40649C0D.80203@pacbell.net>
Date: Fri, 26 Mar 2004 13:09:33 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Robert Schwebel <robert@schwebel.de>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
References: <20040325221145.GJ10711@pengutronix.de> <20040326115947.GA22185@outpost.ds9a.nl> <20040326121928.GC16461@pengutronix.de> <4064530C.5030308@pacbell.net> <20040326163543.GD16461@pengutronix.de> <40646C2B.6020306@pacbell.net> <20040326184142.GF16461@pengutronix.de> <40648876.9050902@pacbell.net> <20040326205744.GH16461@pengutronix.de>
In-Reply-To: <20040326205744.GH16461@pengutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:

> A broader variety of controllers would indeed be helpful. When you have
> the stuff integrated the way you think it's right, just tell me and I'll
> test if it still works on our testbed. 

OK, that'll work fine.  Probably next week sometime.


>>It's not as if the protocol actually _needs_ an interrupt endpoint,
>>though the MSFT spec says it does. It's actually simpler for the host
>>to poll for completion on the control endpoint; none of the requests
>>should take very long to finish anyway. An RNDIS host might not even
>>notice those "toggle broken" issues.
> 
> 
> You probably underestimate the mental sensibility of Windows machines.
> We have seen cases where the Windows host just floods you with
> interrupts when it is not happy with things like these... 

Any system where BSOD is anything other than a screensaver is
lacking many kinds of sensibility ... :)

That question was mostly for curiousity.  The issue with interrupt
endpoints and data toggle is trivially resolved by using ep6in-bulk
instead of ep5in-int.  Which is what the autoconfig version will
likely end up doing, since default quality-of-service model for
interrupt endpoints includes having working data toggle.  PXA is
wierd in that way, but it's got endpoints to burn.


>>Did you have any evidence that the MSFT host was actually using that
>>interrupt endpoint? Like CATC snooping showing it never tried to
>>collect responses until the interrupt packet arrived?
> 
> 
> We have seen the packets with the protocol analyzer. I think we agree
> that using an interrupt endpoint just to announce that the gadget has a
> message for the host available, but that's how M$ designed it... 

Sure it gets sent, but does it get used?  If it does,
does the data toggle matter, or is MSFT by default
ignoring the toggle (and hence letting that needless
data stream be undetectably corrupted)?


>>Also, which versions of MS-Windows did you test against? Some of the
>>MSFT docs suggest version-specific protocol quirks.
> 
> 
> Win 98, XP, 2000. Auerswald currently tests all available other
> variants, and the tests they invented are _really_ crazy ;)

OK, so good basic coverage.  Modulo bugs introduced by
various service packs or national releases ... ;)

- Dave



