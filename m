Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVEQWEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVEQWEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVEQWCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:02:44 -0400
Received: from aigc.net ([64.146.132.21]:62404 "EHLO bach.aigc.net")
	by vger.kernel.org with ESMTP id S261990AbVEQVrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:47:09 -0400
Message-ID: <4255.24.115.31.119.1116366396.squirrel@mail.aigc.net>
Date: Tue, 17 May 2005 17:46:36 -0400 (EDT)
Subject: Re: [2.6.12-rc4] Oops in reiserfs_panic [please CC]
From: "Jesse D Zbikowski" <jdz@aigc.net>
To: linux-kernel@vger.kernel.org
Cc: malmostoso@email.it, vs@nl.linux.org, dsd@gentoo.org, gfraser@online.no,
       linux-fsdevel@vger.kernel.org, reiserfs-list@namesys.com
Reply-To: jdz@aigc.net
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks to be the same bug reported by two Gentoo users against
2.6.12-rc4, as a regression from -rc3.  One reported data corruption.
You should be able to work around by compiling with

CONFIG_REISERFS_CHECK=n

http://bugs.gentoo.org/show_bug.cgi?id=91968

Here is the oops:

ReiserFS: hda7: Using r5 hash to sort names
REISERFS: panic (device Null superblock): reiserfs[4540]: assertion !(
comp_keys( &MAX_KEY, p_s_key ) && ! key_in_buffer(p_s_search_path, p_s_key,
p_s_sb) ) failed at fs/reiserfs/stree.c:685:search_by_key: PAP-5130: key is not
in the buffer

------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:362!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: eeprom i2c_dev asb100 i2c_sensor i2c_core unix
CPU:    0
EIP:    0060:[<c01b05fe>]    Not tainted VLI
EFLAGS: 00010282   (2.6.12-rc4)
EIP is at reiserfs_panic+0x51/0x76
eax: 000000fb   ebx: c0405473   ecx: 000029f2   edx: c04b6701
esi: 00000000   edi: 00000140   ebp: ef2ebd78   esp: ef2ebbcc
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 4540, threadinfo=ef2ea000 task=ef2540a0)
Stack: c04108b4 c0405473 c054ffa0 ffffffff ffffffff c03f008d c01b9daa 00000000
       c0415454 000011bc 000002ad c03f010c 00000000 00000001 ef2ebd7c c01b8933
       eeba0000 ffffffff 00000000 ef2ea000 ef2ea000 ef2ea000 ef2ea000 ef2ea000
Call Trace:
 [<c01b9daa>] search_by_key+0x13cd/0x1bc4
 [<c01b8933>] is_tree_node+0x6c/0x71
 [<c013ecf8>] __alloc_pages+0x173/0x3d8
 [<c011a0a6>] call_console_drivers+0x67/0x13b
 [<c01ad069>] finish_unfinished+0x9f/0x3a2
 [<c012e1a5>] autoremove_wake_function+0x0/0x57
 [<c01c4e80>] do_journal_end+0x7f3/0x966
 [<c025d3c3>] vsprintf+0x27/0x2b
 [<c01af7cc>] reiserfs_fill_super+0x6c6/0x77e
 [<c01a14c9>] reiserfs_init_locked_inode+0x0/0x16
 [<c015f82e>] sb_set_blocksize+0x2e/0x5e
 [<c015f1f8>] get_sb_bdev+0xe0/0x145
 [<c01742dc>] alloc_vfsmnt+0x9c/0xd1
 [<c01af8f0>] get_super_block+0x2f/0x33
 [<c01af106>] reiserfs_fill_super+0x0/0x77e
 [<c015f46c>] do_kern_mount+0x63/0xe9
 [<c0175437>] do_new_mount+0x9e/0xf7
 [<c0175b27>] do_mount+0x19d/0x1bb
 [<c0175933>] copy_mount_options+0x60/0xb7
 [<c0175ef4>] sys_mount+0x9f/0xd7
 [<c0102a27>] sysenter_past_esp+0x54/0x75
Code: 24 8d be 40 01 00 00 e8 e2 fc ff ff 85 f6 89 d8 c7 44 24 08 a0 ff 54 c0 c7
04 24 b4 08 41 c0 0f 45 c7 89 44 24 04 e8 42 9c f6 ff <0f> 0b 6a 01 36 5a 40 c0
85 f6 c7 44 24 08 a0 ff 54 c0 c7 04 24
