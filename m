Return-Path: <linux-kernel-owner+w=401wt.eu-S1754158AbWLRPeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbWLRPeX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754157AbWLRPeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:34:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33599 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754158AbWLRPeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:34:21 -0500
Date: Mon, 18 Dec 2006 16:31:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: bug: crash in adummy_init()
Message-ID: <20061218153145.GA17449@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


crash in adummy_init() - allyesconfig bootup.

	Ingo

---------------->
Calling initcall 0xc1eb1f7e: adummy_init+0x0/0xb9()
adummy: version 1.0
swapper/1[CPU#0]: BUG in kref_get at lib/kref.c:32
 [<c0106273>] show_trace_log_lvl+0x34/0x4a
 [<c01063a9>] show_trace+0x2c/0x2e
 [<c01063d6>] dump_stack+0x2b/0x2d
 [<c0135acb>] __WARN_ON+0x63/0x75
 [<c04f0fb9>] kref_get+0x31/0x3c
 [<c04f028c>] kobject_get+0x1c/0x22
 [<c06e296a>] class_get+0x1d/0x2d
 [<c06e33be>] class_device_add+0x52/0x45c
 [<c06e37e5>] class_device_register+0x1d/0x21
 [<c136b57c>] atm_register_sysfs+0x5a/0xbf
 [<c136b11d>] atm_dev_register+0x1e3/0x245
 [<c1eb1ff0>] adummy_init+0x72/0xb9
 [<c0100567>] init+0x178/0x451
 [<c0105feb>] kernel_thread_helper+0x7/0x10
 =======================
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000064
 printing eip:
c01e318f
*pde = 01fd4001
stopped custom tracer.
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c01e318f>]    Not tainted VLI
EFLAGS: 00010246   (2.6.19.1-rt16 #495)
EIP is at create_dir+0x14/0x1e4
eax: f76d1374   ebx: f76d1374   ecx: 00000008   edx: 00000000
esi: f76d1440   edi: fffffffe   ebp: f7c1ae98   esp: f7c1ae78
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process swapper (pid: 1, ti=f7c1a000 task=f7c2ec50 task.ti=f7c1a000)
Stack: 00000001 c13db5aa c1900e70 00000246 f7c1aea0 f76d1370 f76d1440 fffffffe 
       f7c1aeb8 c01e33da f76d1370 00000000 f76d1374 f7c1aeb0 00000000 f76d1370 
       f7c1aee0 c04f0611 f76d1370 c19bfb14 c1900e68 c1bfeb14 f7c1aef0 f76d1368 
Call Trace:
 [<c0106273>] show_trace_log_lvl+0x34/0x4a
 [<c0106332>] show_stack_log_lvl+0xa9/0xb9
 [<c010663e>] show_registers+0x1f5/0x290
 [<c0106a3b>] die+0x1de/0x2db
 [<c13df0fd>] do_page_fault+0x5a3/0x68c
 [<c13dd2a9>] error_code+0x39/0x40
 [<c01e33da>] sysfs_create_dir+0x7b/0x96
 [<c04f0611>] kobject_add+0xcd/0x187
 [<c06e3421>] class_device_add+0xb5/0x45c
 [<c06e37e5>] class_device_register+0x1d/0x21
 [<c136b57c>] atm_register_sysfs+0x5a/0xbf
 [<c136b11d>] atm_dev_register+0x1e3/0x245
 [<c1eb1ff0>] adummy_init+0x72/0xb9
 [<c0100567>] init+0x178/0x451
 [<c0105feb>] kernel_thread_helper+0x7/0x10
 =======================
Code: 9f ac 00 00 00 c7 87 a4 00 00 00 fc 2b 82 c1 83 c4 0c 5b 5e 5f 5d c3 55 89 e5 57 56 53 83 ec 14 e8 73 bc f3 ff 8b 55 0c 8b 5d 10 <8b> 42 64 89 df 05 cc 00 00 00 e8 ab 89 1f 01 31 c0 83 c9 ff f2 
EIP: [<c01e318f>] create_dir+0x14/0x1e4 SS:ESP 0068:f7c1ae78
 <0>Kernel panic - not syncing: Attempted to kill init!
 [<c0106273>] show_trace_log_lvl+0x34/0x4a
 [<c01063a9>] show_trace+0x2c/0x2e
 [<c01063d6>] dump_stack+0x2b/0x2d
 [<c0134c93>] panic+0x67/0x124
 [<c0137a0d>] do_exit+0xb8/0x9ed
 [<c0106b30>] die+0x2d3/0x2db
 [<c13df0fd>] do_page_fault+0x5a3/0x68c
 [<c13dd2a9>] error_code+0x39/0x40
 [<c01e33da>] sysfs_create_dir+0x7b/0x96
 [<c04f0611>] kobject_add+0xcd/0x187
 [<c06e3421>] class_device_add+0xb5/0x45c
 [<c06e37e5>] class_device_register+0x1d/0x21
 [<c136b57c>] atm_register_sysfs+0x5a/0xbf
 [<c136b11d>] atm_dev_register+0x1e3/0x245
 [<c1eb1ff0>] adummy_init+0x72/0xb9
 [<c0100567>] init+0x178/0x451
 [<c0105feb>] kernel_thread_helper+0x7/0x10
 =======================
 
