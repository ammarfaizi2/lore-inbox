Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVBRNOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVBRNOZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 08:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVBRNOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 08:14:25 -0500
Received: from tim.rpsys.net ([194.106.48.114]:25812 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261352AbVBRNOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 08:14:18 -0500
Message-ID: <047401c515bb$437b5130$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Pavel Machek" <pavel@suse.cz>, "Vojtech Pavlik" <vojtech@suse.cz>,
       "James Simmons" <jsimmons@pentafluge.infradead.org>,
       "Adrian Bunk" <bunk@stusta.de>
Cc: "Linux Input Devices" <linux-input@atrey.karlin.mff.cuni.cz>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <dmitry.torokhov@gmail.com>
References: <20050213004729.GA3256@stusta.de> <Pine.LNX.4.56.0502141756220.7398@pentafluge.infradead.org> <20050214193438.GB7763@ucw.cz> <20050218122217.GA1523@elf.ucw.cz>
Subject: Re: 2.6: drivers/input/power.c is never built
Date: Fri, 18 Feb 2005 13:10:43 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > In 2.6, drivers/input/power.c would only have been built if
> > > CONFIG_INPUT_POWER was enabled - but it is nowhere possible to enable
> > > this option.
> >
> > That was written a long time ago before the new power management went 
> > in.
> > On PDA's there is a power button and suspend button. So this was a hook
> > so that the input layer could detect the power/suspend button being
> > presses and then power down or turn off the device. Now that the new 
> > power
> > management is in what should we do?
>
> Change power.c to generate power events like ACPI does, most likely.


There was some recent discussion of this on linux-input. It was basically 
agreed that the input system should pass the request on to ACPI and/or apm 
and Dmitry Torokhov (cc'd) proposed a patch that did this. His patch needed 
to be slightly modified to work with arm apm, the final result being:

http://www.rpsys.net/openzaurus/2.6.11-rc4/input_power-r1.patch

I can confirm this works well on arm with apm enabled.

Regards,

Richard 

