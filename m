Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbSLVEdd>; Sat, 21 Dec 2002 23:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbSLVEdd>; Sat, 21 Dec 2002 23:33:33 -0500
Received: from services.cam.org ([198.73.180.252]:19783 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S264716AbSLVEdb>;
	Sat, 21 Dec 2002 23:33:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Date: Sat, 21 Dec 2002 23:41:29 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021218094714.43C712C076@lists.samba.org> <200212201829.18430.tomlins@cam.org> <20021221142226.GA24941@suse.de>
In-Reply-To: <20021221142226.GA24941@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212212341.29560.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 21, 2002 09:22 am, Dave Jones wrote:
> On Fri, Dec 20, 2002 at 06:29:18PM -0500, Ed Tomlinson wrote:

>  > but find this in the X startup log.
>  > (EE) MGA: Failed to load module "mga_hal" (module does not exist, 0)
>
> That's matrox's binary only X blob. Not my fault.

Know all about this one... My G400 runs just fine without with X setups.

>  > (EE) MGA(0): [agp] Out of memory (-1014)
>
> This one is. But it may be a knock-on effect from the bug above.
> I'll nail that one first.

Thanks

>  > (EE) MGA(0): [drm] failed to remove DRM signal handler
>  > DRIUnlock called when not locked
>
> That one's a problem for the DRI folks.

Yep

Now for something new.  With bk current (6pm EST) I get:

Dec 21 23:30:56 oscar kernel: Linux agpgart interface v0.100 (c) Dave Jones
Dec 21 23:30:56 oscar kernel: agpgart: Detected VIA MVP3 chipset
Dec 21 23:30:56 oscar kernel:  printing eip:
Dec 21 23:30:56 oscar kernel: e0db9000
Dec 21 23:30:56 oscar kernel: Oops: 0000
Dec 21 23:30:56 oscar kernel: CPU:    0
Dec 21 23:30:56 oscar kernel: EIP:    0060:[<e0db9000>]    Not tainted
Dec 21 23:30:56 oscar kernel: EFLAGS: 00010296
Dec 21 23:30:56 oscar kernel: EIP is at 0xe0db9000
Dec 21 23:30:56 oscar kernel: eax: 00000000   ebx: c15d8800   ecx: 000000a4   edx: 07000203
Dec 21 23:30:56 oscar kernel: esi: 00000000   edi: c15d884c   ebp: c9fc3ee0   esp: c9fc3ec8
Dec 21 23:30:56 oscar kernel: ds: 0068   es: 0068   ss: 0068
Dec 21 23:30:56 oscar kernel: Process modprobe (pid: 2175, threadinfo=c9fc2000 task=d60e92a0)
Dec 21 23:30:56 oscar kernel: Stack: e0de9108 c15d8800 00000000 c15d884c 00000000 00000000 c9fc3ef0 e0de92f8
Dec 21 23:30:56 oscar kernel:        c15d8800 c15d8800 c9fc3f04 e0dd035a c15d8800 e0dcb4a8 a0dcb4a8 c9fc3f28
Dec 21 23:30:56 oscar kernel:        c019d252 c15d8800 e0dd046c c15d884c e0dcb4a8 ffffffed c15d8800 e0dcb480
Dec 21 23:30:56 oscar kernel: Call Trace:
Dec 21 23:30:56 oscar kernel:  [<e0de9108>] agp_backend_initialize+0x1c/0x168 [agpgart]
Dec 21 23:30:56 oscar kernel:  [<e0de92f8>] agp_register_driver+0x2c/0xac [agpgart]
Dec 21 23:30:56 oscar kernel:  [<e0dd035a>] agp_via_probe+0x62/0x6c [via_agp]
Dec 21 23:30:56 oscar kernel:  [<e0dcb4a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
Dec 21 23:30:56 oscar kernel:  [pci_device_probe+70/96] pci_device_probe+0x46/0x60
Dec 21 23:30:56 oscar kernel:  [<e0dd046c>] agp_via_pci_table+0x0/0x38 [via_agp]
Dec 21 23:30:56 oscar kernel:  [<e0dcb4a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
Dec 21 23:30:56 oscar kernel:  [<e0dcb480>] agp_via_pci_driver+0x0/0xa0 [via_agp]
Dec 21 23:30:56 oscar kernel:  [bus_match+56/108] bus_match+0x38/0x6c
Dec 21 23:30:56 oscar kernel:  [driver_attach+66/108] driver_attach+0x42/0x6c
Dec 21 23:30:56 oscar kernel:  [<e0dcb4a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
Dec 21 23:30:56 oscar kernel:  [<e0dcb4a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
Dec 21 23:30:56 oscar kernel:  [bus_add_driver+172/204] bus_add_driver+0xac/0xcc
Dec 21 23:30:56 oscar kernel:  [<e0dcb4a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
Dec 21 23:30:56 oscar kernel:  [<e0dcb4c8>] agp_via_pci_driver+0x48/0xa0 [via_agp]
Dec 21 23:30:56 oscar kernel:  [driver_register+54/56] driver_register+0x36/0x38
Dec 21 23:30:56 oscar kernel:  [<e0dcb4a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
Dec 21 23:30:56 oscar kernel:  [pci_register_driver+68/80] pci_register_driver+0x44/0x50
Dec 21 23:30:56 oscar kernel:  [<e0dcb4a8>] agp_via_pci_driver+0x28/0xa0 [via_agp]
Dec 21 23:30:56 oscar kernel:  [<e0dd0372>] agp_via_init+0xe/0x44 [via_agp]
Dec 21 23:30:56 oscar kernel:  [<e0dcb480>] agp_via_pci_driver+0x0/0xa0 [via_agp]
Dec 21 23:30:56 oscar kernel:  [sys_init_module+274/408] sys_init_module+0x112/0x198
Dec 21 23:30:56 oscar kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 21 23:30:56 oscar kernel:
Dec 21 23:30:56 oscar kernel: Code:  Bad EIP value.

when modprobing via_agp

Ed


