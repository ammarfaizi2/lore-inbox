Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbVISS43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVISS43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVISS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:56:29 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:36493 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932572AbVISS42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:56:28 -0400
Message-ID: <432F09DA.7050408@vc.cvut.cz>
Date: Mon, 19 Sep 2005 20:56:26 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Christoph Lameter <christoph@lameter.com>
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
References: <4329A6A3.7080506@vc.cvut.cz>	<20050916023005.4146e499.akpm@osdl.org>	<432AA00D.4030706@vc.cvut.cz>	<20050916230809.789d6b0b.akpm@osdl.org>	<432EE103.5020105@vc.cvut.cz> <20050919112912.18daf2eb.akpm@osdl.org>
In-Reply-To: <20050919112912.18daf2eb.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
> 
>>Andrew Morton wrote:
>>
>>>Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>>>
>>>
>>>>Andrew Morton wrote:
>>>>
>>>>>Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>>>>>
>>>>>
>>>>>>  so now once crashes on UP system were sorted out, I tried to
>>>>>>put new kernel on my SMP host - and sorry to say, but it does not
>>>>>>seem to work as advertised :-(
>>>>>
>>>>>.config (again), please.
>>>>
>>>>Any SMP with NUMA.  One which I'm trying to debug now is attached.
>>>>It is available at http://vana.vc.cvut.cz/config as well.
>>>
>>>I can get 2.6.14-rc1 to crash with your .config, but current -linus is OK.
>>
>>It still dies for me, with current git (tree 7513cdadc661cfe0bd1625145a4876e54df191ca,
>>commit 6c0741fbdee5bd0f8ed13ac287c4ab18e8ba7d83).  Config is available at
>>http://platan.vc.cvut.cz/config-vana.txt.  Box is dual opteron Tyan K8W, S2885.
>>
>>...
>>
>>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
>>----------- [cut here ] --------- [please bite here ] ---------
>>Kernel BUG at mm/slab.c:1849
>>invalid operand: 0000 [1] SMP
>>CPU 0
>>Modules linked in:
>>Pid: 8, comm: events/0 Not tainted 2.6.14-rc1-6c07 #1
>>RIP: 0010:[<ffffffff8016d316>] <ffffffff8016d316>{free_block+294}
>>RSP: 0000:ffff81007ff21d88  EFLAGS: 00010002
>>RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000310
>>RDX: 0000000000000000 RSI: ffff81007ffddd10 RDI: ffff81007ffda080
>>RBP: ffff81007ffde000 R08: ffff81003ffa0d50 R09: 0000000000000000
>>R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81007ffc9b50
>>R13: ffff81007ffde048 R14: ffff81007ffda080 R15: ffff81007ffda080
>>FS:  0000000000000000(0000) GS:ffffffff805f2800(0000) knlGS:0000000000000000
>>CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
>>CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
>>Process events/0 (pid: 8, threadinfo ffff81007ff20000, task ffff81003ff8c790)
>>Stack: 0000000000000000 0000000000000000 0000000000000292 hda: _NEC DVD_RW ND-3500AG, ATAPI CD/DVD-ROM drive
>>0000000200000000
>>        ffff81007ffddd10 ffff81007ffddd10 ffff81007ffddce8 0000000000000002
>>        0000000000000000 ffff81007ffda080
>>Call Trace:<ffffffff8016e8b7>{drain_array_locked+167} <ffffffff8016e9f7>{cache_reap+231}
>>        <ffffffff80131e23>{__wake_up+67} <ffffffff8016e910>{cache_reap+0}
>>        <ffffffff8014930c>{worker_thread+476} <ffffffff80131d60>{default_wake_function+0}
>>        <ffffffff80131d60>{default_wake_function+0} <ffffffff80149130>{worker_thread+0}
>>        <ffffffff8014db82>{kthread+146} <ffffffff8010ec22>{child_rip+8}
>>        <ffffffff80149130>{worker_thread+0} <ffffffff8014daf0>{kthread+0}
>>        <ffffffff8010ec1a>{child_rip+0}
>>
>>Code: 0f 0b 68 9d 26 3d 80 c2 39 07 48 89 ee 4c 89 ff 4c 8d 75 30
>>RIP <ffffffff8016d316>{free_block+294} RSP <ffff81007ff21d88>
>>  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> 
> 
> Well.  The CPU_UP_CANCELED locking in cpuup_callback() looks borked to me -
> it takes cachep->nodelists[node]->list_lock and then calls
> drain_alien_cache() which appears to take the same lock.  But that's not
> the problem here.
> 
> The code in cache_reap() recalculates numa_node_id() multiple times, so if
> the caller changes CPUs then this assertion will trigger.  However it's
> running under keventd here, which is pinned to a single CPU.  Still, it
> would be useful if you could try putting preempt_disable()s in
> cache_reap(), or change cache_reap() to evaluate numa_node_id() just the
> once, and cache that in a local variable.
> 
> I wonder why numa_node_id() uses raw_smp_processor_id()?  That's just
> asking for preempt non-atomicity bugs.

I've thought that this is problem, but as far as I can tell while this is
problem it does not happen here.  Just free_block() finds that pointer it
got from caller belongs to the slab that belongs to the CPU#1/node#1
while caller obtained lock on CPU#0/node#0 structures.  Which suggests
that drain_array_locked() was issued with node #0 while array_cache->entry
it got contains blocks which belong to node #1.  Which I cannot explain.
								Petr

