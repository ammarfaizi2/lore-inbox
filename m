Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUKSPxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUKSPxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 10:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUKSPxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 10:53:39 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:39592 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261439AbUKSPxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 10:53:12 -0500
Message-ID: <419E16E5.1000601@free.fr>
Date: Fri, 19 Nov 2004 16:53:09 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor>
In-Reply-To: <E1CVAfT-0002n9-Rn@rhn.tartu-labor>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
> mc> try to do an "echo auto > /sys/bus/pnp/device_number/resources"
> mc> 
> mc> It will reenable the device.
> 
> I tried this on my Toshiba Satellite 1800-314 and the device gets IO
> resources but is still disabled. echo activate > ... will enable it but
> the smc-ircc2 driver still finds that the device is disabled (in
> 2.6.10-rc2+yesterdays BK):
> 
> nartsiss:~# cat /sys/bus/pnp/devices/00\:0a/options
> Dependent: 01 - Priority acceptable
>    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 02 - Priority acceptable
>    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 03 - Priority acceptable
>    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
> Dependent: 04 - Priority acceptable
>    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
that's very strange : you must have 2 io entries, 1 dma entry and an irq 
entry.
Could you try pnpacpi from mm series ?
Any warning from pnpbios at startup ?
A laptop of the friend have wrong pnpbios entries...

Also make sure you don't force in your bios the device to be a sir device.


> nartsiss:~# cat /sys/bus/pnp/devices/00\:0a/resources
> state = disabled
> nartsiss:~# echo auto > /sys/bus/pnp/devices/00\:0a/resources
> nartsiss:~# cat /sys/bus/pnp/devices/00\:0a/resources
> state = disabled
> io 0x2e8-0x2ef
activate is not important : here pnp had found the io resources
> nartsiss:~# echo activate > /sys/bus/pnp/devices/00\:0a/resources
> nartsiss:~# cat /sys/bus/pnp/devices/00\:0a/resources
> state = active
> io 0x2e8-0x2ef
^^^^^^^^^^^^^^^^
> nartsiss:~# modprobe smsc-ircc2
> FATAL: Error inserting smsc_ircc2
> (/lib/modules/2.6.10-rc2/kernel/drivers/net/irda/smsc-ircc2.ko): No such device
> nartsiss:~# dmesg|tail -5
> pnp: Device 00:0a activated.
> NET: Registered protocol family 23
> found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
> smsc_superio_flat(): IrDA not enabled
> smsc_superio_flat(): fir: 0x00, sir: 0x2e8, dma: 15, irq: 0, mode: 0x02
> 
> 
> Looks like there is also a enable/disable bit in the actual LPC device,
> or maybe it needs also a fir address and/or irq?
> 

