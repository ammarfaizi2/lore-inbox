Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbUCZRq6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 12:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbUCZRq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 12:46:57 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:51145 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264091AbUCZRqF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 12:46:05 -0500
Message-ID: <40646C2B.6020306@pacbell.net>
Date: Fri, 26 Mar 2004 09:45:15 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Robert Schwebel <robert@schwebel.de>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
References: <20040325221145.GJ10711@pengutronix.de> <20040326115947.GA22185@outpost.ds9a.nl> <20040326121928.GC16461@pengutronix.de> <4064530C.5030308@pacbell.net> <20040326163543.GD16461@pengutronix.de>
In-Reply-To: <20040326163543.GD16461@pengutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:
> On Fri, Mar 26, 2004 at 07:58:04AM -0800, David Brownell wrote:
> 
>>>>>-	.bDeviceClass =		DEV_CONFIG_CLASS,
>>>>>+	.bDeviceClass =		0x02,
>>>>
>>>>Is this wise?
>>>
>>>
>>>Until now DEV_CONFIG_CLASS was 0xFF, which results in Windows getting
>>>hickup. If you directly set this to 0x02 (Network Device) Win is happy.
>>
>>Actually I suspect setting it to USB_CLASS_COMM would be preferred, in
>>RNDIS-specific config descriptors....

(since:  #define USB_CLASS_COMM                  2)


> We have tried that, Windows does not like it. The only constellation
> where it worked was setting the device descriptor's bConfigClass=0x02. 

Sorry, I meant "device" descriptors.  Yes, I noticed their "spec"
had strange things to say.  Is there some reason you're not including
the CDC header and union descriptors?  That spec does talk about those,
and the erratum I found also talks about better CDC ACM conformance.


> RNDIS is a sensitive beast. Do one bit different results in that uggly
> "Error 10" message on the Windows side. We saw it when we started with
> the driver, we saw it when the driver was half way finished and we will
> see it again if somebody tweaks the driver without exactly knowing what
> the guys at Microsoft smoked when they designed that protocol :-) 

I thought it was "just say no to vendor-neutral protocols" crack ...
although that close to BC they would have much better options! ;)

The purist in me is annoyed that rather than just defining a purely
vendor-specific protocol, they re-used bits and pieces of the USB-IF
CDC-ACM spec.  It's not like they needed _any_ of it.  (Unless maybe
subtle sabotoge of CDC was a goal?)



Different topic:  I noticed that on PXA you were using "ep5-int".
That's documented as always using DATA0 -- data toggle not working.
Was that making any trouble for you?  I've never actually tried
using those endpoints, because of that functional limitation.

Also it looks like you've only tested this on PXA hardware.
Most of the patch is the (R)NDIS support code, which is easy
to merge, but the "g_ether" updates will take longer.

- Dave



> Robert


