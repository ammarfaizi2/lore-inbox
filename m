Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267421AbUIUA7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267421AbUIUA7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 20:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUIUA7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 20:59:45 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:187 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S267421AbUIUA7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 20:59:40 -0400
Subject: Re: problem with suspend and usb
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1095685487.4294.14.camel@taz.graycell.biz>
References: <1095685487.4294.14.camel@taz.graycell.biz>
Content-Type: text/plain
Organization: Graycell
Date: Tue, 21 Sep 2004 01:59:31 +0100
Message-Id: <1095728371.16294.14.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Seg, 2004-09-20 at 14:04 +0100, Nuno Ferreira wrote:
> Tried suspend for the first time and after I booted with "nomce" (a
> workaround for my broken BIOS, I think) everything worked, apart from
> USB.
> When resuming, usb does not work. If I unload and load ohci_hcd module
> USB starts working again. My laptop is a Compaq Presario 920.
> Is it a known problem? 
> 
OK, it seems I was sleeping when I made this bug report, I forgot some
essential stuff.
Kernel is 2.6.8, and I'm suspending using "echo 4 > /proc/acpi/sleep".

Also, suspending with my usb mouse plugged in I get a different trace:

Sep 20 23:35:41 taz kernel: Stopping tasks: =========================================================================================|
Sep 20 23:35:41 taz kernel: Freeing memory: ...............................................................................................................................................................................................................................................|
Sep 20 23:35:41 taz kernel: Suspending devices... /critical section: counting pages to copy.[nosave pfn 0x355][nosave pfn 0x356]................................................... (pages needed: 7196+512=7708 free: 119778)
Sep 20 23:35:41 taz kernel: Alloc pagedir
Sep 20 23:35:41 taz kernel: .[nosave pfn 0x355][nosave pfn 0x356]Freeing prev allocated pagedir
Sep 20 23:35:41 taz kernel: done, devices
Sep 20 23:35:41 taz kernel: Warning: CPU frequency out of sync: cpufreq and timingcore thinks of 662605, is 1656512 kHz.
Sep 20 23:35:41 taz kernel: APIC error on CPU0: 00(00)
Sep 20 23:35:41 taz kernel: ohci_hcd 0000:00:02.0: HC died; cleaning up
Sep 20 23:35:41 taz kernel: usb 1-1: USB disconnect, address 2
Sep 20 23:35:41 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 20 23:35:42 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 20 23:35:42 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 20 23:35:45 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 20 23:35:45 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 20 23:35:45 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 20 23:35:45 taz kernel:  [hcd_panic+95/144] hcd_panic+0x5f/0x90
Sep 20 23:35:45 taz kernel:  [worker_thread+357/512] worker_thread+0x165/0x200
Sep 20 23:35:45 taz kernel:  [activate_task+92/112] activate_task+0x5c/0x70
Sep 20 23:35:45 taz kernel:  [hcd_panic+0/144] hcd_panic+0x0/0x90
Sep 20 23:35:45 taz kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep 20 23:35:45 taz kernel:  [__wake_up_common+55/96] __wake_up_common+0x37/0x60
Sep 20 23:35:45 taz kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep 20 23:35:45 taz kernel:  [worker_thread+0/512] worker_thread+0x0/0x200
Sep 20 23:35:45 taz kernel:  [kthread+149/208] kthread+0x95/0xd0
Sep 20 23:35:45 taz kernel:  [kthread+0/208] kthread+0x0/0xd0
Sep 20 23:35:45 taz kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
[... badness messages repeated lots of times...]

> syslog output
> -------------
> Sep 19 02:38:31 taz kernel: Stopping tasks: =================================================================================================|
> Sep 19 02:38:32 taz kernel: Freeing memory: ....................................................................................................................................................................................................................................................|
> Sep 19 02:38:32 taz kernel: Suspending devices... /critical section: counting pages to copy.[nosave pfn 0x355][nosave pfn 0x356]........................................................... (pages needed: 8546+512=9058 free: 118428)
> Sep 19 02:38:32 taz kernel: Alloc pagedir
> Sep 19 02:38:32 taz kernel: .[nosave pfn 0x355][nosave pfn 0x356]Freeing prev allocated pagedir
> Sep 19 02:38:32 taz kernel: done, devices
> Sep 19 02:38:32 taz kernel: Warning: CPU frequency out of sync: cpufreq and timingcore thinks of 529908, is 1655962 kHz.
> Sep 19 02:38:32 taz kernel: APIC error on CPU0: 00(00)
> Sep 19 02:38:32 taz kernel: ohci_hcd 0000:00:02.0: HC died; cleaning up
> Sep 19 02:38:32 taz kernel: eth0: link down
> Sep 19 02:38:32 taz kernel: ACPI: PCI interrupt 0000:00:10.0[A]: no GSI
> Sep 19 02:38:32 taz kernel: Fixing swap signatures... ok
> Sep 19 02:38:32 taz kernel: Restarting tasks... done
> Sep 19 02:38:37 taz kernel: atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
> Sep 19 02:38:38 taz kernel: Warning: CPU frequency out of sync: cpufreq and timing core thinks of 529908, is 1655962 kHz.
> Sep 19 02:39:09 taz dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 6
> Sep 19 02:39:15 taz dhclient: No DHCPOFFERS received.
> Sep 19 02:39:15 taz dhclient: No working leases in persistent database - sleeping.
> Sep 19 02:39:17 taz kernel: ohci_hcd 0000:00:02.0: remove, state 84
> Sep 19 02:39:17 taz kernel: usb usb1: USB disconnect, address 1
> Sep 19 02:39:17 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
> Sep 19 02:39:17 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
> Sep 19 02:39:17 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
> Sep 19 02:39:17 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
> Sep 19 02:39:17 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
> Sep 19 02:39:17 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
> Sep 19 02:39:17 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
> Sep 19 02:39:17 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
> Sep 19 02:39:17 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
> Sep 19 02:39:17 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
> Sep 19 02:39:17 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
> Sep 19 02:39:17 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
> Sep 19 02:39:17 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
> Sep 19 02:39:17 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
> Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
> Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
> Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
 [... repeated traces deleted ...]

-- 
Nuno Ferreira

