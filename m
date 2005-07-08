Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVGHQNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVGHQNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVGHQNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:13:50 -0400
Received: from fep19.inet.fi ([194.251.242.244]:60926 "EHLO fep19.inet.fi")
	by vger.kernel.org with ESMTP id S262695AbVGHQNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:13:48 -0400
Message-ID: <42CEA639.1020605@mbnet.fi>
Date: Fri, 08 Jul 2005 19:13:45 +0300
From: Anssi Hannula <anssi.hannula@mbnet.fi>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Force Feedback interface to joydev
References: <4256BF90.7040408@mbnet.fi> <20050707134049.GA28382@ucw.cz> <42CD3A4B.1000203@mbnet.fi> <20050707150537.GB29510@ucw.cz>
In-Reply-To: <20050707150537.GB29510@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, Jul 07, 2005 at 05:20:59PM +0300, Anssi Hannula wrote:
> 
>>But I think we should not apply (with or without 64-bit) the patch (not 
>>yet, anyway), as I'm (slowly) working on restructuring the kernel FF 
>>interface and developing a user space library (and writing a generic HID 
>>PID FF-driver).
> 
> That sounds interesting. However - I don't know of many devices that'd
> be PID compliant except for the MS SideWinder ForceFeedback Pro 2.
> All the Logitechs, as far as I know don't implement full PID.

Unfortunately so :( Do you have any info on how close the FF 
implementation of the common FF devices is to the PID standard?
I had a poor choice of words in the previous message; I have only little 
code written, mainly I've been just thinking on a bunch of ideas on how 
we could do these things better (in other words, I've taken a summer break).
What I have written, is the PID driver (not complete yet) and a simple 
FF driver for Zeroplus based devices (VID 0x0c12, PID 0x0005 and 0x0008, 
very cheap Playstation-pads with USB connector, I have two branded "XFX 
Executioner Dual Impact" (BTW, their Windows driver is crap, doesn't 
support multiple devices and hangs Control Panel windows continuosly)). 
I could post a patch for the Zeroplus support, but with current FF 
driver model, that would be 90% copy-paste of hid-tmff.c & hid-lgff.c.

> 
>>As a matter of fact, I have two (lengthy) questions:
>>
>>1. What would be the best way to decide when to delete the effects of a 
>>specific process from the device? Currently it is done when flush is 
>>called. However, if one process holds multiple fd's to the interface 
>>(for example input fd through some gaming-input library and FF fd with 
>>the FF library), when any of these closes, all effects are deleted. Good 
>>way to overcome this would be fd-specific effects instead of 
>>process-specific, but I've got no idea how that would be done. One 
>>possible way would be introducing a new device file solely for the FF 
>>(so there would be no reason to hold multiple fd's to this file by the 
>>same process), but would that be overkill?
> 
> 
> I don't think that the fact that when a process holds the device open
> twice, the first close flushes the FF effects is that big a problem. 
> 

Ok.

>>2. Many simpler devices do not have any effect memory, for example there 
>>is just one HID report that is used to apply an effect and stop it. They 
>>could share very much of their timing code (they have effect memories 
>>and timers implemented in software in the kernel). These would also need 
>>software handling of envelopes, which is currently not implemented at 
>>all (also some effects could possibly be software emulated). So, should 
>>these be implemented by the kernel at all or should they implemented in 
>>the userspace library?
>  
> Probably both. The timing sensitive stuff in the kernel, all the rest in
> an userspace library.
> 

Hmm, that wouldn't leave much stuff into the userspace library (Effect 
storage for devices without memory, converting effects with envelopes to 
magnitude+time -sequences for devices without envelope support, etc). 
Maybe we should implement everything in the kernel... I have to think 
about it, maybe something big that should be implemented in userspace 
comes to my mind.

-- 
Anssi Hannula

