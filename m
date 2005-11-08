Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbVKHWPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbVKHWPR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbVKHWPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:15:17 -0500
Received: from r241-132.iq.pl ([86.111.241.132]:35523 "EHLO mail.iq.pl")
	by vger.kernel.org with ESMTP id S1030327AbVKHWPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:15:14 -0500
Date: Tue, 8 Nov 2005 23:16:48 +0100
From: =?iso-8859-2?Q?Pawe=B3_S=B3owik?= <wik@iq.pl>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at mm/prio_tree.c:78
Message-ID: <20051108221648.GA30824@serv13>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had an oops on my home desktop, which is:
Linux desk 2.6.14 #1 PREEMPT Sat Oct 29 16:05:58 CEST 2005 i686
AMD Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux
Syslog excerpt:

Nov  8 21:05:01 desk ------------[ cut here ]------------
Nov  8 21:05:01 desk kernel BUG at mm/prio_tree.c:78!
Nov  8 21:05:01 desk invalid operand: 0000 [#1]
Nov  8 21:05:01 desk PREEMPT 
Nov  8 21:05:01 desk Modules linked in: it87 hwmon_vid lm90 hwmon i2c_isa i2c_viapro i2c_core snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_util_mem snd_hwdep snd_via82xx snd_ac97_codec snd_ac97_bus snd_mpu401_uart snd_rawmidi uhci_hcd cryptoloop loop radeon drm via_agp agpgart
Nov  8 21:05:01 desk CPU:    0
Nov  8 21:05:01 desk EIP:    0060:[<c014192b>]    Not tainted VLI
Nov  8 21:05:01 desk EFLAGS: 00010212   (2.6.14) 
Nov  8 21:05:01 desk EIP is at vma_prio_tree_add+0xab/0xc0
Nov  8 21:05:01 desk eax: dfd98964   ebx: c0805124   ecx: 0000010f   edx: 00000110
Nov  8 21:05:01 desk esi: dfd98964   edi: 00000000   ebp: dfd93474   esp: dd8ffe9c
Nov  8 21:05:01 desk ds: 007b   es: 007b   ss: 0068
Nov  8 21:05:01 desk Process grep (pid: 31686, threadinfo=dd8fe000 task=c0d810b0)
Nov  8 21:05:01 desk Stack: c4c3e284 db352334 c01460c0 c0805124 dfd98964 c4c3b964 dfd93460 00000000 
Nov  8 21:05:01 desk 00000000 00000000 c2e4bae0 dfd93460 da3d9700 c0805124 00000000 00000001 
Nov  8 21:05:01 desk db352334 c0147763 db352334 b7ee3000 b7ee5000 00000114 c0805124 b7ee3000 
Nov  8 21:05:01 desk Call Trace:
Nov  8 21:05:01 desk [<c01460c0>] vma_adjust+0x100/0x390
Nov  8 21:05:01 desk [<c0147763>] split_vma+0xa3/0xf0
Nov  8 21:05:01 desk [<c01478ec>] do_munmap+0x13c/0x150
Nov  8 21:05:01 desk [<c0146967>] do_mmap_pgoff+0x267/0x760
Nov  8 21:05:01 desk [<c0108588>] sys_mmap2+0x78/0xb0
Nov  8 21:05:01 desk [<c0102e81>] syscall_call+0x7/0xb
Nov  8 21:05:01 desk Code: 8b 4a 04 89 53 28 89 42 04 89 01 89 48 04 eb d8 8d 43 28 89 73 34 89 43 28 89 43 2c 89 5e 34 eb c7 0f 0b 4f 00 61 b7 33 c0 eb 93 <0f> 0b 4e 00 61 b7 33 c0 e9 68 ff ff ff 90 8d b4 26 00 00 00 00 
Nov  8 21:05:01 desk <6>note: grep[31686] exited with preempt_count 1
Nov  8 21:05:01 desk scheduling while atomic: grep/0x00000001/31686
Nov  8 21:05:01 desk [<c0327f92>] schedule+0x612/0x620
Nov  8 21:05:01 desk [<c0115885>] vprintk+0x1c5/0x290
Nov  8 21:05:01 desk [<c0328c8d>] rwsem_down_read_failed+0x8d/0x170
Nov  8 21:05:01 desk [<c0118bb2>] .text.lock.exit+0x27/0xb5
Nov  8 21:05:01 desk [<c0103ac0>] do_invalid_op+0x0/0xd0
Nov  8 21:05:01 desk [<c011782b>] do_exit+0xdb/0x440
Nov  8 21:05:01 desk [<c0103ac0>] do_invalid_op+0x0/0xd0
Nov  8 21:05:01 desk [<c010380d>] die+0x17d/0x180
Nov  8 21:05:01 desk [<c0103b6e>] do_invalid_op+0xae/0xd0
Nov  8 21:05:01 desk [<c016bc48>] update_atime+0x58/0xb0
Nov  8 21:05:01 desk [<c014192b>] vma_prio_tree_add+0xab/0xc0
Nov  8 21:05:01 desk [<c01352d3>] do_generic_mapping_read+0x313/0x5d0
Nov  8 21:05:01 desk [<c0162440>] page_put_link+0x0/0x40
Nov  8 21:05:01 desk [<c01fa68e>] rb_insert_color+0x8e/0xf0
Nov  8 21:05:01 desk [<c01f96d0>] prio_tree_insert+0xb0/0x1c0
Nov  8 21:05:01 desk [<c01030ab>] error_code+0x4f/0x54
Nov  8 21:05:01 desk [<c014192b>] vma_prio_tree_add+0xab/0xc0
Nov  8 21:05:01 desk [<c01460c0>] vma_adjust+0x100/0x390
Nov  8 21:05:01 desk [<c0147763>] split_vma+0xa3/0xf0
Nov  8 21:05:01 desk [<c01478ec>] do_munmap+0x13c/0x150
Nov  8 21:05:01 desk [<c0146967>] do_mmap_pgoff+0x267/0x760
Nov  8 21:05:01 desk [<c0108588>] sys_mmap2+0x78/0xb0
Nov  8 21:05:01 desk [<c0102e81>] syscall_call+0x7/0xb

The box is still up and running, but hangs when trying to read from
files:
/proc/31686/cmdline
/proc/31686/environ
/proc/31686/exe
/proc/31686/maps
/proc/31686/smaps
Process 31686 is "unkillable" (shows up as "D (disk sleep)").
So far, this happened only once and I dont't know, what might
be the cause. PID 31686 is a grep command, launched from the
"emerge" python script (emerge is Gentoo Linux package management
utility).

Is this an actual bug, or maybe hardware error? I would be grateful
for any help / comments on this.
I am not subscribed to the list, please CC.
Thank you.

-- 
Pawe³ S³owik
wik@iq.pl


