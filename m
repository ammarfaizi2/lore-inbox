Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVFGWeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVFGWeP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVFGWeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:34:15 -0400
Received: from mxsf25.cluster1.charter.net ([209.225.28.225]:15257 "EHLO
	mxsf25.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262016AbVFGWeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 18:34:07 -0400
X-IronPort-AV: i="3.93,180,1115006400"; 
   d="scan'208"; a="867304729:sNHT43969128"
From: Jacob Martin <martin@cs.uga.edu>
Reply-To: martin@cs.uga.edu
Organization: University of Georgia
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:  OOPSes in PREEMPT SMP for AMD Opteron Dual-Core with Memhole Mapping (non tainted kernel)
Date: Tue, 7 Jun 2005 18:36:12 -0400
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506071836.12076.martin@cs.uga.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about the tainted kernel report.

Here are the reproduced OOPSes with an untainted kernel (using software memhole and discrete mtrr mapping in bios).  

On second thought, the MTRR stuff may not have anything to do with this.


I think this is a bug in the preemptable kernel (I was warned, but didn't listen :).  


"00000000000025b0 RIP" and "PREEMPT SMP" seem to be a common themes in all the OOPSes.



Best Regards,
Jacob Martin



Jun  7 14:11:27 optimator Unable to handle kernel paging request at 00000000000025b0 RIP: 
Jun  7 14:11:27 optimator <ffffffff8016797a>{pte_alloc_map+170}
Jun  7 14:11:27 optimator PGD 138328067 PUD 0 
Jun  7 14:11:27 optimator Oops: 0000 [1] PREEMPT SMP 
Jun  7 14:11:27 optimator CPU 0 
Jun  7 14:11:27 optimator Modules linked in: smsc47b397 i2c_sensor i2c_isa i2c_core
Jun  7 14:11:27 optimator Pid: 6759, comm: java Not tainted 2.6.12-rc6
Jun  7 14:11:27 optimator RIP: 0010:[<ffffffff8016797a>] <ffffffff8016797a>{pte_alloc_map+170}
Jun  7 14:11:27 optimator RSP: 0000:ffff81013bc5bdb8  EFLAGS: 00010293
Jun  7 14:11:27 optimator RAX: ffffffff7fffffff RBX: 00002aabb8a00000 RCX: 0000000000000018
Jun  7 14:11:27 optimator RDX: ffff810107d1e000 RSI: 0000000000000000 RDI: ffff81000000e6c0
Jun  7 14:11:27 optimator RBP: ffff81013876de28 R08: ffff81000000e000 R09: 0000000000000000
Jun  7 14:11:27 optimator R10: 00000000000c1687 R11: 0000000000000000 R12: 0000000000000000
Jun  7 14:11:27 optimator R13: ffff81013f463b40 R14: ffff81013f463bb0 R15: ffff81013876de28
Jun  7 14:11:27 optimator FS:  00000000403bc960(0063) GS:ffffffff805c2640(0000) knlGS:0000000000000000
Jun  7 14:11:27 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun  7 14:11:27 optimator CR2: 00000000000025b0 CR3: 000000013b2cf000 CR4: 00000000000006e0
Jun  7 14:11:27 optimator Process java (pid: 6759, threadinfo ffff81013bc5a000, task ffff81013e8aee30)
Jun  7 14:11:27 optimator Stack: ffff81013b2cf2a8 00002aabb8a00000 ffff81013f0f1560 ffff81013f463b40 
Jun  7 14:11:27 optimator 0000000000000001 ffffffff8016a575 0000000000000000 ffff81013f463bb0 
Jun  7 14:11:27 optimator 0000000000000000 0000000000000000 
Jun  7 14:11:27 optimator Call Trace:<ffffffff8016a575>{handle_mm_fault+293} <ffffffff801213e9>{do_page_fault+1081}
Jun  7 14:11:27 optimator <ffffffff803d93cf>{thread_return+154} <ffffffff80130a70>{default_wake_function+0}
Jun  7 14:11:27 optimator <ffffffff8010f565>{error_exit+0} 
Jun  7 14:11:27 optimator 
Jun  7 14:11:27 optimator Code: 48 8b 8e b0 25 00 00 76 0d b8 00 00 00 80 eb 10 66 66 90 66 
Jun  7 14:11:27 optimator RIP <ffffffff8016797a>{pte_alloc_map+170} RSP <ffff81013bc5bdb8>
Jun  7 14:11:27 optimator CR2: 00000000000025b0
Jun  7 14:11:28 optimator <1>Unable to handle kernel paging request at 00000000000025b0 RIP: 
Jun  7 14:11:28 optimator <ffffffff8016797a>{pte_alloc_map+170}
Jun  7 14:11:28 optimator PGD 10805e067 PUD 108082067 PMD 0 
Jun  7 14:11:28 optimator Oops: 0000 [2] PREEMPT SMP 
Jun  7 14:11:28 optimator CPU 0 
Jun  7 14:11:28 optimator Modules linked in: smsc47b397 i2c_sensor i2c_isa i2c_core
Jun  7 14:11:28 optimator Pid: 7936, comm: sh Not tainted 2.6.12-rc6
Jun  7 14:11:28 optimator RIP: 0010:[<ffffffff8016797a>] <ffffffff8016797a>{pte_alloc_map+170}
Jun  7 14:11:28 optimator RSP: 0000:ffff81013bc5bdb8  EFLAGS: 00010293
Jun  7 14:11:28 optimator RAX: ffffffff7fffffff RBX: 00002aaaaacc3088 RCX: 0000000000000018
Jun  7 14:11:28 optimator RDX: ffff810107d23000 RSI: 0000000000000000 RDI: ffff81000000e6c0
Jun  7 14:11:28 optimator RBP: ffff810108062ab0 R08: ffff81000000e000 R09: 0000000000000000
Jun  7 14:11:28 optimator R10: 00000000000c1668 R11: 0000000000000000 R12: 0000000000000000
Jun  7 14:11:28 optimator R13: ffff81013ea93240 R14: ffff81013ea932b0 R15: ffff810108062ab0
Jun  7 14:11:28 optimator FS:  00002aaaab0486e0(0000) GS:ffffffff805c2640(0000) knlGS:0000000000000000
Jun  7 14:11:28 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun  7 14:11:28 optimator CR2: 00000000000025b0 CR3: 0000000107d1f000 CR4: 00000000000006e0
Jun  7 14:11:28 optimator Process sh (pid: 7936, threadinfo ffff81013bc5a000, task ffff81013df84750)
Jun  7 14:11:28 optimator Stack: ffff810107d1f2a8 00002aaaaacc3088 ffff81013ed621c8 ffff81013ea93240 
Jun  7 14:11:28 optimator 0000000000000001 ffffffff8016a575 ffff81013ed62218 ffff81013ea932b0 
Jun  7 14:11:28 optimator 0000000000000002 0000000000000000 
Jun  7 14:11:28 optimator Call Trace:<ffffffff8016a575>{handle_mm_fault+293} <ffffffff801213e9>{do_page_fault+1081}
Jun  7 14:11:28 optimator <ffffffff8016c18b>{vma_link+283} <ffffffff8016eb3b>{sys_mprotect+1563}
Jun  7 14:11:28 optimator <ffffffff80251731>{__up_write+49} <ffffffff8010f565>{error_exit+0}
Jun  7 14:11:28 optimator 
Jun  7 14:11:28 optimator 
Jun  7 14:11:28 optimator Code: 48 8b 8e b0 25 00 00 76 0d b8 00 00 00 80 eb 10 66 66 90 66 
Jun  7 14:11:28 optimator RIP <ffffffff8016797a>{pte_alloc_map+170} RSP <ffff81013bc5bdb8>
Jun  7 14:11:28 optimator CR2: 00000000000025b0
-- 
Jacob Martin
