Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274820AbTHKTah (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274723AbTHKT3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:29:24 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:65228 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S274813AbTHKT2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:28:55 -0400
Message-ID: <F341E03C8ED6D311805E00902761278C0C35E6DF@xfc04.fc.hp.com>
From: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik.habbinga@hp.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.6.0-test3 and cciss driver (or blk_queue_hardsect_size)
Date: Mon, 11 Aug 2003 15:28:51 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm wondering if anyone else is having problems with 2.6.0-test3 and the
cciss driver, or with the function blk_queue_hardsect_size.  I was able to
successfully boot 2.6.0-test2 in previous weeks, but trying 2.6.0-test3
today gave me:

Compaq CISS Driver (v 2.5.0)
cciss: using DAC cycles
      blocks= 35553120 block_size= 512
      heads= 255, sectors= 32, cylinders= 4357

Unable to handle kernel NULL pointer dereference at virtual address 0000018e
 printing eip:
c0280f88
*pde = 00104001
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0280f88>]    Not tainted
EFLAGS: 00010206
EIP is at blk_queue_hardsect_size+0x8/0x10
eax: 00000000   ebx: f7c92380   ecx: 00000000   edx: 00000200
esi: c27a144c   edi: 00000000   ebp: 00000000   esp: c254fee0
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c254e000 task=c254d900)
Stack: c047e98b 00000000 00000200 00000000 00000000 c27a1400 00000000
00000000
       00000068 c03fc620 ffffffed c2588000 c03fc648 c02446dc c2588000
c0385bfc
       c2588000 c03fc620 ffffffed c02447fb c03fc620 c2588000 c03fc620
c2588000
Call Trace:
 [<c047e98b>] cciss_init_one+0x4f1/0x548
 [<c02446dc>] pci_device_probe_static+0x52/0x64
 [<c02447fb>] __pci_device_probe+0x3b/0x4e
 [<c024483d>] pci_device_probe+0x2f/0x4e
 [<c027edab>] bus_match+0x45/0x74
 [<c027eeb3>] driver_attach+0x59/0x5e
 [<c027f134>] bus_add_driver+0x94/0xa8
 [<c0244adf>] pci_register_driver+0x7f/0x9e
 [<c047e9fd>] cciss_init+0x1b/0x20
 [<c046884e>] do_initcalls+0x28/0x94
 [<c012c70f>] init_workqueues+0xf/0x26
 [<c01050a8>] init+0x4c/0x1a8
 [<c010505c>] init+0x0/0x1a8
 [<c010703d>] kernel_thread_helper+0x5/0xc

Code: 66 89 90 8e 01 00 00 c3 83 ec 10 89 5c 24 0c 8b 5c 24 18 81
 <0>Kernel panic: Attempted to kill init!

I haven't seen any traffic today on LKML about problems with cciss or
blk_queue_hardsect_size.  I'll start debugging myself, but if this looks
obvious to someone, let me know.

The system in question is a 4 CPU XEON 1.9 GHz machine w/ 2 GB ram.  Two
drives are attached to the cciss as a mirrored pair (RAID 1).

Thanks,
Erik Habbinga
Hewlett Packard
