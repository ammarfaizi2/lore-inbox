Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVFJMMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVFJMMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 08:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVFJMMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 08:12:24 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:6281 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S262542AbVFJMLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 08:11:10 -0400
Message-ID: <42A98395.3070805@sw.ru>
Date: Fri, 10 Jun 2005 16:12:05 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Andrew Morton <akpm@osdl.org>, apw@shadowen.org, pazke@donpac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
References: <20050607042931.23f8f8e0.akpm@osdl.org><42A6FF41.5040109@shadowen.org><20050608130117.341fa4ff.akpm@osdl.org><1051200000.1118272473@flay> <20050608162247.2c8f00f0.akpm@osdl.org> <1055500000.1118273677@flay> <42A7ED17.5010707@sw.ru> <577000000.1118324296@[10.10.2.4]>
In-Reply-To: <577000000.1118324296@[10.10.2.4]>
Content-Type: multipart/mixed;
 boundary="------------050408090707010603080100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050408090707010603080100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>>>>>alt+sysrq+p does wierd stuff (is that new patch in your tree Andrew?
>>>>>doesn't seem to inter-react with the other NMI code well)
>>>>
>>>>What patch?
>>>
>>>
>>>Sorry.
>>>
>>>nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch
>>>
>>>It does seem to work. But probably needs some cleanup for the NMI
>>>errors.
>>
>>If you give me to know where the problem come from I can fix it and make a cleanup.
> 
> 
> It gets a lot of the "dazed and confused" errors. Possibly you just need
> to disable that part of the handler?
can you try this cleanup patch?
This fixes the problem for me, though I do no like the way it does so 
very much...

Kirill

> Command> break
> ^@SysRq : Show Regs
> ^M
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 0
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: c040e000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7e3f5a0 CR3: 16dd0300 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c01002c8>] rest_init+0x28/0x2c
> ^M^@ [<c0410899>] start_kernel+0x19d/0x1a0
> ^M^@ Uhhuh. NMI received for unknown reason 00 on CPU 1.
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 16.
> ^M^@Dazed and confused, but trying to continue
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 3.
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 17.
> ^M^@----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 16
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@Dazed and confused, but trying to continue
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 2.
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 18.
> ^M^@Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Dazed and confused, but trying to continue
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 19.
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7420000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 17771800 CR4: 000006b0
> ^M^@Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>]Uhhuh. NMI received for unknown reason 00 on CPU 6.
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 20.
> ^M^@ start_secondary+0x13d/0x140
> ^M^@Dazed and confused, but trying to continue
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 18
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 10.
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7426000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7f25d9c CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>]Uhhuh. NMI received for unknown reason 00 on CPU 29.
> ^M^@ cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 2
> ^M^@ EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7400000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7edeb00 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>]Uhhuh. NMI received for unknown reason 00 on CPU 23.
> ^M^@ start_secondary+0x13d/0x140
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 7.
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 3
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7402000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@CR0: 8005003b CR2: b7f95438 CR3: 17771800 CR4: 000006b0
> ^M^@ [<c0100ca3>]Uhhuh. NMI received for unknown reason 00 on CPU 4.
> ^M^@ cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 17
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 5.
> ^M^@Dazed and confused, but trying to continue
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 14.
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7424000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>]Uhhuh. NMI received for unknown reason 00 on CPU 9.
> ^M^@ cpu_idle+0x7b/0x8c
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 25.
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140Dazed and confused, but trying to continue
> ^M
> ^M^@----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 19
> ^M^@ EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7428000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7f30d9c CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>]Uhhuh. NMI received for unknown reason 00 on CPU 13.
> ^M^@ start_secondary+0x13d/0x140
> ^M^@ Do you have a strange power saving mode enabled?
> ^M^@----------- IPI show regs -----------Uhhuh. NMI received for unknown reason 00 on CPU 8.
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 11.
> ^M^@Dazed and confused, but trying to continue
> ^M^@Dazed and confused, but trying to continue
> ^M^@Dazed and confused, but trying to continue
> ^M
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 20
> ^M^@Dazed and confused, but trying to continue
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 22.
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 26.
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@ESI: d742a000 EDI: c0470300 EBP: c0470300Uhhuh. NMI received for unknown reason 00 on CPU 30.
> ^M^@Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@ DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 21.
> ^M^@ [<c0100ca3>]Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@ cpu_idle+0x7b/0x8c
> ^M^@Dazed and confused, but trying to continue
> ^M^@ [<c010e79d>]Do you have a strange power saving mode enabled?
> ^M^@ start_secondary+0x13d/0x140
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 27.
> ^M^@Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 24.
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 11221, comm:                   cp
> ^M^@EIP: 0060:[<c02efbdc>] CPU: 5
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@EIP is at _spin_lock_irqsave+0x14/0x20
> ^M^@ EFLAGS: 00000286    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@Dazed and confused, but trying to continue
> ^M^@EAX: 00000286 EBX: d6ce4800 ECX: c03cabe0 EDX: c049ba84
> ^M^@ESI: ffffffea EDI: d55f8000 EBP: d55f8000 DS: 007b ES: 007b
> ^M^@Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Dazed and confused, but trying to continue
> ^M^@CR0: 80050033 CR2: bfc7d2fc CR3: 16dd02e0 CR4: 000006b0
> ^M^@ [<c0270377>]Uhhuh. NMI received for unknown reason 00 on CPU 31.
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 12.
> ^M^@ ahc_linux_proc_info+0x27/0x212
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@ [<c0149052>]Do you have a strange power saving mode enabled?
> ^M^@Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@ page_add_anon_rmap+0x62/0x68
> ^M^@ [<c0144358>]Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 15.
> ^M^@Uhhuh. NMI received for unknown reason 00 on CPU 28.
> ^M^@Dazed and confused, but trying to continue
> ^M^@ do_anonymous_page+0x1f0/0x21c
> ^M^@ [<c0144370>]Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@ do_anonymous_page+0x208/0x21c
> ^M^@Dazed and confused, but trying to continue
> ^M^@ [<c01443d9>]Do you have a strange power saving mode enabled?
> ^M^@Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@ do_no_page+0x55/0x3e8
> ^M^@ [<c01372b5>] prep_new_page+0x49/0x50
> ^M^@ [<c0137973>] buffered_rmqueue+0x16f/0x1d0
> ^M^@ [<c0137e1b>] __alloc_pages+0x3bb/0x3c8
> ^M^@ [<c0257cdb>] proc_scsi_read+0x2b/0x44
> ^M^@ [<c0182f28>] proc_file_read+0xec/0x200
> ^M^@ [<c0152ff9>] vfs_read+0x91/0x12c
> ^M^@ [<c01532e4>] sys_read+0x40/0x6c
> ^M^@ [<c0102a19>] syscall_call+0x7/0xb
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 7
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d740c000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 4
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7404000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 080f9c48 CR3: 17771320 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c02efcae>] CPU: 30
> ^M^@EIP is at _spin_lock+0xa/0x10
> ^M^@ EFLAGS: 00000046    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: c1050aa0 EBX: c1050aa0 ECX: d7463ea8 EDX: 00000003
> ^M^@ESI: c10d9620 EDI: c10d9fe0 EBP: d7463eb0 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7eea900 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c011583b>] load_balance+0xcf/0x170
> ^M^@ [<c0115af5>] rebalance_tick+0xe1/0x104
> ^M^@ [<c0115d77>] scheduler_tick+0x97/0x318
> ^M^@ [<c01225b3>] update_process_times+0xef/0x100
> ^M^@ [<c010f5f9>] smp_apic_timer_interrupt+0xd5/0xe4
> ^M^@ [<c0103464>] apic_timer_interrupt+0x1c/0x24
> ^M^@ [<c0100bb0>] default_idle+0x0/0x2c
> ^M^@ [<c0100bd3>] default_idle+0x23/0x2c
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@----------- IPI show regs ----------- 
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c02efb6a>] CPU: 15
> ^M^@EIP is at _spin_trylock+0x6/0x14
> ^M^@ EFLAGS: 00000046    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c1050aa0 ECX: 00000008 EDX: c1050aa0
> ^M^@ESI: c10875a0 EDI: c1087f60 EBP: d741fe84 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0114fda>] double_lock_balance+0x12/0x48
> ^M^@ [<c01157e4>] load_balance+0x78/0x170
> ^M^@ [<c0115af5>] rebalance_tick+0xe1/0x104
> ^M^@ [<c0115d77>] scheduler_tick+0x97/0x318
> ^M^@ [<c01225b3>] update_process_times+0xef/0x100
> ^M^@ [<c010f5f9>] smp_apic_timer_interrupt+0xd5/0xe4
> ^M^@ [<c0103464>] apic_timer_interrupt+0x1c/0x24
> ^M^@ [<c0100bb0>] default_idle+0x0/0x2c
> ^M^@ [<c0100bd3>] default_idle+0x23/0x2c
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 21
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d742c000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 14
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d741c000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7e64070 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 27
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d745c000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7f66d9c CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 8
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d740e000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 080f133c CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 25
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7436000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7f74d9c CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c02efb6a>] CPU: 29
> ^M^@EIP is at _spin_trylock+0x6/0x14
> ^M^@ EFLAGS: 00000046    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000001 EBX: c1050aa0 ECX: 00000008 EDX: c1050aa0
> ^M^@ESI: c10d3ea0 EDI: c10d4860 EBP: d7461e84 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0114fda>] double_lock_balance+0x12/0x48
> ^M^@ [<c01157e4>] load_balance+0x78/0x170
> ^M^@ [<c0115af5>] rebalance_tick+0xe1/0x104
> ^M^@ [<c0115d77>] scheduler_tick+0x97/0x318
> ^M^@ [<c01225b3>] update_process_times+0xef/0x100
> ^M^@ [<c010f5f9>] smp_apic_timer_interrupt+0xd5/0xe4
> ^M^@ [<c0103464>] apic_timer_interrupt+0x1c/0x24
> ^M^@ [<c0100bb0>] default_idle+0x0/0x2c
> ^M^@ [<c0100bd3>] default_idle+0x23/0x2c
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 31
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7464000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 24
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@  EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7434000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7f3cdd8 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 10
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7412000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7ea6920 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 26
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7438000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c01154a3>] CPU: 13
> ^M^@EIP is at find_busiest_group+0x103/0x2f8
> ^M^@ EFLAGS: 00000086    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000005 EBX: 00000005 ECX: c1050aa0 EDX: 00000000
> ^M^@ESI: c04813ac EDI: 00000200 EBP: d741be7c DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7e7e070 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c01157a2>] load_balance+0x36/0x170
> ^M^@ [<c0115af5>] rebalance_tick+0xe1/0x104
> ^M^@ [<c0115d77>] scheduler_tick+0x97/0x318
> ^M^@ [<c01225b3>] update_process_times+0xef/0x100
> ^M^@ [<c010f5f9>] smp_apic_timer_interrupt+0xd5/0xe4
> ^M^@ [<c0103464>] apic_timer_interrupt+0x1c/0x24
> ^M^@ [<c0100bb0>] default_idle+0x0/0x2c
> ^M^@ [<c0100bd3>] default_idle+0x23/0x2c
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 28
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d745e000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c011e897>] CPU: 12
> ^M^@EIP is at __do_softirq+0x47/0x100
> ^M^@ EFLAGS: 00000006    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: c0470380 EBX: c0476020 ECX: 00000030 EDX: c1075ce0
> ^M^@ESI: 00000002 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7f54000 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c011e97f>] do_softirq+0x2f/0x34
> ^M^@ [<c011ea24>] irq_exit+0x34/0x38
> ^M^@ [<c010f601>] smp_apic_timer_interrupt+0xdd/0xe4
> ^M^@ [<c0103464>] apic_timer_interrupt+0x1c/0x24
> ^M^@ [<c0100bb0>] default_idle+0x0/0x2c
> ^M^@ [<c0100bd3>] default_idle+0x23/0x2c
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 9
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7410000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7f1d900 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 11
> ^M^@ EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7414000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 23
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7432000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@----------- IPI show regs ----------- 
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 6
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7408000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7f3cdd8 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@----------- IPI show regs ----------- 
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 22
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: d7430000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: 00000000 CR3: 00474000 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ Dazed and confused, but trying to continue
> ^M^@Do you have a strange power saving mode enabled?
> ^M^@----------- IPI show regs -----------
> ^M^@Pid: 0, comm:              swapper
> ^M^@EIP: 0060:[<c0100bd3>] CPU: 1
> ^M^@EIP is at default_idle+0x23/0x2c
> ^M^@ EFLAGS: 00000246    Not tainted  (2.6.12-rc6-mm1-autokern1)
> ^M^@EAX: 00000000 EBX: c0476020 ECX: c0100bb0 EDX: 003a2f43
> ^M^@ESI: c13fc000 EDI: c0470300 EBP: c0470300 DS: 007b ES: 007b
> ^M^@CR0: 8005003b CR2: b7ee1d9c CR3: 17771640 CR4: 000006b0
> ^M^@ [<c0100ca3>] cpu_idle+0x7b/0x8c
> ^M^@ [<c010e79d>] start_secondary+0x13d/0x140
> ^M^@ ^M
> 
> 
> 
> 
> 
> 


--------------050408090707010603080100
Content-Type: text/plain;
 name="altsysrq-p-cleanup"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="altsysrq-p-cleanup"

--- ./arch/i386/kernel/traps.c.xxx	2005-05-10 18:27:04.000000000 +0400
+++ ./arch/i386/kernel/traps.c	2005-06-10 14:18:32.000000000 +0400
@@ -574,6 +574,14 @@ void die_nmi (struct pt_regs *regs, cons
 	do_exit(SIGSEGV);
 }
 
+static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
+{
+	return 0;
+}
+ 
+static nmi_callback_t nmi_callback = dummy_nmi_callback;
+static nmi_callback_t nmi_ipi_callback = dummy_nmi_callback;
+ 
 static void default_do_nmi(struct pt_regs * regs)
 {
 	unsigned char reason = 0;
@@ -596,6 +604,9 @@ static void default_do_nmi(struct pt_reg
 			return;
 		}
 #endif
+		if (nmi_ipi_callback != dummy_nmi_callback)
+			return;
+
 		unknown_nmi_error(reason, regs);
 		return;
 	}
@@ -612,14 +623,6 @@ static void default_do_nmi(struct pt_reg
 	reassert_nmi();
 }
 
-static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
-{
-	return 0;
-}
- 
-static nmi_callback_t nmi_callback = dummy_nmi_callback;
-static nmi_callback_t nmi_ipi_callback = dummy_nmi_callback;
- 
 fastcall void do_nmi(struct pt_regs * regs, long error_code)
 {
 	int cpu;

--------------050408090707010603080100--

