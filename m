Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbUCMJ50 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 04:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbUCMJ50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 04:57:26 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:62436 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S263074AbUCMJ5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 04:57:00 -0500
Date: Sat, 13 Mar 2004 10:54:29 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>, <linux-atm-general@lists.sourceforge.net>
Subject: NICSTAR_USE_SUNI broken in 2.6.3+
Message-ID: <Pine.LNX.4.30.0403131045040.3568-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a bunch of machines with Forerunner LE ATM NICs.
Starting with kernel version 2.6.3 the kernel crashes at
boot time (see dump below) when CONFIG_ATM_NICSTAR_USE_SUNI
is set.

Regards,
               Peter Daum

 - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8< - - - - -

Unable to handle kernel NULL pointer dereference at virtual address 00000028
c0252650
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0252650>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: f7ce0000   ecx: f7ff6c00   edx: fffffff4
esi: f7d75b80   edi: c033f0f6   ebp: 00000000   esp: c18ffed0
ds: 007b   es: 007b   ss: 0068
Stack: f7fff1f8 000000d0 c0251b28 f7d75b80 f7ce0000 f7d75ba2 c033f0f6 c025261b
       c04083d3 f7d75b80 00000000 00000000 00000020 00000048 0000000e 000000c2
       000000c8 f7d59b80 f7d75ba0 c18fe000 c18fe000 00000000 00000000 6001c925
Call Trace:
 [<c0251b28>] suni_init+0xe0/0xef
 [<c025261b>] suni_start+0x0/0x17d
 [<c04083d3>] nicstar_init_one+0xdac/0xe95
 [<c01f83fe>] pci_device_probe+0x94/0xa3
 [<c0219f41>] bus_match+0x3b/0x76
 [<c021a133>] driver_attach+0x4f/0x8c
 [<c01ed414>] kobject_register+0x28/0x65
 [<c021a1fc>] bus_add_driver+0x8c/0xb3
 [<c01f845a>] pci_register_driver+0x37/0x47
 [<c04075b8>] nicstar_init+0x10/0x7f
 [<c01051c6>] init+0x13b/0x2f5
 [<c010508b>] init+0x0/0x2f5
 [<c01066a5>] kernel_thread_helper+0x5/0xb
Code: 89 70 28 9c 5b fa ba 00 e0 ff ff 21 e2 83 42 14 01 f0 fe 0d


>>EIP; c0252650 <suni_start+35/17d>   <=====

>>ebx; f7ce0000 <__crc_dcache_lock+ad35f/4f2e84>
>>ecx; f7ff6c00 <__crc_dcache_lock+3c3f5f/4f2e84>
>>edx; fffffff4 <TSS_ESP0_OFFSET+1f0/????>
>>esi; f7d75b80 <__crc_dcache_lock+142edf/4f2e84>
>>edi; c033f0f6 <SkGeRxRegs+76/7c>
>>esp; c18ffed0 <__crc___ide_dma_off_quietly+23d789/268d11>

Trace; c0251b28 <suni_init+e0/ef>
Trace; c025261b <suni_start+0/17d>
Trace; c04083d3 <nicstar_init_one+dac/e95>
Trace; c01f83fe <pci_device_probe+94/a3>
Trace; c0219f41 <bus_match+3b/76>
Trace; c021a133 <driver_attach+4f/8c>
Trace; c01ed414 <kobject_register+28/65>
Trace; c021a1fc <bus_add_driver+8c/b3>
Trace; c01f845a <pci_register_driver+37/47>
Trace; c04075b8 <nicstar_init+10/7f>
Trace; c01051c6 <init+13b/2f5>
Trace; c010508b <init+0/2f5>
Trace; c01066a5 <kernel_thread_helper+5/b>

Code;  c0252650 <suni_start+35/17d>
00000000 <_EIP>:
Code;  c0252650 <suni_start+35/17d>   <=====
   0:   89 70 28                  mov    %esi,0x28(%eax)   <=====
Code;  c0252653 <suni_start+38/17d>
   3:   9c                        pushf
Code;  c0252654 <suni_start+39/17d>
   4:   5b                        pop    %ebx
Code;  c0252655 <suni_start+3a/17d>
   5:   fa                        cli
Code;  c0252656 <suni_start+3b/17d>
   6:   ba 00 e0 ff ff            mov    $0xffffe000,%edx
Code;  c025265b <suni_start+40/17d>
   b:   21 e2                     and    %esp,%edx
Code;  c025265d <suni_start+42/17d>
   d:   83 42 14 01               addl   $0x1,0x14(%edx)
Code;  c0252661 <suni_start+46/17d>
  11:   f0 fe 0d 00 00 00 00      lock decb 0x0

 <0>Kernel panic: Attempted to kill init!

