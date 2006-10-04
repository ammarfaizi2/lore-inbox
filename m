Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161234AbWJDPTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161234AbWJDPTa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161232AbWJDPTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:19:30 -0400
Received: from mail.learningfocused.com ([66.129.119.245]:37784 "EHLO
	www.learningfocused.com") by vger.kernel.org with ESMTP
	id S1161234AbWJDPT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:19:28 -0400
Message-Id: <200610041519.k94FJ9pE003905@www.learningfocused.com>
From: "Tim Havens" <tim@learningfocused.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.17 Panic
Date: Wed, 4 Oct 2006 11:18:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AcbnyF30Kf3KZ/bTQbm+PzN9locklA==
X-mail.learningfocused.com-MailScanner-Information: Please contact the ISP for more information
X-mail.learningfocused.com-MailScanner: Found to be clean
X-MailScanner-From: tim@learningfocused.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any pointers would be most helpful!

I've never had to trace down a kernel panic before please forgive me if I
don't provide enough initial info... we've had these same type panics using
kernel: 2.6.15-1.2054_FC5 also...
 
I tried to use ksymoops like this: ./ksymoops -o
/lib/modules/2.6.17-1.2187_FC5 -m /boot/System.map-2.6.17-1.2187_FC5 -l
/tmp/proc-modules-copy -k /proc/kallsyms < panic.txt
 
RESULTED IN... (but I probably did it wrong)

ksymoops 2.4.11 on x86_64 2.6.17-1.2187_FC5.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /tmp/proc-modules-copy (specified)
     -o /lib/modules/2.6.17-1.2187_FC5 (specified)
     -m /boot/System.map-2.6.17-1.2187_FC5 (specified)
 
Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid
ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace: <IRQ> <ffffffff8804aa78> {:aacraid:acc_rkt_intr+55}
<ffffffff80210809> {handle_IRQ_event+41} <ffffffff802b2c73> {__do_IRQ+154}
<ffffffff802713c6> {do_IRQ+60} <ffffffff80262eea> {ret_from_intr+0} <EOI>
Code: 0f 0b 68 64 c3 04 88 c2 b4 00 48 8b 85 80 00 00 00 48 8b 50
Using defaults from ksymoops -t elf64-x86-64 -a i386:x86-64
 

Code;  0000000000000000 Before first symbol
0000000000000000 <_RIP>:
Code;  0000000000000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  0000000000000002 Before first symbol
   2:   68 64 c3 04 88            pushq  $0xffffffff8804c364
Code;  0000000000000007 Before first symbol
   7:   c2 b4 00                  retq   $0xb4
Code;  000000000000000a Before first symbol
   a:   48 8b 85 80 00 00 00      mov    0x80(%rbp),%rax
Code;  0000000000000011 Before first symbol
  11:   48 8b 50 00               mov    0x0(%rax),%rdx
 
Call Trace: <IRQ. <ffffffff8028fcd2> {panic+483} <ffffffff802408ad>
{lock_timer_base+27} <ffffffff8021d333> {__mod_timer+176} <ffffffff803478b9>
{vgacon_blank+428} <ffffffff80269d8e> {spin_lock_irqsave+9}
<ffffffff803471e9> {vgacon_set_cursor_size+54} <ffffffff8026a43e>
{oops_end+81} <ffffffff80270715> {die+58} <ffffffff80270cbc>
{do_invalid_op+173} <ffffffff8804996d> {:aacraid:aac_intr_normal+473}
<ffffffff80290543> {printk+82} <ffffffff802638a5> {error_exit+0}
<ffffffff8804996d> {:aacraid:aac_intr_normal+473} <ffffffff804aa78>
{:aacraid:aac_rkt_intr+55} <ffffffff80210809> {handle_IRQ_event+4}
<ffffffff802b2c73> {__do_IRQ+154} <ffffffff802713c6> {do_IRQ+60}
<ffffffff80262eea> {ret_from_intr+0} <EOI>
 
1 warning issued.  Results may not be reliable.

-------------------------------------------------- RAID DMESG
----------------------------------------------------------------
 
This is from DMESG and the Console Panic message is below...
 
ACPI wakeup devices:
USB0 USB1 Z000 Z002 Z003 Z004 Z005 Z006
ACPI: (supports S0 S1 S5)
Freeing unused kernel memory: 200k freed
Write protecting the kernel read-only data: 919k
SCSI subsystem initialized
Adaptec aacraid driver (1.1-5[2409]-mh1)
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 24 (level, low) -> IRQ 209
AAC0: kernel 5.1-0[8832]
AAC0: monitor 5.1-0[8832]
AAC0: bios 5.1-0[8832]
AAC0: serial 16fe14
AAC0: Non-DASD support enabled.
AAC0: 64bit support enabled.
AAC0: 64 Bit DAC enabled
scsi0 : aacraid
  Vendor: Adaptec   Model: VOLUME 0          Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 286492672 512-byte hdwr sectors (146684 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
SCSI device sda: 286492672 512-byte hdwr sectors (146684 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi removable disk sda
  Vendor: Adaptec   Model: ARRAY 0           Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdb: 1171431424 512-byte hdwr sectors (599773 MB)
sdb: assuming Write Enabled
sdb: assuming drive cache: write through
SCSI device sdb: 1171431424 512-byte hdwr sectors (599773 MB)
sdb: assuming Write Enabled
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2 sdb3
sd 0:0:1:0: Attached scsi removable disk sdb
  Vendor: SEAGATE   Model: ST3146707LC       Rev: 0003
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: SEAGATE   Model: ST3300007LC       Rev: 0005
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: SEAGATE   Model: ST3300007LC       Rev: 0005
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: SEAGATE   Model: ST3300007LC       Rev: 0005
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: SDR       Model: GEM318P           Rev: 1
  Type:   Processor                          ANSI SCSI revision: 02
Fusion MPT base driver 3.03.09
Copyright (c) 1999-2005 LSI Logic Corporation
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.

 
------------------------------- FROM THE CONSOLE - the Kernel Panic
--------------------------------
 
Call Trace: <IRQ> <ffffffff8804aa78> {:aacraid:acc_rkt_intr+55}
<ffffffff80210809> {handle_IRQ_event+41} <ffffffff802b2c73> {__do_IRQ+154}
<ffffffff802713c6> {do_IRQ+60} <ffffffff80262eea> {ret_from_intr+0} <EOI>

Code: 0f 0b 68 64 c3 04 88 c2 b4 00 48 8b 85 80 00 00 00 48 8b 50 RIP
<ffffffff8804996d> {:aacraid:aac_intr_normal+473} RSP<ffff810100133ec8> <0>
Kernal panic - not syncing: Oops

BUG: warning at Kernal/panic.c:137/panic() (Not tainted)

Call Trace: <IRQ. <ffffffff8028fcd2> {panic+483} <ffffffff802408ad>
{lock_timer_base+27} <ffffffff8021d333> {__mod_timer+176} <ffffffff803478b9>
{vgacon_blank+428} <ffffffff80269d8e> {spin_lock_irqsave+9}
<ffffffff803471e9> {vgacon_set_cursor_size+54} <ffffffff8026a43e>
{oops_end+81} <ffffffff80270715> {die+58} <ffffffff80270cbc>
{do_invalid_op+173} <ffffffff8804996d> {:aacraid:aac_intr_normal+473}
<ffffffff80290543> {printk+82} <ffffffff802638a5> {error_exit+0}
<ffffffff8804996d> {:aacraid:aac_intr_normal+473} <ffffffff804aa78>
{:aacraid:aac_rkt_intr+55} <ffffffff80210809> {handle_IRQ_event+4}
<ffffffff802b2c73> {__do_IRQ+154} <ffffffff802713c6> {do_IRQ+60}
<ffffffff80262eea> {ret_from_intr+0} <EOI>


