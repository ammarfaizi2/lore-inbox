Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUAVJap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 04:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbUAVJap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 04:30:45 -0500
Received: from mail36.messagelabs.com ([193.109.254.211]:37265 "HELO
	mail36.messagelabs.com") by vger.kernel.org with SMTP
	id S266006AbUAVJai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 04:30:38 -0500
X-VirusChecked: Checked
X-Env-Sender: okiddle@yahoo.co.uk
X-Msg-Ref: server-6.tower-36.messagelabs.com!1074763833!3305086
X-StarScan-Version: 5.1.15; banners=-,-,-
X-VirusChecked: Checked
X-StarScan-Version: 5.0.7; banners=.,-,-
In-reply-to: <20040120183556.GE23765@srv-lnx2600.matchmail.com> 
From: Oliver Kiddle <okiddle@yahoo.co.uk>
References: <7641.1074512162@gmcs3.local> <20040119193837.6369d498.akpm@osdl.org> <30705.1074618514@gmcs3.local> <20040120183556.GE23765@srv-lnx2600.matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure 
Date: Thu, 22 Jan 2004 10:29:48 +0100
Message-ID: <11370.1074763788@gmcs3.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Tue, Jan 20, 2004 at 06:08:34PM +0100, Oliver Kiddle wrote:
> > the message about the tape device. As suggested by Mike Fedyk, I had
> > the nmi_watchdog stuff enabled. Didn't see any output from it though.
> > Would that have displayed its output to the console?
> 
> It should have.  Run cat /proc/interrupts and again afew seconds later, does
> the NMI: number change?

Yes, the number changes. Still haven't seen any output from it though.

> There should be some lines above this in your log...

Only the trace for other processes. Any initial part was lost, probably
because the task list overflowed the dmesg buffer. I didn't see anything
on the console though.

I got a few page allocation errors yesterday. As they now include
dump_stack() output, I have attached them below. This time, the system
kept going for a few minutes after these error messages. Again, when it
locked up, killing all processes with the sysrq key got things temporarily
back. I have the full dmesg output if anyone wants.

Oliver

st0: Block limits 1 - 16777215 bytes.
xfsdump: page allocation failure. order:9, mode:0xd0
Call Trace:
 [<c0132d18>] __alloc_pages+0x2db/0x319
 [<c02a5dc9>] enlarge_buffer+0xcf/0x182
 [<c02a6cd9>] st_map_user_pages+0x37/0x88
 [<c02a2909>] setup_buffering+0xf3/0x127
 [<c02a3690>] st_read+0xe0/0x3d1
 [<c0147625>] vfs_read+0xb0/0x119
 [<c01478a0>] sys_read+0x42/0x63
 [<c0108ab7>] syscall_call+0x7/0xb

xfsdump: page allocation failure. order:8, mode:0xd0
Call Trace:
 [<c0132d18>] __alloc_pages+0x2db/0x319
 [<c02a5dc9>] enlarge_buffer+0xcf/0x182
 [<c02a6cd9>] st_map_user_pages+0x37/0x88
 [<c02a2909>] setup_buffering+0xf3/0x127
 [<c02a3690>] st_read+0xe0/0x3d1
 [<c0147625>] vfs_read+0xb0/0x119
 [<c01478a0>] sys_read+0x42/0x63
 [<c0108ab7>] syscall_call+0x7/0xb

xfsdump: page allocation failure. order:7, mode:0xd0
Call Trace:
 [<c0132d18>] __alloc_pages+0x2db/0x319
 [<c02a5dc9>] enlarge_buffer+0xcf/0x182
 [<c02a6cd9>] st_map_user_pages+0x37/0x88
 [<c02a2909>] setup_buffering+0xf3/0x127
 [<c02a3690>] st_read+0xe0/0x3d1
 [<c0147625>] vfs_read+0xb0/0x119
 [<c01478a0>] sys_read+0x42/0x63
 [<c0108ab7>] syscall_call+0x7/0xb

st0: Incorrect block size.
xfsdump: page allocation failure. order:9, mode:0xd0
Call Trace:
 [<c0132d18>] __alloc_pages+0x2db/0x319
 [<c02a5dc9>] enlarge_buffer+0xcf/0x182
 [<c02a6cd9>] st_map_user_pages+0x37/0x88
 [<c02a2909>] setup_buffering+0xf3/0x127
 [<c02a2b86>] st_write+0x20c/0x7e7
 [<c0115ecb>] do_page_fault+0x120/0x501
 [<c02a297a>] st_write+0x0/0x7e7
 [<c01477f5>] vfs_write+0xb0/0x119
 [<c0147903>] sys_write+0x42/0x63
 [<c0108ab7>] syscall_call+0x7/0xb

xfsdump: page allocation failure. order:8, mode:0xd0
Call Trace:
 [<c0132d18>] __alloc_pages+0x2db/0x319
 [<c02a5dc9>] enlarge_buffer+0xcf/0x182
 [<c02a6cd9>] st_map_user_pages+0x37/0x88
 [<c02a2909>] setup_buffering+0xf3/0x127
 [<c02a2b86>] st_write+0x20c/0x7e7
 [<c0115ecb>] do_page_fault+0x120/0x501
 [<c02a297a>] st_write+0x0/0x7e7
 [<c01477f5>] vfs_write+0xb0/0x119
 [<c0147903>] sys_write+0x42/0x63
 [<c0108ab7>] syscall_call+0x7/0xb

xfsdump: page allocation failure. order:7, mode:0xd0
Call Trace:
 [<c0132d18>] __alloc_pages+0x2db/0x319
 [<c02a5dc9>] enlarge_buffer+0xcf/0x182
 [<c02a6cd9>] st_map_user_pages+0x37/0x88
 [<c02a2909>] setup_buffering+0xf3/0x127
 [<c02a2b86>] st_write+0x20c/0x7e7
 [<c0115ecb>] do_page_fault+0x120/0x501
 [<c02a297a>] st_write+0x0/0x7e7
 [<c01477f5>] vfs_write+0xb0/0x119
 [<c0147903>] sys_write+0x42/0x63
 [<c0108ab7>] syscall_call+0x7/0xb

