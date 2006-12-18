Return-Path: <linux-kernel-owner+w=401wt.eu-S1754150AbWLRP3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbWLRP3u (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbWLRP3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:29:50 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36522 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154AbWLRP3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:29:49 -0500
Date: Mon, 18 Dec 2006 16:27:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: bug: depca_module_init() cleanup error
Message-ID: <20061218152713.GA16208@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


while doing an allyesconfig bootup on a PC the depca driver triggered 
the crash below.

	Ingo

------------------>
Calling initcall 0xc1ea0506: depca_module_init+0x0/0xd7()
PM: Adding info for platform:depca.0
depca: probe of depca.0 failed with error -16
PM: Removing info for platform:depca.0
kfree_debugcheck: out of range ptr 300h.
BUG at mm/slab.c:2910!
stopped custom tracer.
------------[ cut here ]------------
kernel BUG at mm/slab.c:2910!
invalid opcode: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c0194367>]    Not tainted VLI
EFLAGS: 00010286   (2.6.19.1-rt16 #494)
EIP is at kfree_debugcheck+0x52/0xa9
eax: 0000001a   ebx: 00040000   ecx: c01356a9   edx: 00000001
esi: 00000300   edi: 00000300   ebp: f7c21ec4   esp: f7c21eb0
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process swapper (pid: 1, ti=f7c21000 task=f7c30c50 task.ti=f7c21000)
Stack: c14f9371 c150c05d 00000b5e f772aea0 c1fd4ea0 f7c21ee8 c01953b2 00000300 
       fffffff0 f772b080 00000000 f772aea0 f772b080 c1902880 f7c21ef8 c06e3d0e 
       00000300 c19029f0 f7c21f0c c06dfcd9 f772aea8 c06dfe6e f772b080 f7c21f28 
Call Trace:
 [<c0106273>] show_trace_log_lvl+0x34/0x4a
 [<c0106332>] show_stack_log_lvl+0xa9/0xb9
 [<c010663e>] show_registers+0x1f5/0x290
 [<c0106a3b>] die+0x1de/0x2db
 [<c13deb95>] do_trap+0xac/0xca
 [<c0106f73>] do_invalid_op+0xae/0xb8
 [<c13de8a1>] error_code+0x39/0x40
 [<c01953b2>] kfree+0x42/0xce
 [<c06e3d0e>] platform_device_release+0x1e/0x38
 [<c06dfcd9>] device_release+0x36/0x6b
 [<c04f091c>] kobject_cleanup+0x4d/0x74
 [<c04f095a>] kobject_release+0x17/0x19
 [<c04f0f7a>] kref_put+0x5b/0x69
 [<c04f02b6>] kobject_put+0x24/0x26
 [<c06dfe6e>] put_device+0x1d/0x1f
 [<c06e3cee>] platform_device_put+0x1b/0x1d
 [<c1ea0598>] depca_module_init+0x92/0xd7
 [<c0100567>] init+0x178/0x451
 [<c0105feb>] kernel_thread_helper+0x7/0x10
 =======================
Code: 24 e7 c3 50 c1 e8 00 17 fa ff e8 49 08 fd ff c7 44 24 08 5e 0b 00 00 c7 44 24 04 5d c0 50 c1 c7 04 24 71 93 4f c1 e8 df 16 fa ff <0f> 0b 5e 0b 5d c0 50 c1 6b c3 74 03 05 10 f2 35 c2 8b 00 84 c0 
EIP: [<c0194367>] kfree_debugcheck+0x52/0xa9 SS:ESP 0068:f7c21eb0
 <0>Kernel panic - not syncing: Attempted to kill init!
 [<c0106273>] show_trace_log_lvl+0x34/0x4a
 [<c01063a9>] show_trace+0x2c/0x2e
 [<c01063d6>] dump_stack+0x2b/0x2d
 [<c0134c93>] panic+0x67/0x124
 [<c0137a0d>] do_exit+0xb8/0x9ed
 [<c0106b30>] die+0x2d3/0x2db
 [<c13deb95>] do_trap+0xac/0xca
 [<c0106f73>] do_invalid_op+0xae/0xb8
 [<c13de8a1>] error_code+0x39/0x40
 [<c01953b2>] kfree+0x42/0xce
 [<c06e3d0e>] platform_device_release+0x1e/0x38
 [<c06dfcd9>] device_release+0x36/0x6b
 [<c04f091c>] kobject_cleanup+0x4d/0x74
 [<c04f095a>] kobject_release+0x17/0x19
 [<c04f0f7a>] kref_put+0x5b/0x69
 [<c04f02b6>] kobject_put+0x24/0x26
 [<c06dfe6e>] put_device+0x1d/0x1f
 [<c06e3cee>] platform_device_put+0x1b/0x1d
 [<c1ea0598>] depca_module_init+0x92/0xd7
 [<c0100567>] init+0x178/0x451
 [<c0105feb>] kernel_thread_helper+0x7/0x10
 =======================
 
