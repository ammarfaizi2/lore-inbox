Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVATULN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVATULN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVATULM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:11:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63250 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261358AbVATULG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:11:06 -0500
Date: Thu, 20 Jan 2005 20:10:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Kumar Gala <kumar.gala@freescale.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: serial8250_init and platform_device
Message-ID: <20050120201059.I13242@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Kumar Gala <kumar.gala@freescale.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20050120154420.D13242@flint.arm.linux.org.uk> <736677C2-6B16-11D9-BD44-000393DBC2E8@freescale.com> <20050120193845.H13242@flint.arm.linux.org.uk> <20050120195058.GA8835@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050120195058.GA8835@kroah.com>; from greg@kroah.com on Thu, Jan 20, 2005 at 11:50:58AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 11:50:58AM -0800, Greg KH wrote:
> On Thu, Jan 20, 2005 at 07:38:45PM +0000, Russell King wrote:
> > 
> > Greg - the name is constructed from "name" + "id num" thusly:
> > 
> > 	serial8250
> > 	serial82500
> > 	serial82501
> > 	serial82502
> > 
> > When "name" ends in a number, it gets rather confusing.  Can we have
> > an optional delimiter in there when we append the ID number, maybe
> > something like a '.' or ':' ?
> 
> Sure, that's fine with me.  Someone send me a patch :)

Like this?
-

Separate platform device name from platform device number such that
names ending with numbers aren't confusing.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

--- orig/drivers/base/platform.c	Wed Jan 12 10:11:20 2005
+++ linux/drivers/base/platform.c	Thu Jan 20 20:08:53 2005
@@ -131,7 +131,7 @@ int platform_device_register(struct plat
 	pdev->dev.bus = &platform_bus_type;
 
 	if (pdev->id != -1)
-		snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s%u", pdev->name, pdev->id);
+		snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s.%u", pdev->name, pdev->id);
 	else
 		strlcpy(pdev->dev.bus_id, pdev->name, BUS_ID_SIZE);
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
