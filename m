Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264483AbTEJTOi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbTEJTOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:14:38 -0400
Received: from franka.aracnet.com ([216.99.193.44]:20160 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264483AbTEJTOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:14:35 -0400
Date: Sat, 10 May 2003 10:12:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 700] New: Usb may fail just after plugging the device (usb mp3 player) 
Message-ID: <3500000.1052586774@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=700

           Summary: Usb may fail just after plugging the device (usb mp3
                    player)
    Kernel Version: 2.5.69-bk4
            Status: NEW
          Severity: low
             Owner: greg@kroah.com
         Submitter: solt@dns.toxicfilms.tv


Distribution:Debian 3.0 unstable
Hardware Environment: magicstar mp3 player usb flash driver
Software Environment: 
Problem Description:

Steps to reproduce:
Plugin the device, mount it, remove the device.
After some time plug it again. This will generate this calltrace:ay 10 15:07:44 pysiak kernel: drivers/usb/host/uhci-hcd.c: d000: wakeup_hc
May 10 15:07:44 pysiak kernel: hub 1-0:0: port 1, status 101, change 1, 12 Mb/s
May 10 15:07:45 pysiak kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
May 10 15:07:45 pysiak kernel: drivers/usb/host/uhci-hcd.c: d000: suspend_hc
May 10 15:07:45 pysiak kernel: drivers/usb/host/uhci-hcd.c: d000: wakeup_hc
May 10 15:07:45 pysiak kernel: hub 1-0:0: new USB device on port 1, assigned address 3
May 10 15:07:45 pysiak kernel: usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=3
May 10 15:07:45 pysiak kernel: usb 1-1: Product: USB MP3
May 10 15:07:45 pysiak kernel: usb 1-1: Manufacturer:  
May 10 15:07:45 pysiak kernel: usb 1-1: SerialNumber: 14331C050414
May 10 15:07:45 pysiak kernel: usb 1-1: usb_new_device - registering interface 1-1:0
May 10 15:07:45 pysiak kernel: usb-storage 1-1:0: usb_device_probe
May 10 15:07:45 pysiak kernel: usb-storage 1-1:0: usb_device_probe - got id
May 10 15:07:45 pysiak kernel: scsi0 : SCSI emulation for USB Mass Storage devices   
May 10 15:07:45 pysiak kernel:   Vendor:           Model: USB MP3           Rev: 1.04
May 10 15:07:45 pysiak kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
May 10 15:07:45 pysiak kernel: SCSI device sda: 243712 512-byte hdwr sectors (125 MB)
May 10 15:07:45 pysiak kernel: sda: Write Protect is off   
May 10 15:07:45 pysiak kernel: sda: Mode Sense: 43 00 00 00
May 10 15:07:45 pysiak kernel: sda: cache data unavailable
May 10 15:07:45 pysiak kernel: sda: assuming drive cache: write through
May 10 15:07:45 pysiak kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000018
May 10 15:07:45 pysiak kernel:  printing eip:
May 10 15:07:45 pysiak kernel: c02282db
May 10 15:07:45 pysiak kernel: *pde = 00000000
May 10 15:07:45 pysiak kernel: Oops: 0000 [#1]
May 10 15:07:45 pysiak kernel: CPU:    0
May 10 15:07:45 pysiak kernel: EIP:    0060:[scsi_device_get+9/52]    Tainted: P
May 10 15:07:45 pysiak kernel: EFLAGS: 00010293
May 10 15:07:45 pysiak kernel: EIP is at scsi_device_get+0x9/0x34
May 10 15:07:45 pysiak kernel: eax: 00000000   ebx: c1518500   ecx: 00000001   edx: 00000000
May 10 15:07:45 pysiak kernel: esi: 00000000   edi: c151b5e0   ebp: db89b980   esp: c15bdb00
May 10 15:07:45 pysiak kernel: ds: 007b   es: 007b   ss: 0068
May 10 15:07:45 pysiak kernel: Process khubd (pid: 4, threadinfo=c15bc000 task=dbf8c680)
May 10 15:07:45 pysiak kernel: Stack: c0230135 00000000 00000008 c1518500 c02300f0 00000000 db89b980 c014b2e6
May 10 15:07:45 pysiak kernel:        db89b980 c15bdc64 c12acd80 c0356aac c0130416 c12acd80 00000000 c1518518
May 10 15:07:45 pysiak kernel:        00000000 c1518500 00000001 c15bdc64 da231800 c014b38e c1518500 db89b980
May 10 15:07:45 pysiak kernel: Call Trace:
May 10 15:07:45 pysiak kernel:  [sd_open+69/284] sd_open+0x45/0x11c
May 10 15:07:45 pysiak kernel:  [sd_open+0/284] sd_open+0x0/0x11c
May 10 15:07:45 pysiak kernel:  [do_open+721/764] do_open+0x2d1/0x2fc
May 10 15:07:45 pysiak kernel:  [buffered_rmqueue+146/251] buffered_rmqueue+0x92/0xfb
May 10 15:07:45 pysiak kernel:  [blkdev_get+125/146] blkdev_get+0x7d/0x92
May 10 15:07:45 pysiak kernel:  [register_disk+193/319] register_disk+0xc1/0x13f
May 10 15:07:45 pysiak kernel:  [blk_register_region+72/209] blk_register_region+0x48/0xd1
May 10 15:07:45 pysiak kernel:  [add_disk+78/94] add_disk+0x4e/0x5e  
May 10 15:07:45 pysiak kernel:  [exact_match+0/5] exact_match+0x0/0x5
May 10 15:07:45 pysiak kernel:  [exact_lock+0/30] exact_lock+0x0/0x1e
May 10 15:07:45 pysiak kernel:  [sd_attach+486/716] sd_attach+0x1e6/0x2cc
May 10 15:07:45 pysiak kernel:  [scsi_attach_device+118/154] scsi_attach_device+0x76/0x9a
May 10 15:07:45 pysiak kernel:  [scsi_add_host+95/129] scsi_add_host+0x5f/0x81
May 10 15:07:45 pysiak kernel:  [storage_probe+1331/1879] storage_probe+0x533/0x757  
May 10 15:07:45 pysiak kernel:  [buffered_rmqueue+146/251] buffered_rmqueue+0x92/0xfb
May 10 15:07:45 pysiak kernel:  [usb_device_probe+210/249] usb_device_probe+0xd2/0xf9
May 10 15:07:45 pysiak kernel:  [bus_match+69/115] bus_match+0x45/0x73
May 10 15:07:45 pysiak kernel:  [device_attach+76/127] device_attach+0x4c/0x7f   
May 10 15:07:45 pysiak kernel:  [bus_add_device+100/174] bus_add_device+0x64/0xae
May 10 15:07:45 pysiak kernel:  [device_add+208/254] device_add+0xd0/0xfe
May 10 15:07:45 pysiak kernel:  [usb_new_device+1136/1501] usb_new_device+0x470/0x5dd
May 10 15:07:45 pysiak kernel:  [usb_hub_port_connect_change+564/919] usb_hub_port_connect_change+0x234/0x397
May 10 15:07:45 pysiak kernel:  [usb_hub_events+1037/1144] usb_hub_events+0x40d/0x478
May 10 15:07:45 pysiak kernel:  [usb_hub_thread+49/242] usb_hub_thread+0x31/0xf2
May 10 15:07:45 pysiak kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
May 10 15:07:45 pysiak kernel:  [usb_hub_thread+0/242] usb_hub_thread+0x0/0xf2
May 10 15:07:45 pysiak kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
May 10 15:07:45 pysiak kernel: 
May 10 15:07:45 pysiak kernel: Code: 8b 42 18 8b 40 4c 8b 00 85 c0 74 0b 83 38 02 74 16 ff 80 00

Also, when the device is unplugged and sometimes when it is plugged while rebooting i get  these about 20 lines / second
May 10 18:04:55 pysiak kernel: drivers/usb/host/uhci-hcd.c: d000: wakeup_hc 
May 10 18:04:55 pysiak kernel: drivers/usb/host/uhci-hcd.c: d000: suspend_hc
May 10 18:04:55 pysiak kernel: drivers/usb/host/uhci-hcd.c: d000: wakeup_hc 
May 10 18:04:55 pysiak kernel: drivers/usb/host/uhci-hcd.c: d000: suspend_hc
May 10 18:04:55 pysiak kernel: drivers/usb/host/uhci-hcd.c: d000: wakeup_hc


