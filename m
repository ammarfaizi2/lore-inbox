Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbVICAiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbVICAiE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbVICAiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:38:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161056AbVICAiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:38:02 -0400
Date: Fri, 2 Sep 2005 17:37:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13: Crash in Yenta initialization
Message-Id: <20050902173754.546bc0d0.akpm@osdl.org>
In-Reply-To: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de>
References: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Koch <koch@esa.informatik.tu-darmstadt.de> wrote:
>
> This does not happen in my current kernel (2.6.12-rc6 with Ivan's PCI bridge 
> patches applied). It is definitely localized in the Yenta code, since the 
> boot proceeds when I disable the Yenta config option. My hardware is an Acer 
> Travelmate 8104 with the external ezDock attached.
> 
> I can provide more info if you let me know what to look for.
> 
> ...
> Yenta: CardBus bridge found at 0000:06:09.1 [1025:0070]
> Unable to handle kernel NULL pointer dereference at virtual address 0000004f
>  printing eip:
> c03af658
> *pde = 00000000
> Oops: 0000 [#1]
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c03af658>]    Not tainted VLI
> EFLAGS: 00010292   (2.6.13) 
> EIP is at yenta_config_init+0xd8/0x170
> eax: 00000000   ebx: dfcb7000   ecx: 00000000   edx: e0649000
> esi: dff75000   edi: 00001000   ebp: dff75000   esp: dfd9fea8
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=dfd9e000 task=dfdc7a00)
> Stack: dff7d880 00000049 0000000d 000000a8 c011f9d7 fffffff4 dfcb7000 c03af810 
>        dfcb7000 dff750d8 00001025 00000070 c05abf20 ffffffed dff75000 c05ac340 
>        c05ac36c c028927f dff75000 c05ac2d8 c05ac340 dff75000 dff75044 c02892bf 
> Call Trace:
>  [<c011f9d7>] printk+0x17/0x20
>  [<c03af810>] yenta_probe+0x120/0x280
>  [<c028927f>] __pci_device_probe+0x5f/0x70
>  [<c02892bf>] pci_device_probe+0x2f/0x50
>  [<c03211c8>] driver_probe_device+0x38/0xb0
>  [<c03212c0>] __driver_attach+0x0/0x50
>  [<c0321307>] __driver_attach+0x47/0x50
>  [<c03207a9>] bus_for_each_dev+0x69/0x80
>  [<c0321335>] driver_attach+0x25/0x30
>  [<c03212c0>] __driver_attach+0x0/0x50
>  [<c0320cfd>] bus_add_driver+0x8d/0xe0
>  [<c0289580>] pci_register_driver+0x70/0x90
>  [<c061906f>] yenta_socket_init+0xf/0x20
>  [<c05fc8cb>] do_initcalls+0x2b/0xc0
>  [<c0100290>] init+0x0/0x110
>  [<c0100290>] init+0x0/0x110
>  [<c01002ba>] init+0x2a/0x110
>  [<c0101378>] kernel_thread_helper+0x0/0x18
>  [<c010137d>] kernel_thread_helper+0x5/0x18
> Code: ed ff 8b 13 b9 a8 00 00 00 b8 0d 00 00 00 89 4c 24 0c 89 44 24 08 8b 42 
> 20 89 44 24 04 8b 42 10 89 04 24 e8 bb 56 ed ff 8b 4e 14 <0f> b6 51 4f 0f b6 
> 41 4e c1 e2 10 c1 e0 08 09 c2 0f b6 41 4d 8b 
>  <0>Kernel panic - not syncing: Attempted to kill init!
>  

I don't think any of the recent yenta changes would have caused this.

The .config might help.

Also, can you identify which line is going oops?  Set CONFIG_DEBUG_INFO,
retest, do

gdb vmlinux
(gdb) l *0xc03af658		(the EIP value)

thanks.
