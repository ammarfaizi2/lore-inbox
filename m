Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271941AbTHDRF3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271944AbTHDRF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:05:29 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:33037 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S271941AbTHDRFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:05:01 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2: resiserfs BUG on Alt-SysRq-U
Date: Mon, 4 Aug 2003 20:56:15 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308042056.15413.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this has been around since 2.5.75 at least and may be before it as well.

-andrey

sh-2.05b# SysRq : Emergency Remount R/O
------------[ cut here ]------------
kernel BUG at fs/reiserfs/journal.c:409!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<d187081a>]    Not tainted
EFLAGS: 00010246
EIP is at reiserfs_check_lock_depth+0x2a/0x40 [reiserfs]
eax: 00000000   ebx: cf369004   ecx: 00000000   edx: ffffcc00
esi: cf369004   edi: cf721f78   ebp: cf721eb4   esp: cf721eac
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 7, threadinfo=cf720000 task=cf749000)
Stack: d187bae0 d187ecb3 cf721ef0 d187375e d187ecb3 3f2e87df 00000000 00000000
       d187e847 00000077 00000000 00000000 00000000 00000000 cf369004 cf28d000
       cf721f78 cf721f08 d1873a46 cf721f24 cf369004 0000000a 00000000 cf721f50
Call Trace:
 [<d187375e>] do_journal_begin_r+0x1e/0x2d0 [reiserfs]
 [<d1873a46>] journal_begin+0x16/0x20 [reiserfs]
 [<d1864310>] reiserfs_remount+0xb0/0x1d0 [reiserfs]
 [<c01662fe>] sync_blockdev+0x2e/0x40
 [<c016c4ec>] do_remount_sb+0xac/0x110
 [<c016c6b6>] do_emergency_remount+0x166/0x1b0
 [<c01494fe>] __pdflush+0x16e/0x390
 [<c011f37f>] schedule_tail+0xbf/0xe0
 [<c0149720>] pdflush+0x0/0x20
 [<c014972f>] pdflush+0xf/0x20
 [<c016c550>] do_emergency_remount+0x0/0x1b0
 [<c0109029>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 99 01 d9 eb 87 d1 58 5a eb dd 8d 76 00 8d bc 27 00 00


