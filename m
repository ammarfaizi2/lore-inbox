Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVBRVjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVBRVjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 16:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVBRVi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 16:38:58 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:57303 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261533AbVBRVh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 16:37:27 -0500
Date: Fri, 18 Feb 2005 22:38:01 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Pavel Machek <pavel@suse.cz>, dtor_core@ameritech.net,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218213801.GA3544@ucw.cz>
References: <047401c515bb$437b5130$0f01a8c0@max> <20050218202443.GB1403@elf.ucw.cz> <20050218204018.GA2760@ucw.cz> <200502182223.19896.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502182223.19896.oliver@neukum.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 10:23:19PM +0100, Oliver Neukum wrote:

> What is the benefit of splitting the flow of information so?

It's split already. You get some from input (power and sleep keys on
keyboards, sound volume keys and display brightness on some notebooks),
some from ACPI events (power keys on notebooks and desktop cases, sound
volume, display brightness on other notebooks), some from /proc/acpi/*
(battery status, fan status), some from APM, from platform specific
devices, from hotplug, from userspace daemons (UPS status).

The question is how to unify it.

Using power.c to simply pass power/sleep keys to the ACPI event pipe
could get the input subsystem out of the loop at least. Maybe we could
even pass sound keys to it. 

It's probably still the best option, though I argued for doing it the
other way around - I want to know the pros and cons for all the possible
approaches.

> > I think that's all you need to trigger actions. You don't need the exact
> > percentage of the battery, and you don't need the exact AC voltage at
> > input. 
> 
> That is very debateable. I might want a quiet mode and would be
> interested in notifications about thermal data and fan status. 
> 
> 	Regards
> 		Oliver
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
