Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267130AbSK2TDC>; Fri, 29 Nov 2002 14:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbSK2TDC>; Fri, 29 Nov 2002 14:03:02 -0500
Received: from bgp927589bgs.brghtn01.mi.comcast.net ([68.41.11.66]:59009 "EHLO
	comcast.net") by vger.kernel.org with ESMTP id <S267130AbSK2TDB>;
	Fri, 29 Nov 2002 14:03:01 -0500
Date: Fri, 29 Nov 2002 14:11:36 +0000 (UTC)
From: Alex Goddard <agoddard@purdue.edu>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] Problem Booting 2.5.50
Message-ID: <Pine.LNX.4.44.0211291336040.1182-100000@dust.ebiz-gw.wintek.com>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.45-49 worked fine.  Here's the output, I can provide .config and 
anything else at request.

Oops: 0000
CPU: 0
EIP: 0060:[<c017c04d>]   Not Tainted
EFLAGS: 00010202
EIP: is at ext3_get_inode_loc+0x2d/0x1a0
eax: e7237610  ebx: 00000000  ecx: 00000000  edx: 5a5a5a5a
esi: 5a5a5a5a  edi: e721dec0  edp: e721de78  esp: e721de4c
ds: 0068  es: 0068  ss: 0068
Process mount (pid: 248, threadinfo=e721c000, task=e7708700)
Stack: 

  e7f9c9a4 e7237590 e7c65c80 e7dcde00 e7f9c9a4 e7234594 e7249e84 00000296
  00000000 e75c2584 e7249ec0 e7249eac c017cd4a e7234610 e7249ec0 c01823bd
  e7f9c9a4 e7237594 e7249ea8 c015ace6 e7234610 e7249ec0 e75c2584 e7234610

Call Trace:
	[<c017cd4a>] ext3_reserve_inode_write+0x2a/0xe0
	[<c01823bd>] ext3_destroy_inode+0x1d/0x20
	[<c015ace6>] destory_inode+0x36/0x50
	[<c017ce28>] ext3_mark_inode_dirty+0x28/0x50
	[<c017fe12>] ext3_add_nondir+0x52/0x60
	[<c0151601>] vfs_create+0x61/0xb0
	[<c0151b63>] open_namei+0x363/0x3c0
	[<c0142fe1>] filp_open+0x41/0x70
	[<c0143413>] sys_open+0x53/0x90
	[<c010940b>] sys_call+0x7/0xb

Code: 8b 86 24 01 00 00 3b 50 50 72 0d 8b 9e 24 01 00 00 8b 43 2c

I can't tell if this affects performance or anything one way or another
because my machine dies after the above oops, but I also get another trace
earlier in the boot, during the initialization of my framebuffer console:

Uninitialized timer!
This is just a warning.  Your computer is OK.
function=0xc02af940, data=0x0
Call Trace:
	[<c011fc1f>] check_timer_failed+0x5f/0x70
	[<c02af940>] cursor_timer_handler+0x0/0x40
	[<c011fc70>] add_timer+0x40/0xb0
	[<c02afcad>] fbcon_startup+0x4d/0x50
	[<c0277267>] take_over_console+0x27/0x2c0
	[<c01196cc>] call_console_drivers+0x5c/0x120
	[<c02aef0a>] register_framebuffer+0x12a/0x1a0
	[<c02af18a>] fb_alloc_cmap+0x10a/0x170
	[<c0105078>] init+0x38/0x160
	[<c0105040>] init+0x0/0x160
	[<c010753d>] kernel_thread_helper+0x5/0x18

-- 
Alex Goddard
agoddard@purdue.edu

