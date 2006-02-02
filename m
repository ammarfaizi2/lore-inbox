Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWBBBS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWBBBS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbWBBBS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:18:58 -0500
Received: from macferrin.com ([65.98.32.91]:51471 "EHLO macferrin.com")
	by vger.kernel.org with ESMTP id S1161052AbWBBBS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:18:57 -0500
Message-ID: <43E15DB6.9070003@macferrin.com>
Date: Wed, 01 Feb 2006 18:17:42 -0700
From: Ken MacFerrin <lists@macferrin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Thunderbird/1.0.7 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
References: <43DAE307.5010306@macferrin.com> <Pine.LNX.4.61.0601281537120.5929@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0601281537120.5929@goblin.wat.veritas.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Fri, 27 Jan 2006, Ken MacFerrin wrote:
> 
>>I started getting hard lockups on my desktop PC with the error "kernel BUG at
>>mm/rmap.c:487" starting with kernel 2.6.13 and continuing through 2.6.14.
>>After switching to 2.6.15 the lockups have continued with the message "kernel
>>BUG at mm/rmap.c:486".
> 
> 
> That's progress, we're hoping to get it to vanish at line 0 eventually ;)
> 
> 
>>The frequency and circumstance are completely random which originally had me
>>suspecting bad memory but after running Memtest86+ for over 12 hours without
>>error I'm at a loss.
>>
>>I'm running the binary Nvidia driver so I'll understand if I can't get help
>>here but in searching through the list archives it would seem I'm not alone
>>and I am willing to try any patches that may help diagnose the issue.  The
>>crash happens at least daily and I've seen no difference in running kernels
>>with or without PREEMPT enabled.
>>
>>The machine is a P4 3.00GHz with 2048MB PC3200 Unbuffered RAM on an ASUS
>>motherboard with an ICH5 chipset.  XFX GF 6600GT video card, 600W power supply
>>and plenty of cooling.
> 
> 
> You raise several worthwhile points there, I needn't repeat them back to you.
> 
> Here's the 2.6.15 version of the patch I traditionally send out for this
> (smaller than for earlier releases because of several advances in 2.6.15).
> 
> Please apply and let me know of all "Bad page state" and "Bad rmap"
> messages you get.  Our record at nailing these problems is not good,
> but the patch should at least let you go on running for much longer.
> 
> Thanks,
> Hugh


Well, unfortunately I'm back again.  I applied your patch last night but 
had another crash again today.  My X session crashed and dropped me into 
the console, which then froze, requiring a hard reboot.  I was only able 
to capture the output below because of remote logging.  This time I did 
not get the specific "BUG at mm/rmap.c" message I had in my previous 
report but do have some "Bad rmap..." messages as you can see below.

Again, I'm happy to test any patches or suggestions for isolating the 
problem.

Thanks,
Ken

-------------------------------------
### /var/log/messages output ###
-------------------------------------
Feb  1 17:01:01 mm-home1 cron[31322]: (root) CMD (/usr/bin/updatedb)
Feb  1 17:04:13 mm-home1 __find_get_block_slow() failed. block=1410, 
b_blocknr=71213169107797378
Feb  1 17:04:13 mm-home1 b_state=0x00000029, b_size=4096
Feb  1 17:04:13 mm-home1 device blocksize: 4096
Feb  1 17:04:13 mm-home1 Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Feb  1 17:04:13 mm-home1 printing eip:
Feb  1 17:04:13 mm-home1 c019fe9b
Feb  1 17:04:13 mm-home1 *pde = 00000000
Feb  1 17:04:13 mm-home1 Oops: 0000 [#1]
Feb  1 17:04:13 mm-home1 PREEMPT SMP
Feb  1 17:04:13 mm-home1 Modules linked in: ipt_limit iptable_mangle 
ipt_LOG ipt_MASQUERADE ip_nat ipt_TOS ipt_REJECT ip_conntrack_irc 
ip_conntrack_ftp ipt_state ip_conntrack iptable_filter ip_tables 
snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus 
snd_util_mem snd_hwdep eth1394 nls_utf8 rfcomm bnep l2cap bluetooth 
dv1394 video1394 raw1394 ohci1394 ieee1394 3c59x marvell loop nvidia 
ntfs rtc tsdev
Feb  1 17:04:13 mm-home1 CPU:    0
Feb  1 17:04:13 mm-home1 EIP:    0060:[<c019fe9b>]    Tainted: P      VLI
Feb  1 17:04:13 mm-home1 EFLAGS: 00210282   (2.6.15-gentoo-r1)
Feb  1 17:04:13 mm-home1 EIP is at flush_commit_list+0x229/0x3ef
Feb  1 17:04:13 mm-home1 eax: 00000000   ebx: f8825000   ecx: c15274cc 
  edx: 00000000
Feb  1 17:04:13 mm-home1 esi: e227ae00   edi: f8825000   ebp: 0000000d 
  esp: f7e11e1c
Feb  1 17:04:13 mm-home1 ds: 007b   es: 007b   ss: 0068
Feb  1 17:04:13 mm-home1 Process pdflush (pid: 164, threadinfo=f7e10000 
task=f7c15030)
Feb  1 17:04:13 mm-home1 Stack: f781e000 f7856c00 f781e000 f7856c00 
00000000 00000000 00000000 00000000
Feb  1 17:04:13 mm-home1 ead379c8 00002000 f8825000 c01a3e62 f784f800 
e227ae00 00000001 00002032
Feb  1 17:04:13 mm-home1 00000000 c17d4f18 f7856c00 f7a97f0c 000003fa 
0011fcb3 00000046 e227ae00
Feb  1 17:04:13 mm-home1 Call Trace:
Feb  1 17:04:13 mm-home1 [<c01a3e62>] do_journal_end+0x880/0x8b6
Feb  1 17:04:13 mm-home1 [<c013b7ee>] pdflush+0x0/0x32
Feb  1 17:04:13 mm-home1 [<c01a2e46>] journal_end_sync+0x61/0x67
Feb  1 17:04:13 mm-home1 [<c0194276>] reiserfs_sync_fs+0x31/0x56
Feb  1 17:04:13 mm-home1 [<c01942a6>] reiserfs_write_super+0xb/0xe
Feb  1 17:04:13 mm-home1 [<c0155e3a>] sync_supers+0x79/0xdc
Feb  1 17:04:13 mm-home1 [<c013b018>] wb_kupdate+0x21/0xe2
Feb  1 17:04:13 mm-home1 [<c013b759>] __pdflush+0xe9/0x17e
Feb  1 17:04:13 mm-home1 [<c013b81b>] pdflush+0x2d/0x32
Feb  1 17:04:13 mm-home1 [<c013aff7>] wb_kupdate+0x0/0xe2
Feb  1 17:04:13 mm-home1 [<c0129a6f>] kthread+0x7c/0xa6
Feb  1 17:04:13 mm-home1 [<c01299f3>] kthread+0x0/0xa6
Feb  1 17:04:13 mm-home1 [<c0100ef5>] kernel_thread_helper+0x5/0xb
Feb  1 17:04:13 mm-home1 Code: 73 14 8b 44 24 04 89 d1 8b 54 24 30 03 4b 
0c 8b 58 0c ff 72 0c 89 c8 99 52 51 ff 73 10 e8 19 27 fb ff 89 44 24 28 
89 c2 83 c4 10 <8b> 00 a8 04 75 07 8b 42 0c 85 c0 75 07 52 e8 db 14 fb 
ff 58 8b
Feb  1 17:04:13 mm-home1 Badness in do_exit at kernel/exit.c:796
Feb  1 17:04:13 mm-home1 [<c011ad1e>] do_exit+0x38/0x379
Feb  1 17:04:13 mm-home1 [<c01039fc>] do_trap+0x0/0xc1
Feb  1 17:04:13 mm-home1 [<c0111ecf>] do_page_fault+0x377/0x4a9
Feb  1 17:04:13 mm-home1 [<c0118f79>] printk+0xe/0x11
Feb  1 17:04:13 mm-home1 [<c0111b58>] do_page_fault+0x0/0x4a9
Feb  1 17:04:13 mm-home1 [<c01033d7>] error_code+0x4f/0x54
Feb  1 17:04:13 mm-home1 [<c015007b>] wait_on_retry_sync_kiocb+0x6/0x38
Feb  1 17:04:13 mm-home1 [<c019fe9b>] flush_commit_list+0x229/0x3ef
Feb  1 17:04:13 mm-home1 [<c01a3e62>] do_journal_end+0x880/0x8b6
Feb  1 17:04:13 mm-home1 [<c013b7ee>] pdflush+0x0/0x32
Feb  1 17:04:13 mm-home1 [<c01a2e46>] journal_end_sync+0x61/0x67
Feb  1 17:04:13 mm-home1 [<c0194276>] reiserfs_sync_fs+0x31/0x56
Feb  1 17:04:13 mm-home1 [<c01942a6>] reiserfs_write_super+0xb/0xe
Feb  1 17:04:13 mm-home1 [<c0155e3a>] sync_supers+0x79/0xdc
Feb  1 17:04:13 mm-home1 [<c013b018>] wb_kupdate+0x21/0xe2
Feb  1 17:04:13 mm-home1 [<c013b759>] __pdflush+0xe9/0x17e
Feb  1 17:04:13 mm-home1 [<c013b81b>] pdflush+0x2d/0x32
Feb  1 17:04:13 mm-home1 [<c013aff7>] wb_kupdate+0x0/0xe2
Feb  1 17:04:13 mm-home1 [<c0129a6f>] kthread+0x7c/0xa6
Feb  1 17:04:13 mm-home1 [<c01299f3>] kthread+0x0/0xa6
Feb  1 17:04:13 mm-home1 [<c0100ef5>] kernel_thread_helper+0x5/0xb
Feb  1 17:04:14 mm-home1 kdm[10322]: X server for display :0 terminated 
unexpectedly
Feb  1 17:04:14 mm-home1 su(pam_unix)[11478]: session closed for user root
Feb  1 17:04:14 mm-home1 Bad rmap: page c1ee7ee0 flags c0000014 count 1 
mapcount 0
Feb  1 17:04:14 mm-home1 firefox-bin addr b5313000 ptpfn 69515 vm_flags 
100077
Feb  1 17:04:14 mm-home1 page mapping 00000000 95d4 vma mapping 00000000 
b5313
Feb  1 17:04:14 mm-home1 kde(pam_unix)[10326]: session closed for user krm
Feb  1 17:04:19 mm-home1 Unable to handle kernel paging request at 
virtual address 00180000
Feb  1 17:04:19 mm-home1 printing eip:
Feb  1 17:04:19 mm-home1 c0135fa7
Feb  1 17:04:19 mm-home1 *pde = 00000000
Feb  1 17:04:19 mm-home1 Oops: 0000 [#2]
Feb  1 17:04:19 mm-home1 PREEMPT SMP
Feb  1 17:04:19 mm-home1 Modules linked in: ipt_limit iptable_mangle 
ipt_LOG ipt_MASQUERADE ip_nat ipt_TOS ipt_REJECT ip_conntrack_irc 
ip_conntrack_ftp ipt_state ip_conntrack iptable_filter ip_tables 
snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus 
snd_util_mem snd_hwdep eth1394 nls_utf8 rfcomm bnep l2cap bluetooth 
dv1394 video1394 raw1394 ohci1394 ieee1394 3c59x marvell loop nvidia 
ntfs rtc tsdev
Feb  1 17:04:19 mm-home1 CPU:    1
Feb  1 17:04:19 mm-home1 EIP:    0060:[<c0135fa7>]    Tainted: P      VLI
Feb  1 17:04:19 mm-home1 EFLAGS: 00210097   (2.6.15-gentoo-r1)
Feb  1 17:04:19 mm-home1 EIP is at find_get_pages+0x33/0x54
Feb  1 17:04:19 mm-home1 eax: c000086c   ebx: 00000002   ecx: 00000001 
  edx: 00180000
Feb  1 17:04:19 mm-home1 esi: f59908f8   edi: f7d8fe58   ebp: 00000000 
  esp: f7d8fe18
Feb  1 17:04:19 mm-home1 ds: 007b   es: 007b   ss: 0068
Feb  1 17:04:19 mm-home1 Process kswapd0 (pid: 165, threadinfo=f7d8e000 
task=c23b5550)
Feb  1 17:04:19 mm-home1 Stack: f7d8fe50 00000000 00000031 c013e91f 
f59908f8 00000000 0000000e f7d8fe58
Feb  1 17:04:19 mm-home1 f5990840 c013ed61 f7d8fe50 f59908f8 00000000 
0000000e 00000000 00000000
Feb  1 17:04:19 mm-home1 c21f51c4 00180000 c04c8328 00200046 f65783e8 
f65783f0 0000001e 00200046
Feb  1 17:04:19 mm-home1 Call Trace:
Feb  1 17:04:19 mm-home1 [<c013e91f>] pagevec_lookup+0x1a/0x21
Feb  1 17:04:19 mm-home1 [<c013ed61>] invalidate_mapping_pages+0xa0/0xb5
Feb  1 17:04:19 mm-home1 [<c011cf66>] irq_exit+0x32/0x3d
Feb  1 17:04:19 mm-home1 [<c010330c>] apic_timer_interrupt+0x1c/0x24
Feb  1 17:04:19 mm-home1 [<c013ed83>] invalidate_inode_pages+0xd/0x11
Feb  1 17:04:19 mm-home1 [<c016630d>] prune_icache+0xca/0x17f
Feb  1 17:04:19 mm-home1 [<c01663da>] shrink_icache_memory+0x18/0x30
Feb  1 17:04:19 mm-home1 [<c013f150>] shrink_slab+0x13a/0x1a7
Feb  1 17:04:19 mm-home1 [<c0140285>] balance_pgdat+0x20a/0x320
Feb  1 17:04:19 mm-home1 [<c03bc665>] schedule+0xa59/0xac0
Feb  1 17:04:19 mm-home1 [<c0140493>] kswapd+0xf8/0xfd
Feb  1 17:04:19 mm-home1 [<c0129e42>] autoremove_wake_function+0x0/0x3a
Feb  1 17:04:19 mm-home1 [<c010278e>] ret_from_fork+0x6/0x14
Feb  1 17:04:19 mm-home1 [<c0129e42>] autoremove_wake_function+0x0/0x3a
Feb  1 17:04:19 mm-home1 [<c014039b>] kswapd+0x0/0xfd
Feb  1 17:04:19 mm-home1 [<c0100ef5>] kernel_thread_helper+0x5/0xb
Feb  1 17:04:19 mm-home1 Code: 7c 24 1c 8d 46 10 e8 e3 78 28 00 8d 46 04 
ff 74 24 18 ff 74 24 18 57 50 e8 80 71 12 00 31 c9 83 c4 10 89 c3 39 c1 
73 16 8b 14 8f <8b> 02 f6 c4 40 74 03 8b 52 0c f0 ff 42 04 41 39 d9 72 
ea 8d 46
Feb  1 17:04:19 mm-home1 <6>note: kswapd0[165] exited with preempt_count 1
Feb  1 17:04:19 mm-home1 (krm-11020): GConf server is not in use, 
shutting down.
Feb  1 17:04:21 mm-home1 kdm: :0[15897]: Abnormal termination of greeter 
for display :0, code 127, signal 0
Feb  1 17:04:29 mm-home1 login(pam_unix)[10286]: session opened for user 
root by LOGIN(uid=0)
Feb  1 17:06:45 mm-home1 __find_get_block_slow() failed. block=1681, 
b_blocknr=23362423066986129
Feb  1 17:06:45 mm-home1 b_state=0x00000029, b_size=4096
-----------------------------
### EOF ###
