Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265228AbSKJWnJ>; Sun, 10 Nov 2002 17:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSKJWnJ>; Sun, 10 Nov 2002 17:43:09 -0500
Received: from horkos.telenet-ops.be ([195.130.132.45]:51882 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S265228AbSKJWnI> convert rfc822-to-8bit; Sun, 10 Nov 2002 17:43:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bdschuym@pandora.be>
To: linux-kernel@vger.kernel.org
Subject: oops when adding bridge interface, using v2.5.45
Date: Mon, 11 Nov 2002 00:52:29 +0100
X-Mailer: KMail [version 1.4]
Cc: buytenh@gnu.org
References: <Pine.GSO.4.21.0211101348350.24061-100000@steklov.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0211101348350.24061-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211110052.29495.bdschuym@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ever since I've been using the bridge with a 2.5 kernel I've been having a 
non-fatal oops when adding a bridge interface: adding a bridge works, then 
adding a first interface gives the oops below, adding a second interface 
works. Note that the bridge behaves correct afaik (as in "it works") and both 
interfaces get created, which is why this was no priority.

net/bridge/br_if.c::new_nbp() does
	p = kmalloc(sizeof(*p), GFP_KERNEL);
which triggers the oops through mm/slab.c::kmem_flagcheck()
I don't know what is wrong (I have no such problems with 2.4).

The trace is below:

Debug: sleeping function called from illegal context at mm/slab.c:1304
Call Trace:
 [<c011a93e>] __might_sleep+0x52/0x54
 [<c013b18e>] kmem_flagcheck+0x1e/0x54
 [<c013bf04>] kmalloc+0x54/0x134
 [<d084864e>] new_nbp+0x22/0xb8 [bridge]
 [<d084ba65>] .rodata+0x485/0xf60 [bridge]
 [<d0848826>] br_add_if+0x8e/0x1a4 [bridge]
 [<d0848ee0>] br_ioctl_device+0x60/0x454 [bridge]
 [<d084d92c>] ioctl_mutex+0x0/0x18 [bridge]
 [<c0114829>] smp_local_timer_interrupt+0xbd/0xd4
 [<d084d92c>] ioctl_mutex+0x0/0x18 [bridge]
 [<c0136943>] filemap_nopage+0xeb/0x2b4
 [<c0136973>] filemap_nopage+0x11b/0x2b4
 [<d08494a4>] br_ioctl+0x68/0x7c [bridge]
 [<d08471aa>] br_dev_do_ioctl+0x4a/0x5c [bridge]
 [<c0287870>] dev_ifsioc+0x344/0x360
 [<c0287ada>] dev_ioctl+0x24e/0x2f4
 [<c027fc7d>] sock_ioctl+0x95/0x354
 [<c015f09a>] sys_ioctl+0x25e/0x2d5
 [<c0108eb7>] syscall_call+0x7/0xb

-- 
cheers,
Bart

