Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752261AbWCKAea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbWCKAea (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 19:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbWCKAea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 19:34:30 -0500
Received: from ns1.suse.de ([195.135.220.2]:54993 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751294AbWCKAe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 19:34:29 -0500
Date: Sat, 11 Mar 2006 01:34:28 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: missing sysfs device symlink for platform devices
Message-ID: <20060311003428.GA17309@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why is the /sys/class/net/eth0/device symlink not created for the
mv643xx_eth driver? Does this work for other platform device drivers?
Seems to work for the ps2 keyboard at least.

/sys/class/input/input1/device -> ../../../devices/platform/i8042/serio1


Index: linux-2.6.16-rc5-olh/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.6.16-rc5-olh.orig/drivers/net/mv643xx_eth.c
+++ linux-2.6.16-rc5-olh/drivers/net/mv643xx_eth.c
@@ -1449,6 +1452,7 @@ static int mv643xx_eth_probe(struct plat
        if (err)
                goto out;

+       SET_NETDEV_DEV(dev, &pdev->dev);
        p = dev->dev_addr;
        printk(KERN_NOTICE
                "%s: port %d with MAC address %02x:%02x:%02x:%02x:%02x:%02x\n",

