Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbTJZOBa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 09:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbTJZOBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 09:01:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263157AbTJZOB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 09:01:27 -0500
Date: Sun, 26 Oct 2003 14:01:26 +0000 (GMT)
From: Matthew J Galgoci <mgalgoci@parcelfarce.linux.theplanet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: sbp2 slab corruiton in 2.6-test9
Message-ID: <Pine.LNX.4.44.0310261357100.16378-100000@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

I'm seeing slab corruption in 2.6-test9 when I do a 
cat /proc/scsi/scsi

Here's the trace:

ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0050c5015000013d]
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
Slab corruption: start=e2166758, expend=e21667b7, problemat=e2166788
Last user: [<f088214b>](free_hpsb_packet+0x2b/0x40 [ieee1394])
Data: ************************************************D5 D6 D6 D6 01 00 00 
00 ***************************************A5
Next: 71 F0 2C .4B 21 88 F0 71 F0 2C .....................
slab error in check_poison_obj(): cache `hpsb_packet': object was modified 
after freeing
Call Trace:
 [<c013d2b8>] check_poison_obj+0x108/0x190
 [<c013d4d2>] slab_destroy+0x192/0x1a0
 [<c013f9c9>] reap_timer_fnc+0x129/0x1f0
 [<c013f8a0>] reap_timer_fnc+0x0/0x1f0
 [<c01256f0>] run_timer_softirq+0xb0/0x170
 [<c0121410>] do_softirq+0x90/0xa0
 [<c010c615>] do_IRQ+0xd5/0x110
 [<c0105000>] rest_init+0x0/0x30
 [<c010ab8c>] common_interrupt+0x18/0x20
 [<c0105000>] rest_init+0x0/0x30
 [<c01e1cf2>] acpi_processor_idle+0xd5/0x1c7
 [<c0105000>] rest_init+0x0/0x30
 [<c01088bc>] cpu_idle+0x2c/0x40
 [<c03826d1>] start_kernel+0x171/0x1a0
 [<c0382430>] unknown_bootoption+0x0/0x100
 


