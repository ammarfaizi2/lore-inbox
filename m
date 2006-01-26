Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWAZD7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWAZD7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWAZD7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:59:46 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:17113 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932219AbWAZD7p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:59:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=f3IPMiYH7o6OTd+bB/f6MVZG+Tz5DoRvsMKjKfsQG23qxP30LliiAgpjqLa1NI9utP/aQzlJCNP6jqel0Dl2msW5h0mStnB7vtSkq4HXIogt7PttWIIZ1BhKwzxkiirtdHBr/ZlGJ0qW1akaXYMh3HT+7Ls1Sw6Wl4s0CvdmZzs=
Message-ID: <aa4c40ff0601251959p5f119d5aye42ec61ff430de82@mail.gmail.com>
Date: Wed, 25 Jan 2006 19:59:39 -0800
From: James Lamanna <jlamanna@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: OOPS while doing amdump - 2.6.14
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Received the following oops from 2.6.14-gentoo-r5 while doing an amdump
(holding disk is on a reiserfs partition)
Sorry for the formatting, syslog kinda killed some if it (captured via
netconsole):

Machine is a Dual Opteron 246.
Filesystem is on a 3Ware Escalade 9550 (Raid 5).
System was totally dead at this point.

Unable to handle kernel paging request
at 0000100000000000 RIP:
"<ffffffff801d7e6a>{reiserfs_add_ordered_list+106}"
PGD 0
Oops: 0002 [1]
SMP
CPU 1
Modules linked in:
Pid: 15638, comm: dumper Not tainted 2.6.14-gentoo-r5 #2
RIP: 0010:[<ffffffff801d7e6a>]
"<ffffffff801d7e6a>{reiserfs_add_ordered_list+106}"
RSP: 0018:ffff810030dd7ad8  EFLAGS: 00010286
RAX: ffff81007b378a38 RBX: ffff81007b378ad8 RCX: 0000100000000000
RDX: ffff810040be82d8 RSI: ffff81007b378ad8 RDI: ffffc20000051168
RBP: ffff81007b378a28 R08: ffff81004050b888 R09: 00000000fffffffa
R10: 0000000000000000 R11: ffff81001a7b7e48 R12: ffffc20000051000
R13: ffffc20000051168 R14: ffff81003e299100 R15: ffff81007b378ad8
FS:  00002aaaab8086e0(0000) GS:ffffffff8068d880(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000100000000000 CR3: 0000000026dc9000 CR4: 00000000000006e0
Process dumper (pid: 15638, threadinfo ffff810030dd6000, task ffff81002e5dd600)
Stack:
ffff81003e299238
ffff81007b378ad8
0000000000001000
0000000000000001
ffff8100411ec800
ffffffff801c5c42
0000000000000000
0000000000000001
0000000000001d88
0000000000001000
Call Trace:
"<ffffffff801c5c42>{reiserfs_commit_page+418}"
"<ffffffff801c7da4>{reiserfs_file_write+5956}"
"<ffffffff8040a1e9>{release_sock+25}"
"<ffffffff801900a0>{__pollwait+0}"
"<ffffffff8014b7e0>{autoremove_wake_function+0}"
"<ffffffff8017c498>{vfs_write+200}"
"<ffffffff8017c633>{sys_write+83}"
"<ffffffff8010d8e6>{system_call+126}"

Code:
48 89 11 48 89 40 08 48 89 45 10 eb 2d f0 ff 43 18 e8 00 fe

RIP "<ffffffff801d7e6a>{reiserfs_add_ordered_list+106}"
RSP <ffff810030dd7ad8> CR2: 0000100000000000

Badness in do_exit at kernel/exit.c:799
Call Trace:
"<ffffffff80138082>{do_exit+82}"
"<ffffffff804998e5>{_spin_unlock_irqrestore+5}"
"<ffffffff8049b412>{do_page_fault+1890}"
"<ffffffff8010e5b9>{error_exit+0}"
"<ffffffff801d7e6a>{reiserfs_add_ordered_list+106}"
"<ffffffff801d7e44>{reiserfs_add_ordered_list+68}"
"<ffffffff801c5c42>{reiserfs_commit_page+418}"
"<ffffffff801c7da4>{reiserfs_file_write+5956}"
"<ffffffff8040a1e9>{release_sock+25}"
"<ffffffff801900a0>{__pollwait+0}"
"<ffffffff8014b7e0>{autoremove_wake_function+0}"
"<ffffffff8017c498>{vfs_write+200}"
"<ffffffff8017c633>{sys_write+83}"
"<ffffffff8010d8e6>{system_call+126}"

BUG: soft lockup detected on CPU#1!
CPU 1:

Modules linked in:

Pid: 23511, comm: syslog-ng Not tainted 2.6.14-gentoo-r5 #2
RIP: 0010:[<ffffffff80499b67>]
"<ffffffff80499b67>{.text.lock.spinlock+0}"

RSP: 0018:ffff81005e339ad0  EFLAGS: 00000282
RAX: ffff810041adeb20 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff81004114a000 RSI: 0000000000000050 RDI: ffffc20000051168
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffc20000077410
R10: 0000000000000004 R11: ffff81004fa43b30 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00002aaaab00e6e0(0000) GS:ffffffff8068d880(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000100000000000 CR3: 000000005d6ce000 CR4: 00000000000006e0

Call Trace:
"<ffffffff801d7e8b>{reiserfs_add_ordered_list+139}"
"<ffffffff801c5c42>{reiserfs_commit_page+418}"
"<ffffffff801c7da4>{reiserfs_file_write+5956}"
"<ffffffff80135e98>{release_console_sem+392}"
"<ffffffff8018b84f>{link_path_walk+367}"
"<ffffffff802cf64f>{write_chan+879}"
"<ffffffff80130023>{__wake_up+67}"
"<ffffffff802c9094>{tty_ldisc_deref+116}"
"<ffffffff802c9761>{tty_write+577}"
"<ffffffff8017c498>{vfs_write+200}"
"<ffffffff8017c633>{sys_write+83}"
"<ffffffff8010d8e6>{system_call+126}"

BUG: soft lockup detected on CPU#0!
CPU 0:

Modules linked in:

Pid: 15636, comm: driver Not tainted 2.6.14-gentoo-r5 #2
RIP: 0010:[<ffffffff80499b69>]
"<ffffffff80499b69>{.text.lock.spinlock+2}"

RSP: 0018:ffff810012087ad0  EFLAGS: 00000282
RAX: ffff81003f859a20 RBX: ffffffff801c6353 RCX: 0000000000000000
RDX: ffff81003ffee800 RSI: 0000000000000050 RDI: ffffc20000051168
RBP: 0000000000000001 R08: 0000000000000000 R09: ffff8100411ec800
R10: ffff810041145dc0 R11: ffff810078a49920 R12: 0000000000001000
R13: 0000000000000ec2 R14: 0000000000000001 R15: ffff81003f485a60
FS:  00002aaaab8086e0(0000) GS:ffffffff8068d800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000514948 CR3: 000000001e542000 CR4: 00000000000006e0

Call Trace:
"<ffffffff801d7e8b>{reiserfs_add_ordered_list+139}"
"<ffffffff801c5c42>{reiserfs_commit_page+418}"
"<ffffffff801c7da4>{reiserfs_file_write+5956}"
"<ffffffff8015bc26>{buffered_rmqueue+662}"
"<ffffffff8015bba2>{buffered_rmqueue+530}"
"<ffffffff804075d1>{sock_aio_read+273}"
"<ffffffff80169ea9>{__handle_mm_fault+441}"
"<ffffffff8017c103>{do_sync_read+211}"
"<ffffffff8049b139>{do_page_fault+1161}"
"<ffffffff8014b7e0>{autoremove_wake_function+0}"
"<ffffffff8017c498>{vfs_write+200}"
"<ffffffff8017c633>{sys_write+83}"
"<ffffffff8010d8e6>{system_call+126}"
