Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbUKBWmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUKBWmv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbUKBWmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:42:49 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:22170 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262628AbUKBWjw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:39:52 -0500
Message-ID: <41881B28.5010109@free.fr>
Date: Wed, 03 Nov 2004 00:41:28 +0100
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6]
References: <1099171567.1424.9.camel@krustophenia.net> <20041030233849.498fbb0f@mango.fruits.de> <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu> <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu>
In-Reply-To: <20041101134235.GA18009@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>i've uploaded a fixed kernel (-V0.6.8) to :
>
>http://redhat.com/~mingo/realtime-preempt/ <http://redhat.com/%7Emingo/realtime-preempt/>
>
>  
>

I have thousands of the following BUG with V0.6.9

Nov 2 23:10:14 tigre02 kernel: printk: 6553 messages suppressed.
Nov 2 23:10:14 tigre02 kernel: BUG: using smp_processor_id() in 
preemptible [00000001] code: udev/1159
Nov 2 23:10:14 tigre02 kernel: caller is store_stackinfo+0x5d/0xb0
Nov 2 23:10:14 tigre02 kernel: [<c0106503>] dump_stack+0x23/0x30 (20)
Nov 2 23:10:14 tigre02 kernel: [<c011f177>] smp_processor_id+0xb7/0xc0 (32)
Nov 2 23:10:14 tigre02 kernel: [<c0159a5d>] store_stackinfo+0x5d/0xb0 (28)
Nov 2 23:10:14 tigre02 kernel: [<c015b6ba>] 
cache_free_debugcheck+0x1aa/0x390 (52)
Nov 2 23:10:14 tigre02 kernel: [<c015c656>] kmem_cache_free+0x46/0xf0 (32)
Nov 2 23:10:14 tigre02 kernel: [<c01731f1>] sys_open+0x81/0xb0 (32)
Nov 2 23:10:14 tigre02 kernel: [<c0105561>] sysenter_past_esp+0x52/0x71 
(-8124)
Nov 2 23:10:14 tigre02 kernel: ---------------------------
Nov 2 23:10:14 tigre02 kernel: | preempt count: 00000002 ]
Nov 2 23:10:14 tigre02 kernel: | 2-level deep critical section nesting:
Nov 2 23:10:14 tigre02 kernel: ----------------------------------------
Nov 2 23:10:14 tigre02 kernel: .. [<c011f11f>] .... 
smp_processor_id+0x5f/0xc0
Nov 2 23:10:14 tigre02 kernel: .....[<c0159a5d>] .. ( <= 
store_stackinfo+0x5d/0xb0)
Nov 2 23:10:14 tigre02 kernel: .. [<c014083d>] .... print_traces+0x1d/0x60
Nov 2 23:10:14 tigre02 kernel: .....[<c0106503>] .. ( <= 
dump_stack+0x23/0x30)
Nov 2 23:10:14 tigre02 kernel:
Nov 2 23:10:14 tigre02 kernel: printk: 6548 messages suppressed.
Nov 2 23:10:14 tigre02 kernel: BUG: using smp_processor_id() in 
preemptible [00000001] code: udev/1299
Nov 2 23:10:14 tigre02 kernel: caller is store_stackinfo+0x5d/0xb0
Nov 2 23:10:14 tigre02 kernel: [<c0106503>] dump_stack+0x23/0x30 (20)
Nov 2 23:10:14 tigre02 kernel: [<c011f177>] smp_processor_id+0xb7/0xc0 (32)
Nov 2 23:10:14 tigre02 kernel: [<c0159a5d>] store_stackinfo+0x5d/0xb0 (28)
Nov 2 23:10:14 tigre02 kernel: [<c015b6ba>] 
cache_free_debugcheck+0x1aa/0x390 (52)
Nov 2 23:10:14 tigre02 kernel: [<c015c656>] kmem_cache_free+0x46/0xf0 (32)
Nov 2 23:10:14 tigre02 kernel: [<c01ab892>] proc_destroy_inode+0x22/0x30 
(16)
Nov 2 23:10:14 tigre02 kernel: [<c01908c1>] destroy_inode+0x41/0x90 (24)
Nov 2 23:10:14 tigre02 kernel: [<c01920cb>] iput+0x6b/0xb0 (28)
Nov 2 23:10:14 tigre02 kernel: [<c018e638>] dput+0x138/0x2d0 (32)
Nov 2 23:10:14 tigre02 kernel: [<c0183ed2>] link_path_walk+0x8c2/0xff0 (108)
Nov 2 23:10:14 tigre02 kernel: [<c018495c>] path_lookup+0xac/0x220 (36)
Nov 2 23:10:14 tigre02 kernel: [<c01852d2>] open_namei+0x92/0x6f0 (60)
Nov 2 23:10:14 tigre02 kernel: [<c0172cc6>] filp_open+0x46/0x70 (92)
Nov 2 23:10:14 tigre02 kernel: [<c01731bb>] sys_open+0x4b/0xb0 (32)
Nov 2 23:10:14 tigre02 kernel: [<c0105561>] sysenter_past_esp+0x52/0x71 
(-8124)
Nov 2 23:10:14 tigre02 kernel: ---------------------------
Nov 2 23:10:14 tigre02 kernel: | preempt count: 00000002 ]
Nov 2 23:10:14 tigre02 kernel: | 2-level deep critical section nesting:
Nov 2 23:10:14 tigre02 kernel: ----------------------------------------
Nov 2 23:10:14 tigre02 kernel: .. [<c011f11f>] .... 
smp_processor_id+0x5f/0xc0
Nov 2 23:10:14 tigre02 kernel: .....[<c0159a5d>] .. ( <= 
store_stackinfo+0x5d/0xb0)
Nov 2 23:10:14 tigre02 kernel: .. [<c014083d>] .... print_traces+0x1d/0x60
Nov 2 23:10:14 tigre02 kernel: .....[<c0106503>] .. ( <= 
dump_stack+0x23/0x30)
Nov 2 23:10:14 tigre02 kernel:
Nov 2 23:10:14 tigre02 kernel: Real Time Clock Driver v1.12
Nov 2 23:10:14 tigre02 kernel: thinkpad_acpi: ACPI IBM Thinkpad Fn+Fx 
key driver version 1.1
Nov 2 23:10:14 tigre02 kernel: USB Universal Host Controller Interface 
driver v2.2
Nov 2 23:10:14 tigre02 kernel: printk: 5080 messages suppressed.
Nov 2 23:10:14 tigre02 kernel: BUG: using smp_processor_id() in 
preemptible [00000001] code: modprobe/1386
Nov 2 23:10:14 tigre02 kernel: caller is store_stackinfo+0x5d/0xb0
Nov 2 23:10:14 tigre02 kernel: [<c0106503>] dump_stack+0x23/0x30 (20)
Nov 2 23:10:14 tigre02 kernel: [<c011f177>] smp_processor_id+0xb7/0xc0 (32)
Nov 2 23:10:14 tigre02 kernel: [<c0159a5d>] store_stackinfo+0x5d/0xb0 (28)
Nov 2 23:10:14 tigre02 kernel: [<c015b6ba>] 
cache_free_debugcheck+0x1aa/0x390 (52)
Nov 2 23:10:14 tigre02 kernel: [<c015c7e1>] kfree+0x71/0x120 (40)
Nov 2 23:10:14 tigre02 kernel: [<c02cf7c8>] 
acpi_ut_free_and_track+0x71/0xda (40)
Nov 2 23:10:14 tigre02 kernel: [<c02c3222>] 
acpi_ns_delete_children+0xe9/0x146 (56)
Nov 2 23:10:14 tigre02 kernel: [<c02c331a>] 
acpi_ns_delete_namespace_subtree+0x9b/0xaf (44)
Nov 2 23:10:14 tigre02 kernel: [<c02af59e>] 
acpi_ds_terminate_control_method+0x10d/0x1bb (40)
Nov 2 23:10:14 tigre02 kernel: [<c02c7a37>] 
acpi_ps_parse_aml+0x1f5/0x2be (48)
Nov 2 23:10:14 tigre02 kernel: [<c02c87a7>] acpi_psx_execute+0x26f/0x2b4 
(44)
Nov 2 23:10:14 tigre02 kernel: [<c02c38f7>] 
acpi_ns_execute_control_method+0xb9/0xf6 (40)
Nov 2 23:10:14 tigre02 kernel: [<c02c380f>] 
acpi_ns_evaluate_by_handle+0xe5/0x114 (40)

Hope this help

Remi



