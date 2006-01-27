Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWA0R2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWA0R2c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 12:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWA0R2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 12:28:32 -0500
Received: from madness.at ([217.196.146.217]:13285 "EHLO cronos.madness.at")
	by vger.kernel.org with ESMTP id S932146AbWA0R2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 12:28:31 -0500
Message-ID: <43DA580E.3020100@madness.at>
Date: Fri, 27 Jan 2006 18:27:42 +0100
From: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: andrew.vasquez@qlogic.com
Subject: qla2xxx related oops in 2.6.16-rc1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We hit the following oops in 2.6.16-rc1 during itesting of a
devicemapper based multipath infrastructure.

The oops happend during heavy io on the devicemapper device and a reboot
of one of the switches the host was directly connected too.

The host in questions is as Dual Opteron 280 with 16GB ram and two
qla2340 adapters accessing an IBM DS4300 Array.

Stefan

Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
<ffffffff803cc6c6>{_spin_lock+0}
PGD 3ff513067 PUD 3ff514067 PMD 0
Oops: 0002 [1] SMP
CPU 0
Modules linked in: dm_round_robin dm_multipath dm_mod i2c_amd756 qla2300
qla2xxx i2c_core evdev
Pid: 2568, comm: qla2300_1_dpc Not tainted 2.6.16-rc1 #4
RIP: 0010:[<ffffffff803cc6c6>] <ffffffff803cc6c6>{_spin_lock+0}
RSP: 0018:ffff8101ffbb1d70  EFLAGS: 00010286
RAX: ffffffff804c6cc8 RBX: ffff8101fea11c78 RCX: ffffffffffffffd8
RDX: ffffffffffffffd8 RSI: ffffffff803ca8e1 RDI: 0000000000000000
RBP: ffff8101fea54160 R08: ffff8101ffbb0000 R09: 000000000000000a
R10: 000000000000000a R11: ffff8103ffd18800 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff880288c8 R15: 0000000000509c10
FS:  00002b031d5f0640(0000) GS:ffffffff80571000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000003ff512000 CR4: 00000000000006e0
Process qla2300_1_dpc (pid: 2568, threadinfo ffff8101ffbb0000, task
ffff8101ff6311e0)
Stack: ffffffff803ca95a ffffffff804c6cc8 ffff8101fea11c50 ffff8101fea54000
       ffffffff802bd255 000000000000000a ffff8101fea11c50 ffff8101fea11c00
       ffffffff8031acf5 ffff8101ffcbd600
Call Trace: <ffffffff803ca95a>{klist_del+18}
<ffffffff802bd255>{device_del+28}
       <ffffffff8031acf5>{fc_rport_terminate+81}
<ffffffff8800f3bb>{:qla2xxx:qla2x00_reg_remote_port+28}
       <ffffffff88010001>{:qla2xxx:qla2x00_fabric_dev_login+111}
       <ffffffff8800f749>{:qla2xxx:qla2x00_configure_fabric+503}
       <ffffffff8800efa4>{:qla2xxx:qla2x00_configure_loop+283}
       <ffffffff8801020d>{:qla2xxx:qla2x00_loop_resync+95}
       <ffffffff8800c8bb>{:qla2xxx:qla2x00_do_dpc+655}
<ffffffff8010b726>{child_rip+8}
       <ffffffff8800c62c>{:qla2xxx:qla2x00_do_dpc+0}
<ffffffff8010b71e>{child_rip+0}

Code: f0 ff 0f 0f 88 14 01 00 00 c3 48 89 f8 f0 81 28 00 00 00 01
RIP <ffffffff803cc6c6>{_spin_lock+0} RSP <ffff8101ffbb1d70>
CR2: 0000000000000000
 <6>qla2300 0000:05:08.0: scsi(0:4:0): Abort command issued -- 31e4c 2002.
