Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVBSC6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVBSC6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 21:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVBSC6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 21:58:39 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:64358 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261429AbVBSC6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 21:58:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6: drivers/input/power.c is never built
Date: Fri, 18 Feb 2005 21:58:33 -0500
User-Agent: KMail/1.7.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <047401c515bb$437b5130$0f01a8c0@max> <20050218213801.GA3544@ucw.cz> <20050218233148.GA1628@elf.ucw.cz>
In-Reply-To: <20050218233148.GA1628@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502182158.34910.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 February 2005 18:31, Pavel Machek wrote:
> Hi!
> 
> > > What is the benefit of splitting the flow of information so?
> > 
> > It's split already. You get some from input (power and sleep keys on
> > keyboards, sound volume keys and display brightness on some notebooks),
> > some from ACPI events (power keys on notebooks and desktop cases, sound
> > volume, display brightness on other notebooks), some from /proc/acpi/*
> > (battery status, fan status), some from APM, from platform specific
> > devices, from hotplug, from userspace daemons (UPS status).
> > 
> > The question is how to unify it.
> > 
> > Using power.c to simply pass power/sleep keys to the ACPI event pipe
> > could get the input subsystem out of the loop at least. Maybe we could
> > even pass sound keys to it. 
> 
> I do not think passing sound keys through acpi is good idea. acpid
> does not know how to handle them, and X already know how to get them
> from input subsystem.

What X? I am not saying that sound events should go through acpid, but
why bringing X here? One may not even run X...

> 
> I believe power and suspend keys should definitely go through
> input. I'm not that sure about battery... Lid is somewhere in
> between...
>

I think we need a generic way of delivering system status changes to
userspace. Something like acpid but bigger than that, something not
so heavily oriented on ACPI. I wonder if that kernel connector patch
should be looked at.

-- 
Dmitry
