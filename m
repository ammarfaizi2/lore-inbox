Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbTI1VOW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTI1VOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:14:22 -0400
Received: from [62.38.235.35] ([62.38.235.35]:29584 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S262726AbTI1VOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:14:20 -0400
From: "P. Christeas" <p_christ@hol.gr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [aic7xxx]: Scheduling while atomic on rmmod - 2.6.0-test5,6
Date: Mon, 29 Sep 2003 00:15:24 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309290015.26280.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In an Athlon XP system w. two adaptec adapters:
Adaptec 2930CU SCSI adapter
aic7860: Ultra Single Channel A,
Adaptec 2902/04/10/15/20/30C SCSI adapter>
aic7850: Single Channel A,

I (always) get the same 'scheduling while atomic' error whenever I try to 
rmmod the aic7xxx module or try to suspend. I think my configuration 
(scripts) try to unload the module on suspend, which brings it down to the 
same problem.
Does this trace look familiar? What extra information should I include? 
[please CC. me]

This problem exists both for 2.6.0-test5 and 2.6.0-test6, both with pre-empt 
enabled. They're on a VIA motherboard w. broken ACPI (pci=noacpi given).

kernel: bad: scheduling while atomic!
kernel: Call Trace:
kernel:  [schedule+1414/1424] schedule+0x586/0x590
kernel:  [<c011bb86>] schedule+0x586/0x590
kernel:  [handle_mm_fault+222/400] handle_mm_fault+0xde/0x190
kernel:  [<c01499ae>] handle_mm_fault+0xde/0x190
kernel:  [__down+150/272] __down+0x96/0x110
kernel:  [<c0108196>] __down+0x96/0x110
kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
kernel:  [<c011bbf0>] default_wake_function+0x0/0x30
kernel:  [__down_failed+8/12] __down_failed+0x8/0xc
kernel:  [<c01083cc>] __down_failed+0x8/0xc
kernel:  [_end+828749580/1069457068] .text.lock.aic7xxx_osm+0x19/0x99 
[aic7xxx]
kernel:  [<f1a6f860>] .text.lock.aic7xxx_osm+0x19/0x99 [aic7xxx]
kernel:  [_end+828757092/1069457068] ahc_linux_exit+0x28/0x82 [aic7xxx]
kernel:  [<f1a715b8>] ahc_linux_exit+0x28/0x82 [aic7xxx]
kernel:  [sys_delete_module+338/448] sys_delete_module+0x152/0x1c0
kernel:  [<c01341a2>] sys_delete_module+0x152/0x1c0
kernel:  [do_munmap+339/400] do_munmap+0x153/0x190
kernel:  [<c014bb63>] do_munmap+0x153/0x190
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel:  [<c010949b>] syscall_call+0x7/0xb

