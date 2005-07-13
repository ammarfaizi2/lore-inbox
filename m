Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVGMJHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVGMJHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 05:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVGMJHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 05:07:19 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:6371 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S261546AbVGMJHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 05:07:17 -0400
Message-ID: <42D4D9BB.7010701@gwdg.de>
Date: Wed, 13 Jul 2005 11:07:07 +0200
From: Christian Boehme <Christian.Boehme@gwdg.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG at objrmap:325 in 2.6.5-7.151-smp (SuSE, x86_64)
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
X-AUTH-Id: cboehme1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We often see the following kernel-bug in our logs:

kernel: Kernel BUG at objrmap:325
kernel: invalid operand: 0000 [1] SMP
kernel: CPU 0
kernel: Pid: 4752, comm: mhd3d.opteron Tainted: G  U (2.6.5-7.151-smp SLES9_SP1_BRANCH-200503181131210000)
kernel: RIP: 0010:[<ffffffff8017d1de>] <ffffffff8017d1de>{page_add_rmap+334}
kernel: RSP: 0000:00000103e68d5db8  EFLAGS: 00010246
kernel: RAX: 000000000100806d RBX: 0000010007cefc48 RCX: 0000000000000000
kernel: RDX: ffffffff80596340 RSI: 00000101fb0d9d90 RDI: 0000010007cefc48
kernel: RBP: 00000000000165ae R08: 0000000000000000 R09: 000000000043c300
kernel: R10: 000000000d9b0b10 R11: 0000000000000002 R12: 00000101fb0d9d90
kernel: R13: 0000000000000003 R14: 00000103f0947800 R15: 000000000043c300
kernel: FS:  0000002a961864c0(0000) GS:ffffffff80554200(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 000000000043c300 CR3: 0000000000101000 CR4: 00000000000006e0
kernel: Process mhd3d.opteron (pid: 4752, threadinfo 00000103e68d4000, task 00000101fb6e8c40)
kernel: Stack: 0000000000000246 ffffffff801740db 00000103e5028800 0000010231caf010
kernel:        0000000100000000 00000101fb0d9d90 00000103ea3b01e0 0000000000000000
kernel:        000000000043c300 00000103f0947800
kernel: Call Trace:<ffffffff801740db>{do_no_page+2987} <ffffffff801758a5>{handle_mm_fault+405}
kernel:        <ffffffff80122554>{do_page_fault+468} <ffffffff801477c1>{sys_rt_sigaction+113}
kernel:        <ffffffff80111041>{error_exit+0}
kernel:
kernel: Code: 0f 0b 10 ec 37 80 ff ff ff ff 45 01 8b 07 a9 00 80 00 00 75
kernel: RIP <ffffffff8017d1de>{page_add_rmap+334} RSP <00000103e68d5db8>

The bug always hits the same user-compiled executable,
always at the time the daily cron-jobs are run, so there
seems to be a dependency on another process. The process
4752 is part of an MPI-parallel application, and another
instance of it runs on the same node with PID 4751. Interestingly
after this bug the /proc/4751 dir (i.e., the one of the instance
not cited in the bug) is inaccessible. Thanks for any help
with this issue!

Regards

Christian Boehme

-- 
Dr. Christian Boehme
GWDG                            Private:
Am Fassberg                     Wilhelm-Raabe-Str. 15
37077 Göttingen                 37083 Göttingen
email: Christian.Boehme@gwdg.de ChristianBoehme@web.de
phone: +49 (0)551 201-1839      +49 (0)551 3077000
fax:   +49 (0)551 201-2150      +49 (0)551 3077077

