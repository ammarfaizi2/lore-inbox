Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbULCQdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbULCQdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 11:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbULCQdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 11:33:54 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:20964 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262356AbULCQd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 11:33:27 -0500
From: "EC" <wingman@waika9.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: libata ICH5 2.4.28 kernel oops
Date: Fri, 3 Dec 2004 17:33:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <41B07E11.6030704@pobox.com>
Thread-Index: AcTZSK7+btfTWm9uRIS0Md4KyBATQgADL/cA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20041203163326.B7351173570@postfix3-1.free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> I'm getting trouble to upgrade from 2.4.27 to 2.4.28 since kernel oopses
>on
>> start. That seems to be related to libata and my SATA configuration. I'm
>> using a plain vanilla kernel (no patches).
>>
>> I have a Supermicro P4SCI with a PIV (SATA chipset ICH5), latest bios
>(1.1),
>> one disk (SATA), BIOS configured to SATA Only (but enhanced mode does the
>> same. Same kernel configuration used to work with 2.4.27 with the libata
>> patch. I'm not sure I'm supposed to apply the new 2.4.28 libata patch but
>> anyway with or without it kernel crashes about here :
>>
>> ...
>> SCSI subsystem driver Revision : 1.0...
>> ata1 : SATA max UDMA/133 : cmd 0x1F0 ctl 0x3F6 bmdam 0xF000 irq 14
>> ata1 : dev 0 ATA, max UDMA/133...
>> ata1 : dev 0 configured for UDMA/133
>> Unable to handle Kernel NULL pointer dereference....
>> ...
>
>Give us the oops.

ksymoops ... : 

c01ad09f
*pde = 00000000
Oops: 0000
CPU: 1
EIP: 0010:[<c01ad09f>] Not Tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000 ebx: c19e807c ecx: 00000000 edx: 00000002
esi: c19e8000 edi: c19e8220 ebp: c19e8220 esp: c19bbf18
ds: 0018 es: 0018 ss: 0018
Stack: c19e807c c19e807c c19e8000 f38c4880 c19e8220 00000000 c19e8220
00000000
       f38c4880 c01ad18c c19e8220 f38c4880 00000000 c19e8220 00000001
00000000
       0003e000 f38c4880 c19b2000 00000000 c01ad30c c19e8220 c02537a0
00000000
Call Trace: [<c01ad18c>] [<c01ad30c>] [<c01a15ca>] [<c01b1c78>] [<c01b1cf4>]
            [<c01b1ce6>] [<c01a1f26>] [<c01050a5>] [<c01070f0>]
Code: 8b 40 50 ff d0 83 c4 18 85 c0 74 0d 56 e8 0f 53 ff ff 31 c0


>>EIP; c01ad09f <ata_host_add+3b/5c>   <=====

Trace; c01ad18c <ata_device_add+cc/214>
Trace; c01ad30c <ata_scsi_detect+38/68>
Trace; c01a15ca <scsi_register_host+7e/2f4>
Trace; c01b1c78 <pci_announce_device+1c/50>
Trace; c01b1cf4 <pci_register_driver+48/60>
Trace; c01b1ce6 <pci_register_driver+3a/60>
Trace; c01a1f26 <scsi_register_module+2a/5c>
Trace; c01050a5 <init+29/144>
Trace; c01070f0 <arch_kernel_thread+28/38>

Code;  c01ad09f <ata_host_add+3b/5c>
00000000 <_EIP>:
Code;  c01ad09f <ata_host_add+3b/5c>   <=====
   0:   8b 40 50                  mov    0x50(%eax),%eax   <=====
Code;  c01ad0a2 <ata_host_add+3e/5c>
   3:   ff d0                     call   *%eax
Code;  c01ad0a4 <ata_host_add+40/5c>
   5:   83 c4 18                  add    $0x18,%esp
Code;  c01ad0a7 <ata_host_add+43/5c>
   8:   85 c0                     test   %eax,%eax
Code;  c01ad0a9 <ata_host_add+45/5c>
   a:   74 0d                     je     19 <_EIP+0x19>
Code;  c01ad0ab <ata_host_add+47/5c>
   c:   56                        push   %esi
Code;  c01ad0ac <ata_host_add+48/5c>
   d:   e8 0f 53 ff ff            call   ffff5321 <_EIP+0xffff5321>
Code;  c01ad0b1 <ata_host_add+4d/5c>
  12:   31 c0                     xor    %eax,%eax

