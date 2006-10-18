Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWJRVir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWJRVir (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWJRVir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:38:47 -0400
Received: from as3.cineca.com ([130.186.84.211]:19333 "EHLO as3.cineca.com")
	by vger.kernel.org with ESMTP id S932085AbWJRViq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:38:46 -0400
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: "alpha @ steudten Engineering" <alpha@steudten.com>
Subject: Re: Problem with sn9c102 webcam locks ..
Date: Wed, 18 Oct 2006 23:38:37 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <453692C8.50907@steudten.org>
In-Reply-To: <453692C8.50907@steudten.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610182338.38210.luca.risolia@studio.unibo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

could you test the latest version of the driver at http://www.linux-projects.org.
Load the module with "debug=3". Please report every messages as you
have done before.

Best regards
Luca


Alle 22:47, mercoledì 18 ottobre 2006, alpha @ steudten Engineering ha scritto:
> Hi list
> 
> unplugging the webcam, the kernel 2.6.18 gives this output..
> 
> description:    V4L2 driver for SN9C10x PC Camera Controllers
> version:        1:1.27
> license:        GPL
> vermagic:       2.6.18-1.2200self mod_unload PENTIUMM REGPARM gcc-4.1
> depends:        videodev,v4l2-common
> 
> 
> usb 2-2: new full speed USB device using uhci_hcd and address 2
> PM: Adding info for usb:2-2
> PM: Adding info for No Bus:usbdev2.2_ep00
> usb 2-2: configuration #1 chosen from 1 choice
> PM: Adding info for usb:2-2:1.0
> PM: Adding info for No Bus:usbdev2.2_ep81
> PM: Adding info for No Bus:usbdev2.2_ep82
> PM: Adding info for No Bus:usbdev2.2_ep83
> Linux video capture interface: v2.00
> sn9c102: V4L2 driver for SN9C10x PC Camera Controllers v1:1.27
> usb 2-2: SN9C10[12] PC Camera Controller detected (vid/pid 0x0C45/0x6029)
> usb 2-2: PAS106B image sensor detected
> usb 2-2: Initialization succeeded
> usb 2-2: V4L2 device registered as /dev/video0
> usbcore: registered new driver sn9c102
> 
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> 2.6.18-1.2200self #1
> -------------------------------------------------------
> sn-webcam/3184 is trying to acquire lock:
>  (&cam->dev_mutex){--..}, at: [<c03261e6>] mutex_lock_interruptible+0x21/0x24
> 
> but task is already holding lock:
>  (videodev_lock){--..}, at: [<c0326512>] mutex_lock+0x21/0x24
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (videodev_lock){--..}:
>        [<c012da43>] __lock_acquire+0x82c/0x904
>        [<c012e083>] lock_acquire+0x4b/0x6c
>        [<c03263a4>] __mutex_lock_slowpath+0xb3/0x200
>        [<c0326512>] mutex_lock+0x21/0x24
>        [<f93f91a2>] video_register_device+0x9e/0x217 [videodev]
>        [<f9c76f42>] sn9c102_usb_probe+0x36e/0x4f2 [sn9c102]
>        [<c02a0bbc>] usb_probe_interface+0x5b/0x8b
>        [<c0267866>] driver_probe_device+0x45/0x92
>        [<c026798f>] __driver_attach+0x66/0x8f
>        [<c02672e5>] bus_for_each_dev+0x36/0x5b
>        [<c02677c1>] driver_attach+0x14/0x17
>        [<c0266fc5>] bus_add_driver+0x68/0x106
>        [<c0267c2f>] driver_register+0x78/0x7d
>        [<c02a09dd>] usb_register_driver+0x65/0xc6
>        [<f9396028>] 0xf9396028
>        [<c01341a1>] sys_init_module+0x1340/0x148b
>        [<c0102e17>] syscall_call+0x7/0xb
>        [<ffffffff>] 0xffffffff
> 
> -> #0 (&cam->dev_mutex){--..}:
>        [<c012d977>] __lock_acquire+0x760/0x904
>        [<c012e083>] lock_acquire+0x4b/0x6c
>        [<c0326024>] __mutex_lock_interruptible_slowpath+0xb3/0x254
>        [<c03261e6>] mutex_lock_interruptible+0x21/0x24
>        [<f9c766d9>] sn9c102_open+0x43/0x53e [sn9c102]
>        [<f93fb2e2>] video_open+0xba/0x135 [videodev]
>        [<c0167125>] chrdev_open+0xf3/0x123
>        [<c015e2ae>] __dentry_open+0xb9/0x187
>        [<c015e3ea>] nameidata_to_filp+0x1c/0x2e
>        [<c015e42a>] do_filp_open+0x2e/0x35
>        [<c015e471>] do_sys_open+0x40/0xb5
>        [<c015e512>] sys_open+0x16/0x18
>        [<c0102e17>] syscall_call+0x7/0xb
>        [<ffffffff>] 0xffffffff
> 
> other info that might help us debug this:
> 
> 2 locks held by sn-webcam/3184:
>  #0:  (videodev_lock){--..}, at: [<c0326512>] mutex_lock+0x21/0x24
>  #1:  (sn9c102_disconnect){..--}, at: [<f9c766b1>] sn9c102_open+0x1b/0x53e [sn9c102]
> 
> stack backtrace:
>  [<c0103c87>] show_trace_log_lvl+0x12/0x25
>  [<c0103d6a>] show_trace+0xd/0x10
>  [<c0104532>] dump_stack+0x19/0x1b
>  [<c012d20c>] print_circular_bug_tail+0x59/0x64
>  [<c012d977>] __lock_acquire+0x760/0x904
>  [<c012e083>] lock_acquire+0x4b/0x6c
>  [<c0326024>] __mutex_lock_interruptible_slowpath+0xb3/0x254
>  [<c03261e6>] mutex_lock_interruptible+0x21/0x24
>  [<f9c766d9>] sn9c102_open+0x43/0x53e [sn9c102]
>  [<f93fb2e2>] video_open+0xba/0x135 [videodev]
>  [<c0167125>] chrdev_open+0xf3/0x123
>  [<c015e2ae>] __dentry_open+0xb9/0x187
>  [<c015e3ea>] nameidata_to_filp+0x1c/0x2e
>  [<c015e42a>] do_filp_open+0x2e/0x35
>  [<c015e471>] do_sys_open+0x40/0xb5
>  [<c015e512>] sys_open+0x16/0x18
>  [<c0102e17>] syscall_call+0x7/0xb
>  =======================
> usb 2-2: USB disconnect, address 2
> PM: Removing info for No Bus:usbdev2.2_ep81
> PM: Removing info for No Bus:usbdev2.2_ep82
> PM: Removing info for No Bus:usbdev2.2_ep83
> usb 2-2: Disconnecting SN9C10x PC Camera...
> usb 2-2: V4L2 device /dev/video0 deregistered
> PM: Removing info for usb:2-2:1.0
> PM: Removing info for No Bus:usbdev2.2_ep00
> PM: Removing info for usb:2-2
> Slab corruption: (Not tainted) start=e6fd417c, len=1024
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<c029a4c2>](usb_release_dev+0x40/0x43)
>  [<c0103c87>] show_trace_log_lvl+0x12/0x25
>  [<c0103d6a>] show_trace+0xd/0x10
>  [<c0104532>] dump_stack+0x19/0x1b
>  [<c015b3a1>] check_poison_obj+0x6f/0x171
>  [<c015b4c8>] cache_alloc_debugcheck_after+0x25/0x135
>  [<c015c682>] kmem_cache_alloc+0x94/0xa0
>  [<c013f051>] audit_alloc+0x65/0xc4
>  [<c01161e2>] copy_process+0x56e/0x11a6
>  [<c0116e5c>] do_fork+0x42/0x112
>  [<c0101200>] sys_clone+0x25/0x2a
>  [<c0102e17>] syscall_call+0x7/0xb
>  =======================
> 170: 6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b
> Single bit error detected. Probably bad RAM.
> Run memtest86+ or a similar memory test tool.
> Next obj: start=e6fd4588, len=1024
> Redzone: 0x5a2cf071/0x5a2cf071.
> Last user: [<c02cea08>](skb_release_data+0x80/0x84)
> 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> 
> 
> 
