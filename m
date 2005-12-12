Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVLLQy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVLLQy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 11:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVLLQy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 11:54:58 -0500
Received: from solarneutrino.net ([66.199.224.43]:30982 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751213AbVLLQy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 11:54:58 -0500
Date: Mon, 12 Dec 2005 11:54:43 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20051212165443.GD17295@tau.solarneutrino.net>
References: <20051201195657.GB7236@tau.solarneutrino.net> <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com> <20051202180326.GB7634@tau.solarneutrino.net> <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com> <20051202194447.GA7679@tau.solarneutrino.net> <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com> <20051206160815.GC11560@tau.solarneutrino.net> <Pine.LNX.4.61.0512062025230.28217@goblin.wat.veritas.com> <20051206204336.GA12248@tau.solarneutrino.net> <Pine.LNX.4.61.0512071803300.2975@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512071803300.2975@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And yet another crash, this time during boot:


mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
scsi2 : ioc1: LSI53C1030, FwRev=01030600h, Ports=1, MaxQ=255, IRQ=17
  Vendor: SEAGATE   Model: ST336607LW        Rev: 0007
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdf: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdf: drive cache: write back
SCSI device sdf: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdf: drive cache: write back
 sdf: sdf1 sdf2 sdf3 sdf4
sd 2:0:0:0: Attached scsi disk sdf
sd 2:0:0:0: Attached scsi generic sg8 type 0
general protection fault: 0000 [1] SMP
CPU 1
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.15-rc5 #1
RIP: 0010:[<ffffffff802a0a04>] <ffffffff802a0a04>{scsi_run_queue+20}
RSP: 0000:ffff81010288be18  EFLAGS: 00010296
RAX: 0000000000000001 RBX: ffff81000c0ad770 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff80222090 RDI: 6b6b6b6b6b6b6b6b
RBP: ffff8100f6fba230 R08: 0000000000000000 R09: ffff81000c0aa198
R10: ffff8100f6f88578 R11: 0000000000000001 R12: 0000000000000292
R13: ffff81000486e3e8 R14: ffff81000486e3e8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff804ee880(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff81000482e000, task ffff81000482ae00)
Stack: 0000000000000001 ffff81000c0ad770 ffff8100f6fba230 0000000000000292
       0000000000000001 ffffffff802a0c4f ffff81000c0d93b8 ffff8100f6fba230
       0000000000000024 0000000000010000
Call Trace: <IRQ> <ffffffff802a0c4f>{scsi_end_request+207} <ffffffff802a11af>{scsi_io_completion+1039}
       <ffffffff8029c3c6>{scsi_finish_command+150} <ffffffff8029c2dd>{scsi_softirq+333}
       <ffffffff801386eb>{__do_softirq+107} <ffffffff8010eeeb>{call_softirq+31}
       <ffffffff80110781>{do_softirq+49} <ffffffff80110744>{do_IRQ+52}
       <ffffffff8010e10c>{ret_from_intr+0}  <EOI> <ffffffff8038866c>{thread_return+140}
       <ffffffff8010bb1a>{default_idle+58} <ffffffff8010bd61>{cpu_idle+97}


Code: f6 87 cd 01 00 00 80 48 8b 2f 74 05 e8 fb fe ff ff 48 8b 7d
RIP <ffffffff802a0a04>{scsi_run_queue+20} RSP <ffff81010288be18>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

-ryan
