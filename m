Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbULQR3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbULQR3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbULQR3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:29:19 -0500
Received: from tench.street-vision.com ([212.18.235.100]:52968 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S261878AbULQR3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:29:09 -0500
From: Justin Cormack <justin@street-vision.com>
Message-Id: <200412171723.iBHHNIc10417@tench.street-vision.com>
Subject: AHCI oops
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Date: Fri, 17 Dec 2004 17:23:18 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Have a new AHCI board to test and it oopses pretty quickly just with a few
reads simultaneously.

device is
00:1f.2 Class 0106: Intel Corp. 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 03)

/proc/interrupts
           CPU0       CPU1
  0:     551924     520177    IO-APIC-edge  timer
  1:          8          0    IO-APIC-edge  i8042
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:       3290        528    IO-APIC-edge  ide0
169:      14873          0   IO-APIC-level  eth0, uhci_hcd
177:         64         24   IO-APIC-level  uhci_hcd, libata
185:          0          0   IO-APIC-level  ehci_hcd, uhci_hcd
193:          0          0   IO-APIC-level  uhci_hcd
NMI:          0          0
LOC:    1071874    1071975
ERR:          0
MIS:          0

kernel 2.6.10-rc3

ata2: error occurred, port reset
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
f890a62b
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: sd_mod ahci libata scsi_mod autofs4 i2c_dev i2c_core sunrpc dCPU:    1
EIP:    0060:[<f890a62b>]    Not tainted VLI
EFLAGS: 00010202   (2.6.10-rc3)
EIP is at ata_to_sense_error+0x4c/0x3e0 [libata]
eax: 00000000   ebx: f39a6980   ecx: f380a250   edx: f39a6980
esi: 00000000   edi: f39a6a44   ebp: 00000000   esp: f7f23e94
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f7f22000 task=c18f8520)
Stack: 00000001 00000000 00004ae6 f39a6980 01000292 f39a6980 f380a70c f3cb0340
       f380a70c f890af1c f380a70c 00000001 f380a70c 00000001 f8909015 f380a70c
       00000001 40000001 f3cb0340 c011ddd8 f380a250 40000001 f8912601 f380a70c
Call Trace:
 [<f890af1c>] ata_scsi_qc_complete+0x3c/0x3e [libata]
 [<f8909015>] ata_qc_complete+0x34/0xae [libata]
 [<c011ddd8>] printk+0x17/0x1b
 [<f8912601>] ahci_interrupt+0x8e/0x16c [ahci]
 [<c013aa47>] handle_IRQ_event+0x39/0x6d
 [<c013ab4e>] __do_IRQ+0xd3/0x155
 [<c0105698>] do_IRQ+0x30/0x5a
 [<c0103df2>] common_interrupt+0x1a/0x20
 [<c010157e>] mwait_idle+0x25/0x4a
 [<c010154b>] cpu_idle+0x2e/0x3c
Code: c7 82 54 01 00 00 02 00 00 00 81 c7 c4 00 00 00 a8 01 0f 84 53 01 00 00 8
 <0>Kernel panic - not syncing: Fatal exception in interrupt

