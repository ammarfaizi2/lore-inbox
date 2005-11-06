Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVKFPfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVKFPfg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 10:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVKFPfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 10:35:36 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:3287 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932070AbVKFPff convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 10:35:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qwgNssu3oHzg/7IglHZQMCViO/HN1yjP13u8APmYYwekk0/gQDPtc10V50KP74KazSt0hxUToqrkRlAb4dna8M0ynlOoH3maYonJbAoROqUT81l1aYloGZVZiom7EZa0C3dQUmx4Gg7mLFOjEAs6SCRKQgUsXFE/UOsSIJ0xNR8=
Message-ID: <62b0912f0511060735j3039bf6dve3d22e97ad75cf37@mail.gmail.com>
Date: Sun, 6 Nov 2005 15:35:34 +0000
From: Molle Bestefich <molle.bestefich@gmail.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: atalib regressions in 2.6.14
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems there is a couple of regressions in atalib in 2.6.14 (vs. 2.6.12).

It no longer detects SATA ports without devices, instead it now throw
warnings about abnormal stati.

Also, the kernel oopses on startup from time to time.

Here's an excerpt:

libata version 1.12 loaded.
ata_piix version 1.04
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xE400 ctl 0xE502 bmdma 0xE800 irq 18
ata2: SATA max UDMA/133 cmd 0xE600 ctl 0xE702 bmdma 0xE808 irq 18
ATA: abnormal status 0x7F on port 0xE407
scsi0 : ata_piix
ATA: abnormal status 0x7F on port 0xE607
scsi1 : ata_piix
Unable to handle kernel NULL pointer dereference at virtual address 00000000
st: Version 20050830, fixed bufsize 32768, s/g segs 256
mice: PS/2 mouse device common for all mice
 printing eip:
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
 c03e6f00
*pde = 00000000
NET: Registered protocol family 2
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU: 0
EIP: 0060:[<c036f00>] Not tainted VLI
EFLAGS: 00010282 (2.6.14)
EIP is at scsi_run_queue+0x10/0xb0
eax: 0000000  ebx: c17de6bc  ecx: dffef500  edx: 00000001
esi: df86b00  edi: 00000202  ebp: c17ec0cd  esp: dfea7ec0
ds: 007b  es: 007b  ss: 0068

Process ksoftirqd/0 (pid: 3, threadinfo=dfea6000 task=dfec8a70
Stack: c17ec0c0 c17de6bc df86eb00 00000202 c17ec0c0 c03e7112 df86cb00
00000000 00000000 00000024 c03e7487 00000001 c1403060 dfec4c30
dfec8a70 00000000 00000000 00000000 c17ec0c0 00000024 00040000
00000024 00000000

Call Trace:
[<c03e7112>] scsi_end_request+0xb2/0xd0
[<c03e7487>] scsi_io_completion+0x247/0x7f0
[<c03e2749>] scsi_finish_command+0x79/0xa0
[<c03e2619>] scsi_softirq+0xc9/0x140
[<c0124084>] __do_softieq+0x35/0x40
[<c01240d5>] do_softirq+0x35/0xf0
[<c0124675>] ksoftirqd+0x85/0xf0
[<c01245f0>] ksoftirqd+0x0/0xf0
[<c0132d84>] kthread+0xa4/0xb0
[<c0132cc0>] kthread+0x0/0xb0
[<c0101195>] kernel_thread_helper+0x5/0x10

Code: 0b 00 89 04 24 89 d8 e8 bf ba ff ff eb ac 8d 55 57 56 53 83 ec
04 89 04 24 8b 80 f8 00 00 00 <8b> 38 f6 80 7d 01 00 00 80 0f 85 83 00
00 00 8b 47 34 8d 6f 24

<0>:Kernel panic - not syncing: fatal exception in interrupt


As can be seen, it says "ATA: abnormal status 0x7F on port" instead of
"ATA: no devices on port" (or some such).

No clue what's going on with the Oops?

Vanilla 2.6.14, nothing fancy.
