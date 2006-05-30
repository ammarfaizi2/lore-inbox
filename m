Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWE3Nyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWE3Nyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWE3Nyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:54:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:11218 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751505AbWE3Nyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:54:43 -0400
Message-ID: <447C4E93.9050704@i12.com>
Date: Tue, 30 May 2006 15:54:27 +0200
From: Sascha Warner <_@i12.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc5-mm1 promise_sata bugs
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:80ab310fced15248f8e2da3e2d36cb52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently compiled 2.6.17-rc5-mm1 and it BUGs me while initializing my 
promise TX2 Plus SATA Controller. Here is the message (handwritten, but 
double-checked):

ata1.00: configured for UDMA/133
scsi0 : sata_promise
ata2: SATA link down (SStatus 0 SControl 300)
scsi1: sata_promise
BUG: unable to handle kernel NULL pointer dereference at virtual address 
00000008
printing eip:
c02574c3
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c02574c3>]    Not tainted VLI
EFLAGS:    00010202    (2.6.17-rc5-mm1 #1)
EIP is at pdc_sata_scr_write+0x10/0x14
eax: 00000008    ebx: dfe9429c    ecx: 00000300    edx: 00000002
esi: dfe9429c    edi: 00000300    ebp: 00000002    exp: dffc3e44
ds:  007b   es: 007b   ss: 0068
Process idle (pid: 1, threadinfo=dffc3000 task=dffc2a90)
Stack:  c02ccce0 c024bf4b dfe9429c dfe90c78 fffb82d1 dfe9429c c024dbb5 
c0243c5e
    co2e7294 c3000000 c01ea5e3 c0256fd1 dfe9429c dfe90c78 00000002 c024dcbc
    dfe90834 c02503ee dfe8c408 c1491880 00000053 c02e80e2 e0802300 e0802338
Call Trace:
<c024bf4b> sata_scr_write_flush+0x24/0x37 <c024dbb5> 
__sata_phy_reset+0x2e/0x12d
<c0243c5e> scsi_add_host+0xc0/0x192     <c01ea5e3> __delay+0x6/0x7
<c0256fd1> pdc_reset_port+0x1f/0x34    <c024dcbc> sata_phy_reset+0x8/0x18
<c02503ee> ata_device_add+0x580/0x6b1    <c0257991> 
pdc_ata_init_one+0x2a9/0x3c8
<c01f544b> pci_device_probe+0x40/0x5b    <co23ee1b> 
driver-probe_device+0x3b/0xaa       
<c023ef40> __driver_attach+0x5a/0x5c    <c023e8dd> 
bus_for_each_dev+0x3a/0x58
c023ed8a> driver_attach+0x16/0x1a    <<c023eee6> __driver_attach+0x0/0x5c
<c023e5ac> bus_add_driver+0x6f/0x11f    <c01f55a2> 
__pci_register_driver+0x34/0x4f
<c010028c> _stext+0x6c/0x225        <c02be01e> __kprobes_text_start+0x6/0x14
<c0100220> _stext+0x0/0x225        <c0100220> stext+0x0/0x225
<c0101005> kernel_thread_helper+0x5/0xb
Code: 02 77 0a 8d 04 12 01 c0 03 41 60 8b 00 c3 8b 80 78 1f 00 00 8b 40 
08 8b 40 40 c3 53 fa 02 77 0a 8d
04 12 01 c0 03 43 60 <89> 08 5b c3 55 57 56 53 83 ec 10 89 c6 9c 5d fa 
b8 00 f0 ff ff
EIP: [<c02574c3>] pdc_sata_scr_write+0x10/0x14 SS:ESP 0068:dffc3e44
<0>Kernel panic - not syncing: Attempted to kill init!


This happened some mm kernels before (since libata update I guess)

Just ask for any information you might need.
Is there anything you want me to test?


kind regards
prx
