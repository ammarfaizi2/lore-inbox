Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUIQBQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUIQBQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 21:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUIQBQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 21:16:05 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:14272 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266341AbUIQBP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 21:15:57 -0400
Date: Fri, 17 Sep 2004 10:15:51 +0900
From: NIWA Hideyuki <niwa.hideyuki@soft.fujitsu.com>
Subject: might_sleep in aic79xx scsi driver code of 2.6.5
To: linux-kernel@vger.kernel.org
Cc: niwa.hideyuki@soft.fujitsu.com
Message-id: <20040917101551.71a35008.niwa.hideyuki@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   I tried to hot-remove a PCI scsi card (Adaptec 39320D: aic79xx).
   And, the following kernel messages were output.

   Because aic79xx driver called semaphore with lock environment.
   It was detected in __might_sleep() check .
                                                                                
	Kernel is 2.6.5. 
	CPU is ia64(itanium2 4way), memory is 2GB. 
	And my server have hotpluggable PCI-slots.

kernel messages: 
                                                                               
kernel: Debug: sleeping function called from invalid context at 
include/asm/semaphore.h:76
kernel: in_atomic():0, irqs_disabled():1
kernel: 
kernel: Call Trace:
kernel:  [<a000000100018dc0>] show_stack+0x80/0xa0
kernel:                     sp=e0000004fff17b70 bsp=e0000004fff11298
kernel:  [<a0000001000678a0>] __might_sleep+0x1a0/0x1c0
kernel:                     sp=e0000004fff17d40 bsp=e0000004fff11270
kernel:  [<a0000002007d1bf0>] ahd_linux_kill_dv_thread+0x170/0x280 [aic79xx]
                              ~~~~~~~~~~~~~~~~~~~~~~~~
kernel:                     sp=e0000004fff17d50 bsp=e0000004fff11248
kernel:  [<a0000002007d03e0>] ahd_platform_free+0x80/0x3e0 [aic79xx]
kernel:                     sp=e0000004fff17d50 bsp=e0000004fff111f0
kernel:  [<a00000020079d3f0>] ahd_free+0x1f0/0x3e0 [aic79xx]
                              ~~~~~~~~
kernel:                     sp=e0000004fff17d50 bsp=e0000004fff111c0
kernel:  [<a0000002007dc7f0>] ahd_linux_pci_dev_remove+0x1b0/0x220 [aic79xx]
kernel:                     sp=e0000004fff17d50 bsp=e0000004fff11188
kernel:  [<a000000100201720>] pci_device_remove+0xc0/0xe0
kernel:                     sp=e0000004fff17d60 bsp=e0000004fff11160
kernel:  [<a0000001002ba900>] device_release_driver+0x120/0x140
kernel:                     sp=e0000004fff17d60 bsp=e0000004fff11130
kernel:  [<a0000001002bac60>] bus_remove_device+0xe0/0x1e0
kernel:                     sp=e0000004fff17d60 bsp=e0000004fff11100
kernel:  [<a0000001002b7af0>] device_del+0x150/0x240
kernel:                     sp=e0000004fff17d60 bsp=e0000004fff110c0
kernel:  [<a0000001002b7c00>] device_unregister+0x20/0x60
kernel:                     sp=e0000004fff17d60 bsp=e0000004fff110a0
kernel:  [<a0000001001fd2f0>] pci_destroy_dev+0x30/0x160
kernel:                     sp=e0000004fff17d60 bsp=e0000004fff11080
kernel:  [<a000000200383d30>] acpiphp_unconfigure_function+0x70/0x160 [acpiphp]
kernel:                     sp=e0000004fff17d60 bsp=e0000004fff11050
kernel:  [<a000000200381410>] disable_device+0x130/0x140 [acpiphp]
kernel:                     sp=e0000004fff17d60 bsp=e0000004fff11020
kernel:  [<a000000200382180>] acpiphp_disable_slot+0x80/0x280 [acpiphp]
kernel:                     sp=e0000004fff17d60 bsp=e0000004fff10fe8
kernel:  [<a000000200381ae0>] handle_hotplug_event_func+0x120/0x320 [acpiphp]
kernel:                     sp=e0000004fff17d60 bsp=e0000004fff10fb8
kernel:  [<a00000010021ca80>] acpi_ev_notify_dispatch+0x140/0x180
kernel:                     sp=e0000004fff17db0 bsp=e0000004fff10f98
kernel:  [<a000000100211010>] acpi_os_execute_deferred+0x50/0x80
kernel:                     sp=e0000004fff17db0 bsp=e0000004fff10f78
kernel:  [<a000000100095180>] worker_thread+0x420/0x5c0
kernel:                     sp=e0000004fff17db0 bsp=e0000004fff10ee0
kernel:  [<a00000010009eaa0>] kthread+0x160/0x180
kernel:                     sp=e0000004fff17e20 bsp=e0000004fff10ea8
kernel:  [<a00000010001a9b0>] kernel_thread_helper+0x30/0x60
kernel:                     sp=e0000004fff17e30 bsp=e0000004fff10e80
kernel:  [<a000000100008c40>] start_kernel_thread+0x20/0x40
kernel:                     sp=e0000004fff17e30 bsp=e0000004fff10e80
kernel: Synchronizing SCSI cache for disk sdd: <4>FAILED
kernel:   status = 0, message = 00, host = 1, driver = 00


__might_sleep() function called from lock context.
That has been detected at down() in ahd_linux_kill_dv_thread(). 
(drivers/scsi/aic7xxx/aic79xx_osm.c)

> static void
> ahd_linux_kill_dv_thread(struct ahd_softc *ahd)
> {
>         u_long s;

	...

>                  * parent (dv threads are parented by init).
>                  * Cross your fingers...
>                  */
>                 down(&ahd->platform_data->eh_sem); <<<<< called __might_sleep
> 
 


ahd_list_lock() have locked in ahd_linux_pci_dev_remove() .
(drivers/scsi/aic7xxx/aic79xx_osm_pci.c)

> static void
> ahd_linux_pci_dev_remove(struct pci_dev *pdev)
> {
>         struct ahd_softc *ahd;
>         u_long l;
> 
>         /*
>          * We should be able to just perform
>          * the free directly, but check our
>          * list for extra sanity.
>          */
>         ahd_list_lock(&l); <<<<< lock: called spin_lock_irqsave() 
>         ahd = ahd_find_softc((struct ahd_softc *)pci_get_drvdata(pdev));
>         if (ahd != NULL) {
>                 u_long s;
> 
>                 ahd_lock(ahd, &s);
>                 ahd_intr_enable(ahd, FALSE);
>                 ahd_unlock(ahd, &s);
>                 ahd_free(ahd);  <<<<< called ahd_platform_free =>
                                             called ahd_linux_kill_dv_thread  
>         }
>         ahd_list_unlock(&l);  <<<<< unlock : 
> }

Maybe, ai7xxx driver has a same problem.



Thanks in advance
NIWA Hideyuki
