Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUITNGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUITNGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 09:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUITNGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 09:06:19 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:45836 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S266474AbUITNE5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 09:04:57 -0400
Subject: problem with suspend and usb
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Graycell
Date: Mon, 20 Sep 2004 14:04:47 +0100
Message-Id: <1095685487.4294.14.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2004 13:04:52.0253 (UTC) FILETIME=[6AC1CCD0:01C49F12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried suspend for the first time and after I booted with "nomce" (a
workaround for my broken BIOS, I think) everything worked, apart from
USB.
When resuming, usb does not work. If I unload and load ohci_hcd module
USB starts working again. My laptop is a Compaq Presario 920.
Is it a known problem? 

syslog output
-------------
Sep 19 02:38:31 taz kernel: Stopping tasks: =================================================================================================|
Sep 19 02:38:32 taz kernel: Freeing memory: ....................................................................................................................................................................................................................................................|
Sep 19 02:38:32 taz kernel: Suspending devices... /critical section: counting pages to copy.[nosave pfn 0x355][nosave pfn 0x356]........................................................... (pages needed: 8546+512=9058 free: 118428)
Sep 19 02:38:32 taz kernel: Alloc pagedir
Sep 19 02:38:32 taz kernel: .[nosave pfn 0x355][nosave pfn 0x356]Freeing prev allocated pagedir
Sep 19 02:38:32 taz kernel: done, devices
Sep 19 02:38:32 taz kernel: Warning: CPU frequency out of sync: cpufreq and timingcore thinks of 529908, is 1655962 kHz.
Sep 19 02:38:32 taz kernel: APIC error on CPU0: 00(00)
Sep 19 02:38:32 taz kernel: ohci_hcd 0000:00:02.0: HC died; cleaning up
Sep 19 02:38:32 taz kernel: eth0: link down
Sep 19 02:38:32 taz kernel: ACPI: PCI interrupt 0000:00:10.0[A]: no GSI
Sep 19 02:38:32 taz kernel: Fixing swap signatures... ok
Sep 19 02:38:32 taz kernel: Restarting tasks... done
Sep 19 02:38:37 taz kernel: atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
Sep 19 02:38:38 taz kernel: Warning: CPU frequency out of sync: cpufreq and timing core thinks of 529908, is 1655962 kHz.
Sep 19 02:39:09 taz dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 6
Sep 19 02:39:15 taz dhclient: No DHCPOFFERS received.
Sep 19 02:39:15 taz dhclient: No working leases in persistent database - sleeping.
Sep 19 02:39:17 taz kernel: ohci_hcd 0000:00:02.0: remove, state 84
Sep 19 02:39:17 taz kernel: usb usb1: USB disconnect, address 1
Sep 19 02:39:17 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:17 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:17 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:17 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:17 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:17 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:17 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:17 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:17 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:17 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:17 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:17 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:17 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:17 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+25/224] usb_disable_device+0x19/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_device+39/224] usb_disable_device+0x27/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_endpoint_disable at drivers/usb/core/hcd.c:1308
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+322/352] hcd_endpoint_disable+0x142/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [usb_disable_interface+38/64] usb_disable_interface+0x26/0x40
Sep 19 02:39:18 taz kernel:  [usb_unbind_interface+29/128] usb_unbind_interface+0x1d/0x80
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [bus_remove_device+84/144] bus_remove_device+0x54/0x90
Sep 19 02:39:18 taz kernel:  [device_del+82/160] device_del+0x52/0xa0
Sep 19 02:39:18 taz kernel:  [usb_disable_device+116/224] usb_disable_device+0x74/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: Badness in hcd_unlink_urb at drivers/usb/core/hcd.c:1240
Sep 19 02:39:18 taz kernel:  [hcd_unlink_urb+358/368] hcd_unlink_urb+0x166/0x170
Sep 19 02:39:18 taz kernel:  [usb_kill_urb+87/240] usb_kill_urb+0x57/0xf0
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+265/352] hcd_endpoint_disable+0x109/0x160
Sep 19 02:39:18 taz kernel:  [hcd_endpoint_disable+0/352] hcd_endpoint_disable+0x0/0x160
Sep 19 02:39:18 taz kernel:  [usb_disable_endpoint+101/144] usb_disable_endpoint+0x65/0x90
Sep 19 02:39:18 taz kernel:  [hub_disconnect+269/304] hub_disconnect+0x10d/0x130
Sep 19 02:39:18 taz kernel:  [usb_unbind_interface+84/128] usb_unbind_interface+0x54/0x80
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [bus_remove_device+84/144] bus_remove_device+0x54/0x90
Sep 19 02:39:18 taz kernel:  [device_del+82/160] device_del+0x52/0xa0
Sep 19 02:39:18 taz kernel:  [usb_disable_device+116/224] usb_disable_device+0x74/0xe0
Sep 19 02:39:18 taz kernel:  [usb_disconnect+162/304] usb_disconnect+0xa2/0x130
Sep 19 02:39:18 taz kernel:  [usb_hcd_pci_remove+126/384] usb_hcd_pci_remove+0x7e/0x180
Sep 19 02:39:18 taz kernel:  [pci_device_remove+40/48] pci_device_remove+0x28/0x30
Sep 19 02:39:18 taz kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
Sep 19 02:39:18 taz kernel:  [driver_detach+24/48] driver_detach+0x18/0x30
Sep 19 02:39:18 taz kernel:  [bus_remove_driver+68/128] bus_remove_driver+0x44/0x80
Sep 19 02:39:18 taz kernel:  [driver_unregister+8/32] driver_unregister+0x8/0x20
Sep 19 02:39:18 taz kernel:  [pci_unregister_driver+11/32] pci_unregister_driver+0xb/0x20
Sep 19 02:39:18 taz kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
Sep 19 02:39:18 taz kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Sep 19 02:39:18 taz kernel:  [do_munmap+239/336] do_munmap+0xef/0x150
Sep 19 02:39:18 taz kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 02:39:18 taz kernel: ohci_hcd 0000:00:02.0: USB bus 1 deregistered
Sep 19 02:39:18 taz kernel: ohci_hcd 0000:00:0f.0: remove, state 1
Sep 19 02:39:18 taz kernel: usb usb2: USB disconnect, address 1
Sep 19 02:39:18 taz kernel: ohci_hcd 0000:00:0f.0: USB bus 2 deregistered
Sep 19 02:39:49 taz kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Sep 19 02:39:49 taz kernel: ohci_hcd: block sizes: ed 64 td 64
Sep 19 02:39:49 taz kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
Sep 19 02:39:49 taz kernel: ohci_hcd 0000:00:02.0: ALi Corporation USB 1.1 Controller
Sep 19 02:39:49 taz kernel: ohci_hcd 0000:00:02.0: irq 11, pci mem df893000
Sep 19 02:39:49 taz kernel: ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
Sep 19 02:39:49 taz kernel: hub 1-0:1.0: USB hub found
Sep 19 02:39:49 taz kernel: hub 1-0:1.0: 2 ports detected
Sep 19 02:39:49 taz kernel: ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 11 (level, low) -> IRQ 11
Sep 19 02:39:49 taz kernel: ohci_hcd 0000:00:0f.0: ALi Corporation USB 1.1 Controller (#2)
Sep 19 02:39:49 taz kernel: ohci_hcd 0000:00:0f.0: irq 11, pci mem df897000
Sep 19 02:39:49 taz kernel: ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 2
Sep 19 02:39:50 taz kernel: hub 2-0:1.0: USB hub found
Sep 19 02:39:50 taz kernel: hub 2-0:1.0: 4 ports detected

Thanks
-- 
Nuno Ferreira

