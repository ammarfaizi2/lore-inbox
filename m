Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVGGPIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVGGPIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVGGPGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:06:30 -0400
Received: from styx.suse.cz ([82.119.242.94]:60868 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261424AbVGGPFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:05:42 -0400
Date: Thu, 7 Jul 2005 17:05:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Anssi Hannula <anssi.hannula@mbnet.fi>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Force Feedback interface to joydev
Message-ID: <20050707150537.GB29510@ucw.cz>
References: <4256BF90.7040408@mbnet.fi> <20050707134049.GA28382@ucw.cz> <42CD3A4B.1000203@mbnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CD3A4B.1000203@mbnet.fi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 05:20:59PM +0300, Anssi Hannula wrote:
> Vojtech Pavlik wrote:
> >On Fri, Apr 08, 2005 at 08:29:52PM +0300, Anssi Hannula wrote:
> >
> >>This patch adds Force Feedback interface to joydev. I felt this 
> >>necessary because games usually don't run as root while evdev usually 
> >>can't be read or written by anyone else. Patch is against 2.6.12-rc2. If 
> >>there is a reason this can't be applied or needs modifications, please 
> >>say it :)
> >
> >Modern distros usually chown() the event devices to the user logged on
> >the console, so this shouldn't be a problem. Anyway, I'm not opposed to
> >adding the ioctl()s, but you should also add 64-bit compatible versions
> >of them.
> >
> 
> Well, with Mandriva 10.2 that happens only with jsX.
> 
> But I think we should not apply (with or without 64-bit) the patch (not 
> yet, anyway), as I'm (slowly) working on restructuring the kernel FF 
> interface and developing a user space library (and writing a generic HID 
> PID FF-driver).

That sounds interesting. However - I don't know of many devices that'd
be PID compliant except for the MS SideWinder ForceFeedback Pro 2.
All the Logitechs, as far as I know don't implement full PID.

> As a matter of fact, I have two (lengthy) questions:
> 
> 1. What would be the best way to decide when to delete the effects of a 
> specific process from the device? Currently it is done when flush is 
> called. However, if one process holds multiple fd's to the interface 
> (for example input fd through some gaming-input library and FF fd with 
> the FF library), when any of these closes, all effects are deleted. Good 
> way to overcome this would be fd-specific effects instead of 
> process-specific, but I've got no idea how that would be done. One 
> possible way would be introducing a new device file solely for the FF 
> (so there would be no reason to hold multiple fd's to this file by the 
> same process), but would that be overkill?

I don't think that the fact that when a process holds the device open
twice, the first close flushes the FF effects is that big a problem. 

> 2. Many simpler devices do not have any effect memory, for example there 
> is just one HID report that is used to apply an effect and stop it. They 
> could share very much of their timing code (they have effect memories 
> and timers implemented in software in the kernel). These would also need 
> software handling of envelopes, which is currently not implemented at 
> all (also some effects could possibly be software emulated). So, should 
> these be implemented by the kernel at all or should they implemented in 
> the userspace library?
 
Probably both. The timing sensitive stuff in the kernel, all the rest in
an userspace library.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
