Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbULKVAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbULKVAF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 16:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbULKVAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 16:00:05 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:50666 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262013AbULKU76
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 15:59:58 -0500
From: "EC" <wingman@waika9.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>, "'EC'" <wingman@waika9.com>
Cc: "'Alan J. Wylie'" <alan@wylie.me.uk>, <linux-kernel@vger.kernel.org>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Subject: RE: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
Date: Sat, 11 Dec 2004 21:59:57 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <41BB5A78.1040008@pobox.com>
Thread-Index: AcTfwV3iNg8/pyRQSLGWEOqpA0fkugAAnU2A
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20041211205957.203D2173503@postfix3-1.free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>Objet : Re: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA
>controller
>>>
>>>Alan J. Wylie wrote:
>>>
>>>>Code;  c01ccd07 <ata_host_add+57/80>
>>>>00000000 <_EIP>:
>>>>Code;  c01ccd07 <ata_host_add+57/80>   <=====
>>>>   0:   ff 50 50                  call   *0x50(%eax)   <=====
>>>>Code;  c01ccd0a <ata_host_add+5a/80>
>>>>   3:   89 da                     mov    %ebx,%edx
>>>>Code;  c01ccd0c <ata_host_add+5c/80>
>>>>   5:   85 c0                     test   %eax,%eax
>>>>Code;  c01ccd0e <ata_host_add+5e/80>
>>>>   7:   75 12                     jne    1b <_EIP+0x1b>
>>>>Code;  c01ccd10 <ata_host_add+60/80>
>>>>   9:   8b 5c 24 14               mov    0x14(%esp),%ebx
>>>>Code;  c01ccd14 <ata_host_add+64/80>
>>>>   d:   89 d0                     mov    %edx,%eax
>>>>Code;  c01ccd16 <ata_host_add+66/80>
>>>>   f:   8b 74 24 18               mov    0x18(%esp),%esi
>>>>Code;  c01ccd1a <ata_host_add+6a/80>
>>>>  13:   8b 00                     mov    (%eax),%eax
>>>
>>>If you are getting an oops there, it looks like your ata_piix driver is
>>>mismatched from the libata core.  Did you compile them both at the same
>>>time, from the same source kernel?
>>>
>>>The assembly code above is where function ata_host_add in libata-core.c
>>>calls "ap->ops->port_start", which definitely exists in ata_piix.c.
>>>
>>>	Jeff
>>
>>
>> After some more testing I made my system work again.
>> With 2.4.27 kernel + patch : SATA Only works fine in BIOS.
>> With 2.4.28 kerenl, no patch : *Must* put enhanced mode (SATA Only makes
>> oops).
>
>Can you provide oops output decoded with ksymoops?
>

As given on the first mail of this thread  :

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

EC.

