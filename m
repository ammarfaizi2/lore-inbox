Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbUKSPdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUKSPdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 10:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUKSPdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 10:33:11 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:10513 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S261437AbUKSPdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 10:33:06 -0500
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org, matthieu castet <castet.matthieu@free.fr>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
In-Reply-To: <419CECFF.2090608@free.fr>
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.10-rc2 (i686))
Message-Id: <E1CVAfT-0002n9-Rn@rhn.tartu-labor>
Date: Fri, 19 Nov 2004 17:27:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mc> try to do an "echo auto > /sys/bus/pnp/device_number/resources"
mc> 
mc> It will reenable the device.

I tried this on my Toshiba Satellite 1800-314 and the device gets IO
resources but is still disabled. echo activate > ... will enable it but
the smc-ircc2 driver still finds that the device is disabled (in
2.6.10-rc2+yesterdays BK):

nartsiss:~# cat /sys/bus/pnp/devices/00\:0a/options
Dependent: 01 - Priority acceptable
   port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 02 - Priority acceptable
   port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 03 - Priority acceptable
   port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 04 - Priority acceptable
   port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
nartsiss:~# cat /sys/bus/pnp/devices/00\:0a/resources
state = disabled
nartsiss:~# echo auto > /sys/bus/pnp/devices/00\:0a/resources
nartsiss:~# cat /sys/bus/pnp/devices/00\:0a/resources
state = disabled
io 0x2e8-0x2ef
nartsiss:~# echo activate > /sys/bus/pnp/devices/00\:0a/resources
nartsiss:~# cat /sys/bus/pnp/devices/00\:0a/resources
state = active
io 0x2e8-0x2ef
nartsiss:~# modprobe smsc-ircc2
FATAL: Error inserting smsc_ircc2
(/lib/modules/2.6.10-rc2/kernel/drivers/net/irda/smsc-ircc2.ko): No such device
nartsiss:~# dmesg|tail -5
pnp: Device 00:0a activated.
NET: Registered protocol family 23
found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
smsc_superio_flat(): IrDA not enabled
smsc_superio_flat(): fir: 0x00, sir: 0x2e8, dma: 15, irq: 0, mode: 0x02


Looks like there is also a enable/disable bit in the actual LPC device,
or maybe it needs also a fir address and/or irq?

-- 
Meelis Roos
