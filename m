Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269711AbTGVGka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 02:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269750AbTGVGka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 02:40:30 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:13696 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S269711AbTGVGkY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 02:40:24 -0400
From: Nicolas <linux@1g6.biz>
To: Roger Luethi <rl@hellgate.ch>, Douglas J Hunley <doug@hunley.homeip.net>
Subject: Re: 2.6.0-test1: illegal context call in slab.c
Date: Tue, 22 Jul 2003 08:55:24 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200307211129.02337.doug@hunley.homeip.net> <20030721221636.GA12277@k3.hellgate.ch>
In-Reply-To: <20030721221636.GA12277@k3.hellgate.ch>
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200307220855.24582.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I had very similar oops, maybe experts are interrested in, but
it was in 2.5.74 or 2.5.75 (11 Jul)
Some points I am suspicious about my oops :
	I have Highmem,
	snmpd running,
	reiserfs, 
	gcc  3.2.2,
	acpi,
	IO-APIC on sis648,
	Mandrake 9.1 crontabs
	sis900 and epro100

Regards.

Nicolas.


Jul 11 21:14:12 hal9003 kernel:  printing eip:
Jul 11 21:14:12 hal9003 kernel: c0135754
Jul 11 21:14:12 hal9003 kernel: Oops: 0000 [#1]
Jul 11 21:14:12 hal9003 kernel: CPU:    0
Jul 11 21:14:12 hal9003 kernel: EIP:    0060:[__kmalloc+94/414]    Not tainted
Jul 11 21:14:12 hal9003 kernel: EIP:    0060:[<c0135754>]    Not tainted
Jul 11 21:14:12 hal9003 kernel: EFLAGS: 00010046
Jul 11 21:14:12 hal9003 kernel: EIP is at __kmalloc+0x5e/0x19e
Jul 11 21:14:12 hal9003 kernel: eax: f7b7fbc0   ebx: f7b7fbc0   ecx: 00003fa0   
edx: 00000000
Jul 11 21:14:12 hal9003 kernel: esi: 00003f00   edi: 00000246   ebp: e6387d18   
esp: e6387cf8
Jul 11 21:14:12 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Jul 11 21:14:12 hal9003 kernel: Process kdeinit (pid: 3984, 
threadinfo=e6386000 task=f092f380)
Jul 11 21:14:12 hal9003 kernel: Stack: f7b7fbc0 000000d0 0000005a c023a1b1 
f725c570 f725c570 00003f00 f3fe61e4
Jul 11 21:14:12 hal9003 kernel:        e6387d38 c023a1d6 00003fa0 000000d0 
00000000 ffffffe0 00000000 f3fe61e4
Jul 11 21:14:12 hal9003 kernel:        e6387d64 c0239aa9 00003f00 000000d0 
e6386000 e6387d68 00000282 f11acaac
Jul 11 21:14:12 hal9003 kernel: Call Trace:
Jul 11 21:14:12 hal9003 kernel:  [alloc_skb+35/225] alloc_skb+0x23/0xe1
Jul 11 21:14:12 hal9003 kernel:  [<c023a1b1>] alloc_skb+0x23/0xe1
Jul 11 21:14:12 hal9003 kernel:  [alloc_skb+72/225] alloc_skb+0x48/0xe1
Jul 11 21:14:12 hal9003 kernel:  [<c023a1d6>] alloc_skb+0x48/0xe1
Jul 11 21:14:12 hal9003 kernel:  [sock_alloc_send_pskb+198/489] 
sock_alloc_send_pskb+0xc6/0x1e9
Jul 11 21:14:12 hal9003 kernel:  [<c0239aa9>] sock_alloc_send_pskb+0xc6/0x1e9
Jul 11 21:14:12 hal9003 kernel:  [sock_alloc_send_skb+46/50] 
sock_alloc_send_skb+0x2e/0x32
Jul 11 21:14:12 hal9003 kernel:  [<c0239bfa>] sock_alloc_send_skb+0x2e/0x32
Jul 11 21:14:12 hal9003 kernel:  [unix_stream_sendmsg+394/926] 
unix_stream_sendmsg+0x18a/0x39e
Jul 11 21:14:12 hal9003 kernel:  [<c028dafd>] unix_stream_sendmsg+0x18a/0x39e
Jul 11 21:14:12 hal9003 kernel:  [sock_sendmsg+146/175] sock_sendmsg+0x92/0xaf
Jul 11 21:14:12 hal9003 kernel:  [<c0236dd0>] sock_sendmsg+0x92/0xaf
Jul 11 21:14:12 hal9003 kernel:  [__rmqueue+207/288] __rmqueue+0xcf/0x120
Jul 11 21:14:12 hal9003 kernel:  [<c0131c31>] __rmqueue+0xcf/0x120
Jul 11 21:14:12 hal9003 kernel:  [buffered_rmqueue+160/265] 
buffered_rmqueue+0xa0/0x109
Jul 11 21:14:12 hal9003 kernel:  [<c0131e75>] buffered_rmqueue+0xa0/0x109
Jul 11 21:14:12 hal9003 kernel:  [__alloc_pages+131/770] 
__alloc_pages+0x83/0x302
Jul 11 21:14:12 hal9003 kernel:  [<c0131f61>] __alloc_pages+0x83/0x302
Jul 11 21:14:12 hal9003 kernel:  [sock_readv_writev+113/156] 
sock_readv_writev+0x71/0x9c
Jul 11 21:14:12 hal9003 kernel:  [<c023712b>] sock_readv_writev+0x71/0x9c
Jul 11 21:14:12 hal9003 kernel:  [sock_writev+74/81] sock_writev+0x4a/0x51
Jul 11 21:14:12 hal9003 kernel:  [<c02371f1>] sock_writev+0x4a/0x51
Jul 11 21:14:12 hal9003 kernel:  [do_readv_writev+348/648] 
do_readv_writev+0x15c/0x288
Jul 11 21:14:12 hal9003 kernel:  [<c0147d56>] do_readv_writev+0x15c/0x288
Jul 11 21:14:12 hal9003 kernel:  [update_wall_time+15/58] 
update_wall_time+0xf/0x3a
Jul 11 21:14:12 hal9003 kernel:  [<c01207f3>] update_wall_time+0xf/0x3a
Jul 11 21:14:12 hal9003 kernel:  [do_timer+223/228] do_timer+0xdf/0xe4
Jul 11 21:14:12 hal9003 kernel:  [<c0120beb>] do_timer+0xdf/0xe4
Jul 11 21:14:12 hal9003 kernel:  [vfs_writev+95/99] vfs_writev+0x5f/0x63
Jul 11 21:14:12 hal9003 kernel:  [<c0147f44>] vfs_writev+0x5f/0x63
Jul 11 21:14:12 hal9003 kernel:  [sys_writev+63/93] sys_writev+0x3f/0x5d
Jul 11 21:14:12 hal9003 kernel:  [<c0147fe4>] sys_writev+0x3f/0x5d
Jul 11 21:14:12 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 11 21:14:12 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
Jul 11 21:14:12 hal9003 kernel:
Jul 11 21:14:12 hal9003 kernel: Code: 8b 02 85 c0 0f 84 0d 01 00 00 ff 83 90 
00 00 00 8b 02 c7 42
Jul 12 07:45:01 hal9003 kernel: general protection fault: 5c3c [#2]
Jul 12 07:45:01 hal9003 kernel: CPU:    0
Jul 12 07:45:01 hal9003 kernel: EIP:    0060:[dentry_open+134/440]    Not 
tainted
Jul 12 07:45:01 hal9003 kernel: EIP:    0060:[<c0146d1a>]    Not tainted
Jul 12 07:45:01 hal9003 kernel: EFLAGS: 00010286
Jul 12 07:45:01 hal9003 kernel: EIP is at dentry_open+0x86/0x1b8
Jul 12 07:45:01 hal9003 kernel: eax: c02e9960   ebx: f62b5bf4   ecx: 00000000   
edx: f62b5c3c
Jul 12 07:45:01 hal9003 kernel: esi: dff3ce60   edi: f7ff66a4   ebp: d7eb9f50   
esp: d7eb9f38
Jul 12 07:45:01 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Jul 12 07:45:01 hal9003 kernel: Process mrtg (pid: 32339, threadinfo=d7eb8000 
task=f6041880)
Jul 12 07:45:01 hal9003 kernel: Stack: f62b5c3c dff3ceec ffffffe9 00008000 
00008000 d4639000 d7eb9f9c c0146c92
Jul 12 07:45:01 hal9003 kernel:        dd971e20 f7ff66a4 00008000 d7eb9f68 
dd971e20 f7ff66a4 00001000 fffffff4
Jul 12 07:45:01 hal9003 kernel:        00000006 00000101 00000001 00008001 
00000000 00000006 d4639000 00008000
Jul 12 07:45:01 hal9003 kernel: Call Trace:
Jul 12 07:45:01 hal9003 kernel:  [filp_open+98/100] filp_open+0x62/0x64
Jul 12 07:45:01 hal9003 kernel:  [<c0146c92>] filp_open+0x62/0x64
Jul 12 07:45:01 hal9003 kernel:  [sys_open+85/133] sys_open+0x55/0x85
Jul 12 07:45:01 hal9003 kernel:  [<c014704f>] sys_open+0x55/0x85
Jul 12 07:45:01 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 12 07:45:01 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
Jul 12 07:45:01 hal9003 kernel:
Jul 12 07:45:01 hal9003 kernel: Code: 07 84 1e 01 00 00 8b 00 ba 01 00 00 00 
85 c0 74 0f 83 38 02
Jul 12 10:18:22 hal9003 kernel: Emergency Sync complete
Jul 12 10:19:15 hal9003 kernel:  printing eip:
Jul 12 10:19:15 hal9003 kernel: 78116ef1
Jul 12 10:19:15 hal9003 kernel: Oops: 0000 [#3]
Jul 12 10:19:15 hal9003 kernel: CPU:    0
Jul 12 10:19:15 hal9003 kernel: EIP:    0060:[<78116ef1>]    Not tainted
Jul 12 10:19:15 hal9003 kernel: EFLAGS: 00010047
Jul 12 10:19:15 hal9003 kernel: EIP is at 0x78116ef1
Jul 12 10:19:15 hal9003 kernel: eax: 00000088   ebx: e39441dc   ecx: c02e00c0   
edx: 00000027
Jul 12 10:19:15 hal9003 kernel: esi: f7d38780   edi: c02de788   ebp: e0ba7fbc   
esp: e0ba7f9c
Jul 12 10:19:15 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Jul 12 10:19:15 hal9003 kernel: Process kdeinit (pid: 4219, 
threadinfo=e0ba6000 task=f626f300)
Jul 12 10:19:15 hal9003 kernel: Stack: c0147abc f2721f3c 08067520 00000134 
f626f300 00000003 08067520 08066fe0
Jul 12 10:19:15 hal9003 kernel:        e0ba6000 c010900a 00000003 08067520 
00000134 08067520 08066fe0 bfffec38
Jul 12 10:19:15 hal9003 kernel:        00000134 c010007b 0000007b 00000004 
40f15728 00000073 00000246 bfffec18
Jul 12 10:19:15 hal9003 kernel: Call Trace:
Jul 12 10:19:15 hal9003 kernel:  [sys_write+63/93] sys_write+0x3f/0x5d
Jul 12 10:19:15 hal9003 kernel:  [<c0147abc>] sys_write+0x3f/0x5d
Jul 12 10:19:15 hal9003 kernel:  [work_resched+5/22] work_resched+0x5/0x16
Jul 12 10:19:15 hal9003 kernel:  [<c010900a>] work_resched+0x5/0x16
Jul 12 10:19:15 hal9003 kernel:
Jul 12 10:19:15 hal9003 kernel: Code:  Bad EIP value.




Le Mardi 22 Juillet 2003 00:16, Roger Luethi a écrit :
> On Mon, 21 Jul 2003 11:28:55 -0400, Douglas J Hunley wrote:
> > Issues with the kernel? Or is it the nvidia module? Thanks.
>
> Not nvidia this time. It seems to be the kernel proper. My vanilla kernel
> gave me the same warning:
>
> Debug: sleeping function called from illegal context at mm/slab.c:1811
> Call Trace:
>  [<c011e85c>] __might_sleep+0x5c/0x60
>  [<c0151204>] kmem_cache_alloc+0x184/0x190
>  [<c026e098>] alloc_skb+0x48/0xf0
>  [<c026e073>] alloc_skb+0x23/0xf0
>  [<c026d596>] sock_alloc_send_pskb+0xd6/0x200
>  [<c026d6ee>] sock_alloc_send_skb+0x2e/0x30
>  [<fa8bcf20>] unix_dgram_sendmsg+0x160/0x5c0 [unix]
>  [<c026a24d>] sock_aio_write+0xbd/0xe0
>  [<c016ef59>] do_sync_write+0x89/0xc0
>  [<c0238ea7>] taskfile_output_data+0x77/0x90
>  [<c0239f81>] task_out_intr+0x181/0x260
>  [<c0239e00>] task_out_intr+0x0/0x260
>  [<c016f077>] vfs_write+0xe7/0x120
>  [<c016f14f>] sys_write+0x3f/0x60
>  [<c0109eff>] syscall_call+0x7/0xb
>
> bad: scheduling while atomic!
> Call Trace:
>  [<c011c510>] schedule+0x500/0x510
>  [<c016f14f>] sys_write+0x3f/0x60
>  [<c0109f26>] work_resched+0x5/0x16
>
> Unable to handle kernel paging request at virtual address 491f3b50
>  printing eip:
> 491f3b50
> *pde = 37455067
> *pte = 00000000
> Oops: 0004 [#1]
> CPU:    0
> EIP:    0073:[<491f3b50>]    Not tainted
> EFLAGS: 00010246
> EIP is at 0x491f3b50
> eax: 0804d2a6   ebx: 0000005b   ecx: 000003d8   edx: 00000008
> esi: 0000031b   edi: 0804d708   ebp: 00000383   esp: bfff756c
> ds: 007b   es: 007b   ss: 007b
> Process klogd (pid: 3138, threadinfo=f7452000 task=f7be0740)
>  <6>note: klogd[3138] exited with preempt_count 1
> bad: scheduling while atomic!
> Call Trace:
>  [<c011c510>] schedule+0x500/0x510
>  [<c0159a61>] unmap_page_range+0x41/0x70
>  [<c0159c70>] unmap_vmas+0x1e0/0x340
>  [<c015f259>] exit_mmap+0xc9/0x2a0
>  [<c011f5c4>] mmput+0xa4/0x130
>  [<c0125655>] do_exit+0x265/0x990
>  [<c010a82c>] die+0x1fc/0x200
>  [<c011a204>] do_page_fault+0x2c4/0x4aa
>  [<c016f056>] vfs_write+0xc6/0x120
>  [<c011c1fe>] schedule+0x1ee/0x510
>  [<c016f14f>] sys_write+0x3f/0x60
>  [<c0119f40>] do_page_fault+0x0/0x4aa
>  [<c010a0a9>] error_code+0x2d/0x38
>
> Linux 2.6.0-test1, gcc 3.2.3
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

