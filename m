Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbVAYWTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVAYWTe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVAYWSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:18:02 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:42889 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S262172AbVAYWNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:13:09 -0500
Date: Wed, 26 Jan 2005 01:35:56 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050126013556.247b74bc@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050125224051.190b5ff9.khali@linux-fr.org>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<20050124175449.GK3515@stusta.de>
	<20050124213442.GC18933@kroah.com>
	<20050124214751.GA6396@infradead.org>
	<20050125060256.GB2061@kroah.com>
	<20050125195918.460f2b10.khali@linux-fr.org>
	<20050126003927.189640d4@zanzibar.2ka.mipt.ru>
	<20050125224051.190b5ff9.khali@linux-fr.org>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 22:40:51 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Evgeniy & all,
> 
> > > 1* This was 5 months ago. I'd expect Evgeniy's code to have
> > > significantly evolved since, so an additional review now would
> > > certainly be welcome.
> > 
> > superio core was not changed much, all related changes were posted
> > into  lm_sensors mail list and discussed.
> 
> Well, according to the mailing-list archives, which have a better memory
> than I do, I skipped at least one:
> 
> http://archives.andrew.net.au/lm-sensors/msg18655.html
> 
> So I suspect that this update at least was never reviewed by anyone (on
> the sensors list at least).

I have one rule - if noone answers that it means noone objects,
or it is not interesting for anyone, and thus noone objects.

> And while we are at it, this post by Andrew is certainly of interest
> too:
> 
> http://archives.andrew.net.au/lm-sensors/msg18749.html

I believe he commented connector patch mostly - we had some very little
private discussion that time about it.

I've posted connector patch several times to lkml - no answers except 
Alan Cox, thus noone objects but patch is very usefull.

> > > 3* Some of my objections have been ignored by Evgeniy. Among others,
> > > the choice of "sc" as a prefix for the superio stuff is definitely
> > > poor and has to be changed.
> > >
> > > http://archives.andrew.net.au/lm-sensors/msg27847.html
> > 
> > Yep %)
> > SuperIO Control - is a good name, sio_ I've seen somewhere...
> 
> Sure, sio would be better, or even superio in whole. Anything that
> reminds "Super-I/O" is fine with me. sc doesn't.
> 
> > GPIO and AccessBus are very simple devices, and I added them just
> > because 1. people often asked exactly about GPIO
> > 2. I had only GPIO and ACB to test. Actually I had a RTC and WDT too, 
> > but noone never asked in any mail list about them, but I think it
> > worth to implement.
> > 
> > Addind SuperIO itself does not have much sence that it can not be 
> > tested without at least one logical device, thus I added two.
> > 
> > Porting existing SuperIO devices to the new schema is a very good
> > task,  but I had only SC1100 processor and PC87366 chip, so I created
> > and tested  superio chip drivers for them.
> 
> The PC87366 has integrated sensors, some of which have to be connected
> whatever your configuration: voltage inputs 7 to 10 and third
> temperature channel. We have a driver for it in the kernel:
> drivers/i2c/chips/pc87360. So if you have such a chip, this is actually
> someone you can use as a test for your superio subsystem.

Btw, they appeared almost the same time :)
Difference was about several days...

I have pc8736x logical devices in my TODO list, but they are currently 
preempted by acrypto, but I definitely will get it very soon.

> If you can provide a patch which adds your superio core driver and one
> which modifies the pc87360 driver to take make use of it, and only that,
> this would certainly be easier for everyone (and especially me) to
> review your superio code. Once this is in, incremental patches for the
> additional features should be easier for you to generate and for the
> rest of us to review.

pc87360.c can not be used with superio as is, it requires big rewrite, 
since you implemented it as part of i2c core, 
that is why I created parts that was not touched by your driver.
Since GPIO can be used with w1 it had greater priority.

Your driver is part of i2c core, it just not supposed to be used 
in superio, although many hardware routings could be used.

I will use it as a base for other superio logical devices.

> Thanks,
> -- 
> Jean Delvare
> http://khali.linux-fr.org/


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
