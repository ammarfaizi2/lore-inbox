Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUCZTqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 14:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUCZTqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 14:46:50 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:55189 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261156AbUCZTqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 14:46:48 -0500
Message-ID: <40648876.9050902@pacbell.net>
Date: Fri, 26 Mar 2004 11:45:58 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Robert Schwebel <robert@schwebel.de>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
References: <20040325221145.GJ10711@pengutronix.de> <20040326115947.GA22185@outpost.ds9a.nl> <20040326121928.GC16461@pengutronix.de> <4064530C.5030308@pacbell.net> <20040326163543.GD16461@pengutronix.de> <40646C2B.6020306@pacbell.net> <20040326184142.GF16461@pengutronix.de>
In-Reply-To: <20040326184142.GF16461@pengutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:
> ...
> 
> The problem is that, as it is now, it works. The whole RNDIS stuff is
> extremely time intensive to debug: when you have one odd value in some
> place, Windows just says "Error 10" and you have to guess what you did
> wrong. No further information available. So the best way to be
> successful may be to check it in as it is, maybe add some FIXMEs, and
> let the masses test the code. Then cleanup the remaining issues step by
> step and wait until nobody crys any more :-) 

Well, what I merge is necessarily going to work on more
hardware than just PXA ... it'll work over net2280 (at high
speed), goku, and surely other hardware.  In most cases
that'll just require sanity testing.  Maybe I can get Julian
to test on SH3, and it sounds like Andrew is getting close
on the MediaQ.

Once I can see it work, then it'll be ready for that more
widespread testing.  (Do penguins actually cry?)


>>Different topic:  I noticed that on PXA you were using "ep5-int".
>>That's documented as always using DATA0 -- data toggle not working.
>>Was that making any trouble for you?  I've never actually tried
>>using those endpoints, because of that functional limitation.
> 
> 
> Well, there is no other interrupt endpoint on the PXA, and it somehow
> works :-) 

It's not as if the protocol actually _needs_ an interrupt endpoint,
though the MSFT spec says it does.  It's actually simpler for the
host to poll for completion on the control endpoint; none of the
requests should take very long to finish anyway.  An RNDIS host
might not even notice those "toggle broken" issues.

Did you have any evidence that the MSFT host was actually using
that interrupt endpoint?   Like CATC snooping showing it never
tried to collect responses until the interrupt packet arrived?

Also, which versions of MS-Windows did you test against?  Some of
the MSFT docs suggest version-specific protocol quirks.  That's
where I expect most of the end-user problem reports to appear!
Which is why I'd like to have all the documented protocol quirks
(including the other CDC descriptors) resolved before this starts
to get really broad testing.

- Dave



