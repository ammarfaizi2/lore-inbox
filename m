Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTJOMRu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTJOMRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:17:49 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:32205 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262991AbTJOMRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:17:45 -0400
Date: Wed, 15 Oct 2003 14:17:34 +0200
From: Jan Killius <jkillius@arcor.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Re: 2.6.0-test7-mm1
Message-ID: <20031015121734.GA2400@gate.unimatrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test7-bk5 i586
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm getting a kernel BUG at include/linux/list.h:149
Here is the log:
Oct 15 13:20:22 deepspace kernel BUG at include/linux/list.h:149!
Oct 15 13:20:22 deepspace invalid operand: 0000 [#1]
Oct 15 13:20:22 deepspace PREEMPT
Oct 15 13:20:22 deepspace CPU:    0
Oct 15 13:20:22 deepspace EIP:    0060:[<c0171a07>]    Tainted: PF  VLI
Oct 15 13:20:22 deepspace EFLAGS: 00210283
Oct 15 13:20:22 deepspace EIP is at generic_forget_inode+0x167/0x190
Oct 15 13:20:22 deepspace eax: de6d53d8   ebx: de6d5650   ecx: d88174ec
edx: de6d5658
Oct 15 13:20:22 deepspace esi: dbaf0000   edi: 0000010a   ebp: d9e9c000
esp: d9e9dd00
Oct 15 13:20:22 deepspace ds: 007b   es: 007b   ss: 0068
Oct 15 13:20:22 deepspace Process kdeinit (pid: 5286,
threadinfo=d9e9c000 task=db0aace0)
Oct 15 13:20:22 deepspace Stack: 00000000 c01593d8 da8df0c0 de6d5650
de6d5650 c0171ab2 de6d5650 c03b1620
Oct 15 13:20:22 deepspace d3aa2bc0 c016e993 de6d5650 de6d5650 da8df180
dbaf0800 da20f580 db5d18d0
Oct 15 13:20:22 deepspace c016ed8c 00000151 da8df180 e0c2dd84 da8df180
db5d18d0 00000000 000c2837
Oct 15 13:20:22 deepspace Call Trace:
Oct 15 13:20:22 deepspace [<c01593d8>] bh_lru_install+0xa8/0xe0
Oct 15 13:20:22 deepspace [<c0171ab2>] iput+0x62/0x90
Oct 15 13:20:22 deepspace [<c016e993>] prune_dcache+0x193/0x1e0
Oct 15 13:20:22 deepspace [<c016ed8c>] shrink_dcache_parent+0x1c/0x30
Oct 15 13:20:22 deepspace [<e0c2dd84>] nfs_lookup_revalidate+0x2d4/0x650
[nfs]
Oct 15 13:20:22 deepspace [<c0159557>] __getblk+0x37/0x70
Oct 15 13:20:22 deepspace [<c0190dd6>] ext3_getblk+0xb6/0x310
Oct 15 13:20:22 deepspace [<c019b983>] ext3fs_dirhash+0xb3/0x170
Oct 15 13:20:22 deepspace [<c01b89d1>] rb_insert_color+0xd1/0xf0
Oct 15 13:20:22 deepspace [<c018e3bf>]
ext3_htree_store_dirent+0x12f/0x1a0
Oct 15 13:20:22 deepspace [<c0191063>] ext3_bread+0x33/0xc0
Oct 15 13:20:22 deepspace [<e0a349b8>]
rpcauth_lookup_credcache+0x1c8/0x2b0 [sunrpc]
Oct 15 13:20:22 deepspace [<e0c2fb20>] nfs_permission+0x0/0x2e0 [nfs]
Oct 15 13:20:22 deepspace [<e0a34b1a>] rpcauth_lookupcred+0x7a/0xb0
[sunrpc]
Oct 15 13:20:22 deepspace [<c0164ae8>] do_lookup+0x68/0xb0
Oct 15 13:20:22 deepspace [<c0164639>] permission+0x49/0x50
Oct 15 13:20:22 deepspace [<c016512e>] link_path_walk+0x5fe/0xa60
Oct 15 13:20:22 deepspace [<c0165ac9>] __user_walk+0x49/0x60
Oct 15 13:20:22 deepspace [<c016075f>] vfs_stat+0x1f/0x60
Oct 15 13:20:22 deepspace [<c018e1bf>] free_rb_tree_fname+0x4f/0x80
Oct 15 13:20:22 deepspace [<c016e1e1>] dput+0x21/0x310
Oct 15 13:20:22 deepspace [<c0160edb>] sys_stat64+0x1b/0x40
Oct 15 13:20:22 deepspace [<c0155ca2>] filp_close+0x52/0x90
Oct 15 13:20:22 deepspace [<c0155d41>] sys_close+0x61/0xa0
Oct 15 13:20:22 deepspace [<c02baba2>] sysenter_past_esp+0x43/0x65
Oct 15 13:20:22 deepspace
Oct 15 13:20:22 deepspace Code: c7 44 24 04 00 00 00 00 c7 44 24 08 00
00 00 00 89 04 24 e8 dc 1d fd ff eb ca e8 65 a6 fa ff eb b9 e8 5e a6 fa
ff e9 15 ff ff ff <0f> 0b 95 00 7d 12 2d c0 e9 c9 fe ff ff 0f 0b 94 00
7d 12 2d c0
Oct 15 13:20:22 deepspace <6>note: kdeinit[5286] exited with
preempt_count 2
Oct 15 13:20:22 deepspace bad: scheduling while atomic!
Oct 15 13:20:22 deepspace Call Trace:
Oct 15 13:20:22 deepspace [<c011c054>] schedule+0x744/0x750
Oct 15 13:20:22 deepspace [<c0146d03>] unmap_page_range+0x43/0x70
Oct 15 13:20:22 deepspace [<c0146f06>] unmap_vmas+0x1d6/0x230
Oct 15 13:20:22 deepspace [<c014aeeb>] exit_mmap+0x7b/0x190
Oct 15 13:20:22 deepspace [<c011dc79>] mmput+0x79/0xf0
Oct 15 13:20:22 deepspace [<c0121ea2>] do_exit+0x122/0x3f0
Oct 15 13:20:22 deepspace [<c010b9e0>] do_invalid_op+0x0/0xc0
Oct 15 13:20:22 deepspace [<c010b719>] die+0xf9/0x100
Oct 15 13:20:22 deepspace [<c010ba93>] do_invalid_op+0xb3/0xc0
Oct 15 13:20:22 deepspace [<c0171a07>] generic_forget_inode+0x167/0x190
Oct 15 13:20:22 deepspace [<e0c3ae9b>] nfs3_proc_lookup+0xbb/0x220 [nfs]
Oct 15 13:20:22 deepspace [<c0139999>] find_get_pages+0x39/0x80
Oct 15 13:20:22 deepspace [<c01435ee>] pagevec_lookup+0x2e/0x40
Oct 15 13:20:22 deepspace [<c0143ac6>]
invalidate_mapping_pages+0x66/0xf0
Oct 15 13:20:22 deepspace [<c02bb623>] error_code+0x2f/0x38
Oct 15 13:20:22 deepspace [<c0171a07>] generic_forget_inode+0x167/0x190
Oct 15 13:20:22 deepspace [<c01593d8>] bh_lru_install+0xa8/0xe0
Oct 15 13:20:22 deepspace [<c0171ab2>] iput+0x62/0x90
Oct 15 13:20:22 deepspace [<c016e993>] prune_dcache+0x193/0x1e0
Oct 15 13:20:22 deepspace [<c016ed8c>] shrink_dcache_parent+0x1c/0x30
Oct 15 13:20:22 deepspace [<e0c2dd84>] nfs_lookup_revalidate+0x2d4/0x650
[nfs]
Oct 15 13:20:22 deepspace [<c0159557>] __getblk+0x37/0x70
Oct 15 13:20:22 deepspace [<c0190dd6>] ext3_getblk+0xb6/0x310
Oct 15 13:20:22 deepspace [<c019b983>] ext3fs_dirhash+0xb3/0x170
Oct 15 13:20:22 deepspace [<c01b89d1>] rb_insert_color+0xd1/0xf0
Oct 15 13:20:22 deepspace [<c018e3bf>]
ext3_htree_store_dirent+0x12f/0x1a0
Oct 15 13:20:22 deepspace [<c0191063>] ext3_bread+0x33/0xc0
Oct 15 13:20:22 deepspace [<e0a349b8>]
rpcauth_lookup_credcache+0x1c8/0x2b0 [sunrpc]
Oct 15 13:20:22 deepspace [<e0c2fb20>] nfs_permission+0x0/0x2e0 [nfs]
Oct 15 13:20:22 deepspace [<e0a34b1a>] rpcauth_lookupcred+0x7a/0xb0
[sunrpc]
Oct 15 13:20:22 deepspace [<c0164ae8>] do_lookup+0x68/0xb0
Oct 15 13:20:22 deepspace [<c0164639>] permission+0x49/0x50
Oct 15 13:20:22 deepspace [<c016512e>] link_path_walk+0x5fe/0xa60
Oct 15 13:20:22 deepspace [<c0165ac9>] __user_walk+0x49/0x60
Oct 15 13:20:22 deepspace [<c016075f>] vfs_stat+0x1f/0x60
Oct 15 13:20:22 deepspace [<c018e1bf>] free_rb_tree_fname+0x4f/0x80
Oct 15 13:20:22 deepspace [<c016e1e1>] dput+0x21/0x310
Oct 15 13:20:22 deepspace [<c0160edb>] sys_stat64+0x1b/0x40
Oct 15 13:20:22 deepspace [<c0155ca2>] filp_close+0x52/0x90
Oct 15 13:20:22 deepspace [<c0155d41>] sys_close+0x61/0xa0
Oct 15 13:20:22 deepspace [<c02baba2>] sysenter_past_esp+0x43/0x65
Oct 15 13:20:22 deepspace

-- 
Greets
Jan Killius
