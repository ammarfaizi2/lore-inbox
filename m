Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVBSG0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVBSG0v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 01:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVBSG0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 01:26:51 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:52659 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261355AbVBSG0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 01:26:48 -0500
Subject: Re: 2.6: drivers/input/power.c is never built
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Oliver Neukum <oliver@neukum.org>, Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200502182158.34910.dtor_core@ameritech.net>
References: <047401c515bb$437b5130$0f01a8c0@max>
	 <20050218213801.GA3544@ucw.cz> <20050218233148.GA1628@elf.ucw.cz>
	 <200502182158.34910.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1108794519.4098.24.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 19 Feb 2005 17:28:39 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-02-19 at 13:58, Dmitry Torokhov wrote: 
> On Friday 18 February 2005 18:31, Pavel Machek wrote:
> > I believe power and suspend keys should definitely go through
> > input. I'm not that sure about battery... Lid is somewhere in
> > between...
> I think we need a generic way of delivering system status changes to
> userspace. Something like acpid but bigger than that, something not
> so heavily oriented on ACPI. I wonder if that kernel connector patch
> should be looked at.

Absolutely. I've been thinking about this too, but haven't yet found the
time to put it down on paper/email yet.

I think we need a very generic system by which changes in anything 
remotely impacting on power management (kernelspace or userspace,
including ACPI, UPS drivers, keyboard handlers, devices etc) can notify
events to a userspace daemon. This daemon can act in accordance with
user specified policies (changeable on the fly) to implement system
level state changes (suspend to ram/disk, shutdown etc), run time power
management (shutdown a USB hub that just signalled the removal of its
last client), logging and so on. In some cases, it might set policy but
not be actively informed of the details of the application of that
policy (we don't feedback loops with a process leaving C3 to notify that
it's entering C3!).

This implies, of course, not just a generic way of notifying changes,
but a generic way of implementing policy.

Sound too ambitious, or am I thinking your thoughts after you?

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

