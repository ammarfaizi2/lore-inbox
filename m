Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTEHP4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTEHP4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:56:43 -0400
Received: from rakis.net ([216.235.252.212]:45017 "EHLO egg.rakis.net")
	by vger.kernel.org with ESMTP id S261788AbTEHP4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:56:41 -0400
Date: Thu, 8 May 2003 12:09:18 -0400 (EDT)
From: Greg Boyce <gboyce@rakis.net>
X-X-Sender: gboyce@egg
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Not enough ptys in 2.5.69-mm2
In-Reply-To: <3EBA7AE2.4000004@cox.net>
Message-ID: <Pine.LNX.4.42.0305081206590.15558-100000@egg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 May 2003, Kevin P. Fleming wrote:

> Greg Boyce wrote:

> > gboyce@cthulhu gboyce $ xterm
> > xterm: Error 32, errno 2: No such file or directory
> > Reason: get_pty: not enough ptys
> >
>
> Have you mounted devpts on /dev/pts? If not, that's now mandatory after
> some devfs changes that went in during 2.5.68/2.5.69 timefreame.

Hm.  I thought I had tried that, but apparently not.  Setting /etc/fstab
to mount devpts automatically caused xterms to start properly.  I am
getting a panic now that I didn't get initially though.  After
commenting devpts back out and rebooting, I still got the panic, so it's
probably unrelated.

If anyone is interested, here is the panic.

------------[ cut here ]------------
kernel BUG at include/linux/list.h:140!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c011b4e4>]    Not tainted VLI
EFLAGS: 00010006
EIP is at remove_wait_queue+0x64/0x70
eax: df88be74   ebx: df88a000   ecx: df88be80   edx: df905e08
esi: 00000286   edi: df88be74   ebp: df88be38   esp: df88be30
ds: 007b   es: 007b   ss: 0068
Process hotplug (pid: 73, threadinfo=df88a000 task=dfbe0cc0)
Stack: df905e08 df88a000 df88bea0 c01b912a c03dd6c0 c14ee918 00000000 df905e04
       dff706c0 00000000 dfbe0cc0 c0119e70 00000000 00000000 c0137db9 dfa3d005
       dfaac5b0 00000000 dfbe0cc0 c0119e70 df905e08 df905e08 dfa3d005 00299a31
Call Trace:
 [<c01b912a>] devfs_d_revalidate_wait+0x17a/0x190
 [<c0119e70>] default_wake_function+0x0/0x20
 [<c0137db9>] __alloc_pages+0x329/0x390
 [<c0119e70>] default_wake_function+0x0/0x20
 [<c015d5ac>] do_lookup+0x5c/0xb0
 [<c015daa2>] link_path_walk+0x4a2/0x900
 [<c015e836>] open_namei+0x76/0x470
 [<c014e111>] filp_open+0x41/0x70
 [<c014e5f5>] sys_open+0x55/0x90
 [<c010954b>] syscall_call+0x7/0xb

Code: 43 08 83 e0 08 75 0b 8b 1c 24 8b 74 24 04 89 ec 5d c3 8b 1c 24 8b 74 24 04 89 ec 5d e9 46 e9 ff ff 0f 0b 8d 00 b5 65 37 c0 eb ca <0f> 0b 8c 00 b5 65 37 c0 eb b8 89 f6 55 89 e5 83 ec 0c 89 1c 24
 <6>note: hotplug[73] exited with preempt_count 1

