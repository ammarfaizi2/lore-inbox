Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVATU3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVATU3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVATU3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:29:32 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:34474 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261924AbVATU0q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:26:46 -0500
In-Reply-To: <20050120193845.H13242@flint.arm.linux.org.uk>
References: <20050120193845.H13242@flint.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <91CB879A-6B21-11D9-BD44-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: serial8250_init and platform_device
Date: Thu, 20 Jan 2005 14:26:30 -0600
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good, I can understand the need to maintain compatibility until we get 
ride of SERIAL_PORT_DFNS.

- kumar

On Jan 20, 2005, at 1:38 PM, Russell King wrote:

> On Thu, Jan 20, 2005 at 01:06:55PM -0600, Kumar Gala wrote:
>  > Russell,
>  >
> > I think this all makes sense to me.  I'm just wondering why we would
> > have a platform device register in a system for 'legacy ISA' when we
> > know the system doesnt have any ports that will fit the category.
>  >
> > As you show in example #2 you have
>  >
> > .../devices/platform/serial82500
> > .../devices/platform/serial8250
> >
> > why have the 'serial8250' if you know your system doesnt have any 
> ports
>  > that will exist there?
>
> In this case, it is a placeholder, and needs to be there if you're 
> using
>  power management.
>
> For instance, you may use setserial on /dev/ttyS2 to reconfigure it
>  to an address where you know a serial port is.  Without the 
> "serial8250"
>  device, it isn't linked into the device model, and therefore doesn't
>  receive any power management notifications.
>
> Once the SERIAL_PORT_DFNS are gone, and we have a more modern interface
>  than setserial for setting up random ports, this "serial8250" device
>  will vanish.
>
> While we're here, you've reminded me about an annoying point about
>  platform device naming...
>
> Greg - the name is constructed from "name" + "id num" thusly:
>
>         serial8250
>          serial82500
>          serial82501
>          serial82502
>
> When "name" ends in a number, it gets rather confusing.  Can we have
>  an optional delimiter in there when we append the ID number, maybe
>  something like a '.' or ':' ?
>
> -- 
> Russell King
>   Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
>                  2.6 Serial core

