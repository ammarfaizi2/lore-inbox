Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVAYV15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVAYV15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVAYVZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:25:24 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:12416 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S262152AbVAYVUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:20:11 -0500
Date: Wed, 26 Jan 2005 00:39:27 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050126003927.189640d4@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050125195918.460f2b10.khali@linux-fr.org>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<20050124175449.GK3515@stusta.de>
	<20050124213442.GC18933@kroah.com>
	<20050124214751.GA6396@infradead.org>
	<20050125060256.GB2061@kroah.com>
	<20050125195918.460f2b10.khali@linux-fr.org>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 19:59:18 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> Hi all,
> 
> > As previously mentioned, these patches have had that, on the sensors
> > mailing list.  Lots of review and comments went into them there, and
> > the code was reworked quite a lot based on it.
> 
> That's right, I did actually review Evgeniy's code some times ago, as
> can be seen here:
> http://archives.andrew.net.au/lm-sensors/msg27817.html
> 
> I might however add the following:
> 
> 1* This was 5 months ago. I'd expect Evgeniy's code to have
> significantly evolved since, so an additional review now would certainly
> be welcome.

superio core was not changed much, all related changes were posted into 
lm_sensors mail list and discussed.
 
> 2* I only reviewed the superio code. The acb part is completely new so I
> obviously couldn't comment on it back then, and I skipped the gpio part
> because I admittedly have no particular interest in this part.

acb and gpio are logical devices and are very simple.
It was design task to create such model, where each device is as simple 
as possible, and only handle low-level operations.

> 3* Some of my objections have been ignored by Evgeniy. Among others, the
> choice of "sc" as a prefix for the superio stuff is definitely poor and
> has to be changed.
>
> http://archives.andrew.net.au/lm-sensors/msg27847.html

Yep %)
SuperIO Control - is a good name, sio_ I've seen somewhere...
 
> I don't think that getting the whole stuff (superio, acb and gpio)
> merged at once is a good idea. Preferably we would merge superio alone
> first, then update the drivers that are already in the kernel and could
> make use of it (it87, w83627hf, pc87360 and smsc47m1, all of i2c/sensors
> fame, come to mind). This would help ensure that Evgeniy's interface
> choices were correct, and would additionally be a very good example of
> how this interface must be used. Then, and only then IMVHO, should the
> gpio and acb stuff be merged.
> 
> Before all this happens, I really would like Evgeniy to present an
> overall plan of his current superio implementation. Last time we
> discussed about this, we obviously had different views on the interface
> level that should be proposed by the superio core, as well as how
> chip-specific values should be handled (or, according to me, mostly not
> handled). 

GPIO and AccessBus are very simple devices, and I added them just because
1. people often asked exactly about GPIO
2. I had only GPIO and ACB to test. Actually I had a RTC and WDT too, 
but noone never asked in any mail list about them, but I think it worth
to implement.

Addind SuperIO itself does not have much sence that it can not be 
tested without at least one logical device, thus I added two.

Porting existing SuperIO devices to the new schema is a very good task, 
but I had only SC1100 processor and PC87366 chip, so I created and tested 
superio chip drivers for them.

> Please note that I am certainly not the most qualified of us all to
> review this code. What I can do is check whether I will be able to use
> the new superio interface in the sensor chip drivers I mentioned above,
> and that's about it. I am not familiar enough with kernel core
> architectures to decide whether Evgeniy's approach is correct or not. I
> am willing to help, but I can do so only within my own current skills.

I always appreciate your comments, they are definitely right and helped
me very much.

Thank you.
 
> Thanks,
> -- 
> Jean Delvare
> http://khali.linux-fr.org/


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
