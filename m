Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWGWFY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWGWFY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 01:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWGWFY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 01:24:58 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:51564 "EHLO
	asav05.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750729AbWGWFY5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 01:24:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAHiiwkSBTg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Magnus =?utf-8?q?Vigerl=C3=B6f?= <wigge@bigfoot.com>
Subject: Re: [RFC] input: Wacom tablet driver for simple X hotplugging
Date: Sun, 23 Jul 2006 01:24:55 -0400
User-Agent: KMail/1.9.3
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20060721211341.5366.93270.sendpatchset@pipe> <200607212209.05254.dtor@insightbb.com> <200607221200.51700.wigge@bigfoot.com>
In-Reply-To: <200607221200.51700.wigge@bigfoot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607230124.56094.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 July 2006 06:00, Magnus Vigerlöf wrote:
> On Saturday 22 July 2006 04:09, Dmitry Torokhov wrote:
> >
> > I do not think that creating device-specific "drivers" is a good idea
> > even short term, especially in kernel. If you want a "persistent"
> > device just create a userspace daemon and listen for hotplug events.
> > When you see the input device you interested in grab it and pipe all
> > data into somewhere. Next time you see hotplug event for the same
> > device release the old instance and grab the new one. In cases when
> > final recepient of events uses ioctls to query input devices capabilities
> > you can create uinput feed back into kernel. This way your program will
> > work for all types of input devices and no kernel changes are needed.
> 
> Creating userspace device drivers is something new for me. If you have some 
> pointers to information about it I would be grateful (I've found the FUSD 
> framework through google). From what I can read from the doc of FUSD, I'll 
> have to open the inputX device if I want events from the tablet to propagate, 
> and I'm afraid I might hit the oops in evdev I described in my previous 
> thread if I do that.
> 

No, I was not talking about FUSD, just uinput driver that is in kernel
proper. Take a look at this:

	http://svn.navi.cx/misc/trunk/inputpipe/

It allows making input devices "network-transparent" and for example
use joystick physically connected to one box to play game on another.
Hmm, actually it is almost what you need, you just need modify server
to multiplex events into single device instead of creating separate
input devices.

> So.. Are the locking issues in evdev something that is about to be fixed soon 
> or should I contribute? Or do you think the issue will be completely 
> irrelevant for a user-space driver?
> 

No, I think you will still have the same issues with locking, unfortunately
I can't commint on a specific date when they will be resolved. Patches are
always welcome of course.

-- 
Dmitry
