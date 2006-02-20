Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWBTPX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWBTPX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWBTPX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:23:28 -0500
Received: from mail.gmx.de ([213.165.64.20]:63664 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030285AbWBTPX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:23:28 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.16-rc4-mm1 kernel crash at bootup. parport trouble?
From: MIke Galbraith <efault@gmx.de>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43F9DB1D.4090305@aitel.hist.no>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	 <43F9DB1D.4090305@aitel.hist.no>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 16:25:23 +0100
Message-Id: <1140449123.7563.2.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-20 at 16:07 +0100, Helge Hafting wrote:
> pentium IV single processor, gcc (GCC) 4.0.3 20060128
> 
> During boot, I normally get:
> parport0: irq 7 detected
> lp0: using parport0 (polling).
> 
> Instead, I got this, written by hand:

........

> This oops is simplified. I can get the exact text if
> that really matters.  It is much more to write down and
> I don't usually have my camera at work.

I get the same, and already have the serial console hooked up.

BUG: unable to handle kernel NULL pointer dereference at virtual address 000000e8
 printing eip:
c0295414
*pde = 00000000
Oops: 0000 1]
PREEMPT SMP 
last sysfs file: 
Modules linked in:
CPU:    1
EIP:    0060:[<c0295414>]    Not tainted VLI
EFLAGS: 00010282   (2.6.16-rc4-mm17) 
EIP is at kref_get+0x9/0x43
eax: 000000e8   ebx: 000000e8   ecx: c1923a00   edx: 000000d0
esi: c04d87ab   edi: dfccfce7   ebp: c1910d68   esp: c1910d54
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c1910000 task=c190faa0)
Stack: <0>dfcdf5c8 00008124 dfccfd40 00000286 000000d0 c1910d74 c0294964 dfccfd00 
       c1910da0 c019e308 dfcdf5c0 dfccfd40 000000d0 dfce04d0 fffffff4 dfcd2d74 
       00000048 dfcdf5c0 00000000 c1910dd8 c031f953 dfcdf5c8 c04dd2e1 dfcdf640 
Call Trace:
 <c0103e8c> show_stack_log_lvl+0xb7/0xfd   <c0104064> show_registers+0x192/0x228
 <c0104347> die+0x119/0x24a   <c011387f> do_page_fault+0x2ff/0x57a
 <c0103837> error_code+0x4f/0x54   <c0294964> kobject_get+0x12/0x17
 <c019e308> sysfs_create_link+0x91/0x103   <c031f953> class_device_add+0x13c/0x2b1
 <c031fada> class_device_register+0x12/0x15   <c031fb59> class_device_create+0x7c/0x9e
 <c0306e20> lp_register+0xa8/0xef   <c0306e93> lp_attach+0x2c/0x73
 <c0314c4f> attach_driver_chain+0x14/0x2d   <c0314d1e> parport_announce_port+0x89/0xb9
 <c031b94e> parport_pc_probe_port+0x6d9/0xeb2   <c031c1d9> parport_pc_pnp_probe+0xb2/0x108
 <c02ef096> pnp_device_probe+0x47/0x93   <c031eae2> driver_probe_device+0x3e/0xb6
 <c031ec29> __driver_attach+0x68/0x6a   <c031e198> bus_for_each_dev+0x40/0x5e
 <c031e9cd> driver_attach+0x19/0x1b   <c031e474> bus_add_driver+0x6c/0x119
 <c031efa2> driver_register+0x76/0xaa   <c02eeecd> pnp_register_driver+0x1d/0x47
 <c062bc92> parport_pc_init+0x26b/0x295   <c0100427> init+0x124/0x365
 <c0100e25> kernel_thread_helper+0x5/0xb  
Code: dc 12 00 e9 79 fe ff ff 0f 0b 33 03 03 28 4b c0 e9 54 fe ff ff 90 90 55 89 e5 c7 00 01 00 00 00 5d c3 55 89 e5 53 83 ec 10 89 c3 <8b> 00 85 c0 74 09 f0 ff 03 83 c4 10 5b 5d c3 c7 44 24 0c 88 d3 
 <0>Kernel panic - not syncing: Attempted to kill init!


