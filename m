Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbTJIOIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTJIOIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:08:45 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:20879 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S262201AbTJIOIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:08:40 -0400
Subject: Call trace when rmmod'ing saa7134 and error when compiling static
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Cc: kraxel@bytesex.org
Content-Type: text/plain
Message-Id: <1065708534.737.2.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 16:08:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when I try to rmmod the saa7134 module from kernel 2.6.0-test7, I get
this call trace:

Device class 'i2c-1' does not have a release() function, it is broken
and must be fixed.
Badness in class_dev_release at drivers/base/class.c:200
Call Trace:
 [<c02be4d5>] kobject_cleanup+0x85/0x90
 [<c03e0040>] i2cdev_detach_adapter+0x0/0x40
 [<c03e0069>] i2cdev_detach_adapter+0x29/0x40
 [<c03dd216>] i2c_del_adapter+0x1c6/0x200
 [<e8a7bb59>] .text.lock.saa7134_tvaudio+0x37/0x3e [saa7134]
 [<e8a77784>] saa7134_i2c_unregister+0x14/0x20 [saa7134]
 [<e8a76a56>] saa7134_finidev+0xa6/0x1d0 [saa7134]
 [<c02cc94b>] pci_device_remove+0x3b/0x40
 [<c031c846>] device_release_driver+0x66/0x70
 [<c031c87b>] driver_detach+0x2b/0x40
 [<c031cace>] bus_remove_driver+0x3e/0x80
 [<c031ced3>] driver_unregister+0x13/0x2a
 [<c02ccb36>] pci_unregister_driver+0x16/0x30
 [<e8a76c0f>] saa7134_fini+0xf/0x11 [saa7134]
 [<c013b36a>] sys_delete_module+0x13a/0x170
 [<c01536a5>] sys_munmap+0x45/0x70
 [<c01095fb>] syscall_call+0x7/0xb

And when I try to build the driver into the kernel (not as a module), I
get this link failure:

drivers/built-in.o(.text+0x89a60): In function `saa7134_initdev':
: undefined reference to `register_sound_dsp'
drivers/built-in.o(.text+0x89aa0): In function `saa7134_initdev':
: undefined reference to `register_sound_mixer'
drivers/built-in.o(.text+0x89b7e): In function `saa7134_initdev':
: undefined reference to `unregister_sound_dsp'
drivers/built-in.o(.text+0x89ea7): In function `saa7134_finidev':
: undefined reference to `unregister_sound_mixer'
drivers/built-in.o(.text+0x89eb2): In function `saa7134_finidev':
: undefined reference to `unregister_sound_dsp'
make: *** [.tmp_vmlinux1] Error 1

But this has never worked.

Best regards,
Stian

