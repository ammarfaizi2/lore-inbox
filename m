Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264801AbUDWM0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbUDWM0T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 08:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264803AbUDWM0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 08:26:19 -0400
Received: from linux-bt.org ([217.160.111.169]:12160 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S264801AbUDWMZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 08:25:55 -0400
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Simon Kelley <simon@thekelleys.org.uk>
In-Reply-To: <200404230142.46792.dtor_core@ameritech.net>
References: <200404230142.46792.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1082723147.1843.14.camel@merlin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Apr 2004 14:25:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> The latest change in sysfs/symlink (conversion to use kobject_name instead
> of name fiedld directly) broke atmel_cs driver:
> 
> Apr 23 00:30:10 core kernel: Oops: 0000 [#1]
> Apr 23 00:30:10 core kernel: PREEMPT
> Apr 23 00:30:10 core kernel: CPU:    0
> Apr 23 00:30:10 core kernel: EIP:    0060:[<c0182ef9>]    Not tainted
> Apr 23 00:30:10 core kernel: EFLAGS: 00010246   (2.6.6-rc2)
> Apr 23 00:30:10 core kernel: EIP is at object_path_length+0x19/0x30
> Apr 23 00:30:10 core kernel: eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: e1930284
> Apr 23 00:30:10 core kernel: esi: 00000001   edi: 00000000   ebp: dedd5d64   esp: dedd5d58
> Apr 23 00:30:10 core kernel: ds: 007b   es: 007b   ss: 0068
> Apr 23 00:30:10 core kernel: Process ifenslave (pid: 1693, threadinfo=dedd4000 task=ded6c1f0)
> Apr 23 00:30:10 core kernel: Stack: 00000003 00000000 e1930284 dedd5d98 c0182f99 e1930284 00000000 e192c6b4
> Apr 23 00:30:10 core kernel:        dedd5d90 c01ac578 c030f37b c03876c0 de2d4de0 e192c700 de5c80c0 e192c6a0
> Apr 23 00:30:10 core kernel:        dedd5dac c0211490 de5c80c8 e1930284 c0312fc6 dedd5dd4 c02117ad de5c80c0
> Apr 23 00:30:10 core kernel: Call Trace:
> Apr 23 00:30:10 core kernel:  [<c0182f99>] sysfs_create_link+0x29/0x140
> Apr 23 00:30:10 core kernel:  [<c01ac578>] kobject_hotplug+0x58/0x60
> Apr 23 00:30:10 core kernel:  [<c0211490>] class_device_dev_link+0x30/0x40
> Apr 23 00:30:10 core kernel:  [<c02117ad>] class_device_add+0xed/0x130
> Apr 23 00:30:10 core kernel:  [<e192a618>] fw_register_class_device+0x118/0x180 [firmware_class]
> Apr 23 00:30:10 core kernel:  [<e192a6ab>] fw_setup_class_device+0x2b/0x120 [firmware_class]
> Apr 23 00:30:10 core kernel:  [<e192a802>] request_firmware+0x62/0x170 [firmware_class]
> Apr 23 00:30:10 core kernel:  [<e197ccce>] reset_atmel_card+0x7ae/0x800 [atmel]
> Apr 23 00:30:10 core kernel:  [<e1978a82>] atmel_open+0x22/0x50 [atmel]
> Apr 23 00:30:10 core kernel:  [<c027f8b8>] dev_open+0xd8/0x120
> Apr 23 00:30:10 core kernel:  [<c0284915>] dev_mc_upload+0x25/0x50
> Apr 23 00:30:10 core kernel:  [<c0280f78>] dev_change_flags+0x138/0x150
> Apr 23 00:30:10 core kernel:  [<c027f724>] dev_load+0x24/0x80
> Apr 23 00:30:10 core kernel:  [<c02c0c1a>] devinet_ioctl+0x26a/0x660
> Apr 23 00:30:10 core kernel:  [<c02c3324>] inet_ioctl+0x64/0xb0
> Apr 23 00:30:10 core kernel:  [<c0278385>] sock_ioctl+0xf5/0x2b0
> Apr 23 00:30:10 core kernel:  [<c0161320>] sys_ioctl+0x100/0x260
> Apr 23 00:30:10 core kernel:  [<c010510b>] syscall_call+0x7/0xb
> 
> Below is the "fix" that helps avoid oopsing, and should be removed when
> atmel_cs driver properly registers atmel_device.

I haven't tested it yet, but the same problem should apply to the
bt3c_cs driver for the 3Com Bluetooth card. Are there any patches
available that integrates the PCMCIA subsystem into the driver model, so
we don't have to hack around it if a firmware download is needed?

Regards

Marcel


