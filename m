Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTLLWRS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbTLLWRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:17:18 -0500
Received: from relay.inway.cz ([212.24.128.3]:58770 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S261967AbTLLWRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:17:02 -0500
Message-ID: <3FDA3E50.2010602@scssoft.com>
Date: Fri, 12 Dec 2003 23:16:48 +0100
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.0-t11-bk8 GPF
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am getting crashes on 2.6.0-test11-bk8, started to happen after a 
memory uprade to 2GB (from 1GB)
and turning on the HIGHMEM (4GB) support.

The server is UP AMD Opteron(tm) Processor 244, board is MSI KT800 (VIA 
chipset),
SATA 250GB drive.

I was doing a little stress-test over samba trying to use as io cache as 
possible.
(copied several 1GB files from the server)

the server does not run any fancy applications, just non-loaded www, 
imap, smtp, ftp...

I am not sure what relevant information should I provide, I'd be happy 
to help to track this
down, of course - if it is not hardware related :-(

general protection fault: 0000 [#1]
CPU:    0
EIP:    0060:[<c0145ed8>]    Not tainted
EFLAGS: 00010286
EIP is at page_referenced+0x58/0xa0
eax: ed941140   ebx: ed941140   ecx: 0000000e   edx: ffffffff
esi: 00000001   edi: 00000000   ebp: c2399fa8   esp: f7dcbdf0
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 7, threadinfo=f7dca000 task=f7dcf2e0)
Stack: c1e96a60 c2399fc0 c2399fa8 c239aae8 c03338c8 c013e938 c1e96970 
c03338d8
       c1e96920 00000000 00000000 00000000 c239a3f8 c239af88 f7dcbe28 
f7dcbe28
       c239ab00 c239c388 c1e96858 c03338e0 c013e470 f7dcbe64 000000d0 
f7dcbedc
Call Trace:
 [<c013e938>] refill_inactive_zone+0x3a8/0x410
 [<c013e470>] shrink_cache+0x160/0x280
 [<c013ea1c>] shrink_zone+0x7c/0xb0
 [<c013edfb>] balance_pgdat+0x17b/0x200
 [<c013ef97>] kswapd+0x117/0x130
 [<c011d6c0>] autoremove_wake_function+0x0/0x50
 [<c011d6c0>] autoremove_wake_function+0x0/0x50
 [<c013ee80>] kswapd+0x0/0x130
 [<c0107289>] kernel_thread_helper+0x5/0xc

Code: 0f ba 32 05 19 c0 85 c0 8d 56 01 0f 45 f2 47 49 79 e6 8b 03

Linux a.b.c 2.6.0-test11-bk8 #1 Fri Dec 12 22:22:22 CET 2003 i686 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre4
e2fsprogs              1.35-WIP
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91

  Vendor: ATA       Model: WDC WD2500JD-00F  Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05

hmm.. interesting (but maybe unrelated stuff) in the dmesg is:
_CRS returns NULL! Using IRQ 21 for device (PCI Interrupt Link [ALKB]).
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
Pin 2-21 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
_CRS returns NULL! Using IRQ 20 for device (PCI Interrupt Link [ALKA]).
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:00:11[A] -> 2-20 -> IRQ 20
Pin 2-21 already programmed
_CRS returns NULL! Using IRQ 22 for device (PCI Interrupt Link [ALKC]).
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
_CRS returns NULL! Using IRQ 23 for device (PCI Interrupt Link [ALKD]).
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
00:00:11[D] -> 2-23 -> IRQ 23

