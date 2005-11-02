Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVKBAjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVKBAjc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVKBAjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:39:31 -0500
Received: from tim.rpsys.net ([194.106.48.114]:21709 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932074AbVKBAja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:39:30 -0500
Subject: Re: best way to handle LEDs
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: vojtech@suse.cz, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20051101234459.GA443@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 00:39:13 +0000
Message-Id: <1130891953.8489.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 00:44 +0100, Pavel Machek wrote:
> Handheld machines have limited number of software-controlled status
> LEDs. Collie, for example has two of them; one is labeled "charge" and
> second is labeled "mail".

> I think even slow blinking was used somewhere. I have some code from
> John Lenz (attached); it uses sysfs interface, exports led collor, and
> allows setting different frequencies.
> 
> Is that acceptable, or should some other interface be used?

This has been discussed before and I know there are several differing
opinions.

Based upon previous discussion both here, on linux-arm-kernel and in the
handhelds community in general I came up with some ideas which I've yet
to have time to code. I'll try and describe it though:

The system would be in two sections (classes?), leds themselves and led
triggers. The leds would be driven by something similar to John's driver
Pavel attached. I think colour and other unchanging properties of the
device should be something exported in the device name which could have
some format like: device_name-colour-otherprops. 

Led triggers would be kernel sources of led on/off events. Some
examples:

2Hz Heartbeat - useful for debugging (and/or Generic Timer)
CPU Load indicator
Charging indicator
HDD activity (useful for microdrive on handheld)
Network activity
no doubt many more

led triggers would be connected to leds via sysfs. Each trigger would
probably have a number you could echo into an led's trigger attribute.
Sensible default mappings could be had by assigning a default trigger to
a device by name in the platform code that declares the led.

A trigger of "0" would mean the led becomes under userspace control via
sysfs for whatever userspace wishes to do with it.

The underlying principle would be to keep this class as simple as
possible whilst maximising the options open for triggering the leds from
both the kernel and userspace. 

Does this sound like a sensible way forward?

Richard





