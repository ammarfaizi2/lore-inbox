Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751897AbWJABcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbWJABcU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 21:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbWJABcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 21:32:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:60396 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751884AbWJABcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 21:32:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hBLbJHX6p8d5hznd6rbKqO9Z2AmcCzs08Fihu+fiKvHQMAFM0LQtkBNJ/cVygxtdzz060RIWOnb+WWF5YU5atOiMrejToH/ldUsIcp53lSKvXFScHAYuRreRubMsDNWgWtw+k5lCx21Z5WrZ1hcEyAGinUe9JnxxNDWS5kKy2rY=
Message-ID: <5f3c152b0609301832t141607d0s442d8f65e7ab9958@mail.gmail.com>
Date: Sun, 1 Oct 2006 03:32:17 +0200
From: "Eric Rannaud" <eric.rannaud@gmail.com>
To: Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Oops in megaraid_mbox (git HEAD)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following OOPS on current git HEAD
cfae35804bcb909225d6f4eb5bd29e25971614d8 with the following config,
early on boot:
http://engm.ath.cx/kernel/config-cfae35804bcb909225d6f4eb5bd29e25971614d8
http://engm.ath.cx/kernel/liw64-lspci.txt

Seems related to megaraid_mbox.
It is reproductible (just reboot).
Doesn't happen on vanilla 2.6.18.


(It is to be noted that this box is having some trouble with recent
versions of the kernel, that may or may not be related to this Oops,
see the thread ".BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)".
However the symptoms are different, so maybe this is of interest.)

I can git-bisect it if you think it could be useful.

er.

P.S. The "CI: Cannot allocate resource region 0 of device
0000:08:0a.1" is a new message (from v2.6.18)

----
[  182.870034] PCI: Cannot allocate resource region 0 of device 0000:08:0a.1
[  182.870343] PCI: Cannot allocate resource region 0 of device 0000:08:0b.1
[  256.181299] Unable to handle kernel NULL pointer dereference at
0000000000000000 RIP:
[  256.181361]  [<ffffffff811f1bce>] megaraid_mbox_dpc+0x1ce/0x670
[  256.181483] PGD 0
[  256.181553] Oops: 0000 [1] SMP
[  256.181656] CPU 0
[  256.181725] Modules linked in:
[  256.181811] Pid: 3, comm: ksoftirqd/0 Not tainted 2.6.18rannaud-gcfae3580 #46
[  256.181872] RIP: 0010:[<ffffffff811f1bce>]  [<ffffffff811f1bce>]
megaraid_mbox_dpc+0x1ce/0x670
[  256.181982] RSP: 0018:ffffffff814c5eb8  EFLAGS: 00010202
[  256.182039] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
[  256.182099] RDX: ffff810222898000 RSI: 0000000000000000 RDI: 0000000000000000
[  256.182159] RBP: ffffffff814c5f38 R08: ffff8102211aa000 R09: 0000000000000001
[  256.182218] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8102236bc048
[  256.182279] R13: ffff810037fed070 R14: ffff8102236bc050 R15: ffff8102210bbc80
[  256.182342] FS:  00000000005a6860(0000) GS:ffffffff81444000(0000)
knlGS:0000000000000000
[  256.182417] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[  256.182474] CR2: 0000000000000000 CR3: 0000000001001000 CR4: 00000000000006e0
[  256.182534] Process ksoftirqd/0 (pid: 3, threadinfo
ffff810223e06000, task ffff810223f780c0)
[  256.182610] Stack:  ffffffff8103b917 ffffffff814c5ec0
ffff8102211aa000 ffff810222898000
[  256.182853]  0000000000000000 ffffffff814c5ef0 ffff810037fe9080
ffff810037fe9080
[  256.183064]  ffff8102236bc050 ffff8102236bc050 0000000000000000
ffff8102211aa000
[  256.183224] Call Trace:
[  256.183320]  <IRQ>  [<ffffffff8103b917>] run_timer_softirq+0x1d7/0x1f0
[  256.183419]  [<ffffffff81037f26>] tasklet_action+0x76/0xe0
[  256.183478]  [<ffffffff810380f0>] __do_softirq+0x80/0x100
[  256.183536]  [<ffffffff81037df0>] ksoftirqd+0x0/0xc0
[  256.183595]  [<ffffffff8100af9c>] call_softirq+0x1c/0x30
[  256.183651]  <EOI>  [<ffffffff8100c65d>] do_softirq+0x3d/0xb0
[  256.183744]  [<ffffffff81037df0>] ksoftirqd+0x0/0xc0
[  256.183802]  [<ffffffff81037e67>] ksoftirqd+0x77/0xc0
[  256.183859]  [<ffffffff81037df0>] ksoftirqd+0x0/0xc0
[  256.183917]  [<ffffffff81046efa>] kthread+0xda/0x110
[  256.183978]  [<ffffffff8100ac28>] child_rip+0xa/0x12
[  256.184037]  [<ffffffff812c507b>] _spin_unlock_irq+0x2b/0x40
[  256.184095]  [<ffffffff8100a3ac>] restore_args+0x0/0x30
[  256.184152]  [<ffffffff81046e20>] kthread+0x0/0x110
[  256.184209]  [<ffffffff8100ac1e>] child_rip+0x0/0x12
[  256.184265]
[  256.184313]
[  256.184314] Code: 48 8b 39 48 85 ff 74 24 e8 95 7d e7 ff 4c 8b 45 a0 48 c1 e0
[  256.185118] RIP  [<ffffffff811f1bce>] megaraid_mbox_dpc+0x1ce/0x670
[  256.185210]  RSP <ffffffff814c5eb8>
[  256.185263] CR2: 0000000000000000
[  256.185316]  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
[  256.185417]
----
