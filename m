Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVLLQx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVLLQx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 11:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVLLQx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 11:53:29 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:11015 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1751172AbVLLQx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 11:53:28 -0500
Subject: Kernel BUG at arch/x86_64/mm/pageattr.c:154
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 17:53:18 +0100
Message-Id: <1134406398.4953.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello... i know my kernel is tainted, however, since the thing with
nvidia giving warnings i think this still might be apropriate to report.

i get the following by running bzflag 2.0.4 (2.0.2 works)..
the first time i did it, X froze, the next time, it didnt, however no
opengl worked anymore...
bzflag seems to be the only thing whihc doesent work, other opengl stuff
seems not to be affected, despite the warning from nvidia..

Kernel BUG at arch/x86_64/mm/pageattr.c:154
invalid operand: 0000 [1]
CPU 0
Modules linked in: vfat fat isofs zlib_inflate nvidia i2c_viapro
ehci_hcd uhci_hcd amd64_agp agpgart snd_pcm_oss snd_mixer_oss
snd_seq_oss snd_seq_midi_event snd_seq $
Pid: 6760, comm: bzflag Tainted: P      2.6.15-rc5-ck2-redee #1
RIP: 0010:[<ffffffff8011e0d0>] <ffffffff8011e0d0>{__change_page_attr
+608}
RSP: 0018:ffff8100356b9d98  EFLAGS: 00010282
RAX: 00000000000001f8 RBX: ffff8100010001f8 RCX: 80000000328001e3
RDX: 0000000000000048 RSI: 0000000000032962 RDI: ffff810000000000
RBP: ffff810032962000 R08: 00003ffffffff000 R09: 8000000000000163
R10: ffffffffffffffff R11: ffffffff80152d40 R12: 0000000000000000
R13: ffff810000009ca0 R14: 0000000000000ca0 R15: 8000000000000163
FS:  00002aaaace1b1f0(0000) GS:ffffffff80412800(0000)
knlGS:000000004014e6b0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000881708 CR3: 0000000014629000 CR4: 00000000000006e0
Process bzflag (pid: 6760, threadinfo ffff8100356b8000, task
ffff810017a3a3c0)
Stack: 0000001e00000001 ffffffff80101810 0000000000000102
0000000000000000
       ffff810037f66000 0000000000000013 0000000000000246
ffff810032962000
       0000000000032962 0000000000000000
Call Trace:<ffffffff80101810>{init_level4_pgt+2064}
<ffffffff8011e31b>{change_page_attr_addr+155}
       <ffffffff88479947>{:nvidia:nv_vm_free_pages+274}
<ffffffff88475b44>{:nvidia:nv_kern_vma_release+126}
       <ffffffff8015f80c>{remove_vma+44} <ffffffff8015fd78>{exit_mmap
+184}
       <ffffffff8012c37b>{mmput+27} <ffffffff80130633>{do_exit+547}
       <ffffffff80131029>{do_group_exit+169}
<ffffffff8010e96e>{system_call+126}


Code: 0f 0b 68 d2 a5 2d 80 c2 9a 00 66 66 90 66 66 90 8b 03 89 c0
RIP <ffffffff8011e0d0>{__change_page_attr+608} RSP <ffff8100356b9d98>
 <1>Fixing recursive fault but reboot is needed!


