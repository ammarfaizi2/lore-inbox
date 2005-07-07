Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVGGOVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVGGOVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVGGOVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 10:21:34 -0400
Received: from fep19.inet.fi ([194.251.242.244]:54670 "EHLO fep19.inet.fi")
	by vger.kernel.org with ESMTP id S261573AbVGGOVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 10:21:02 -0400
Message-ID: <42CD3A4B.1000203@mbnet.fi>
Date: Thu, 07 Jul 2005 17:20:59 +0300
From: Anssi Hannula <anssi.hannula@mbnet.fi>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Force Feedback interface to joydev
References: <4256BF90.7040408@mbnet.fi> <20050707134049.GA28382@ucw.cz>
In-Reply-To: <20050707134049.GA28382@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Fri, Apr 08, 2005 at 08:29:52PM +0300, Anssi Hannula wrote:
> 
>>This patch adds Force Feedback interface to joydev. I felt this 
>>necessary because games usually don't run as root while evdev usually 
>>can't be read or written by anyone else. Patch is against 2.6.12-rc2. If 
>>there is a reason this can't be applied or needs modifications, please 
>>say it :)
> 
> Modern distros usually chown() the event devices to the user logged on
> the console, so this shouldn't be a problem. Anyway, I'm not opposed to
> adding the ioctl()s, but you should also add 64-bit compatible versions
> of them.
> 

Well, with Mandriva 10.2 that happens only with jsX.

But I think we should not apply (with or without 64-bit) the patch (not 
yet, anyway), as I'm (slowly) working on restructuring the kernel FF 
interface and developing a user space library (and writing a generic HID 
PID FF-driver).
As a matter of fact, I have two (lengthy) questions:

1. What would be the best way to decide when to delete the effects of a 
specific process from the device? Currently it is done when flush is 
called. However, if one process holds multiple fd's to the interface 
(for example input fd through some gaming-input library and FF fd with 
the FF library), when any of these closes, all effects are deleted. Good 
way to overcome this would be fd-specific effects instead of 
process-specific, but I've got no idea how that would be done. One 
possible way would be introducing a new device file solely for the FF 
(so there would be no reason to hold multiple fd's to this file by the 
same process), but would that be overkill?

2. Many simpler devices do not have any effect memory, for example there 
is just one HID report that is used to apply an effect and stop it. They 
could share very much of their timing code (they have effect memories 
and timers implemented in software in the kernel). These would also need 
software handling of envelopes, which is currently not implemented at 
all (also some effects could possibly be software emulated). So, should 
these be implemented by the kernel at all or should they implemented in 
the userspace library?


-- 
Anssi Hannula

