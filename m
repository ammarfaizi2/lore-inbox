Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbVKUUbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVKUUbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVKUUbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:31:47 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:16872 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751017AbVKUUbq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:31:46 -0500
Message-ID: <43822EAD.9050803@ru.mvista.com>
Date: Mon, 21 Nov 2005 23:31:41 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Komal Shah <komal_shah802003@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       dmitry pervushin <dpervushin@gmail.com>, Greg KH <greg@kroah.com>,
       spi-devel-general@lists.sourceforge.net,
       Stephen Street <stephen@streetfiresound.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [spi-devel-general] SPI
References: <20051121092923.10651.qmail@web32909.mail.mud.yahoo.com> <200511211017.49509.david-b@pacbell.net>
In-Reply-To: <200511211017.49509.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

apart of just struggling whose core is better, I'd like to find 
rationale in both.
I think that we've got to have a final convergence of the cores, so 
let's pass over to constructive dialogue.

>I'll comment that you've significantly mischaracterized the work I've
>done in your "list of main differences" in several respects, but I've
>not yet read the whole thing.
>  
>
Can you please review both the list and the new core and comment on the 
recent one?

>Also, that won't work on current GIT trees because it's not caught
>up to the "remove third argument to device_driver.suspend()" patch,
>which Russell King did as followup to the previous version of my
>patch.  (URL for current version of my patch is below, which IS
>caught up to that and other 2.6.14+ changes.)
>
>
>  
>
True, although it works with 2.6.14 which is probably the most recent 
kernel needed for anyone else aside :-)
Will respin shortly anyway.

>>I see no discussion on the kernel/spi-devel list on this patch. I am
>>working on TI OMAP2420 (linux-omap-open-source), I want to use this
>>latest spi framework for omap24xx spi driver implementation.
>>    
>>
>
>I'd suggest instead using the light weight framework I sent before:
>
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=113169588230519&w=2
>
>That's got a bunch of drivers working in it right now, including an
>ads7846 (touchscreen/sensor) driver that runs on both OMAP and PXA
>controller drivers.  Reusable drivers ... what a concept!  :)
>  
>
Well, I can agree that for simple SPI devices David's core might be 
easier to use.

>>SPI already works on 24xx using custom hack for audio and touchscreen
>>but it can not be submitted to linux-omap tree, as it is not following
>>proper driver model.
>>    
>>
>
>That's one of the reasons I started on the SPI stuff ... the current
>MicroWire hookup (for TSC210x audio/touchscreen and ADS7846 touchscreen)
>sort of sucks from the driver model perspective.  But then, so did the
>first half dozen SPI "framework" patches I saw posted on LKML, so I
>though it might help if I fixed that not-so-little issue.  :)
>
>I've tried to take the best of the frameworks I've seen, subject to the
>basic constraints that
>
>(a) SPI shouldn't perpetuate the driver model botches of I2C;
>(b) ditto I2C's "everything is synchronous" botches;
>  
>
Those two are fulfilled in both cores.

>(c) it should work well with DMA, to support things like DataFlash;
>  
>
Lemme point once again that David' core is not DMA-ready. More comments 
on that will follow, lemme get some sleep :)

>(d) given the variety of SPI chips, protocol controls are needed;
>  
>
IMHO this one is fulfilled in both.

>(e) place minimal implementation constraints on controller drivers.
>  
>
Yeah David's core fulfilling this one well. However, my view on that is 
it's leaving too much for the controller driver to implement, requiring 
so much sophistication from it that it partially disapproves the whole 
concept of having the _core_.

>>If you guys give me the latest update on this framework and it's
>>possiblity of getting accepted in linux-kernel mailing list?
>>_otherwise_ I can take this framework write a driver for 24xx and
>>submit to linux-omap-open-source mailing list, so that it can get omap
>>specific audience + more testing.
>>    
>>
>
>Anything can be accepted onto LKML ... it's an open list!  The issue
>is more whether some API starts to become official, by merging into
>first the MM tree and then the mainstream kernel.  That matters because
>the point of a framework is code re-use, and that won't happen if there
>are multiple frameworks.
>  
>
Yeah and I do suggest that we start a true convergence of the cores. I 
think that it should happen after David thoroughly reviews/comments 
Dmitry's notes on his core rather than just say in bare words that 
they're invalid.

Vitaly
