Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbTDWSim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbTDWSim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:38:42 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.46]:25306 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264215AbTDWSih convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:38:37 -0400
From: DevilKin-LKML <devilkin-lkml@blindguardian.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket initialisation
Date: Wed, 23 Apr 2003 20:50:39 +0200
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>, devilkin-lkml@blindguardian.org
References: <200304230747.27579.devilkin-lkml@blindguardian.org> <200304231454.18834.devilkin-lkml@blindguardian.org> <1051107787.4195.2.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1051107787.4195.2.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304232050.41230.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 23 April 2003 16:23, Felipe Alfaro Solana wrote:
> Could you please try again with this individual and newer PCMCIA patch
> at http://patches.arm.linux.org.uk/pcmcia-20030421.diff? If you prefer,
> you can also try with 2.5.68-mm2 which includes the mentioned patch.

Tried the patch against vanilla 2.5.68, gives me this oops:

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
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x84f 0x868-0x86f
cs: IO port probe 0x0100-0x04ff: excluding 0x280-0x287 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
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
eax: 00000000   ebx: cf2a8800   ecx: d10545c0   edx: 00000000
esi: cf2a884c   edi: ffffffed   ebp: c12d284c   esp: ce591e88
ds: 007b   es: 007b   ss: 0068
Process pcmcia/0 (pid: 388, threadinfo=ce590000 task=ce6f7300)
Stack: d109edc8 c01d1abf cf2a884c d109edc8 d109edf8 cf2a884c c02d7ff8 c01d1b5f 
       cf2a884c d109edc8 cf2a884c c02d7fa0 cf2a8888 c01d1d24 cf2a884c c0282ddf 
       c02de000 cf2a884c 00000000 cf2a8888 c01d0ef0 cf2a884c cf2a8800 cffd08b4 
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
 [<d116fdad>] cb_alloc+0xad/0xf0 [pcmcia_core]
 [<d115a17e>] pci_set_socket+0x3e/0x40 [yenta_socket]
 [<d115d140>] +0x0/0x5a0 [yenta_socket]
 [<d116c6d1>] state_wait_ready+0x151/0x260 [pcmcia_core]
 [<d116b9fa>] get_socket_status+0x1a/0x20 [pcmcia_core]
 [<d116cbae>] sm_do_work+0x5e/0x70 [pcmcia_core]
 [<c012867f>] worker_thread+0x1ff/0x2e0
 [<d116cb50>] sm_do_work+0x0/0x70 [pcmcia_core]
 [<c01168f0>] default_wake_function+0x0/0x20
 [<c01091c2>] ret_from_fork+0x6/0x14
 [<c01168f0>] default_wake_function+0x0/0x20
 [<c0128480>] worker_thread+0x0/0x2e0
 [<c01071dd>] kernel_thread_helper+0x5/0x18

Code: 8b 11 85 d2 74 7a 89 f6 83 fa ff 74 2b 0f b7 43 24 39 c2 74 
 
DK
- -- 
San Francisco isn't what it used to be, and it never was.
		-- Herb Caen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+puCBpuyeqyCEh60RAoj+AJ97jlGV25k0tMzJFx7SIhRmhVjyKgCeMBRr
1QyJMJciTYIcNm6odgu+CZk=
=HVXA
-----END PGP SIGNATURE-----

