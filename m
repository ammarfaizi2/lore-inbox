Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271101AbTG2IjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 04:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271208AbTG2IjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 04:39:17 -0400
Received: from ns.bmstu.ru ([195.19.32.2]:27653 "EHLO soap.bmstu.ru")
	by vger.kernel.org with ESMTP id S271101AbTG2Iix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 04:38:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Serge A. Suchkov" <ss@e1.bmstu.ru>
Reply-To: ss@e1.bmstu.ru
Organization: BMSTU
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 bugreport
Date: Tue, 29 Jul 2003 12:31:27 +0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <03072912312701.10545@XP1700>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I"m test 2.6.0-test2, quick bugreport below...


1) No logo in vesafb ;) (in 2.6.0-test1 logo present)

-8<-lilo.conf--------------
# VESA framebuffer console @ 1024x768x64k
vga=792
-8<-lilo.conf--------------

-8<-.config--------------
#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
-8<-.config--------------

2) USB storage still broken (?)

In attempt umount disconnected (previously mounted) device  

-8<- dmesg ---------------
usb 1-2: USB disconnect, address 3
usb-storage: storage_disconnect() called
usb-storage: usb_stor_stop_transport called
usb-storage: -- dissociate_dev
usb-storage: -- sending exit command to thread
usb-storage: *** thread awakened.
usb-storage: -- exit command received
usb-storage: -- usb_stor_release_resources finished
Unable to handle kernel paging request at virtual address c5cad188
 printing eip:
c015350a
*pde = 00017067
*pte = 05cad000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c015350a>]    Not tainted
EFLAGS: 00010246
EIP is at __filemap_fdatawrite+0x7a/0x200
eax: c5cad180   ebx: 00000000   ecx: c1c2a068   edx: 00000001
esi: c19460c0   edi: c99beaa0   ebp: c5d2dea8   esp: c5d2de40
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 941, threadinfo=c5d2c000 task=c6338000)
Stack: 00000000 00000000 000005fe 00000000 00000000 0000004f 000009f8 
00000000 
       00000001 00000000 00000000 00000000 00000000 00000000 00000000 
00000000 
       00000001 00000000 00000000 00000000 00000000 00000000 00000000 
00000000 
Call Trace:
 [<c01536a9>] filemap_fdatawrite+0x19/0x20
 [<c0181006>] sync_blockdev+0x26/0x50
 [<c01810b0>] fsync_super+0x80/0xc0
 [<c018813a>] generic_shutdown_super+0x4a/0x440
 [<c018a3bd>] kill_block_super+0x1d/0x50
 [<c0187a32>] deactivate_super+0xd2/0x2c0
 [<c01aad08>] free_vfsmnt+0x28/0x30
 [<c01ac32c>] sys_umount+0x3c/0x80
 [<c01ac389>] sys_oldumount+0x19/0x20
 [<c010b0db>] syscall_call+0x7/0xb

Code: 8b 40 08 85 c0 74 0a 31 c0 83 c4 5c 5b 5e 5f c9 c3 b8 00 e0 
-8<- dmesg ---------------

But already not in SCSI, as in 2.6.0-test1



2) USB connected GPRS modem (Motorola C330) (cdc-acm) not work (?)
(in 2.4.22-pre* acm work fine)

-8<- /var/log/messages ---------------
Jul 29 09:44:36 ss pppd[846]: pppd 2.4.1 started by root, uid 0
Jul 29 09:44:39 ss pppd[846]: Serial connection established.
Jul 29 09:44:39 ss pppd[846]: Using interface ppp0
Jul 29 09:44:39 ss pppd[846]: Connect: ppp0 <--> /dev/ttyACM0
Jul 29 09:44:39 ss /etc/hotplug/net.agent: NET add event not supported
Jul 29 09:44:43 ss kernel: PPP Deflate Compression module registered
Jul 29 09:44:43 ss pppd[846]: LCP terminated by peer (^E^@^@^J^@^@^@^@^@^@)
Jul 29 09:44:43 ss pppd[846]: ioctl(PPPIOCSASYNCMAP): Inappropriate ioctl for 
device(25)
Jul 29 09:44:43 ss pppd[846]: tcflush failed: Input/output error
Jul 29 09:44:43 ss /etc/hotplug/net.agent: NET remove event not supported
Jul 29 09:44:44 ss pppd[846]: Exit.
-8<- /var/log/messages ---------------


-8<- dmesg ---------------
Jul 29 09:44:40 ss kernel: Debug: sleeping function called from invalid 
context at mm/slab.c:1817
Jul 29 09:44:40 ss kernel: Call Trace:
Jul 29 09:44:40 ss kernel:  [<c0126e4f>] __might_sleep+0x5f/0x90
Jul 29 09:44:40 ss kernel:  [<c015f740>] __kmalloc+0x1f0/0x210
Jul 29 09:44:40 ss kernel:  [<c9a2c67f>] ohci_urb_enqueue+0xbf/0x3c0 
[ohci_hcd]
Jul 29 09:44:40 ss kernel:  [<c015f96b>] kmem_cache_free+0x20b/0x350
Jul 29 09:44:40 ss kernel:  [<c9a48517>] hcd_submit_urb+0x1b7/0x2b0 [usbcore]
Jul 29 09:44:40 ss kernel:  [<c038dae5>] kfree_skbmem+0x25/0x30
Jul 29 09:44:40 ss kernel:  [<c9a499e5>] usb_submit_urb+0x1c5/0x240 [usbcore]
Jul 29 09:44:40 ss kernel:  [<c9a197f2>] acm_tty_write+0xd2/0x140 [cdc_acm]
Jul 29 09:44:40 ss kernel:  [<c9a7b06c>] ppp_async_push+0x1fc/0x350 
[ppp_async]
Jul 29 09:44:40 ss kernel:  [<c9a7ae63>] ppp_async_send+0x43/0x50 [ppp_async]
Jul 29 09:44:40 ss kernel:  [<c99eb79b>] ppp_channel_push+0x1bb/0x6a0 
[ppp_generic]
Jul 29 09:44:40 ss kernel:  [<c038d8a8>] alloc_skb+0x48/0xf0
Jul 29 09:44:40 ss kernel:  [<c99e8560>] ppp_write+0x1f0/0x2d0 [ppp_generic]
Jul 29 09:44:40 ss kernel:  [<c017f101>] vfs_write+0xd1/0x140
Jul 29 09:44:40 ss kernel:  [<c017f20f>] sys_write+0x3f/0x60
Jul 29 09:44:40 ss kernel:  [<c010b0db>] syscall_call+0x7/0xb
Jul 29 09:44:40 ss kernel: 
Jul 29 09:44:40 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:40 ss kernel: Call Trace:
Jul 29 09:44:40 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:40 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:40 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:40 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:40 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:40 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:40 ss kernel:  [<c02f42e5>] ide_do_request+0x2a5/0x590
Jul 29 09:44:40 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:40 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:40 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:40 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:40 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:40 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:40 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:40 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:40 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:40 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:40 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:40 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:40 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:40 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:40 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:40 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:40 ss kernel: 
Jul 29 09:44:40 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:40 ss kernel: Call Trace:
Jul 29 09:44:40 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:40 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:40 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:40 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:40 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:40 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:40 ss kernel:  [<c02f42e5>] ide_do_request+0x2a5/0x590
Jul 29 09:44:40 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:40 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:40 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:40 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:40 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:40 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:40 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:40 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:40 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:40 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:40 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:40 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:40 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:40 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:40 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:40 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:40 ss kernel: 
Jul 29 09:44:40 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:40 ss kernel: Call Trace:
Jul 29 09:44:40 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:40 ss kernel:  [<c9a7b627>] ppp_async_input+0x2b7/0x560 
[ppp_async]
Jul 29 09:44:40 ss kernel:  [<c9a7a57e>] ppp_asynctty_receive+0x9e/0x1b0 
[ppp_async]
Jul 29 09:44:40 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:40 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:40 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:40 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:40 ss kernel:  [<c02f42e5>] ide_do_request+0x2a5/0x590
Jul 29 09:44:41 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:41 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:41 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:41 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:41 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:41 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:41 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:41 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:41 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:41 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:41 ss kernel: 
Jul 29 09:44:41 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:41 ss kernel: Call Trace:
Jul 29 09:44:41 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:41 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:41 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:41 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:41 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:41 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:41 ss kernel:  [<c02f42e5>] ide_do_request+0x2a5/0x590
Jul 29 09:44:41 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:41 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:41 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:41 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:41 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:41 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:41 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:41 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:41 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:41 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:41 ss kernel: 
Jul 29 09:44:41 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:41 ss kernel: Call Trace:
Jul 29 09:44:41 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:41 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:41 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:41 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:41 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:41 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:41 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:41 ss kernel:  [<c013575d>] update_wall_time+0xd/0x40
Jul 29 09:44:41 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:41 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:41 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:41 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:41 ss kernel:  [<c015fcee>] kfree+0x23e/0x3c0
Jul 29 09:44:41 ss kernel:  [<c038dad4>] kfree_skbmem+0x14/0x30
Jul 29 09:44:41 ss kernel:  [<c038dad4>] kfree_skbmem+0x14/0x30
Jul 29 09:44:41 ss kernel:  [<c038db71>] __kfree_skb+0x81/0x100
Jul 29 09:44:41 ss kernel:  [<c99e82bd>] ppp_read+0x23d/0x2f0 [ppp_generic]
Jul 29 09:44:41 ss kernel:  [<c0124760>] default_wake_function+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c019ae40>] sys_select+0x220/0x4c0
Jul 29 09:44:41 ss kernel:  [<c0124760>] default_wake_function+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c019ae40>] sys_select+0x220/0x4c0
Jul 29 09:44:41 ss kernel:  [<c017ef01>] vfs_read+0xd1/0x140
Jul 29 09:44:41 ss kernel:  [<c011329a>] do_gettimeofday+0x1a/0x90
Jul 29 09:44:41 ss kernel:  [<c017f1af>] sys_read+0x3f/0x60
Jul 29 09:44:41 ss kernel:  [<c010b0db>] syscall_call+0x7/0xb
Jul 29 09:44:41 ss kernel: 
Jul 29 09:44:41 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:41 ss kernel: Call Trace:
Jul 29 09:44:41 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:41 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:41 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:41 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:41 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:41 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:41 ss kernel:  [<c02f42e5>] ide_do_request+0x2a5/0x590
Jul 29 09:44:41 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:41 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:41 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:41 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:41 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:41 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:41 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:41 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:41 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:41 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:41 ss kernel: 
Jul 29 09:44:41 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:41 ss kernel: Call Trace:
Jul 29 09:44:41 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:41 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:41 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:41 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:41 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:41 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:41 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:41 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:41 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:41 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:41 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:41 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:41 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:41 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:41 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:41 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:41 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:41 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:41 ss kernel: 
Jul 29 09:44:41 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:41 ss kernel: Call Trace:
Jul 29 09:44:41 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:41 ss kernel:  [<c9a7b627>] ppp_async_input+0x2b7/0x560 
[ppp_async]
Jul 29 09:44:42 ss kernel:  [<c9a7a57e>] ppp_asynctty_receive+0x9e/0x1b0 
[ppp_async]
Jul 29 09:44:42 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:42 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:42 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:42 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:42 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:42 ss kernel:  [<c02f50b4>] ide_intr+0x3e4/0x5d0
Jul 29 09:44:42 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:42 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:42 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:42 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:42 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:42 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:42 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:42 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:42 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:42 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:42 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:42 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:42 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:42 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:42 ss kernel: 
Jul 29 09:44:42 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:42 ss kernel: Call Trace:
Jul 29 09:44:42 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:42 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:42 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:42 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:42 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:42 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:42 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:42 ss kernel:  [<c02f50b4>] ide_intr+0x3e4/0x5d0
Jul 29 09:44:42 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:42 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:42 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:42 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:42 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:42 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:42 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:42 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:42 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:42 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:42 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:42 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:42 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:42 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:42 ss kernel: 
Jul 29 09:44:42 ss kernel: Debug: sleeping function called from invalid 
context at mm/slab.c:1817
Jul 29 09:44:42 ss kernel: Call Trace:
Jul 29 09:44:42 ss kernel:  [<c0126e4f>] __might_sleep+0x5f/0x90
Jul 29 09:44:42 ss kernel:  [<c015f740>] __kmalloc+0x1f0/0x210
Jul 29 09:44:42 ss kernel:  [<c9a2c67f>] ohci_urb_enqueue+0xbf/0x3c0 
[ohci_hcd]
Jul 29 09:44:42 ss kernel:  [<c015f96b>] kmem_cache_free+0x20b/0x350
Jul 29 09:44:42 ss kernel:  [<c9a48517>] hcd_submit_urb+0x1b7/0x2b0 [usbcore]
Jul 29 09:44:42 ss kernel:  [<c038dae5>] kfree_skbmem+0x25/0x30
Jul 29 09:44:42 ss kernel:  [<c9a499e5>] usb_submit_urb+0x1c5/0x240 [usbcore]
Jul 29 09:44:42 ss kernel:  [<c9a197f2>] acm_tty_write+0xd2/0x140 [cdc_acm]
Jul 29 09:44:42 ss kernel:  [<c9a7b06c>] ppp_async_push+0x1fc/0x350 
[ppp_async]
Jul 29 09:44:42 ss kernel:  [<c9a7ae63>] ppp_async_send+0x43/0x50 [ppp_async]
Jul 29 09:44:42 ss kernel:  [<c99eb79b>] ppp_channel_push+0x1bb/0x6a0 
[ppp_generic]
Jul 29 09:44:42 ss kernel:  [<c038d8a8>] alloc_skb+0x48/0xf0
Jul 29 09:44:42 ss kernel:  [<c99e8560>] ppp_write+0x1f0/0x2d0 [ppp_generic]
Jul 29 09:44:42 ss kernel:  [<c017f101>] vfs_write+0xd1/0x140
Jul 29 09:44:42 ss kernel:  [<c017f20f>] sys_write+0x3f/0x60
Jul 29 09:44:42 ss kernel:  [<c010b0db>] syscall_call+0x7/0xb
Jul 29 09:44:42 ss kernel: 
Jul 29 09:44:42 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:42 ss kernel: Call Trace:
Jul 29 09:44:42 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:42 ss kernel:  [<c9a7b627>] ppp_async_input+0x2b7/0x560 
[ppp_async]
Jul 29 09:44:42 ss kernel:  [<c9a7a57e>] ppp_asynctty_receive+0x9e/0x1b0 
[ppp_async]
Jul 29 09:44:42 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:42 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:42 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:42 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:42 ss kernel:  [<c02dd42f>] elv_queue_empty+0x1f/0x30
Jul 29 09:44:42 ss kernel:  [<c02f40a0>] ide_do_request+0x60/0x590
Jul 29 09:44:42 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:42 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:42 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:42 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:42 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:42 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:42 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:42 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:42 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:42 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:42 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:42 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:42 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:42 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:42 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:42 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:42 ss kernel: 
Jul 29 09:44:42 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:42 ss kernel: Call Trace:
Jul 29 09:44:42 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:42 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:43 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:43 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:43 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:43 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:43 ss kernel:  [<c02dd42f>] elv_queue_empty+0x1f/0x30
Jul 29 09:44:43 ss kernel:  [<c02f40a0>] ide_do_request+0x60/0x590
Jul 29 09:44:43 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:43 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:43 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:43 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:43 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:43 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:43 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:43 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:43 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:43 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:43 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:43 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:43 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:43 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:43 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:43 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:43 ss kernel: 
Jul 29 09:44:43 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:43 ss kernel: Call Trace:
Jul 29 09:44:43 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:43 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:43 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:43 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:43 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:43 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:43 ss kernel:  [<c02f42e5>] ide_do_request+0x2a5/0x590
Jul 29 09:44:43 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:43 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:43 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:43 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:43 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:43 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:43 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:43 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:43 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:43 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:43 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:43 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:43 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:43 ss pppd[846]: ioctl(PPPIOCSASYNCMAP): Inappropriate ioctl for 
device(25)
Jul 29 09:44:43 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:43 ss pppd[846]: tcflush failed: Input/output error
Jul 29 09:44:43 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:43 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:43 ss kernel: 
Jul 29 09:44:43 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:43 ss kernel: Call Trace:
Jul 29 09:44:43 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:43 ss kernel:  [<c9a7b627>] ppp_async_input+0x2b7/0x560 
[ppp_async]
Jul 29 09:44:43 ss kernel:  [<c9a7a57e>] ppp_asynctty_receive+0x9e/0x1b0 
[ppp_async]
Jul 29 09:44:43 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:43 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:43 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:43 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:43 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:43 ss kernel:  [<c019ae40>] sys_select+0x220/0x4c0
Jul 29 09:44:43 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:43 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:43 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:43 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:43 ss kernel: 
Jul 29 09:44:43 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:43 ss kernel: Call Trace:
Jul 29 09:44:43 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:43 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:43 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:43 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:43 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:43 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:43 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:43 ss kernel:  [<c019ae40>] sys_select+0x220/0x4c0
Jul 29 09:44:43 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:43 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:43 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:43 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:43 ss kernel: 
Jul 29 09:44:43 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:43 ss kernel: Call Trace:
Jul 29 09:44:43 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:43 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:43 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:43 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:43 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:43 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:43 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:43 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:44 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:44 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:44 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:44 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:44 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:44 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:44 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:44 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:44 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:44 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:44 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:44 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:44 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:44 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:44 ss kernel: 
Jul 29 09:44:44 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:44 ss kernel: Call Trace:
Jul 29 09:44:44 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:44 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:44 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:44 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:44 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:44 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:44 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:44 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:44 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:44 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:44 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:44 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:44 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:44 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:44 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:44 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:44 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:44 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:44 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:44 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:44 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:44 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:44 ss kernel: 
Jul 29 09:44:44 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:44 ss kernel: Call Trace:
Jul 29 09:44:44 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:44 ss kernel:  [<c9a7b627>] ppp_async_input+0x2b7/0x560 
[ppp_async]
Jul 29 09:44:44 ss kernel:  [<c9a7a57e>] ppp_asynctty_receive+0x9e/0x1b0 
[ppp_async]
Jul 29 09:44:44 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:44 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:44 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:44 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:44 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:44 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:44 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:44 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:44 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:44 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:44 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:44 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:44 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:44 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:44 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:44 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:44 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:44 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:44 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:44 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:44 ss kernel: 
Jul 29 09:44:44 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:44 ss kernel: Call Trace:
Jul 29 09:44:44 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:44 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:44 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:44 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:44 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:44 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:44 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:44 ss kernel:  [<c0135e2d>] do_timer+0xdd/0xf0
Jul 29 09:44:44 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:44 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:44 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:45 ss kernel:  [<c012c3ce>] profile_hook+0x2e/0x47
Jul 29 09:44:45 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:45 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:45 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:45 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:45 ss kernel:  [<c0108040>] default_idle+0x0/0x30
Jul 29 09:44:45 ss kernel:  [<c0108067>] default_idle+0x27/0x30
Jul 29 09:44:45 ss kernel:  [<c01080e1>] cpu_idle+0x31/0x40
Jul 29 09:44:45 ss kernel:  [<c0105000>] rest_init+0x0/0xf0
Jul 29 09:44:45 ss kernel:  [<c04f0775>] start_kernel+0x1b5/0x210
Jul 29 09:44:45 ss kernel:  [<c04f0480>] unknown_bootoption+0x0/0x100
Jul 29 09:44:45 ss kernel: 
Jul 29 09:44:45 ss kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 29 09:44:45 ss kernel: Call Trace:
Jul 29 09:44:45 ss kernel:  [<c0130678>] local_bh_enable+0x88/0x90
Jul 29 09:44:45 ss kernel:  [<c9a7a5d6>] ppp_asynctty_receive+0xf6/0x1b0 
[ppp_async]
Jul 29 09:44:45 ss kernel:  [<c02ac3ee>] flush_to_ldisc+0x15e/0x250
Jul 29 09:44:45 ss kernel:  [<c9a191f8>] acm_read_bulk+0xb8/0x140 [cdc_acm]
Jul 29 09:44:45 ss kernel:  [<c9a493d7>] usb_hcd_giveback_urb+0x27/0x40 
[usbcore]
Jul 29 09:44:45 ss kernel:  [<c9a2c4a1>] dl_done_list+0x201/0x320 [ohci_hcd]
Jul 29 09:44:45 ss kernel:  [<c9a2d93c>] ohci_irq+0x28c/0x370 [ohci_hcd]
Jul 29 09:44:45 ss kernel:  [<c038db71>] __kfree_skb+0x81/0x100
Jul 29 09:44:45 ss kernel:  [<c9a4941e>] usb_hcd_irq+0x2e/0x60 [usbcore]
Jul 29 09:44:45 ss kernel:  [<c010d4cb>] handle_IRQ_event+0x3b/0x70
Jul 29 09:44:45 ss kernel:  [<c010db01>] do_IRQ+0x141/0x3a0
Jul 29 09:44:45 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:45 ss kernel:  [<c01305df>] do_softirq+0x9f/0xb0
Jul 29 09:44:45 ss kernel:  [<c010dc10>] do_IRQ+0x250/0x3a0
Jul 29 09:44:45 ss kernel:  [<c010ba48>] common_interrupt+0x18/0x20
Jul 29 09:44:45 ss kernel:  [<c0130491>] current_kernel_time+0x1/0x40
Jul 29 09:44:45 ss kernel:  [<c02a8ee6>] tty_write+0x3b6/0x750
Jul 29 09:44:45 ss kernel:  [<c019aa6c>] do_select+0x26c/0x3f0
Jul 29 09:44:45 ss kernel:  [<c02afe90>] write_chan+0x0/0x220
Jul 29 09:44:45 ss kernel:  [<c017f53f>] do_readv_writev+0x1cf/0x280
Jul 29 09:44:45 ss kernel:  [<c02a8b30>] tty_write+0x0/0x750
Jul 29 09:44:45 ss kernel:  [<c017f6bd>] vfs_writev+0x5d/0x70
Jul 29 09:44:45 ss kernel:  [<c017f76f>] sys_writev+0x3f/0x60
Jul 29 09:44:45 ss kernel:  [<c010b0db>] syscall_call+0x7/0xb
Jul 29 09:44:45 ss kernel: 
-8<- dmesg ---------------

It's pppd or kernel problem ?

BTW: kernel build with  CONFIG_PREEMPT=y 
perhaps it's source of last problem ?

Regards, 

/SS
