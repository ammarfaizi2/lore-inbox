Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbTJQHDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 03:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbTJQHDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 03:03:51 -0400
Received: from web40911.mail.yahoo.com ([66.218.78.208]:65459 "HELO
	web40911.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263305AbTJQHDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 03:03:49 -0400
Message-ID: <20031017070348.46326.qmail@web40911.mail.yahoo.com>
Date: Fri, 17 Oct 2003 00:03:48 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: 2.6.0-test7-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031016083124.45a171a5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Morton,

After backing out these two patches, recompiling and rebooting, I get these
two unrelated Oopses:

PID hash table entries: 2048 (order 11: 16384 bytes)
Debug: sleeping function called from invalid context at include/linux/rwsem.h:66
in_atomic():1, irqs_disabled():1
Call Trace:
 [<c0123fc6>] __might_sleep+0xa0/0xc2
 [<c02e9727>] cpufreq_register_notifier+0x30/0x96
 [<c0107000>] rest_init+0x0/0xf4
 [<c0493af9>] init_tsc+0x54/0xf2
 [<c0107000>] rest_init+0x0/0xf4
 [<c011a141>] select_timer+0x26/0x55
 [<c048f4d5>] time_init+0x38/0x49
 [<c048c66b>] start_kernel+0x124/0x22e
 [<c048c41b>] unknown_bootoption+0x0/0xff

Detected 1994.068 MHz processor.

ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8207000-e82077ff]  Max
Packet=[2048]
Debug: sleeping function called from invalid context at mm/slab.c:1869
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c0123fc6>] __might_sleep+0xa0/0xc2
 [<c0156bc0>] __kmalloc+0x204/0x216
 [<e08a9ed4>] hpsb_create_hostinfo+0x6b/0xe8 [ieee1394]
 [<e08af0e6>] nodemgr_add_host+0x23/0x1d2 [ieee1394]
 [<c0217c88>] sprintf+0x1f/0x23
 [<e08aa789>] highlevel_add_host+0x6b/0x6f [ieee1394]
 [<e08a9cce>] hpsb_add_host+0x6d/0x95 [ieee1394]
 [<e08c0ba2>] ohci1394_pci_probe+0x512/0x620 [ohci1394]
 [<e08bdb41>] ohci_irq_handler+0x0/0x1129 [ohci1394]
 [<c021e01e>] pci_device_probe_static+0x52/0x63
 [<c021e06a>] __pci_device_probe+0x3b/0x4e
 [<c021e0a9>] pci_device_probe+0x2c/0x4a
 [<c028105e>] bus_match+0x3f/0x6a
 [<c0281170>] driver_attach+0x56/0x80
 [<c0281442>] bus_add_driver+0x9f/0xb1
 [<c02818a6>] driver_register+0x8c/0x90
 [<c021e295>] pci_register_driver+0x8c/0xab
 [<e0886013>] ohci1394_init+0x13/0x3d [ohci1394]
 [<c01482f9>] sys_init_module+0x213/0x3e6
 [<c0176189>] sys_read+0x42/0x63
 [<c03aedea>] sysenter_past_esp+0x43/0x65

ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0b8060000db10]

The second one has already been explained, but what about the first? I haven't
shut down the machine I'm running this kernel on yet, so I don't know if the patch
removal has fixed that problem or not.

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
