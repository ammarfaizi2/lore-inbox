Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbTGLNbP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 09:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265631AbTGLNbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 09:31:15 -0400
Received: from franka.aracnet.com ([216.99.193.44]:35529 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265628AbTGLNbL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 09:31:11 -0400
Date: Sat, 12 Jul 2003 06:45:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 914] New: "bad: scheduling while atomic!" flood after IDE error 
Message-ID: <166680000.1058017544@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=914

           Summary: "bad: scheduling while atomic!" flood after IDE error
    Kernel Version: 2.5.75
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: rl@hellgate.ch


This problem has been reported on LKML for 2.5.74. I think I have seen it
at least with 2.5.73, too. The system looks okay, then, usually hours later
(if at all, it's a rare event), something freezes the system for several
seconds and triggers a flood of those call traces (many of them per second).
It seems an IDE error causes it.

A 2.5.75 trace (the call stack is always the same):

Jul 12 13:08:47 [kernel] hda: dma_timer_expiry: dma status == 0x61
Jul 12 13:09:02 [kernel] hda: timeout waiting for DMA
Jul 12 13:09:03 [kernel] ide0: reset: success
Jul 12 13:09:03 [kernel] bad: scheduling while atomic!
                - Last output repeated 103 times -
Jul 12 13:09:51 [kernel] Call Trace:
Jul 12 13:09:51 [kernel]  [<c0107000>] default_idle+0x0/0x40
Jul 12 13:09:51 [kernel]  [<c011f4a0>] schedule+0x500/0x510
Jul 12 13:09:51 [kernel]  [<c010706a>] poll_idle+0x2a/0x40
Jul 12 13:09:51 [kernel]  [<c01180e3>] apm_cpu_idle+0xa3/0x140
Jul 12 13:09:51 [kernel]  [<c0118040>] apm_cpu_idle+0x0/0x140
Jul 12 13:09:51 [kernel]  [<c0107000>] default_idle+0x0/0x40
Jul 12 13:09:51 [kernel]  [<c01070b8>] cpu_idle+0x38/0x40
Jul 12 13:09:51 [kernel]  [<c0105000>] rest_init+0x0/0x30
Jul 12 13:09:51 [kernel]  [<c0380738>] start_kernel+0x138/0x140
Jul 12 13:09:51 [kernel]  [<c03804c0>] unknown_bootoption+0x0/0x100
Jul 12 13:09:51 [kernel] bad: scheduling while atomic!
                - Last output repeated 144 times -


