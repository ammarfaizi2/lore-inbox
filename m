Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbUJXVop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUJXVop (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 17:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbUJXVop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 17:44:45 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:61123 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261596AbUJXVon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 17:44:43 -0400
Subject: ext3 oops + data corruption with 2.6.8
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 24 Oct 2004 17:44:41 -0400
Message-Id: <1098654282.1555.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This left me with a corrupt filesystem.  fsck restored it.

Oct 22 19:46:22 debian kernel: d08c871e
Oct 22 19:46:22 debian kernel: PREEMPT
Oct 22 19:46:22 debian kernel: Modules linked in: tdfx apm ipv6 af_packet dm_mod capability commoncap psmouse snd_ens1370 snd_rawmidi snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc gameport snd_ak4531_codec snd soundcore mousedev eepro100 mii rtc ext3 jbd ide_generic piix ide_disk ide_core unix font vesafb cfbcopyarea cfbimgblt cfbfillrect
Oct 22 19:46:22 debian kernel: CPU:    0
Oct 22 19:46:22 debian kernel: EIP:    0060:[__crc_driver_find+3565795/4844497]    Not tainted
Oct 22 19:46:22 debian kernel: EFLAGS: 00010286   (2.6.8-1-386)
Oct 22 19:46:22 debian kernel: EIP is at ext3_clear_inode+0x15/0x55 [ext3]
Oct 22 19:46:22 debian kernel: eax: d08d92a0   ebx: cd641454   ecx: cd64145c   edx: ff7fffff
Oct 22 19:46:22 debian kernel: esi: cf929eec   edi: 0000000f   ebp: c028b30c   esp: cf929eb4
Oct 22 19:46:22 debian kernel: ds: 007b   es: 007b   ss: 0068
Oct 22 19:46:22 debian kernel: Process kswapd0 (pid: 47, threadinfo=cf928000 task=cf906b70)
Oct 22 19:46:22 debian kernel: Stack: cd641454 c0159361 cd641454 cd641454 c01593d9 cd641454 cf928000 c8fcd994
Oct 22 19:46:22 debian kernel:        c8fcd99c c0159774 cf929eec 00000000 00000012 00000012 cd64161c cd6417dc
Oct 22 19:46:22 debian kernel:        00000012 00000080 000000d0 cffee9e0 c01597c6 00000012 c0135bbe 00000012
Oct 22 19:46:22 debian kernel: Call Trace:
Oct 22 19:46:22 debian kernel:  [clear_inode+156/201] clear_inode+0x9c/0xc9
Oct 22 19:46:22 debian kernel:  [dispose_list+75/128] dispose_list+0x4b/0x80
Oct 22 19:46:22 debian kernel:  [prune_icache+410/471] prune_icache+0x19a/0x1d7
Oct 22 19:46:22 debian kernel:  [shrink_icache_memory+21/45] shrink_icache_memory+0x15/0x2d
Oct 22 19:46:22 debian kernel:  [shrink_slab+243/341] shrink_slab+0xf3/0x155
Oct 22 19:46:22 debian kernel:  [balance_pgdat+358/494] balance_pgdat+0x166/0x1ee
Oct 22 19:46:22 debian kernel:  [kswapd+193/197] kswapd+0xc1/0xc5
Oct 22 19:46:22 debian kernel:  [autoremove_wake_function+0/58] autoremove_wake_function+0x0/0x3a
Oct 22 19:46:22 debian kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Oct 22 19:46:22 debian kernel:  [autoremove_wake_function+0/58] autoremove_wake_function+0x0/0x3a
Oct 22 19:46:22 debian kernel:  [kswapd+0/197] kswapd+0x0/0xc5
Oct 22 19:46:22 debian kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
Oct 22 19:46:22 debian kernel: Code: ff 0a 0f 94 c0 84 c0 74 07 52 e8 a2 bc 86 ef 58 c7 43 d8 ff

rlrevell@debian:~$ uname -a
Linux debian 2.6.8-1-386 #1 Thu Oct 7 02:21:16 EDT 2004 i686 GNU/Linux
-- 
Lee Revell <rlrevell@joe-job.com>

