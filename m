Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVHLTrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVHLTrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVHLTrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:47:15 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:27816 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751266AbVHLTrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:47:15 -0400
X-ME-UUID: 20050812194713799.C31821C001C4@mwinf0809.wanadoo.fr
From: Guillaume Foliard <guifo@wanadoo.fr>
Organization: _
To: Ingo Molnar <mingo@redhat.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High Resolution Timers & RCU-tasklist features
Date: Fri, 12 Aug 2005 21:47:28 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200508112039.07660.guifo@wanadoo.fr> <Pine.LNX.4.58.0508120426070.3233@devserv.devel.redhat.com> <200508122127.26928.guifo@wanadoo.fr>
In-Reply-To: <200508122127.26928.guifo@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508122147.28731.guifo@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 August 2005 21:27, Guillaume Foliard wrote:
> On Friday 12 August 2005 14:53, Ingo Molnar wrote:
> > On Thu, 11 Aug 2005, Guillaume Foliard wrote:
> > > Hi,
> > >
> > > Here is the compilation error I had with 0.7.53-02 :
> >
> > thanks - i've uploaded the -53-05 patch which should fix this - does it
> > build/work for you now?
>
> I've tried -53-07. Build is ok. Kernel has booted and is running.

I'm running dmesg from times to times and just catched this one :

BUG: kblockd/0/84: leaked RT prio 98 (110)?
 [<c0139e02>] up_mutex+0xd1/0x11e (8)
 [<c014b0a1>] kmem_cache_alloc+0x5d/0xe1 (32)
 [<c02efd97>] __scsi_get_command+0x23/0x66 (32)
 [<c02efe0f>] scsi_get_command+0x35/0x9e (28)
 [<c02f5a97>] scsi_prep_fn+0x120/0x220 (28)
 [<c02a35f8>] elv_next_request+0x5c/0x1bd (36)
 [<c029e7ff>] get_device+0x1b/0x24 (12)
 [<c02f5c8b>] scsi_request_fn+0x4b/0x3a0 (16)
 [<c02ac92f>] as_work_handler+0x2b/0x3d (40)
 [<c013093d>] worker_thread+0x193/0x259 (16)
 [<c02ac904>] as_work_handler+0x0/0x3d (32)
 [<c011b8e2>] default_wake_function+0x0/0x22 (32)
 [<c01307aa>] worker_thread+0x0/0x259 (32)
 [<c0135b73>] kthread+0x98/0x9c (4)
 [<c0135adb>] kthread+0x0/0x9c (24)
 [<c0101011>] kernel_thread_helper+0x5/0xb (16)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0139d4e>] .... up_mutex+0x1d/0x11e
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x47)


Also, during boot this one occured :

WARNING: swapper/1 changed soft IRQ-flags.
 [<c032ce28>] rh_call_control+0xd9/0x3f2 (8)
 [<c013a82b>] sub_preempt_count+0x18/0x1c (20)
 [<c0139da4>] up_mutex+0x73/0x11e (28)
 [<c032df0b>] hcd_submit_urb+0x1e1/0x22e (32)
 [<c032ee5a>] usb_start_wait_urb+0x69/0x10c (44)
 [<c013a82b>] sub_preempt_count+0x18/0x1c (64)
 [<c013934d>] __init_rt_mutex+0x37/0x56 (12)
 [<c013a440>] _spin_lock_init+0x30/0x3c (16)
 [<c032ef8c>] usb_internal_control_msg+0x8f/0x9b (28)
 [<c032f02c>] usb_control_msg+0x94/0xa8 (28)
 [<c032f8ed>] usb_get_descriptor+0x94/0xc8 (56)
 [<c014b001>] cache_flusharray+0x6a/0xad (40)
 [<c032fd2a>] usb_get_device_descriptor+0x62/0x8e (32)
 [<c032abda>] usb_set_device_state+0x18/0x54 (24)
 [<c032d860>] register_root_hub+0x6e/0x148 (20)
 [<c032e69c>] usb_add_hcd+0x1ef/0x3aa (40)
 [<c0332c9d>] usb_hcd_pci_probe+0x1cd/0x2f9 (56)
 [<c02445de>] pci_match_device+0x1e/0xc8 (20)
 [<c02446cc>] __pci_device_probe+0x44/0x4f (28)
 [<c0244700>] pci_device_probe+0x29/0x3f (20)
 [<c029fa56>] driver_probe_device+0x3d/0xa7 (20)
 [<c048c86f>] klist_dec_and_del+0x1a/0x1e (12)
 [<c029fb34>] __driver_attach+0x0/0x4e (16)
 [<c029fb73>] __driver_attach+0x3f/0x4e (4)
 [<c029f17c>] bus_for_each_dev+0x5b/0x7b (20)
 [<c029fba8>] driver_attach+0x26/0x2a (44)
 [<c029fb34>] __driver_attach+0x0/0x4e (16)
 [<c029f61a>] bus_add_driver+0x6e/0xce (4)
 [<c0244932>] pci_register_driver+0x89/0xab (32)
 [<c0617b70>] init+0x1d/0x25 (24)
 [<c05fe83d>] do_initcalls+0x54/0xce (8)
 [<c01002a2>] init+0x0/0x1ae (16)
 [<c01002d5>] init+0x33/0x1ae (16)
 [<c010100c>] kernel_thread_helper+0x0/0xb (12)
 [<c0101011>] kernel_thread_helper+0x5/0xb (4)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------



Guillaume

