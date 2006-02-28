Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWB1MM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWB1MM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWB1MM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:12:59 -0500
Received: from khc.piap.pl ([195.187.100.11]:7940 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932516AbWB1MM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:12:58 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mathieu Chouquet-Stringer <ml2news@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: libata PATA patch for 2.6.16-rc5
References: <1141054370.3089.0.camel@localhost.localdomain>
	<m3k6bgk7oi.fsf@localhost.localdomain>
	<1141085952.3089.23.camel@localhost.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 28 Feb 2006 13:12:53 +0100
In-Reply-To: <1141085952.3089.23.camel@localhost.localdomain> (Alan Cox's
 message of "Tue, 28 Feb 2006 00:19:12 +0000")
Message-ID: <m33bi3of5m.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On the whole I'd like to see the core and most of the drivers pushed to
> 2.6.17 as experimental and merged with the main tree. The DMA CRC
> changedown work is important before it leaves "experimental" status.

That would be nice.

BTW: with rc5 and patch-2.6.16-rc5-ide1.gz I get MWDMA2 (VIA EPIA-M,
I've sent you details with rc2-ide2 report):

ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xE000 irq 14
via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
ata1: dev 0 cfg 49:0b00 82:0210 83:4000 84:4000 85:0000 86:0000 87:4000 88:0407
ata1: dev 0 ATAPI, max UDMA/33
via_do_set_mode: Mode=8 ast broken=Y udma=133 mul=4
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
via_do_set_mode: Mode=34 ast broken=Y udma=133 mul=4
ata1: dev 0 configured for MWDMA2
scsi0 : pata_via
  Vendor: LITE-ON   Model: DVD SOHD-16P9SV   Rev: F$01
  Type:   CD-ROM                             ANSI SCSI revision: 05


instead of UDMA/33 with patch-2.6.16-rc2-ide2.gz which does:
via_do_set_mode: Mode=12 ast broken=Y udma=133 mul=4
via_do_set_mode: Mode=66 ast broken=Y udma=133 mul=4
ata1: dev 0 configured for UDMA/33


"rmmod sr_mod" assertion warning is gone.

"rmmod pata_via" and then "modprobe pata_via" is still there:

ata3: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xE000 irq 14
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01d0121
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: pata_via cdrom libata scsi_mod lirc_serial lirc_dev via_agp agpgart via_rhine
CPU:    0
EIP:    0060:[<c01d0121>]    Not tainted VLI
EFLAGS: 00010206   (2.6.16-rc5-term-via #29) 
EIP is at make_class_name+0x31/0xb0
eax: 00000000   ebx: ffffffff   ecx: ffffffff   edx: 00000000
esi: 00000009   edi: 00000000   ebp: 00000000   esp: c6f83ca8
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 382, threadinfo=c6f83000 task=c6165a30)
Stack: <0>00000044 c618f1f0 000200d0 c02a8680 00000010 c10a9fa0 c6f83000 c7926204 
       c618f1f0 c7926204 c792620c c01d0226 c79261a0 00000000 00000246 c618f1f0 
       c618f000 c618f028 c618f280 c01d02e8 c618f0d0 c790edcd c618f280 00000000 
Call Trace:
 [<c01d0226>] class_device_del+0x86/0x140
 [<c01d02e8>] class_device_unregister+0x8/0x10
 [<c790edcd>] scsi_remove_host+0x7d/0xc0 [scsi_mod]
 [<c78fb99e>] ata_host_remove+0xe/0x20 [libata]
 [<c78ff40d>] ata_device_add+0x2fd/0xb80 [libata]
 [<c021a02f>] pci_read+0x1f/0x30
 [<c02188f9>] pcibios_set_master+0x19/0xa0
 [<c78fffe4>] ata_pci_init_one+0x354/0x390 [libata]
 [<c01cf860>] __driver_attach+0x0/0x60
 [<c01cf860>] __driver_attach+0x0/0x60
 [<c78ef688>] via_init_one+0x138/0x2a0 [pata_via]
 [<c018995b>] pci_device_probe+0x4b/0x70
 [<c01cf778>] driver_probe_device+0x38/0xb0
 [<c01cf8ba>] __driver_attach+0x5a/0x60
 [<c01ceda8>] bus_for_each_dev+0x38/0x70
 [<c01cf651>] driver_attach+0x11/0x20
 [<c01cf860>] __driver_attach+0x0/0x60
 [<c01cf0da>] bus_add_driver+0x6a/0x130
 [<c01cfbd0>] klist_devices_get+0x0/0x10
 [<c018953e>] __pci_register_driver+0x4e/0x90
 [<c01292df>] sys_init_module+0x12f/0x1690
 [<c0138e0e>] __handle_mm_fault+0x3ce/0x570
 [<c010e2c0>] do_page_fault+0x210/0x5fa
 [<c0102889>] syscall_call+0x7/0xb
Code: 1c 89 44 24 04 8b 40 3c 8b 10 31 ed bb ff ff ff ff 89 d9 89 d7 89 e8 f2 ae f7 d1 49 89 ce 8b 44 24 04 8b 50 08 89 d9 89 d7 89 e8 <f2> ae f7 d1 49 8d 44 0e 02 ba d0 00 00 00 e8 cc f5 f6 ff 89 04

Of course additional details are available on request.

Thanks,
-- 
Krzysztof Halasa
