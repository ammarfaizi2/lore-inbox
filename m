Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTENWeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTENWeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:34:23 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:36970
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S262984AbTENWeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:34:19 -0400
Message-ID: <3EC2C760.6050604@rogers.com>
Date: Wed, 14 May 2003 18:46:56 -0400
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Riley Williams <Riley@Williams.Name>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] NE2000 driver updates
References: <BKEGKPICNAKILKJKMHCACEOMCPAA.Riley@Williams.Name>
In-Reply-To: <BKEGKPICNAKILKJKMHCACEOMCPAA.Riley@Williams.Name>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Wed, 14 May 2003 18:46:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams wrote:

>Hi Jeff.
>
> > Attached is the rough beginnings of a patch that does this.
> >
> > Basically it adds ISA bus support and uses it in ne.c.
> >
> > ISA Bus Support
> > --
> > The bus uses ioaddr as the bus_id because I don't think we have
> > anything else unique to use.
>
>If there's going to be any problems, it's with devices claiming the
>same IOaddr as each other - and certain addresses are far too common
>where that's concerned - especially 0x0300 through 0x031F which are
>almost universal in their use !!!!!!!
>  
>
This is a problem that already exists, if two devices are at the same io 
address there is not much we can do. Autoprobe will pick up one first 
and the second is out of luck.
(or are you confusing bus_id with device_id?)

>
> > Drivers are responsible for adding devices to the bus, through 
> > isa_device_register(). Once added, devices stay around forever,
> > even after driver unload. Right now I use the device id's stolen
> > from eisa, but I can't see any reason not to just make ids up as
> > necessary.
>
> > ne.c
> > ---
> > ne_probe (the function called by Space.c) autoprobes for ne2000
> > devices and then as it finds them it calls isa_register_device.
> > It always returns -ENODEV. (eventually if all the net drivers
> > get moved to this model, some of this stuff could be moved into
> > Space.c) Later on, during module init the driver registers itself
> > with ISA bus and then ne_isa_probe is called appropriately.
>
>According to what I've been told and have seen for myself in the
>past, having this autoprobe at address 0x0300 is VERY likely to lock
>the machine up solid because of the number of other devices using
>that range. However, autoprobing the other addresses that this card
>can be at is apparently far less dangerous.
>
Nothing is being changed as far as this concerned. If you compile ne.c 
into your kernel you get autoprobe at 0x300.

-Jeff

