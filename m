Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVAYVoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVAYVoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbVAYVm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:42:26 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:30989 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262174AbVAYVky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:40:54 -0500
Date: Tue, 25 Jan 2005 22:40:51 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-Id: <20050125224051.190b5ff9.khali@linux-fr.org>
In-Reply-To: <20050126003927.189640d4@zanzibar.2ka.mipt.ru>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<20050124175449.GK3515@stusta.de>
	<20050124213442.GC18933@kroah.com>
	<20050124214751.GA6396@infradead.org>
	<20050125060256.GB2061@kroah.com>
	<20050125195918.460f2b10.khali@linux-fr.org>
	<20050126003927.189640d4@zanzibar.2ka.mipt.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeniy & all,

> > 1* This was 5 months ago. I'd expect Evgeniy's code to have
> > significantly evolved since, so an additional review now would
> > certainly be welcome.
> 
> superio core was not changed much, all related changes were posted
> into  lm_sensors mail list and discussed.

Well, according to the mailing-list archives, which have a better memory
than I do, I skipped at least one:

http://archives.andrew.net.au/lm-sensors/msg18655.html

So I suspect that this update at least was never reviewed by anyone (on
the sensors list at least).

And while we are at it, this post by Andrew is certainly of interest
too:

http://archives.andrew.net.au/lm-sensors/msg18749.html

> > 3* Some of my objections have been ignored by Evgeniy. Among others,
> > the choice of "sc" as a prefix for the superio stuff is definitely
> > poor and has to be changed.
> >
> > http://archives.andrew.net.au/lm-sensors/msg27847.html
> 
> Yep %)
> SuperIO Control - is a good name, sio_ I've seen somewhere...

Sure, sio would be better, or even superio in whole. Anything that
reminds "Super-I/O" is fine with me. sc doesn't.

> GPIO and AccessBus are very simple devices, and I added them just
> because 1. people often asked exactly about GPIO
> 2. I had only GPIO and ACB to test. Actually I had a RTC and WDT too, 
> but noone never asked in any mail list about them, but I think it
> worth to implement.
> 
> Addind SuperIO itself does not have much sence that it can not be 
> tested without at least one logical device, thus I added two.
> 
> Porting existing SuperIO devices to the new schema is a very good
> task,  but I had only SC1100 processor and PC87366 chip, so I created
> and tested  superio chip drivers for them.

The PC87366 has integrated sensors, some of which have to be connected
whatever your configuration: voltage inputs 7 to 10 and third
temperature channel. We have a driver for it in the kernel:
drivers/i2c/chips/pc87360. So if you have such a chip, this is actually
someone you can use as a test for your superio subsystem.

If you can provide a patch which adds your superio core driver and one
which modifies the pc87360 driver to take make use of it, and only that,
this would certainly be easier for everyone (and especially me) to
review your superio code. Once this is in, incremental patches for the
additional features should be easier for you to generate and for the
rest of us to review.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
