Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUCWBRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 20:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUCWBRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 20:17:46 -0500
Received: from painless.aaisp.net.uk ([217.169.20.17]:25529 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S261803AbUCWBRo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 20:17:44 -0500
Message-ID: <405F920C.9090809@rgadsdon2.giointernet.co.uk>
Date: Tue, 23 Mar 2004 01:25:32 +0000
From: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7b) Gecko/20040320
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.5-rc2 - panic when slocate.cron job accesses firewire disk
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following when the slocate.cron job accesses the first of 3 
120GB firewire disks:
-------------------------------------------------------------
EIP:   0060:[<f89e3a27>]   Tainted:  P
EFLAGS: 00010047  (2.6.5-rc2)
EIP is at hpsb_packet_sent +0x27/0x90 [ieee1394]
eax : 00100100  ebx: f1b34000  ecx:  d37a4da0  edx: 00200200
esi:  00000001  edi: d37a4da0  ebp:  f1b36060  esp: f7f4fefc
ds:  007b  es: 007b ss: 0068
Process swapper  (pid: 0, threadinfo=f7f4e000 task=f7e5f150)
Stack: f1b361a4 f890a9e8 f1b34000 d37a4da0 00000001 dcc54b40 f1b361d0 
00000282
        f1b361a4 00000000 f7f4e000 c04c35c0 c0124a83 f1b361a4 00000001 
c0493fa8
        0000000a 00000046 c01247b7 c0493fa8 f7f4e000 f7f4e000 00000009 
00000020
Call Trace:
[<f890a9e8>] dma_trm_tasklet+0xa8/0x1b0 [ohci1394]
[<c0124a83>] tasklet_action+Bx73/0xe0
[<c01247b7>] do_softirq+0xc7/0xd0
[<c010b77b>] do_IRQ+0x13b/0x1a0
[<c01998a8>] common_interrupt+0x18/0x20
[<c0186970>] default_idle+0x0/0x40
[<c016699c>] default_idle+0x2c/0x40
[<c0106a2b>] cpu_idle+0x3b/0x50
[<c0120a38>] printk+0xl78/0x1f0

Code: 89 50 04 89 02 c7 41 04 00 02 20 00 c7 01 00 01 10 00 c6 41
<0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
-------------------------------------------------------------
(copied/OCRed from screen photo)

When booting and mounting the disks, the console shows the following 
'errors/warnings':
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
........
ieee1394: unsolicited response packet received - no tlabel match

Similar problem occurs with 2.6.4, but 2.6.3 and earlier are OK.

System is a 2-cpu PIII (Via) running Fedora 1 with 2.6.x kernel..

..................................
Robert Gadsdon
..................................
