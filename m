Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbULFIW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbULFIW0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 03:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbULFIW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 03:22:26 -0500
Received: from gsecone.com ([61.95.227.64]:24463 "EHLO gateway.gsecone.com")
	by vger.kernel.org with ESMTP id S261356AbULFIWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 03:22:20 -0500
Subject: [CRASH][2.6.10-rc2-mm4] kexec on bochs
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: bochs-developers@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Global Security One
Date: Mon, 06 Dec 2004 13:54:25 +0530
Message-Id: <1102321465.3768.30.camel@vinay.gsecone.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While trying kexectools-1.98 on bochs-2.1.1, the newly loaded kernel
panics soon after starting (its the same kernel used to boot bochs).
kexec with the same works fine on a P-III based system.

Can provide the .config if required.

BOCHS configuration
./configure --enable-cpu-level=6 --enable-pci --enable-ne2000
romimage: file=$BXSHARE/BIOS-bochs-latest, address=0xf0000

This is what I did:

# kexec -l /boot/bzImage --append="root=/dev/hda1"
# kexec -e



Below is a capture:

EFLAGS: 00010086   (2.6.10-rc2-mm4) @vpntest.gsecone.com) (gcc version 3.2.3 200
EIP is at __queue_work+0x34/0x60
eax: 00000000   ebx: c0405f20   ecx: c0405f24   edx: 00000003
esi: f000ff53   edi: 00000286   ebp: c044bf60   esp: c044bf28
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c044a000 task=c03bdb20)
Stack: c02627d0 00000000 00000000 c02627d0 c0129dae 00000000 c0405f20 00000100
       c0123331 00000000 c03c3a8c 00000013 c04894c0 c044a000 c044bf60 c044bf60
       0000007b 00000001 c04894c8 0000000a 004c6007 c011f555 c04894c8 00000046
Call Trace:
 [<c02627d0>] blank_screen_t+0x0/0x20
 [<c02627d0>] blank_screen_t+0x0/0x20
 [<c0129dae>] queue_work+0x2e/0x50
 [<c0123331>] run_timer_softirq+0xc1/0x200
 [<c011f555>] __do_softirq+0x85/0x90
 [<c011f587>] do_softirq+0x27/0x30
 [<c0104a6b>] do_IRQ+0x3b/0x70
 [<c010310e>] common_interrupt+0x1a/0x20
 [<c044c734>] start_kernel+0xc4/0x1a0
 [<c044c340>] unknown_bootoption+0x0/0x200
Code: 24 04 8b 5c 24 18 89 74 24 08 89 7c 24 0c 9c 5f fa 8d 50 08 8d 4b 04 89 43
 14 8b 72 04 89 53 04 89 4a 04 ba 03 00 00 00 89 71 04 <89> 0e b9 01 00 00 00 ff
 40 04 83 c0 10 c7 04 24 00 00 00 00 e8
 <0>Kernel panic - not syncing: Fatal exception in interrupt


Thanks
Vinay


