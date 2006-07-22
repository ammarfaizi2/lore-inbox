Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWGVKA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWGVKA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 06:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWGVKA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 06:00:56 -0400
Received: from mail1.cenara.com ([193.111.152.3]:7651 "EHLO kingpin.cenara.com")
	by vger.kernel.org with ESMTP id S932109AbWGVKAz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 06:00:55 -0400
From: Magnus =?utf-8?q?Vigerl=C3=B6f?= <wigge@bigfoot.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [RFC] input: Wacom tablet driver for simple X hotplugging
Date: Sat, 22 Jul 2006 12:00:51 +0200
User-Agent: KMail/1.9.1
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20060721211341.5366.93270.sendpatchset@pipe> <200607212209.05254.dtor@insightbb.com>
In-Reply-To: <200607212209.05254.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607221200.51700.wigge@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 July 2006 04:09, Dmitry Torokhov wrote:
> Hi Magnus,
>
> On Friday 21 July 2006 17:13, Magnus Vigerlöf wrote:
> > I'd appreciate whether you think this is a viable idea to make it as a
> > generic driver instead or should I continue with the Wacom-specific
> > one. I know the 'right' thing would be to make X truly hot-plug aware,
> > but this driver is something that would be possible to use in current
> > systems without any problems.
>
> Yes, I think fixing X would ultimately be time better spent.
As a long term fix, I'll consider getting involved with that.. However, I'd 
like to have something that works with my current setup, hence the.. 
temporary driver... Ok, I'm still going to use it as it solves one bad and 
one annoying thing I have with my Wacom tablet, but I'll keep it outside the 
kernel while better ways to solve this are made.

> > If it is a viable idea; Which other devices/types of device do you
> > think could be of interest to handle in a similar fashion? Tablets of
> > different makes/models are obvious, but are there any others that
> > would benefit from a similar driver?
>
> I do not think that creating device-specific "drivers" is a good idea
> even short term, especially in kernel. If you want a "persistent"
> device just create a userspace daemon and listen for hotplug events.
> When you see the input device you interested in grab it and pipe all
> data into somewhere. Next time you see hotplug event for the same
> device release the old instance and grab the new one. In cases when
> final recepient of events uses ioctls to query input devices capabilities
> you can create uinput feed back into kernel. This way your program will
> work for all types of input devices and no kernel changes are needed.

Creating userspace device drivers is something new for me. If you have some 
pointers to information about it I would be grateful (I've found the FUSD 
framework through google). From what I can read from the doc of FUSD, I'll 
have to open the inputX device if I want events from the tablet to propagate, 
and I'm afraid I might hit the oops in evdev I described in my previous 
thread if I do that.

So.. Are the locking issues in evdev something that is about to be fixed soon 
or should I contribute? Or do you think the issue will be completely 
irrelevant for a user-space driver?

Thanks
 Magnus
