Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263641AbUDYWFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUDYWFV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 18:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbUDYWFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 18:05:21 -0400
Received: from mail2.mail.iol.ie ([193.95.141.54]:46766 "EHLO
	mail2.mail.iol.ie") by vger.kernel.org with ESMTP id S263641AbUDYWFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 18:05:14 -0400
Date: Sun, 25 Apr 2004 23:05:11 +0100
From: Kenn Humborg <kenn@linux.ie>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Platform device matching
Message-ID: <20040425220511.GA20808@excalibur.research.wombat.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm looking at the code for binding platform devices with drivers.  
However, platform_match() doesn't seem to agree with its kerneldoc
comment:

drivers/base/platform.c:
 50 /**
 51  *      platform_match - bind platform device to platform driver.
 52  *      @dev:   device.
 53  *      @drv:   driver.
 54  *
 55  *      Platform device IDs are assumed to be encoded like this: 
 56  *      "<name><instance>", where <name> is a short description of the 
 57  *      type of device, like "pci" or "floppy", and <instance> is the 
 58  *      enumerated instance of the device, like '' or '42'.
 59  *      Driver IDs are simply "<name>". 
 60  *      So, extract the <name> from the device, and compare it against 
 61  *      the name of the driver. Return whether they match or not.
 62  */
 63 
 64 static int platform_match(struct device * dev, struct device_driver * drv)
 65 {
 66         struct platform_device *pdev = container_of(dev, struct platform_device, dev);
 67 
 68         return (strncmp(pdev->name, drv->name, BUS_ID_SIZE) == 0);
 69 }

Shouldn't that really be

 64 static int platform_match(struct device * dev, struct device_driver * drv)
 65 {
 66         struct platform_device *pdev = container_of(dev, struct platform_device, dev);
 67 
 68         return (strncmp(pdev->name, drv->name, strlen(drv->name)) == 0);
 69 }

So that, for example, the 'floppy' driver will match with any of the 
'floppy', 'floppy0' and 'floppy1' devices?

Later,
Kenn


