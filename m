Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965470AbWI0J0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965470AbWI0J0K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965472AbWI0J0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:26:09 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:35846 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965470AbWI0J0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:26:08 -0400
Message-ID: <451A4394.7000504@shadowen.org>
Date: Wed, 27 Sep 2006 10:25:40 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.18-mm1
References: <20060924040215.8e6e7f1a.akpm@osdl.org>
In-Reply-To: <20060924040215.8e6e7f1a.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.  Now that we've got past the linker changes breaking down under
older tool chains I am getting following panic on boot.  The machine has
one of these, other machines do seem to boot:

0000:02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030
PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)

It appears that this driver is unchanged between 2.6.18 and -mm1.
2.6.18 boots just fine.  Odd.

Any suggestions?

-apw

mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
mptbase: Initiating ioc0 recovery
Unable to handle kernel NULL pointer dereference at 0000000000000500 RIP:
 [<ffffffff803fadfb>] mptspi_dv_renegotiate_work+0x10/0x4a
PGD 0
Oops: 0000 [1] SMP
last sysfs file:
CPU 0
Modules linked in:
Pid: 14, comm: events/0 Not tainted 2.6.18-mm1-autokern1 #1
RIP: 0010:[<ffffffff803fadfb>]  [<ffffffff803fadfb>]
mptspi_dv_renegotiate_work+0x10/0x4a
RSP: 0000:ffff8101000e1e20  EFLAGS: 00010282
RAX: 0000000000000001 RBX: ffff810001fe6940 RCX: 000000000000001f
RDX: 0000000000000000 RSI: ffff810001fe6940 RDI: 0000000000001fe6
RBP: ffff8101000e1e30 R08: ffff8101000e0000 R09: 0000000000000011
R10: ffff810001014820 R11: ffff810001014820 R12: 0000000000000500
R13: ffff810001ef1640 R14: 0000000000000206 R15: ffff810001fe6940
FS:  0000000000000000(0000) GS:ffffffff80582000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000500 CR3: 0000000000201000 CR4: 00000000000006e0
Process events/0 (pid: 14, threadinfo ffff8101000e0000, task
ffff8100816b1040)
Stack:  ffff810001fe6940 ffff810001fe6948 ffff8101000e1e70 ffffffff80239163
 ffffffff803fadeb ffff810001ef1640 ffff810001f0dd40 ffffffff802391a7
 00000000fffffffc ffffffff804b08d4 ffff8101000e1f00 ffffffff8023929a
Call Trace:
 [<ffffffff80239163>] run_workqueue+0xa2/0xe6
 [<ffffffff803fadeb>] mptspi_dv_renegotiate_work+0x0/0x4a
 [<ffffffff802391a7>] worker_thread+0x0/0x126
 [<ffffffff8023929a>] worker_thread+0xf3/0x126
 [<ffffffff80224de3>] default_wake_function+0x0/0xf
 [<ffffffff80224de3>] default_wake_function+0x0/0xf
 [<ffffffff802391a7>] worker_thread+0x0/0x126
 [<ffffffff8023c304>] kthread+0xd0/0xfc
 [<ffffffff8020a658>] child_rip+0xa/0x12
 [<ffffffff8023c234>] kthread+0x0/0xfc
 [<ffffffff8020a64e>] child_rip+0x0/0x12


Code: 49 8b 04 24 31 f6 48 8b b8 48 01 00 00 e8 5f 8f fe ff 48 85
RIP  [<ffffffff803fadfb>] mptspi_dv_renegotiate_work+0x10/0x4a
 RSP <ffff8101000e1e20>
CR2: 0000000000000500

