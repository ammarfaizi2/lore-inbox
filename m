Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVFWPOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVFWPOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 11:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVFWPON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 11:14:13 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:53686 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262500AbVFWPNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 11:13:54 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: x86_64 access of some bad address
From: Alexander Nyberg <alexn@telia.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 23 Jun 2005 17:13:50 +0200
Message-Id: <1119539630.1170.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I only have one x86_64 which is my main workstation it's far too
tedious to do binary searching (this doesn't happen on x86).

Happens with both latest -git and 2.6.12-mm1
The tools to reproduce this is at: http://serkiaden.mine.nu/kp2.tar

Just do:
gdb lyze
run

and it crashes here giving:

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "mm/memory.c":911
invalid operand: 0000 [1] PREEMPT SMP
CPU 1
Modules linked in: snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc
Pid: 1285, comm: gdb Not tainted 2.6.12
RIP: 0010:[<ffffffff80162b46>] <ffffffff80162b46>{get_user_pages+326}
RSP: 0018:ffff810030e3de48  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffffaf5000 RCX: 0000000001e06000
RDX: ffff810000000000 RSI: 03fffffffffff000 RDI: ffffffff803900a0
RBP: ffffffffffaf5440 R08: 0000000000000000 R09: 0000000000000001
R10: 00007fffff95f398 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: ffff810037eb3240 R15: ffff810037eb3240
FS:  00002aaaab31c090(0000) GS:ffffffff804882c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaab12a288 CR3: 0000000028146000 CR4: 00000000000006e0
Process gdb (pid: 1285, threadinfo ffff810030e3c000, task ffff8100316a55b0)
Stack: 0000000000000246 ffffffff8011d479 0000000000003950 0000000000000246
       0000000000000246 0000001037eb3298 0000000100000000 0000000100000000
       ffff810034298df0 ffff810030e3df08
Call Trace:<ffffffff8011d479>{do_page_fault+601} <ffffffff8013a596>{access_process_vm+134}
       <ffffffff80110e6e>{sys_ptrace+318} <ffffffff8010e569>{error_exit+0}
       <ffffffff8010da1a>{system_call+126}

Code: 0f 0b 70 6c 2f 80 ff ff ff ff 8f 03 48 c1 eb 09 48 21 f0 81
RIP <ffffffff80162b46>{get_user_pages+326} RSP <ffff810030e3de48>
 <6>lyze[1286]: segfault at ffffffffffaf5447 rip 0000000000400d6b rsp 00007fffffaf5420 error 4


