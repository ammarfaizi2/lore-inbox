Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbUKQKNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbUKQKNS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbUKQKNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:13:17 -0500
Received: from [203.88.135.194] ([203.88.135.194]:4003 "EHLO elitecore.com")
	by vger.kernel.org with ESMTP id S262247AbUKQKMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:12:48 -0500
From: "Sumit Pandya" <sumit@elitecore.com>
To: <linux-kernel@vger.kernel.org>, <len.brown@intel.com>
Subject: OOPS - APIC or othere?
Date: Wed, 17 Nov 2004 15:36:35 +0530
Message-ID: <HGEFKOBCHAIJDIEJLAKDGEMECAAA.sumit@elitecore.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
	At one of our client I faced timer problem in kernel-2.4.26 and I tried to
fixed with patching "arch/i386/kernel/mpparse.c" file taken from
patch-2.4.27.
...	...	...
Mikael Pettersson:
  o i386 and x86_64 ACPI mpparse timer bug
...	...	...
	After booting up the system now I get OOPS. Did I applied partial patch by
taking only patch for mpparse.c from the whole buntch? Does it broken
dependency to some other functionality? I've ACPI support enabled into
kernel.
	Does following Len's patch provide solution to my OOPS?
ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.4.26-rc4/200
40422153228-irq2.patch

Here is output of ksymsoops.

Unable to handle Kernel NULL pointer dereference at virtual address 00000001
c02c4d80
*pde = 00000000
Oops: 0000
CPU: 0
EIP:  0010:[<c02c4d80>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010293
eax: 00000000 ebx: 00000011 ecx: 00000000 edx: 00000000
esi: 00000000 edi: 00000000 ebp: c02bbf38 esp: c02bbf2c
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c02bb000)
Stack: C02bbf78 fffffffb c02bbf80 c02bbf9c c02c50de 00000000 00000000
00000000
       00001000 00000011 00000010 c02bbf78 00001000 00000000 00000246
00000001
       00000286 00000000 00000000 00000900 01000000 00000016 c02bbf98
c0117930
Call Trace:  [<c0117930>] [<c0105000>] [<c0117930>] [<c0105000>]
[<c0105000>]
Code: 0f b6 44 d1 01 3b 45 10 75 26 0f b6 44 d7 06 3a 86 01 dc 2d

>>EIP; c02c4d80 <find_irq_entry+30/70>   <=====
Trace; c0117930 <printk+100/110>
Trace; c0105000 <_stext+0/0>
Trace; c0117930 <printk+100/110>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Code;  c02c4d80 <find_irq_entry+30/70>
00000000 <_EIP>:
Code;  c02c4d80 <find_irq_entry+30/70>   <=====
   0:   0f b6 44 d1 01            movzbl 0x1(%ecx,%edx,8),%eax   <=====
Code;  c02c4d85 <find_irq_entry+35/70>
   5:   3b 45 10                  cmp    0x10(%ebp),%eax
Code;  c02c4d88 <find_irq_entry+38/70>
   8:   75 26                     jne    30 <_EIP+0x30> c02c4db0
<find_irq_entry+60/70>
Code;  c02c4d8a <find_irq_entry+3a/70>
   a:   0f b6 44 d7 06            movzbl 0x6(%edi,%edx,8),%eax
Code;  c02c4d8f <find_irq_entry+3f/70>
   f:   3a 86 01 dc 2d 00         cmp    0x2ddc01(%esi),%al

 <0>Kernel Panic: Attempted to kill the idle task!

I can see following messages before OOPS
Enabled ExtINT on CPU#0
ESR Value before enabling vector : 00000000
ESR Value after enabling vector : 00000000
ENABLING IO-APIC IRQs
... Here OOPS start ....

	One more point here is with same kernel source and its configuration and
SMP is enabled with 2  processors the kernel boots up. While it was giving
oops in uniprocessor.

  _____     __    __    ____   ____    __    ______
/\  ___\  /\  \ /\  \ /\  \ \/ /\  \ /\  \ /\__   _\
\ \ ____ \\ \  \\_|  \\ \  \_ /\ \  \\ \  \\__ \  \/
 \//\____ \\ \______ / \ \__\   \ \__\\ \__\  \ \__\
   \/_____/ \/_____ /   \/__/    \/__/ \/__/   \/__/

