Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264016AbTDWMlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 08:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264017AbTDWMlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 08:41:51 -0400
Received: from [195.95.38.160] ([195.95.38.160]:21746 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S264016AbTDWMls convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 08:41:48 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket initialisation
Date: Wed, 23 Apr 2003 14:54:06 +0200
User-Agent: KMail/1.5.1
Cc: LKML <linux-kernel@vger.kernel.org>, devilkin-lkml@blindguardian.org
References: <200304230747.27579.devilkin-lkml@blindguardian.org> <1051096374.653.9.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1051096374.653.9.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304231454.18834.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 23 April 2003 13:12, Felipe Alfaro Solana wrote:
> Download and apply the following:
>
> http://patches.arm.linux.org.uk/pcmcia/pcmcia-1.diff
>
> Also, the -mm kernel series starting with 2.5.67-mm4 do include this
> patch. You can download -mm patches from
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5

This results in the following oops:

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
PCI: Sharing IRQ 11 with 00:07.2
Yenta IRQ list 0698, PCI irq11
Socket status: 30000020
PCI: Found IRQ 11 for device 00:03.1
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:07.2
Yenta IRQ list 0698, PCI irq11
Socket status: 30000010
cs: sock ce519800 old smfunc d116d1a0 mask 0x0000004a pending 0x00000002 
sockstate 0x00000000 status 0x00001880 delivering 0x00000002
cs: sock ce519800 new smfunc d116d280 mask 0x00000001 pending 0x00000002 
sockstate 0x00000010
cs: sock ce519800 old smfunc d116d280 mask 0x00000001 pending 0x00000003 
sockstate 0x00000010 status 0x00001880 delivering 0x00000001
cs: sock ce519800 new smfunc d116d480 mask 0x00000001 pending 0x00000002 
sockstate 0x00008018
cs: sock ce519000 old smfunc d116d1a0 mask 0x0000004a pending 0x00000002 
sockstate 0x00000000 status 0x000000b0 delivering 0x00000002
cs: sock ce519000 new smfunc d116d280 mask 0x00000001 pending 0x00000002 
sockstate 0x00000010
cs: sock ce519000 old smfunc d116d280 mask 0x00000001 pending 0x00000003 
sockstate 0x00000010 status 0x000000b0 delivering 0x00000001
cs: sock ce519000 new smfunc d116d480 mask 0x00000001 pending 0x00000002 
sockstate 0x00000018
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x84f 0x868-0x86f
cs: IO port probe 0x0100-0x04ff: excluding 0x280-0x287 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: sock ce519800 old smfunc d116d480 mask 0x00000001 pending 0x00000023 
sockstate 0x00008018 status 0x000019c0 delivering 0x00000001
cs: sock ce519800 new smfunc d116d580 mask 0x00000001 pending 0x00000022 
sockstate 0x00008018
cs: sock ce519800 old smfunc d116d580 mask 0x00000001 pending 0x00000023 
sockstate 0x00008018 status 0x000019c0 delivering 0x00000001
Unable to handle kernel paging request at virtual address d10545c0
 printing eip:
c01b0368
*pde = 0fb66067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01b0368>]    Not tainted
EFLAGS: 00010286
EIP is at pci_bus_match+0x18/0xb0
eax: 00000000   ebx: cef4dc00   ecx: d10545c0   edx: 00000000
esi: cef4dc4c   edi: ffffffed   ebp: c12d284c   esp: ce479e74
ds: 007b   es: 007b   ss: 0068
Process pcmcia/0 (pid: 2203, threadinfo=ce478000 task=ce4df300)
Stack: d109edc8 c01d1abf cef4dc4c d109edc8 d109edf8 cef4dc4c c02d7ff8 c01d1b5f 
       cef4dc4c d109edc8 cef4dc4c c02d7fa0 cef4dc88 c01d1d24 cef4dc4c c0282ddf 
       c02de000 cef4dc4c 00000000 cef4dc88 c01d0ef0 cef4dc4c cef4dc00 cffd08b4 
Call Trace:
 [<d109edc8>] m3_pci_driver+0x28/0xa0 [maestro3]
 [<c01d1abf>] bus_match+0x2f/0x80
 [<d109edc8>] m3_pci_driver+0x28/0xa0 [maestro3]
 [<d109edf8>] m3_pci_driver+0x58/0xa0 [maestro3]
 [<c01d1b5f>] device_attach+0x4f/0x90
 [<d109edc8>] m3_pci_driver+0x28/0xa0 [maestro3]
 [<c01d1d24>] bus_add_device+0x64/0xb0
 [<c01d0ef0>] device_add+0xd0/0x110
 [<c01aca6b>] pci_bus_add_devices+0x4b/0xb0
 [<d1170e2d>] cb_alloc+0xad/0xf0 [pcmcia_core]
 [<c011a608>] printk+0x118/0x180
 [<d116d6d1>] state_wait_ready+0x151/0x260 [pcmcia_core]
 [<d116dbf1>] sm_do_work+0xa1/0xf0 [pcmcia_core]
 [<c012867f>] worker_thread+0x1ff/0x2e0
 [<d116db50>] sm_do_work+0x0/0xf0 [pcmcia_core]
 [<c01168f0>] default_wake_function+0x0/0x20
 [<c01091c2>] ret_from_fork+0x6/0x14
 [<c01168f0>] default_wake_function+0x0/0x20
 [<c0128480>] worker_thread+0x0/0x2e0
 [<c01071dd>] kernel_thread_helper+0x5/0x18

Code: 8b 11 85 d2 74 7a 89 f6 83 fa ff 74 2b 0f b7 43 24 39 c2 74 
 
DK
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+poz3puyeqyCEh60RAmgoAJ40zorNV1oRGbmy6hngz6LE29T/sACfbiro
+tUYPVecqFk8PBWN6njOBDI=
=ubew
-----END PGP SIGNATURE-----

