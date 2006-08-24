Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbWHXR6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbWHXR6f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWHXR6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:58:35 -0400
Received: from bay0-omc2-s32.bay0.hotmail.com ([65.54.246.168]:45049 "EHLO
	bay0-omc2-s32.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751657AbWHXR6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:58:34 -0400
Message-ID: <BAY123-F83FB9BEE7F065A45CA6BDDF440@phx.gbl>
X-Originating-IP: [75.34.181.35]
X-Originating-Email: [dravet@hotmail.com]
From: "Jason Dravet" <dravet@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: INFO: possible recursive locking detected
Date: Thu, 24 Aug 2006 12:58:29 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 24 Aug 2006 17:58:33.0983 (UTC) FILETIME=[EA86A8F0:01C6C7A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a recent attempted install of fedora's rawhide I saw the following in my 
anaconda.log file.

<4>=============================================
<4>[ INFO: possible recursive locking detected ]
<4>2.6.17-1.2571.fc6 #1
<4>---------------------------------------------
<4>anaconda/432 is trying to acquire lock:
<4> (&bdev->bd_mutex){--..}, at: [<c04658bb>] __blkdev_put+0x1f/0x11f
<4>
<4>but task is already holding lock:
<4> (&bdev->bd_mutex){--..}, at: [<c0465b4e>] do_open+0x6b/0x3b2
<4>
<4>other info that might help us debug this:
<4>1 lock held by anaconda/432:
<4> #0:  (&bdev->bd_mutex){--..}, at: [<c0465b4e>] do_open+0x6b/0x3b2
<4>
<4>stack backtrace:
<4> [<c04037db>] show_trace_log_lvl+0x58/0x159
<4> [<c0403d9e>] show_trace+0xd/0x10
<4> [<c0403e3b>] dump_stack+0x19/0x1b
<4> [<c042bddb>] __lock_acquire+0x765/0x97c
<4> [<c042c563>] lock_acquire+0x4b/0x6c
<4> [<c05f37ee>] mutex_lock_nested+0xcb/0x214
<4> [<c04658bb>] __blkdev_put+0x1f/0x11f
<4> [<c04659d4>] blkdev_put+0xa/0xc
<4> [<c0465e26>] do_open+0x343/0x3b2
<4> [<c0466030>] blkdev_open+0x1f/0x48
<4> [<c045d83c>] __dentry_open+0xb8/0x186
<4> [<c045d978>] nameidata_to_filp+0x1c/0x2e
<4> [<c045d9b9>] do_filp_open+0x2f/0x36
<4> [<c045da00>] do_sys_open+0x40/0xbb
<4> [<c045daa7>] sys_open+0x16/0x18
<4> [<c0402e57>] syscall_call+0x7/0xb
<4>DWARF2 unwinder stuck at syscall_call+0x7/0xb
<4>Leftover inexact backtrace:
<4> [<c0403d9e>] show_trace+0xd/0x10
<4> [<c0403e3b>] dump_stack+0x19/0x1b
<4> [<c042bddb>] __lock_acquire+0x765/0x97c
<4> [<c042c563>] lock_acquire+0x4b/0x6c
<4> [<c05f37ee>] mutex_lock_nested+0xcb/0x214
<4> [<c04658bb>] __blkdev_put+0x1f/0x11f
<4> [<c04659d4>] blkdev_put+0xa/0xc
<4> [<c0465e26>] do_open+0x343/0x3b2
<4> [<c0466030>] blkdev_open+0x1f/0x48
<4> [<c045d83c>] __dentry_open+0xb8/0x186
<4> [<c045d978>] nameidata_to_filp+0x1c/0x2e
<4> [<c045d9b9>] do_filp_open+0x2f/0x36
<4> [<c045da00>] do_sys_open+0x40/0xbb
<4> [<c045daa7>] sys_open+0x16/0x18
<4> [<c0402e57>] syscall_call+0x7/0xb

Also posted at https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=203137


