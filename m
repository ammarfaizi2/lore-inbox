Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVATU2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVATU2u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVATU2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:28:49 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:28842 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261907AbVATU0H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:26:07 -0500
In-Reply-To: <20050120201059.I13242@flint.arm.linux.org.uk>
References: <20050120201059.I13242@flint.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <763C3603-6B21-11D9-BD44-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: serial8250_init and platform_device
Date: Thu, 20 Jan 2005 14:25:44 -0600
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

agreed, the lack of a delimiter in the naming was annoying.

- kumar

On Jan 20, 2005, at 2:10 PM, Russell King wrote:

> On Thu, Jan 20, 2005 at 11:50:58AM -0800, Greg KH wrote:
>  > On Thu, Jan 20, 2005 at 07:38:45PM +0000, Russell King wrote:
>  > >
> > > Greg - the name is constructed from "name" + "id num" thusly:
>  > >
> > >     serial8250
>  > >     serial82500
>  > >     serial82501
>  > >     serial82502
>  > >
> > > When "name" ends in a number, it gets rather confusing.  Can we 
> have
>  > > an optional delimiter in there when we append the ID number, maybe
>  > > something like a '.' or ':' ?
>  >
> > Sure, that's fine with me.  Someone send me a patch :)
>
> Like this?
>  -
>
> Separate platform device name from platform device number such that
>  names ending with numbers aren't confusing.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>
>
> --- orig/drivers/base/platform.c        Wed Jan 12 10:11:20 2005
> +++ linux/drivers/base/platform.c       Thu Jan 20 20:08:53 2005
> @@ -131,7 +131,7 @@ int platform_device_register(struct plat
>          pdev->dev.bus = &platform_bus_type;
>  
>          if (pdev->id != -1)
>  -               snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s%u", 
> pdev->name, pdev->id);
>  +               snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s.%u", 
> pdev->name, pdev->id);
>          else
>                  strlcpy(pdev->dev.bus_id, pdev->name, BUS_ID_SIZE);
>  
>
> -- 
> Russell King
>   Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
>                  2.6 Serial core

