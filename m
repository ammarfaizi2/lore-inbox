Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWKEGRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWKEGRx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 01:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWKEGRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 01:17:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36622 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161107AbWKEGRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 01:17:52 -0500
Date: Sun, 5 Nov 2006 07:17:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.16.30 reiserfs failure or glitch?
Message-ID: <20061105061753.GS13381@stusta.de>
References: <srrpk2pp0kh2icnoes49jtqq954gjkuoih@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <srrpk2pp0kh2icnoes49jtqq954gjkuoih@4ax.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 07:27:14AM +1100, Grant Coady wrote:

> Hi there,

Hi Grant,

> Me not seen this one before, compiling 2.6.18.2 kernel, running 2.6.16.30:
> 
> make[1]: *** [fs/super.o] Error 139
> make: *** [fs] Error 2
>...
> /var/log/syslog:
> Nov  5 06:49:53 pooh kernel: ------------[ cut here ]------------
> Nov  5 06:49:53 pooh kernel: kernel BUG at lib/radix-tree.c:282!
> Nov  5 06:49:53 pooh kernel: invalid opcode: 0000 [#1]
> Nov  5 06:49:53 pooh kernel: Modules linked in:
> Nov  5 06:49:53 pooh kernel: CPU:    0
> Nov  5 06:49:53 pooh kernel: EIP:    0060:[<c01cfb4d>]    Not tainted VLI
> Nov  5 06:49:53 pooh kernel: EFLAGS: 00010086   (2.6.16.30a #3)
> Nov  5 06:49:53 pooh kernel: EIP is at radix_tree_insert+0x10d/0x140
> Nov  5 06:49:53 pooh kernel: eax: ffffffff   ebx: fffffffa   ecx: 00000000   edx: 00000000
> Nov  5 06:49:53 pooh kernel: esi: 00000000   edi: 00000002   ebp: c75af4c4   esp: c0cd0d04
> Nov  5 06:49:53 pooh kernel: ds: 007b   es: 007b   ss: 0068
> Nov  5 06:49:53 pooh kernel: Process fixdep (pid: 2119, threadinfo=c0cd0000 task=c2e4f050)
> Nov  5 06:49:53 pooh kernel: Stack: <0>c10b9700 c7b2b130 00000002 00000002 c012eed5 c7b2b134 00000002 c10b9700
> Nov  5 06:49:53 pooh kernel:        c10b9700 c10b9700 000200d2 c012ef38 c10b9700 c7b2b130 00000002 000200d2
> Nov  5 06:49:53 pooh kernel:        c10b9700 00000000 c012f27f c10b9700 c7b2b130 00000002 000200d2 c0cd0ee4
> Nov  5 06:49:53 pooh kernel: Call Trace:
> Nov  5 06:49:53 pooh kernel:  [<c012eed5>] add_to_page_cache+0x35/0x80
> Nov  5 06:49:53 pooh kernel:  [<c012ef38>] add_to_page_cache_lru+0x18/0x40
> Nov  5 06:49:53 pooh kernel:  [<c012f27f>] find_or_create_page+0x1f/0xa0
> Nov  5 06:49:53 pooh kernel:  [<c0189768>] reiserfs_prepare_file_region_for_write+0xe8/0x880
> Nov  5 06:49:53 pooh kernel:  [<c01829f3>] make_cpu_key+0x33/0x40
> Nov  5 06:49:53 pooh kernel:  [<c01895d6>] reiserfs_check_for_tail_and_convert+0x116/0x1c0
> Nov  5 06:49:53 pooh kernel:  [<c018a1f0>] reiserfs_file_write+0x2f0/0x6a0
> Nov  5 06:49:53 pooh kernel:  [<c0139fdf>] zap_pte_range+0x13f/0x220
> Nov  5 06:49:53 pooh kernel:  [<c013a15d>] unmap_page_range+0x9d/0x140
> Nov  5 06:49:53 pooh kernel:  [<c013a2d7>] unmap_vmas+0xd7/0x1a0
> Nov  5 06:49:53 pooh kernel:  [<c01399e1>] free_pgtables+0x61/0x80
> Nov  5 06:49:53 pooh kernel:  [<c013df83>] unmap_region+0xa3/0xe0
> Nov  5 06:49:53 pooh kernel:  [<c013c882>] remove_vma+0x42/0x60
> Nov  5 06:49:53 pooh kernel:  [<c0163a94>] mntput_no_expire+0x14/0x60
> Nov  5 06:49:53 pooh kernel:  [<c014a63c>] vfs_write+0x7c/0x100
> Nov  5 06:49:53 pooh kernel:  [<c014a77b>] sys_write+0x3b/0x80
> Nov  5 06:49:53 pooh kernel:  [<c0102979>] syscall_call+0x7/0xb
> Nov  5 06:49:53 pooh kernel: Code: 04 e9 6d ff ff ff 8b 4c 24 14 89 51 08 e9 61 ff ff ff 0f 0b 1b 01 58 6a 2a c0 b8 00 00 00 00 eb a4 5b b8 f4 ff ff ff 5e 5f 5d c3 <0f> 0b 1a 01 58 6a 2a c0 e9 7b ff ff ff 0f 0b 17 01 58 6a 2a c0
> 
> root@pooh:~# lsmod
> Module                  Size  Used by
> root@pooh:~#
> 
> dmesg: http://bugsplatter.mine.nu/test/boxen/pooh/dmesg-2.6.16.30a.gz
> 
> Five other boxen not show problem, so is this a once-off glitch?  This box 
> also ran 2.6.16.30-rc1 no problem.


thanks for your report.

There are no changes between 2.6.30-rc1 and 2.6.30 (except for the 
version number in the toplevel Makefile).

I've Cc'ed the reiserfs developers that might have some clues what went 
wrong.


> On reboot to 2.6.17.14 dmesg said of the troublesome partition:
> ReiserFS: hda4: found reiserfs format "3.6" with standard journal
> ReiserFS: hda4: using ordered data mode
> ReiserFS: hda4: journal params: device hda4, size 8192, journal first block 18, max trans len 10
> 24, max batch 900, max commit age 30, max trans age 30
> ReiserFS: hda4: checking transaction log (hda4)
> ReiserFS: hda4: replayed 8 transactions in 1 seconds
> ReiserFS: hda4: Using r5 hash to sort names
> 
> Box has two old IDE HDDs:
> # df
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/hda2               258036    123436    134600  48% /
> /dev/hda4              2128824   1246068    882756  59% /home
> /dev/hdc4              2503788   1109156   1394632  45% /usr
> /dev/hdc2               124947        52    118444   1% /usr/local
> 
> Seems okay now?  Odd.
> 
> Grant.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

