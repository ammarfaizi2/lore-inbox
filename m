Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbUJ3WBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbUJ3WBl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbUJ3WBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:01:41 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:58156 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S261338AbUJ3WBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:01:34 -0400
Message-ID: <41840F35.9000700@travellingkiwi.com>
Date: Sat, 30 Oct 2004 23:01:25 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Continual panics... Kernel 2.6.9  - VP6 motherboard dual 866MHz PIII
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.


I have been running fine for several years, but decided to upgrade from 
RH9.0, to Gentoo. It was all going swimmingly for about a day, then the 
crashes started. As I'd justin installed a TV card, I thought I'd 
buggered up the hardware... Static maybe... There's always a first time. 
And the crashes went on while I rmeoved various bits, reseated memory 
etc. Until I accidentally rebooted with my old installation on a second 
HD, and it's stable again...

The main difference, besides RH9.0 vs Gentoot, is that the Gentoo 
installation was running kernel 2.6.9 with ReiserFS filesystems, while 
the RH is 2.4.20 with mainly ext3fs (Although I do have a reiserfs on 
the 2.4 as well).

The main crashes log the following information


Oct 24 22:17:00 damned REISERFS: panic (device hdb6): journal_begin 
called without kernel lock held
Oct 24 22:17:00 damned ------------[ cut here ]------------
Oct 24 22:17:00 damned kernel BUG at fs/reiserfs/prints.c:362!
Oct 24 22:17:00 damned invalid operand: 0000 [#1]
Oct 24 22:17:00 damned SMP
Oct 24 22:17:00 damned Modules linked in: rtc
Oct 24 22:17:00 damned CPU:    1
Oct 24 22:17:00 damned EIP:    0060:[<c01ab6d2>]    Not tainted VLI
Oct 24 22:17:00 damned EFLAGS: 00010292   (2.6.9)  
Oct 24 22:17:00 damned EIP is at reiserfs_panic+0x52/0x80
Oct 24 22:17:00 damned eax: 00000050   ebx: c0478521   ecx: 00000000   
edx: 00000282
Oct 24 22:17:00 damned esi: cffb2a00   edi: cffb2b44   ebp: ca5f3264   
esp: c88a6cc8
Oct 24 22:17:00 damned ds: 007b   es: 007b   ss: 0068 
Oct 24 22:17:00 damned Process jpegtopnm (pid: 6815, threadinfo=c88a6000 
task=c13325d0)
Oct 24 22:17:00 damned Stack: c047f2d8 cffb2b44 c05c5d80 d2b9e000 
c88a6d70 cffb2a00 c01b7354 cffb2a00
Oct 24 22:17:00 damned c0480360 c0478ca2 c01bb3f5 cffb2a00 c0478ca2 
c07a0660 0000004e c26f1f84
Oct 24 22:17:00 damned 00000003 00000000 00000000 00000000 757d5f79 
00081cd0 001d8d26 c120df60
Oct 24 22:17:00 damned Call Trace:
Oct 24 22:17:00 damned [<c01b7354>] reiserfs_check_lock_depth+0x34/0x40
Oct 24 22:17:00 damned [<c01bb3f5>] do_journal_begin_r+0x25/0x2b0
Oct 24 22:17:00 damned [<c01bb82a>] journal_begin+0x6a/0xd0
Oct 24 22:17:00 damned [<c01a88c7>] reiserfs_dirty_inode+0x57/0xe0
Oct 24 22:17:00 damned [<c011445d>] smp_apic_timer_interrupt+0x8d/0x100
Oct 24 22:17:00 damned [<c02cf816>] __copy_to_user_ll+0x46/0x80
Oct 24 22:17:00 damned [<c01a8870>] reiserfs_dirty_inode+0x0/0xe0
Oct 24 22:17:00 damned [<c017a2ea>] __mark_inode_dirty+0x1da/0x1e0
Oct 24 22:17:00 damned [<c014248f>] do_page_cache_readahead+0xcf/0x190
Oct 24 22:17:00 damned [<c0174019>] update_atime+0xd9/0xe0
Oct 24 22:17:00 damned [<c013b108>] do_generic_mapping_read+0x2b8/0x550
Oct 24 22:17:00 damned [<c013b68b>] __generic_file_aio_read+0x20b/0x240
Oct 24 22:17:00 damned [<c013b3a0>] file_read_actor+0x0/0xe0
Oct 24 22:17:00 damned [<c013b7f4>] generic_file_read+0xb4/0xd0
Oct 24 22:17:00 damned [<c0165ea9>] pipe_writev+0x269/0x320
Oct 24 22:17:00 damned [<c011be60>] autoremove_wake_function+0x0/0x60
Oct 24 22:17:00 damned [<c0165f98>] pipe_write+0x38/0x40
Oct 24 22:17:00 damned [<c01751fa>] dnotify_parent+0x3a/0xb0
Oct 24 22:17:00 damned [<c0158fc8>] vfs_read+0xb8/0x130
Oct 24 22:17:00 damned [<c01592b1>] sys_read+0x51/0x80
Oct 24 22:17:00 damned [<c01043bf>] syscall_call+0x7/0xb
Oct 24 22:17:00 damned Code: 01 00 00 89 04 24 e8 0e fd ff ff c7 04 24 
d8 f2 47 c0 85 f6 89 d8 0f 45 c7 ba 80 5d 5c c0 89 54 24 08 89 44 24 04 
e8 ce 2d f7 ff <0f> 0b 6a 01 16 8a 47 c0 c7 04 24 fc f2 47 c0 85 f6 be 
80 5d 5c

The panics were pretty consistent... I was moving photos about on a 
website in gallery. (A php program under apache 2.0.51). The same thing 
works fine under 2.4.20...

Has anyone else experienced any problems with 2.6 and reiserfs 
filesystems that work fine under 2.4?

TIA

Hamish.

