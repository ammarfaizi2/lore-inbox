Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWBKVmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWBKVmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 16:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWBKVmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 16:42:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750715AbWBKVme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 16:42:34 -0500
Date: Sat, 11 Feb 2006 13:41:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Hermanowski <lkml@martin.mh57.de>
Cc: linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.16-rc2-mm1
Message-Id: <20060211134142.11c1af44.akpm@osdl.org>
In-Reply-To: <20060211203158.GA9020@mh57.de>
References: <20060207220627.345107c3.akpm@osdl.org>
	<20060211203158.GA9020@mh57.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Hermanowski <lkml@martin.mh57.de> wrote:
>
> Hi,
> 
> 2.6.16-rc2-mm1 is running fine on my IBM notebook, but the hdaps module
> (acceleration sensor) does not work like I expected:
> 
> ,----[ modprobe hdaps ]
> | Feb 11 21:24:26 nimrais kernel: hdaps: inverting axis readings.
> | Feb 11 21:24:26 nimrais kernel: hdaps: IBM ThinkPad T41p detected.
> | Feb 11 21:24:26 nimrais kernel: hdaps: driver successfully loaded.
> `----
> 
> AFAIK the module should create sysfs files in
> /sys/devices/platform/hdaps/, but I see only `bus', `power' and
> `uevent'.
> 
> When unloading the hdaps module, I get a BUG:
> 
> ,----[ rmmod hdaps ]
> | Feb 11 21:24:49 nimrais kernel:  <c011d8b6> release_resource+0x76/0x80 <c0265bf4> platform_device_del+0x44/0x60
> | Feb 11 21:24:49 nimrais kernel:  <c0265c18> platform_device_unregister+0x8/0x10   <f9b9c8ed> hdaps_exit+0xd/0x25 [hdaps]
> | Feb 11 21:24:49 nimrais kernel:  <f9b9c8e0> hdaps_exit+0x0/0x25 [hdaps] <c0132e05> sys_delete_module+0x145/0x1c0
> | Feb 11 21:24:49 nimrais kernel:  <c0149901> remove_vma+0x41/0x50 <c014ab57> do_munmap+0x1a7/0x200
> | Feb 11 21:24:49 nimrais kernel:  <c0102d91> syscall_call+0x7/0xb  
> | Feb 11 21:24:49 nimrais kernel: hdaps: driver unloaded.
> `----
> 
> Do you need more information?
> 

Thanks, I'll drop hdaps-convert-to-the-new-platform-device-interface.patch,
which very likely to have caused this.

You could try reverting that patch (wget
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/broken-out/hdaps-convert-to-the-new-platform-device-interface.patch
; patch -p1 -R < hdaps-convert-to-the-new-platform-device-interface.patch) or please test next -mm, let us know?
