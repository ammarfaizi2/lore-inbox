Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267387AbUIJMqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267387AbUIJMqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267389AbUIJMqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:46:53 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:52710
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S267387AbUIJMqv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:46:51 -0400
Date: Fri, 10 Sep 2004 13:46:50 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Cc: ken@kenmoffat.uklinux.net
Subject: kernel BUG at fs/inode.c:1098! (2.6.8.1)
Message-ID: <Pine.LNX.4.58.0409101338050.22737@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I was looking at the mail from an rsync daily backup this morning, and
found that it had failed because rm couldn't unlink one of the old
backup files (i/o error).  Looking at the log found the following.

 There was another oops while I was shutting it down, I think it had
started to complain about orphaned inodes on the backup disk during
umount (?) but I didn't manage to catch that one.

 This is on a Celeron 1000 with 1GB physical memory but not using
CONFIG_HIMEM, kernel 2.6.8.1 compiled with gcc-3.3.3.

 What other information do I need to provide ?

Ken

Sep 10 02:30:00 john_the_monkey fcron[26453]: Job /usr/bin/updatedb started for user root (pid 26454)
Sep 10 02:36:32 john_the_monkey kernel: ------------[ cut here ]------------
Sep 10 02:36:32 john_the_monkey kernel: kernel BUG at fs/inode.c:1098!
Sep 10 02:36:32 john_the_monkey kernel: invalid operand: 0000 [#1]
Sep 10 02:36:32 john_the_monkey kernel: PREEMPT
Sep 10 02:36:32 john_the_monkey kernel: Modules linked in: snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd soundcore radeon natsemi crc32 rtc
Sep 10 02:36:32 john_the_monkey kernel: CPU:    0
Sep 10 02:36:32 john_the_monkey kernel: EIP:    0060:[<c0160286>]    Not tainted
Sep 10 02:36:32 john_the_monkey kernel: EFLAGS: 00010246   (2.6.8.1-1)
Sep 10 02:36:32 john_the_monkey kernel: EIP is at iput+0x66/0x70
Sep 10 02:36:32 john_the_monkey kernel: eax: c042c7c0   ebx: e55340cc   ecx: e55340dc   edx: e55340dc
Sep 10 02:36:32 john_the_monkey kernel: esi: e55340cc   edi: f7c9e000   ebp: f7c9fee8   esp: f7c9fee4
Sep 10 02:36:32 john_the_monkey kernel: ds: 007b   es: 007b   ss: 0068
Sep 10 02:36:32 john_the_monkey kernel: Process kswapd0 (pid: 35, threadinfo=f7c9e000 task=f7c50050)
Sep 10 02:36:32 john_the_monkey kernel: Stack: d2420674 f7c9ff00 c015d903 00000028 0000007b 00000000 f7c9e000 f7c9ff08
Sep 10 02:36:33 john_the_monkey kernel:        c015dde7 f7c9ff3c c0136227 01858d00 00000000 00018bf6 000000fb 00000000
Sep 10 02:36:33 john_the_monkey kernel:        f7ffeaa0 000000d0 00000020 c0429484 00000001 c0429360 f7c9ff88 c013763b
Sep 10 02:36:33 john_the_monkey kernel: Call Trace:
Sep 10 02:36:33 john_the_monkey kernel:  [<c010468a>] show_stack+0x7a/0x90
Sep 10 02:36:33 john_the_monkey kernel:  [<c0104809>] show_registers+0x149/0x1a0
Sep 10 02:36:33 john_the_monkey kernel:  [<c010499d>] die+0x8d/0x100
Sep 10 02:36:33 john_the_monkey kernel:  [<c0104d4a>] do_invalid_op+0x9a/0xa0
Sep 10 02:36:33 john_the_monkey kernel:  [<c0104325>] error_code+0x2d/0x38
Sep 10 02:36:33 john_the_monkey kernel:  [<c015d903>] prune_dcache+0x153/0x1b0
Sep 10 02:36:33 john_the_monkey kernel:  [<c015dde7>] shrink_dcache_memory+0x17/0x40
Sep 10 02:36:33 john_the_monkey kernel:  [<c0136227>] shrink_slab+0x137/0x180
Sep 10 02:36:33 john_the_monkey kernel:  [<c013763b>] balance_pgdat+0x1eb/0x230
Sep 10 02:36:33 john_the_monkey kernel:  [<c013773e>] kswapd+0xbe/0xd0
Sep 10 02:36:33 john_the_monkey kernel:  [<c01024b5>] kernel_thread_helper+0x5/0x10
Sep 10 02:36:33 john_the_monkey kernel: Code: 0f 0b 4a 04 25 24 3d c0 eb ac 55 89 e5 83 ec 08 89 74 24 04
Sep 10 02:36:37 john_the_monkey fcron[26453]: Job /usr/bin/updatedb terminated

-- 
 das eine Mal als Tragödie, das andere Mal als Farce

