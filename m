Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVBRNbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVBRNbA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 08:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVBRNbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 08:31:00 -0500
Received: from gprs215-15.eurotel.cz ([160.218.215.15]:978 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261352AbVBRNax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 08:30:53 -0500
Date: Fri, 18 Feb 2005 14:26:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218132651.GA1813@elf.ucw.cz>
References: <20050213004729.GA3256@stusta.de> <Pine.LNX.4.56.0502141756220.7398@pentafluge.infradead.org> <20050214193438.GB7763@ucw.cz> <20050218122217.GA1523@elf.ucw.cz> <047401c515bb$437b5130$0f01a8c0@max>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <047401c515bb$437b5130$0f01a8c0@max>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> >> > CONFIG_INPUT_POWER was enabled - but it is nowhere possible to enable
> >> > this option.
> >>
> >> That was written a long time ago before the new power management went 
> >> in.
> >> On PDA's there is a power button and suspend button. So this was a hook
> >> so that the input layer could detect the power/suspend button being
> >> presses and then power down or turn off the device. Now that the new 
> >> power
> >> management is in what should we do?
> >
> >Change power.c to generate power events like ACPI does, most likely.
> 
> 
> There was some recent discussion of this on linux-input. It was basically 
> agreed that the input system should pass the request on to ACPI and/or apm 
> and Dmitry Torokhov (cc'd) proposed a patch that did this. His patch needed 
> to be slightly modified to work with arm apm, the final result being:
> 
> http://www.rpsys.net/openzaurus/2.6.11-rc4/input_power-r1.patch
> 
> I can confirm this works well on arm with apm enabled.

It has quite a lot of #ifdefs for CONFIG_APM/CONFIG_ARM/CONFIG_ACPI,
and it will not work on i386/APM, anyway. I still believe right
solution is to add input interface to ACPI. /proc/acpi/events needs to
die, being replaced by input subsystem.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
