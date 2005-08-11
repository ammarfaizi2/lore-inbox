Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVHKQAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVHKQAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVHKQAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:00:05 -0400
Received: from cramus.icglink.com ([66.179.92.18]:26341 "EHLO mx03.icglink.com")
	by vger.kernel.org with ESMTP id S932240AbVHKQAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:00:01 -0400
Date: Thu, 11 Aug 2005 10:59:54 -0500
From: Phil Dier <phil@icglink.com>
To: linux-kernel@vger.kernel.org
Cc: ziggy <ziggy@icglink.com>, Scott Holdren <scott@icglink.com>,
       Jack Massari <jack@icglink.com>
Subject: 2.6.13-rc6 Oops with Software RAID, LVM, JFS, NFS
Message-Id: <20050811105954.31f25407.phil@icglink.com>
Organization: ICGLink
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted an oops a few days ago from 2.6.12.3 [1].  Here are the results
of my tests on 2.6.13-rc6.  The kernel oopses, but it the box isn't completely
hosed; I can still log in and move around.  It appears that the only things that are
locked are the apps that were doing i/o to the test partition.  More detailed info 
about my configuration can be found here:

<http://www.icglink.com/debug-2.6.13-rc6.html>

Here is the oops:

Oops: 0000 [#1]
SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c0116dd0>]    Not tainted VLI
EFLAGS: 00010207   (2.6.13-rc6)
EIP is at kmap+0x10/0x30
eax: 00000003   ebx: d0977440   ecx: c9efb470   edx: 00000000
esi: c1000000   edi: 00000000   ebp: ce59d570   esp: f7adde18
ds: 007b   es: 007b   ss: 0068
Process md4_raid1 (pid: 6442, threadinfo=f7adc000 task=f70eda20)
Stack: c014e0bd c9efb470 00000001 00000000 00000000 cb129000 00000001 e0c65f00
       f7dcbe18 087641ef 00000000 f7dcbe18 c014e146 f7dcbe18 f7addeb0 c3146940
       c033f03f f7dcbe18 f7addeb0 0021d906 00000000 0000003f 00000040 00000000
Call Trace:
 [<c014e0bd>] __blk_queue_bounce+0x20d/0x260
 [<c014e146>] blk_queue_bounce+0x36/0x60
 [<c033f03f>] __make_request+0x5f/0x560
 [<c0132b90>] autoremove_wake_function+0x0/0x60
 [<c033f921>] generic_make_request+0x151/0x230
 [<c0132b90>] autoremove_wake_function+0x0/0x60
 [<c04a5fac>] schedule+0x62c/0xcb0
 [<c04a5fe0>] schedule+0x660/0xcb0
 [<c0132b90>] autoremove_wake_function+0x0/0x60
 [<c0126973>] del_timer+0x73/0x80
 [<c033db0d>] blk_remove_plug+0x3d/0x80
 [<c03feed9>] raid1d+0x289/0x2a0
 [<c0414bb3>] md_thread+0x143/0x190
 [<c0132b90>] autoremove_wake_function+0x0/0x60
 [<c0102ed2>] ret_from_fork+0x6/0x14
 [<c0132b90>] autoremove_wake_function+0x0/0x60
 [<c0414a70>] md_thread+0x0/0x190
 [<c01011b5>] kernel_thread_helper+0x5/0x10
Code: 00 40 c7 46 0c 90 30 15 c0 c7 46 10 90 31 15 c0 eb b9 90 90 90 90 90 90 90 90 90 8b 4c 24 04 8b 01 c1 e8 1e 8b 14 85 14 f4 63 c0 <8b> 82 0c 04 00 00 05 00 09 00 00 39 c2 74 05 e9 ac 73 03 00 89


Thanks for looking..


-- 

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
