Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267213AbSKUX4F>; Thu, 21 Nov 2002 18:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267220AbSKUX4E>; Thu, 21 Nov 2002 18:56:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33554 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267213AbSKUX4C>;
	Thu, 21 Nov 2002 18:56:02 -0500
Message-ID: <3DDD7418.2010408@pobox.com>
Date: Thu, 21 Nov 2002 19:02:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Adam Kropelin <akropel1@rochester.rr.com>,
       Neil Cafferkey <caffer@cs.ucc.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Setting MAC address in ewrk3 driver
References: <20021121195417.A18859@cuc.ucc.ie>	<1037914095.9122.0.camel@irongate.swansea.linux.org.uk> 	<20021121233950.GB4654@www.kroptech.com> <1037924776.9122.7.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <20021121195417.A18859@cuc.ucc.ie>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Thu, 2002-11-21 at 23:39, Adam Kropelin wrote:
>
> >Alan, could you clarify for me? I'm the last guy to diddle with ewrk3 so
> >I'll track this down if there is indeed something to track down. ewrk3
> >has a private ioctl for setting the mac address. By the "up" method do
> >you mean the etherdev open method? Should there be a standard ioctl
> >implemented for setting the mac address?
>
>
> dev->set_mac_address()



To be more specific:

Read the MAC address in the probe phase.
Write MAC address to NIC on _each_ dev->open().
If you care about changing the MAC address while interface is up, 
implement dev->set_mac_address().

So, dev->set_mac_address() is pretty useless, when you can just tell 
users "down the interface before setting MAC address" which is a sane 
thing to do anyway, and much less complicated.

	Jeff



