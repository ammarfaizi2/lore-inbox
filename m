Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263721AbUDYXfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263721AbUDYXfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 19:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUDYXfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 19:35:19 -0400
Received: from mail1.mail.iol.ie ([193.120.142.151]:2004 "EHLO
	mail1.mail.iol.ie") by vger.kernel.org with ESMTP id S263721AbUDYXfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 19:35:13 -0400
Date: Mon, 26 Apr 2004 00:35:10 +0100
From: Kenn Humborg <kenn@linux.ie>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Platform device matching
Message-ID: <20040425233510.GA30747@excalibur.research.wombat.ie>
References: <20040425220511.GA20808@excalibur.research.wombat.ie> <20040426000050.F13748@flint.arm.linux.org.uk> <20040425231709.GA29153@excalibur.research.wombat.ie> <20040426002733.A26138@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426002733.A26138@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 12:27:33AM +0100, Russell King wrote:
> pdev->name is the platform device name, which is just the <name> part.
> pdev->dev.bus_id is the device model name, which is <name><instance-number>,
> and the devices are known by this name.
> 
> Rather than going to the trouble of parsing <name> from the device model
> name which would be inherently buggy, we reference it directly from the
> platform_device structure.

OK - I see it now.

> So, this comment needs updating:
> 
>  *      So, extract the <name> from the device, and compare it against
>  *      the name of the driver. Return whether they match or not.

Want a patch?

Later,
Kenn

--- drivers/base/platform.c~	2004-01-12 23:49:04.000000000 +0000
+++ drivers/base/platform.c	2004-04-26 00:33:43.000000000 +0100
@@ -57,8 +57,9 @@
  *	type of device, like "pci" or "floppy", and <instance> is the 
  *	enumerated instance of the device, like '0' or '42'.
  *	Driver IDs are simply "<name>". 
- *	So, extract the <name> from the device, and compare it against 
- *	the name of the driver. Return whether they match or not.
+ *	So, extract the <name> from the platform_device structure, 
+ *	and compare it against the name of the driver. Return whether 
+ *	they match or not.
  */
 
 static int platform_match(struct device * dev, struct device_driver * drv)
