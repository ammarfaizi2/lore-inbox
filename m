Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271073AbTGPLdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 07:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271072AbTGPLcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 07:32:48 -0400
Received: from tazz.wtf.dk ([80.199.6.58]:21121 "EHLO sokrates")
	by vger.kernel.org with ESMTP id S271066AbTGPLbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 07:31:47 -0400
Date: Wed, 16 Jul 2003 13:47:11 +0200
From: Michael Kristensen <michael@wtf.dk>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: OOPS in the emu10k1 module
Message-ID: <20030716114711.GA4820@sokrates>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I booted my fresh-compiled 2.6.0-test1, and found out, that the sound
didn't work. Later, I found out that there was an oops in /var/log/dmesg.

$ cat /proc/modules | grep emu10k1
emu10k1 66944 1 - Loading 0xe0894000
ac97_codec 17792 1 emu10k1, Live 0xe0869000

$ uname -a
Linux sokrates 2.6.0-test1 #1 Wed Jul 16 10:35:17 CEST 2003 i686 GNU/Linux

If it should matter, it is a Debian system, and I do have the module-init-tools for 2.5.x and 2.6.x.

Bottom of /var/log/dmesg:

Creative EMU10K1 PCI Audio Driver, version 0.20, 10:36:10 Jul 16 2003
emu10k1: EMU10K1 rev 7 model 0x8064 found, IO at 0xd400-0xd41f, IRQ 12
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
emu10k1: SBLive! 5.1 card detected
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
e089be06
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<e089be06>]    Not tainted
EFLAGS: 00010202
EIP is at emu10k1_probe+0x236/0x3c0 [emu10k1]
eax: 00000000   ebx: dfe89854   ecx: 81240001   edx: 007051f1
esi: 00000000   edi: dff90000   ebp: e08a4220   esp: dfa4bee0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 75, threadinfo=dfa4a000 task=dfbc1980)
Stack: dff90000 ffffffed dfe89800 e08a4280 e08a42a8 dff90000 80641102 c01a85dc
       dfe89800 e08a4224 dfe89800 e08a4280 dfe89854 c01a870f e08a4280 dfe89800
       e08a4280 dfe89800 c01a874f e08a4280 dfe89800 dfe89800 ffffffed e08a42a8
Call Trace:
 [<c01a85dc>] pci_device_probe_static+0x2c/0x50
 [<c01a870f>] __pci_device_probe+0x1f/0x40
 [<c01a874f>] pci_device_probe+0x1f/0x40
 [<c01ccff7>] bus_match+0x37/0x70
 [<c01cd0f3>] driver_attach+0x43/0x60
 [<c01cd34b>] bus_add_driver+0x6b/0x90
 [<c01cd724>] driver_register+0x34/0x40
 [<c01a89c8>] pci_register_driver+0x68/0x90
 [<e083c018>] emu10k1_init_module+0x18/0x40 [emu10k1]
 [<c012b2f4>] sys_init_module+0xf4/0x200
 [<c0108c5f>] syscall_call+0x7/0xb

Code: 00 00 c7 87 dc 40 00 00 01 00 00 00 c7 87 e0 40 00 00 00 00
.

I know that this is a oops - a kernel error - so I'm posting it here. Please tell me, if you need additional info about my system.

-- 
Med Venlig Hilsen/Best Regards/Mit freundlichen Grüßen
Michael Kristensen <michael@wtf.dk>
