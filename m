Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161331AbWJYBZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161331AbWJYBZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 21:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161332AbWJYBZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 21:25:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:4640 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161331AbWJYBZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 21:25:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:mime-version:content-type:content-transfer-encoding:x-mailer:x-mimeole:thread-index:in-reply-to:message-id;
        b=ghH7l8sgR28Gda3NB99Q57Y01oprHkFvZqKWVmSaCvynXlXbuYN74R0ajhnUgdVuXgV+IKu8L+qB7vgRQNKQgiSZAP80GAeDmAwmVYRm46qvjJLzaxuoRjtjOMU25zdgiQ8eytVVuKK3G6gwd3zyjr6CVChaKKtH520IPU592JI=
From: "Michael" <michael.sallaway@gmail.com>
To: <sergio@sergiomb.no-ip.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: Oops when doing disk heavy disk I/O
Date: Wed, 25 Oct 2006 11:25:07 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: Acb3zpffcWt1OAZgShKq/SvfxJUndgAASC2w
In-Reply-To: <1161736906.2922.14.camel@localhost.portugal>
Message-ID: <453ebcfd.615c691e.52ef.2927@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Sergio Monteiro Basto [mailto:sergio@sergiomb.no-ip.org] 
> Sent: Wednesday, 25 October 2006 10:42 AM
> 
> well I don't know for sure , but after this initials Lost Timer tick ,
> it appears more after a few time of uptime ? 
> 

Well, when the machine was just sitting there, I don't get any lost timer
ticks -- it's perfectly happy. However, I started to `dd if=/dev/zero
of=/dev/hda6` again, and after a few minutes, it oops'ed again (below),
losing 2 timer ticks:  <4>time.c: Lost 2 timer tick(s)! rip
__do_softirq+0x4a/0xc4)

Also, I rebooted and did the same command, but with bs=512K. It Oops'ed
again (after about 30 seconds?), but this time, with:
<4>time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x8/0x9)
Kernel panic - not syncing: Aiee, killing interrupt handler!

It seems to be related to interrupts, somehow... since I'm not too familiar
with what's happening, would anyone have any suggestions about what I could
do next to troubleshoot?

Thanks!
Michael


Full Oops:

Unable to handle kernel NULL pointer dereference at 000000000000002b RIP:
 [<ffffffff8021a6c5>] __block_write_full_page+0xa4/0x2df
PGD 7a312067 PUD 7a374067 PMD 0
Oops: 0000 [1] SMP
CPU 0
Modules linked in:
Pid: 263, comm: pdflush Not tainted 2.6.19-rc3 #1
RIP: 0010:[<ffffffff8021a6c5>]  [<ffffffff8021a6c5>]
__block_write_full_page+0xa4/0x2df
RSP: 0018:ffff810037ebbc30  EFLAGS: 00010287
RAX: 0000000000000000 RBX: 000000000000002b RCX: 0000000000000002
RDX: 000000000000000a RSI: 00000000000554a9 RDI: ffff810037cc8440
RBP: ffff8100015f1c30 R08: ffff810037cc8440 R09: ffff810037ebbe70
R10: ffffffff802bee4c R11: ffffffff80440b8b R12: ffff81001b2c9dc8
R13: 00000000001552a7 R14: ffff810037cc8440 R15: 0000000001c42574
FS:  00002b1c6f9536d0(0000) GS:ffffffff807d6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 000000000000002b CR3: 000000007a315000 CR4: 00000000000006e0
Process pdflush (pid: 263, threadinfo ffff810037eba000, task
ffff810037f250e0)
Stack:  ffff810037ebbe70 ffffffff802bee4c 00000400015f1c30 ffff8100015f1c30
 ffff810037ebbe70 ffff810037cc8550 000000000000000b ffff81007efe9b08
 0000000000000000 ffffffff8029db1e 000000000000000e ffffffff802bdff3
Call Trace:
 [<ffffffff802bee4c>] blkdev_get_block+0x0/0x46
 [<ffffffff8029db1e>] generic_writepages+0x18e/0x2d8
 [<ffffffff802bdff3>] blkdev_writepage+0x0/0xf
 [<ffffffff8025591f>] do_writepages+0x20/0x2d
 [<ffffffff8022cf8c>] __writeback_single_inode+0x1b4/0x38b
 [<ffffffff8021f44f>] sync_sb_inodes+0x1d1/0x2b5
 [<ffffffff802897e0>] keventd_create_kthread+0x0/0x61
 [<ffffffff8024b3b7>] writeback_inodes+0x82/0xd8
 [<ffffffff8029dfb4>] background_writeout+0x82/0xb5
 [<ffffffff8025108f>] pdflush+0x0/0x1e3
 [<ffffffff802511c8>] pdflush+0x139/0x1e3
 [<ffffffff8029df32>] background_writeout+0x0/0xb5
 [<ffffffff8022f78a>] kthread+0xd1/0x101
 [<ffffffff80258ed8>] child_rip+0xa/0x12
 [<ffffffff802897e0>] keventd_create_kthread+0x0/0x61
 [<ffffffff8022f6b9>] kthread+0x0/0x101
 [<ffffffff80258ece>] child_rip+0x0/0x12


Code: 8b 03 a8 20 75 6c 8b 03 a8 02 74 66 8b 44 24 14 48 39 43 20
RIP  [<ffffffff8021a6c5>] __block_write_full_page+0xa4/0x2df
 RSP <ffff810037ebbc30>
CR2: 000000000000002b
 <4>time.c: Lost 2 timer tick(s)! rip __do_softirq+0x4a/0xc4)



