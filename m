Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbUKJI2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbUKJI2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 03:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbUKJI2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 03:28:55 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:32650 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261266AbUKJI2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 03:28:47 -0500
Message-ID: <4191D13C.3060308@yahoo.com.au>
Date: Wed, 10 Nov 2004 19:28:44 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hindley <mark@hindley.uklinux.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS: 2.6.9
References: <20041110074851.GA9757@titan.home.hindley.uklinux.net>
In-Reply-To: <20041110074851.GA9757@titan.home.hindley.uklinux.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hindley wrote:
> I got this oops this morning with 2.6.9
> 
> I have rebooted without the nvidia module and will let you know if it
> hapens again.
> 
> Let me know if you need more info
> 
> Mark
> 
> Nov 10 07:40:01 titan kernel: kernel BUG at mm/vmscan.c:370!
> Nov 10 07:40:01 titan kernel: invalid operand: 0000 [#1]
> Nov 10 07:40:01 titan kernel: PREEMPT 
> Nov 10 07:40:01 titan kernel: Modules linked in: ide_cd cdrom nvidia ipv6 nfs nfsd exportfs lockd sunrpc snd_als100 snd_opl3_lib snd_hwdep snd_sb16_dsp snd_sb_common snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 3c59x dummy ipt_REJECT ipt_LOG ipt_limit ipt_MASQUERADE ipt_owner ipt_REDIRECT iptable_nat ipt_state iptable_filter ip_conntrack ip_tables hangcheck_timer 8250_pnp 8250 serial_core
> Nov 10 07:40:01 titan kernel: CPU:    0
> Nov 10 07:40:01 titan kernel: EIP:    0060:[shrink_list+155/1064]    Tainted: P   VLI
> Nov 10 07:40:01 titan kernel: EFLAGS: 00010202   (2.6.9) 
> Nov 10 07:40:01 titan kernel: EIP is at shrink_list+0x9b/0x428
> Nov 10 07:40:01 titan kernel: eax: 20001045   ebx: c102ffe0   ecx: c102fff8   edx: c1060338
> Nov 10 07:40:01 titan kernel: esi: c1172000   edi: c10d7490   ebp: c10d7490   esp: c1173e44
> Nov 10 07:40:01 titan kernel: ds: 007b   es: 007b   ss: 0068
> Nov 10 07:40:01 titan kernel: Process kswapd0 (pid: 41, threadinfo=c1172000 task=c115ab10)
> Nov 10 07:40:01 titan kernel: Stack: c1173ee4 c1172000 c02b59ac 00000021 00000001 00000001 00000009 00000005 
> Nov 10 07:40:01 titan kernel:        c1059398 c10713d8 00000009 00000001 c104b320 c105e800 c1079160 c1062f20 
> Nov 10 07:40:01 titan kernel:        c10798e0 c104e9a0 c1045120 c1076d00 c10433e0 00000001 c105f1e0 c013c763 
> Nov 10 07:40:01 titan kernel: Call Trace:
> Nov 10 07:40:01 titan kernel:  [refill_inactive_zone+1267/1380] refill_inactive_zone+0x4f3/0x564
> Nov 10 07:40:01 titan kernel:  [shrink_cache+463/824] shrink_cache+0x1cf/0x338
> Nov 10 07:40:01 titan kernel:  [shrink_zone+147/172] shrink_zone+0x93/0xac
> Nov 10 07:40:01 titan kernel:  [balance_pgdat+399/668] balance_pgdat+0x18f/0x29c
> Nov 10 07:40:01 titan kernel:  [kswapd+216/224] kswapd+0xd8/0xe0
> Nov 10 07:40:01 titan kernel:  [kswapd+0/224] kswapd+0x0/0xe0
> Nov 10 07:40:01 titan kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
> Nov 10 07:40:01 titan kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
> Nov 10 07:40:01 titan kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
> Nov 10 07:40:01 titan kernel: Code: 50 04 89 02 c7 01 00 01 10 00 c7 41 04 00 02 20 00 31 c0 0f ab 41 e8 19 c0 85 c0 0f 85 05 03 00 00 8b 41 e8 a9 40 00 00 00 74 08 <0f> 0b 72 01 84 ab 26 c0 8b 41 e8 a9 00 20 00 00 0f 85 de 02 00 
> 
> 

    a9 40 00 00 00            test   $0x40,%eax
    74 08                     je     33 <_EIP+0x33>
    0f 0b                     ud2a

So eax (20001045) is page->flags, which is
PG_locked | PG_referenced | PG_active | PG_private, I think.

You might have flipped a bit. Can you run memtest86 on the system overnight?
