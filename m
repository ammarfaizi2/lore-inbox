Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTEOBnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTEOBnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:43:00 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:65152 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263570AbTEOBm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:42:58 -0400
Date: Wed, 14 May 2003 21:51:34 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Jeff Muizelaar <muizelaar@rogers.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] NE2000 driver updates
Message-ID: <20030514215134.GA32285@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Jeff Muizelaar <muizelaar@rogers.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, greg@kroah.com,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <3EB15127.2060409@rogers.com> <1051817031.21546.23.camel@dhcp22.swansea.linux.org.uk> <3EB1ADEC.6080007@rogers.com> <1051884070.23249.4.camel@dhcp22.swansea.linux.org.uk> <3EC1A368.9010707@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC1A368.9010707@rogers.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 10:01:12PM -0400, Jeff Muizelaar wrote:
> Attached is the rough beginings of a patch that does this.
>
> Basically it adds isa bus support and uses it ne.c.
> 
> ISA Bus Support
> --
> The bus uses ioaddr as the bus_id because I don't think we have anything 
> else unique to use.
> 
> Drivers are responsible for adding devices to the bus, through 
> isa_device_register(). Once added, devices stay around forever, even 
> after driver unload.
> Right now I use the device id's stolen from eisa, but I can't see any 
> reason not to just make ids up as necessary.
>
>
> ne.c
> ---
> ne_probe (the function called by Space.c) will autoprobe for ne2000
> devices and then as it finds them it calls isa_register_device. It
> always returns -ENODEV. (eventually if all the net drivers get moved to
> this model, some of this stuff could be moved into Space.c)
> Later on, during module init the driver registers itself with with isa
> bus and then ne_isa_probe is called appropriately.
>
> Moving to doing things this way, should make it possible to merge pci
> support back in and get rid of ne2k-pci.c, because all buses will use
> the same model. Eventually ne2k_cbus.c could probably be added merged as
> well.
>
> Any comments or suggestions?
>
> -Jeff

Hi Jeff,

I agree that an isa interface with sysfs would be useful.  This patch looks like 
a great start.  I'm considering the following aditional changes...

1.) Perhaps the contents of /drivers/eisa and /drivers/isa should be held in the 
same directory.  Comments?

2.) Some collaboration between isapnp, eisa, and isa would be nice.  This is 
because all three of these interfaces could potentially be detecting the same 
devices, resulting in nasty conflicts.

3.) A sysfs interface that would export isa information would be useful.

4.) Perhaps the isa drivers could match against the name of the legacy probing 
driver or maybe the system should be designed to not use device_ids at all.


Also a few things to consider...

Is isa limited to one dma, one irq, and one ioport?  I haven't seen more then 
this anywere but it would be nice to know for registration purposes.

What is the best action to take if a legacy probing technique detects an area 
that conflicts with a previous legacy probe from another driver.  At the very 
least, it would be nice if isa was aware of such things.


Best Regards,
Adam
