Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVLKQI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVLKQI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 11:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVLKQIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 11:08:34 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:5076 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750735AbVLKQIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 11:08:31 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm2: ehci_hcd crashes on load sometimes
Date: Sun, 11 Dec 2005 17:06:42 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20051211041308.7bb19454.akpm@osdl.org> <200512111647.31202.rjw@sisk.pl>
In-Reply-To: <200512111647.31202.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111706.42867.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ehci_hcd driver causes problems like this:

ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: debug port 1
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: irq 5, io mem 0xfebfdc00
usb 2-2: Product: USB Receiver
usb 2-2: Manufacturer: Logitech
usb 2-2: configuration #1 chosen from 1 choice
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Unable to handle kernel NULL pointer dereference at 00000000000002a4 RIP:
<ffffffff880ad9d0>{:ehci_hcd:ehci_irq+224}
PGD 2dba6067 PUD 2d477067 PMD 0
Oops: 0000 [1] PREEMPT
CPU 0
Modules linked in: ehci_hcd ohci_hcd sk98lin sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 1336, comm: modprobe Not tainted 2.6.15-rc5-mm2 #2
RIP: 0010:[<ffffffff880ad9d0>] <ffffffff880ad9d0>{:ehci_hcd:ehci_irq+224}
RSP: 0018:ffffffff80481e08  EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
RDX: ffffc2000007ac20 RSI: 00000000ffffffff RDI: ffff81002c5d3c78
RBP: ffffffff80481ee8 R08: 0000000000010000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffff81002c5d3c78
R13: ffff81002c5d3c58 R14: ffff81002c5d3b08 R15: 0000000000000000
FS:  00002aaaaade8b00(0000) GS:ffffffff8050f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000000002a4 CR3: 000000002cc54000 CR4: 00000000000006e0
Process modprobe (pid: 1336, threadinfo ffff81002dac6000, task ffff81002fdf2790)
Stack: ffffffff80481e38 ffff81002dac7b88 ffffffff801819e0 ffff810001c365c0
       ffff81002fdf32f0 ffff81002fdf3000 ffffffff80481e78 ffffffff8017b5f5
       ffffffff80481e58 ffff810001c365c0
Call Trace: <IRQ> <ffffffff801819e0>{filp_dtor+0} <ffffffff8017b5f5>{cache_free_debugcheck+597}
       <ffffffff80181516>{file_free_rcu+22} <ffffffff802dbe04>{usb_hcd_irq+52}
       <ffffffff8015b563>{handle_IRQ_event+51} <ffffffff8015b652>{__do_IRQ+162}
       <ffffffff801114b7>{do_IRQ+55} <ffffffff8010f0b0>{ret_from_intr+0}
        <EOI> <ffffffff801c1a01>{sysfs_add_file+1} <ffffffff801c1aad>{sysfs_create_file+61}
       <ffffffff802bfd47>{class_device_create_file+23} <ffffffff880ae0c9>{:ehci_hcd:ehci_run+377}
       <ffffffff802d6a86>{usb_alloc_dev+262} <ffffffff802dd4df>{usb_add_hcd+1007}
       <ffffffff802e6f53>{usb_hcd_pci_probe+691} <ffffffff802584da>{pci_device_probe+106}
       <ffffffff802bed79>{driver_probe_device+89} <ffffffff802bedf0>{__driver_attach+0}
       <ffffffff802bee51>{__driver_attach+97} <ffffffff802be68f>{bus_for_each_dev+79}
       <ffffffff802bec0c>{driver_attach+28} <ffffffff802be058>{bus_add_driver+136}
       <ffffffff802beff9>{driver_register+121} <ffffffff8025878e>{__pci_register_driver+206}
       <ffffffff88011050>{:ehci_hcd:ehci_hcd_pci_init+80} <ffffffff80150a1d>{sys_init_module+253}
       <ffffffff8010eb0e>{system_call+126}

Code: 0f b6 80 a4 02 00 00 83 e0 03 3c 03 0f 85 9e 00 00 00 45 8b
RIP <ffffffff880ad9d0>{:ehci_hcd:ehci_irq+224} RSP <ffffffff80481e08>
CR2: 00000000000002a4
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

to appear from time to time when it's being loaded (20% of times or so).
If it loads successfully, it seems to work fine.
