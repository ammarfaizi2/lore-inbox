Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVHOUfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVHOUfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVHOUfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:35:37 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.21]:35856 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S964787AbVHOUfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:35:36 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ryan Brown <some.nzguy@gmail.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>
In-Reply-To: <20050815111804.GA26161@elte.hu>
References: <20050811110051.GA20872@elte.hu>
	 <1c1c8636050812172817b14384@mail.gmail.com>
	 <20050815111804.GA26161@elte.hu>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 22:35:28 +0200
Message-Id: <1124138128.15180.7.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

two small buglets for my config. This is the first .53 kernel that
worked for me (admittedly -07 was the last I tried). It feels a bit odd
but that might be the lack of sleep.

two traces, two patches.

Peter Zijlstra

kernel: WARNING: swapper/1 changed soft IRQ-flags.
kernel:  [<c01046b3>] dump_stack+0x23/0x30 (20)
kernel:  [<c0147e2f>] illegal_API_call+0x4f/0x60 (20)
kernel:  [<c0147f31>] __local_irq_save+0x31/0x40 (8)
kernel:  [<c02d4a2e>] rh_call_control+0x16e/0x3e0 (88)
kernel:  [<c02d4f53>] rh_urb_enqueue+0x33/0x60 (20)
kernel:  [<c02d5c04>] hcd_submit_urb+0x194/0x1c0 (44)
kernel:  [<c02d6a01>] usb_submit_urb+0x1e1/0x2c0 (44)
kernel:  [<c02d6d1e>] usb_start_wait_urb+0x6e/0x120 (164)
kernel:  [<c02d6e69>] usb_internal_control_msg+0x99/0xb0 (32)
kernel:  [<c02d6f12>] usb_control_msg+0x92/0xb0 (56)
kernel:  [<c02d781a>] usb_get_descriptor+0x9a/0xe0 (76)
kernel:  [<c02d7cb5>] usb_get_device_descriptor+0x65/0xa0 (44)
kernel:  [<c02d5507>] register_root_hub+0x77/0x160 (44)
kernel:  [<c02d63c2>] usb_add_hcd+0x172/0x3b0 (56)
kernel:  [<c02dafec>] usb_hcd_pci_probe+0x27c/0x3b0 (56)
kernel:  [<c022ea26>] __pci_device_probe+0x56/0x70 (28)
kernel:  [<c022ea74>] pci_device_probe+0x34/0x60 (24)
kernel:  [<c028156e>] driver_probe_device+0x3e/0xc0 (36)
kernel:  [<c02816ef>] __driver_attach+0x4f/0x60 (24)
kernel:  [<c0280b12>] bus_for_each_dev+0x62/0x90 (48)
kernel:  [<c028172d>] driver_attach+0x2d/0x30 (24)
kernel:  [<c0281068>] bus_add_driver+0x88/0xf0 (36)
kernel:  [<c0281b4d>] driver_register+0x5d/0x70 (32)
kernel:  [<c022ed8a>] pci_register_driver+0x9a/0xc0 (28)
kernel:  [<c048c7a9>] ohci_hcd_pci_init+0x39/0x40 (16)
kernel:  [<c0471b02>] do_initcalls+0x32/0xf0 (36)
kernel:  [<c0471bea>] do_basic_setup+0x2a/0x30 (8)
kernel:  [<c01003fa>] init+0x8a/0x290 (24)
kernel:  [<c01015f9>] kernel_thread_helper+0x5/0xc (1049518108)
kernel: ---------------------------
kernel: | preempt count: 00000000 ]
kernel: | 0-level deep critical section nesting:
kernel: ----------------------------------------
kernel:
kernel: ------------------------------
kernel: | showing all locks held by: |  (swapper/1 [c171b4f0, 116]):
kernel: ------------------------------
kernel:
kernel: #001:             [c07f6a74] {(struct semaphore *)(&hwif->gendev_rel_sem)}
kernel: ... acquired at:               init_hwif_data+0x94/0x190
kernel:
kernel: #002:             [c07f75f4] {(struct semaphore *)(&hwif->gendev_rel_sem)}
kernel: ... acquired at:               init_hwif_data+0x94/0x190
kernel:
kernel: #003:             [c07f8174] {(struct semaphore *)(&hwif->gendev_rel_sem)}
kernel: ... acquired at:               init_hwif_data+0x94/0x190
kernel:
kernel: #004:             [c07f8cf4] {(struct semaphore *)(&hwif->gendev_rel_sem)}
kernel: ... acquired at:               init_hwif_data+0x94/0x190
kernel:
kernel: #005:             [c07f9874] {(struct semaphore *)(&hwif->gendev_rel_sem)}
kernel: ... acquired at:               init_hwif_data+0x94/0x190
kernel:
kernel: #006:             [c07fa3f4] {(struct semaphore *)(&hwif->gendev_rel_sem)}
kernel: ... acquired at:               init_hwif_data+0x94/0x190
kernel:
kernel: #007:             [c07faf74] {(struct semaphore *)(&hwif->gendev_rel_sem)}
kernel: ... acquired at:               init_hwif_data+0x94/0x190
kernel:
kernel: #008:             [c07fbaf4] {(struct semaphore *)(&hwif->gendev_rel_sem)}
kernel: ... acquired at:               init_hwif_data+0x94/0x190
kernel:
kernel: #009:             [c07fc674] {(struct semaphore *)(&hwif->gendev_rel_sem)}
kernel: ... acquired at:               init_hwif_data+0x94/0x190
kernel:
kernel: #010:             [c07fd1f4] {(struct semaphore *)(&hwif->gendev_rel_sem)}
kernel: ... acquired at:               init_hwif_data+0x94/0x190
kernel:
kernel: #011:             [efe6fa00] {(struct semaphore *)(&dev->sem)}
kernel: ... acquired at:               __driver_attach+0x21/0x60
kernel:
kernel: #012:             [c03dcfe4] {kernel_sem.lock}
kernel: ... acquired at:               __reacquire_kernel_lock+0x38/0x80
kernel:
kernel: #013:             [c0429144] {usb_bus_list_lock.lock}
kernel: ... acquired at:               register_root_hub+0x5b/0x160

--- linux-2.6.13-rc6-git7-RT-V0.7.53-11/drivers/usb/core/hcd.c~ 2005-08-15 21:23:45.000000000 +0200
+++ linux-2.6.13-rc6-git7-RT-V0.7.53-11/drivers/usb/core/hcd.c  2005-08-15 22:03:33.000000000 +0200
@@ -506,13 +506,11 @@ error:
        }

        /* any errors get returned through the urb completion */
-       local_irq_save (flags);
+       local_irq_save_nort (flags);
        spin_lock (&urb->lock);
        if (urb->status == -EINPROGRESS)
                urb->status = status;
        spin_unlock (&urb->lock);
        usb_hcd_giveback_urb (hcd, urb, NULL);
-       local_irq_restore (flags);
+       local_irq_restore_nort (flags);
        return 0;
 }


kernel: WARNING: softirq-timer/0/4 changed soft IRQ-flags.
kernel:  [<c01046b3>] dump_stack+0x23/0x30 (20)
kernel:  [<c0147e2f>] illegal_API_call+0x4f/0x60 (20)
kernel:  [<c0147f31>] __local_irq_save+0x31/0x40 (8)
kernel:  [<c02d4cda>] usb_hcd_poll_rh_status+0x5a/0x180 (48)
kernel:  [<c02d4e16>] rh_timer_func+0x16/0x20 (12)
kernel:  [<c0131b30>] run_timer_softirq+0x210/0x430 (64)
kernel:  [<c012d5af>] ksoftirqd+0xff/0x1f0 (48)
kernel:  [<c013f816>] kthread+0xb6/0xf0 (48)
kernel:  [<c01015f9>] kernel_thread_helper+0x5/0xc (268668956)
kernel: ---------------------------
kernel: | preempt count: 00000000 ]
kernel: | 0-level deep critical section nesting:
kernel: ----------------------------------------
kernel:
kernel: ------------------------------
kernel: | showing all locks held by: |  (softirq-timer/0/4 [effc5510,  98]):
kernel: ------------------------------
kernel:


similar fix, completions need not have irqs disabled on 
PREEMPT_RT right?

--- linux-2.6.13-rc6-git7-RT-V0.7.53-11/drivers/usb/core/hcd.c~ 2005-08-15 22:03:33.000000000 +0200
+++ linux-2.6.13-rc6-git7-RT-V0.7.53-11/drivers/usb/core/hcd.c  2005-08-15 22:32:54.000000000 +0200
@@ -538,7 +538,7 @@ void usb_hcd_poll_rh_status(struct usb_h
        if (length > 0) {

                /* try to complete the status urb */
-               local_irq_save (flags);
+               local_irq_save_nort (flags);
                spin_lock(&hcd_root_hub_lock);
                urb = hcd->status_urb;
                if (urb) {
@@ -562,7 +562,7 @@ void usb_hcd_poll_rh_status(struct usb_h
                        usb_hcd_giveback_urb (hcd, urb, NULL);
                else
                        hcd->poll_pending = 1;
-               local_irq_restore (flags);
+               local_irq_restore_nort (flags);
        }

        /* The USB 2.0 spec says 256 ms.  This is close enough and won't



-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

