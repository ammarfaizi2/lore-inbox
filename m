Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUG0Nik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUG0Nik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 09:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUG0Nik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 09:38:40 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:10500 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265462AbUG0NiM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 09:38:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Date: Tue, 27 Jul 2004 16:37:36 +0300
X-Mailer: KMail [version 1.4]
References: <200407271233.04205.gene.heskett@verizon.net>
In-Reply-To: <200407271233.04205.gene.heskett@verizon.net>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200407271637.36197.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 19:33, Gene Heskett wrote:
> Greetings everybody;
>
> I have now had 4 crashes while running 2.6.8-rc2, the last one
> requiring a full powerdown before the intel-8x0 could
> re-establish control over the sound.
>
> All have had an initial Opps located in prune_dcache, and were
> logged as follows:
> Jul 27 07:58:58 coyote kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000000 Jul 27 07:58:58 coyote kernel: 
> printing eip:
> Jul 27 07:58:58 coyote kernel: c0164376
> Jul 27 07:58:58 coyote kernel: *pde = 00000000
> Jul 27 07:58:58 coyote kernel: Oops: 0002 [#1]
> Jul 27 07:58:58 coyote kernel: PREEMPT
> Jul 27 07:58:58 coyote kernel: Modules linked in: tuner tvaudio bttv
> video_buf btcx_risc eeprom snd_seq_oss snd_seq _midi_event snd_seq
> snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm
> snd_timer snd_page_allo c snd_mpu401_uart snd_rawmidi snd_seq_device snd
> forcedeth sg
> Jul 27 07:58:58 coyote kernel: CPU:    0
> Jul 27 07:58:58 coyote kernel: EIP:    0060:[<c0164376>]    Not tainted
> Jul 27 07:58:58 coyote kernel: EFLAGS: 00010216   (2.6.8-rc2-nf2)
> Jul 27 07:58:58 coyote kernel: EIP is at prune_dcache+0x36/0x1c0
> Jul 27 07:58:58 coyote kernel: eax: c03706f8   ebx: dbbf1090   ecx:
> dbbf5c34   edx: 00000000 Jul 27 07:58:58 coyote kernel: esi: ed1f8990  
> edi: c1989000   ebp: 0000001e   esp: c1989ef8 Jul 27 07:58:58 coyote
> kernel: ds: 007b   es: 007b   ss: 0068
> Jul 27 07:58:58 coyote kernel: Process kswapd0 (pid: 66,
> threadinfo=c1989000 task=c1978050) Jul 27 07:58:58 coyote kernel: Stack:
> ed1f8990 c1989ef8 0000002a 00000000 c1989000 f7ffea20 c016491f 0000002a Jul
> 27 07:58:58 coyote kernel:        c013ab6b 0000002a 000000d0 0001df9e
> 022f2e00 00000000 0000012a 00000000 Jul 27 07:58:58 coyote kernel:       
> c036f6e4 00000002 00000007 c036f5c0 c013bf11 00000020 000000d0 00000000 Jul
> 27 07:58:58 coyote kernel: Call Trace:
> Jul 27 07:58:58 coyote kernel:  [<c016491f>] shrink_dcache_memory+0x1f/0x50
> Jul 27 07:58:58 coyote kernel:  [<c013ab6b>] shrink_slab+0x14b/0x190
> Jul 27 07:58:58 coyote kernel:  [<c013bf11>] balance_pgdat+0x1b1/0x200
> Jul 27 07:58:58 coyote kernel:  [<c013c027>] kswapd+0xc7/0xe0
> Jul 27 07:58:58 coyote kernel:  [<c01146b0>]
> autoremove_wake_function+0x0/0x60 Jul 27 07:58:58 coyote kernel: 
> [<c0103fb2>] ret_from_fork+0x6/0x14 Jul 27 07:58:58 coyote kernel: 
> [<c01146b0>] autoremove_wake_function+0x0/0x60 Jul 27 07:58:58 coyote
> kernel:  [<c013bf60>] kswapd+0x0/0xe0
> Jul 27 07:58:58 coyote kernel:  [<c0102251>] kernel_thread_helper+0x5/0x14
> Jul 27 07:58:58 coyote kernel: Code: 89 02 89 49 04 89 09 a1 fc 06 37 c0 0f
> 18 00 90 ff 0d 04 07 Jul 27 07:58:58 coyote kernel:  <6>note: kswapd0[66]
> exited with preempt_count 1 Jul 27 07:58:58 coyote kernel:
> c_pid_flush+0x17/0x30
> Jul 27 07:58:58 coyote kernel:  [<c011779d>] release_task+0x13d/0x1e0
> Jul 27 07:58:58 coyote kernel:  [<c011923b>] wait_task_zombie+0x15b/0x1c0
> Jul 27 07:58:58 coyote kernel:  [<c0119653>] sys_wait4+0x213/0x260
> Jul 27 07:58:58 coyote kernel:  [<c0113420>] default_wake_function+0x0/0x20
> Jul 27 07:58:58 coyote kernel:  [<c0113420>] default_wake_function+0x0/0x20
> Jul 27 07:58:58 coyote kernel:  [<c01196c7>] sys_waitpid+0x27/0x2b
> Jul 27 07:58:58 coyote kernel:  [<c0104089>] sysenter_past_esp+0x52/0x71
>
> With several iterations of this appended next:
> Jul 27 07:58:58 coyote kernel: bad: scheduling while atomic!
> Jul 27 07:58:58 coyote kernel:  [<c030dc3c>] schedule+0x47c/0x490
> Jul 27 07:58:58 coyote kernel:  [<c01673e4>] __wait_on_inode+0x84/0xa0
> Jul 27 07:58:58 coyote kernel:  [<c0113420>] default_wake_function+0x0/0x20
> Jul 27 07:58:58 coyote kernel:  [<c0113420>] default_wake_function+0x0/0x20
> Jul 27 07:58:58 coyote kernel:  [<c016d7ea>]
> __writeback_single_inode+0x5a/0xc0 Jul 27 07:58:58 coyote kernel: 
> [<c016d9be>] sync_sb_inodes+0x16e/0x290 Jul 27 07:58:58 coyote kernel: 
> [<c016dc4e>] sync_inodes_sb+0x7e/0xa0 Jul 27 07:58:58 coyote kernel: 
> [<c016ddcb>] sync_inodes+0x7b/0xa0 Jul 27 07:58:58 coyote kernel: 
> [<c014e1f4>] do_sync+0x44/0x80
> Jul 27 07:58:58 coyote kernel:  [<c014e23f>] sys_sync+0xf/0x20
> Jul 27 07:58:58 coyote kernel:  [<c011667f>] panic+0xff/0x110
> Jul 27 07:58:58 coyote kernel:  [<c0118e9f>] do_exit+0x3ff/0x420
> Jul 27 07:58:58 coyote kernel:  [<c0111640>] do_page_fault+0x0/0x51b
> Jul 27 07:58:58 coyote kernel:  [<c0104968>] die+0xf8/0x100
> Jul 27 07:58:58 coyote kernel:  [<c011181b>] do_page_fault+0x1db/0x51b
> Jul 27 07:58:58 coyote kernel:  [<c0105e12>] do_IRQ+0x102/0x1a0
> Jul 27 07:58:58 coyote kernel:  [<c030da4e>] schedule+0x28e/0x490
> Jul 27 07:58:58 coyote kernel:  [<c0111640>] do_page_fault+0x0/0x51b
> Jul 27 07:58:58 coyote kernel:  [<c0104285>] error_code+0x2d/0x38
> Jul 27 07:58:58 coyote kernel:  [<c01647d6>] select_parent+0x56/0xb0
> Jul 27 07:58:58 coyote kernel:  [<c0164840>] shrink_dcache_parent+0x10/0x30
> Jul 27 07:58:58 coyote kernel:  [<c017b557>] proc_pid_flush+0x17/0x30
> Jul 27 07:58:59 coyote kernel:  [<c011779d>] release_task+0x13d/0x1e0
> Jul 27 07:58:59 coyote kernel:  [<c011923b>] wait_task_zombie+0x15b/0x1c0
> Jul 27 07:58:59 coyote kernel:  [<c0119653>] sys_wait4+0x213/0x260
> Jul 27 07:58:59 coyote kernel:  [<c0113420>] default_wake_function+0x0/0x20
> Jul 27 07:58:59 coyote kernel:  [<c0113420>] default_wake_function+0x0/0x20
> Jul 27 07:58:59 coyote kernel:  [<c01196c7>] sys_waitpid+0x27/0x2b
> Jul 27 07:58:59 coyote kernel:  [<c0104089>] sysenter_past_esp+0x52/0x71
>
> Now, someone gave me the syntax to do a dis on this, but I'm no intel
> assembly guru.  If someone could repeat that such that I could apply
> it to fs/cache.o, I'd be happy to fwd the results to whomever it might

results of

# objdump -d fs/cache.o

and

# make fs/cache.s

are needed.
-- 
vda
