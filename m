Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTKMLdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 06:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTKMLdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 06:33:20 -0500
Received: from users.linvision.com ([62.58.92.114]:17133 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263956AbTKMLdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 06:33:19 -0500
Date: Thu, 13 Nov 2003 12:33:16 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG 2.6.0-test9] sleep from invalid function (ALSA related?)
Message-ID: <20031113113316.GA30460@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I compiled 2.6.0-test9 on my desktop last night. Not too many problems
so far, but this debug trace caught my attention:

Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011df5b>] __might_sleep+0xab/0xd0
 [<e0c2d608>] ap_cs8427_sendbytes+0x38/0xd0 [snd_ice1712]
 [<e0b5a292>] snd_i2c_sendbytes+0x22/0x30 [snd_i2c]
 [<e0bcd14c>] snd_cs8427_reg_read+0x2c/0xa0 [snd_cs8427]
 [<e0bcd432>] snd_cs8427_create+0x92/0x320 [snd_cs8427]
 [<e0b4c320>] snd_device_new+0x20/0x70 [snd]
 [<e0c2954f>] snd_ice1712_init_cs8427+0x2f/0x70 [snd_ice1712]
 [<e0c2dfad>] snd_ice1712_delta_init+0x23d/0x2d0 [snd_ice1712]
 [<e0c2d112>] snd_ice1712_probe+0x322/0x350 [snd_ice1712]
 [<c0169de4>] dput+0x24/0x220
 [<c01ad55b>] pci_device_probe_static+0x4b/0x60
 [<c01ad5a6>] __pci_device_probe+0x36/0x50
 [<c01ad5ec>] pci_device_probe+0x2c/0x50
 [<c01ed34d>] bus_match+0x3d/0x70
 [<c01ed47a>] driver_attach+0x5a/0x90
 [<c01ed774>] bus_add_driver+0xa4/0xc0
 [<c01edbd1>] driver_register+0x31/0x40
 [<c01ad7cb>] pci_register_driver+0x5b/0x80
 [<e0af3015>] alsa_card_ice1712_init+0x15/0x4c [snd_ice1712]
 [<c0136670>] sys_init_module+0x130/0x280
 [<c010a36f>] syscall_call+0x7/0xb

It looks ALSA related to me, the soundcard I use is a Midiman
Audiophile 2496, which uses the ice1712 driver.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
