Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264720AbUEXWRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264720AbUEXWRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUEXWRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:17:05 -0400
Received: from death.pitchblack.cc ([216.117.210.2]:14720 "EHLO
	death.pitchblack.cc") by vger.kernel.org with ESMTP id S264733AbUEXWQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:16:46 -0400
Date: Mon, 24 May 2004 15:16:37 -0700 (PDT)
From: kirk <kirk@pitchblack.cc>
To: linux-kernel@vger.kernel.org
Subject: Badness in smp_call_function ( usb_storage? )
Message-ID: <Pine.LNX.4.58.0405241430160.6523@death.pitchblack.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I havent been able to boot any kernels after 2.6.5 ( i think it started 
about 2.6.6-bk4 IIRC ), i was pretty puzzled 
about it, boots always hung on mounting local file systems, on my system i 
have 5 usb-2.0 external hard drives, and was thinking it might be related.

today i tried to boot 2.6.7-rc1 vanilla, had the same issue, so i tried 
loading the usb modules ( usbcore uhci-hcd ohci-hcd ehci-hcd usb-storage ) 
via initrd and was able to boot and caught the problem i think.

this is in my dmesg after boot, and 4 of my mass-storage devices are not 
detected correctly ( no model name ), and 2 are not accessable.

Badness in smp_call_function at arch/i386/kernel/smp.c:523
 [<c011193c>] smp_call_function+0x174/0x18f
 [<c0150691>] unmap_area_pmd+0x4b/0x56
 [<c015089c>] map_vm_area+0x62/0xa2
 [<c0111796>] flush_tlb_all+0x27/0x37
 [<c0111708>] do_flush_tlb_all+0x0/0x67
 [<c0150a45>] remove_vm_area+0x51/0x69
 [<c0150aa8>] __vunmap+0x4b/0xc2
 [<c0150b46>] vfree+0x27/0x35
 [<f88e9a45>] sg_add+0x1d9/0x470 [sg]
 [<c023c95a>] kobject_hotplug+0x42/0x46
 [<c027f3e2>] class_device_add+0xdc/0x141
 [<c02b600d>] scsi_sysfs_add_sdev+0x69/0x1f6
 [<f88f1076>] slave_configure+0x5f/0x61 [usb_storage]
 [<c02b4892>] scsi_add_lun+0x2b9/0x39e
 [<c02b4a54>] scsi_probe_and_add_lun+0xdd/0x26c
 [<c02b4c9f>] scsi_sequential_lun_scan+0xbc/0x126
 [<c02b5386>] scsi_scan_target+0x11f/0x124
 [<c02b5424>] scsi_scan_channel+0x99/0xb4
 [<c02b54dd>] scsi_scan_host_selected+0x9e/0x137
 [<c02b55a5>] scsi_scan_host+0x2f/0x33
 [<f88f3d4a>] storage_probe+0x190/0x1d3 [usb_storage]
 [<f8848060>] usb_probe_interface+0x5a/0x6e [usbcore]
 [<c027e716>] bus_match+0x3f/0x7a
 [<c027e79e>] device_attach+0x4d/0xb4
 [<c027e97f>] bus_add_device+0x5c/0xa1
 [<c027d9c7>] device_add+0x8f/0x117
 [<f884ed58>] usb_set_configuration+0x352/0x427 [usbcore]
 [<f8848ee5>] usb_new_device+0xe3/0x1f7 [usbcore]
 [<f884afd7>] hub_port_connect_change+0x22c/0x394 [usbcore]
 [<f884b29f>] hub_events+0x160/0x354 [usbcore]
 [<f884b4d1>] hub_thread+0x3e/0xc8 [usbcore]
 [<c0118f87>] default_wake_function+0x0/0x12
 [<f884b493>] hub_thread+0x0/0xc8 [usbcore]
 [<c0103c85>] kernel_thread_helper+0x5/0xb

this is the timeouts from the drives in dmesg.

usb 7-2: control timeout on ep0out
usb 7-2: control timeout on ep0out
usb 7-2: device not accepting address 3, error -110
usb 7-3: new high speed USB device using address 4
usb 7-3: control timeout on ep0out
usb 7-3: control timeout on ep0out
usb 7-3: device not accepting address 4, error -110
usb 7-3: new high speed USB device using address 5
usb 7-3: control timeout on ep0out
usb 7-3: control timeout on ep0out
usb 7-3: device not accepting address 5, error -110
usb 7-4: new high speed USB device using address 6
usb 7-4: control timeout on ep0out
usb 7-4: control timeout on ep0out
usb 7-4: device not accepting address 6, error -110
usb 7-4: new high speed USB device using address 7
usb 7-4: control timeout on ep0out
usb 7-4: control timeout on ep0out
usb 7-4: device not accepting address 7, error -110

if you need any other info please let me know
please CC me in the reply as im not subscribed to the list.

Thanks,
Kirk

