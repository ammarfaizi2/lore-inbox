Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262631AbTCIVYE>; Sun, 9 Mar 2003 16:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262634AbTCIVYE>; Sun, 9 Mar 2003 16:24:04 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:36366
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S262631AbTCIVYB>; Sun, 9 Mar 2003 16:24:01 -0500
Subject: Re: Kernel bug in dcache.h:266; 2.5.64, EIP at sysfs_remove_dir
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Tomasz Torcz, BG" <zdzichu@irc.pl>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.33.0303091427100.994-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0303091427100.994-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1047245678.8985.188.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Mar 2003 13:34:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-09 at 12:31, Patrick Mochel wrote:
> I was able to reproduce the Oops with a USB device on multiple insert/
> removals. The patch below fixes the Oops for me. Could people who have 
> seen the Oops try it out and let me know if it helps them? 
> 
> [ Unfortunately, I can't test some of the exact failure scenarios, as I 
> don't use ppp, and my one system with PCMCIA has decided that it doesn't 
> want to let me (physically) insert cards anymore.. ]

I'm still getting a crash with this patch+mm4.  I got this on ethernet
card removal:

------------[ cut here ]------------
kernel BUG at include/linux/dcache.h:266!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c017a219>]    Not tainted
EFLAGS: 00010246
EIP is at sysfs_remove_dir+0x19/0x178
eax: 00000000   ebx: cb384190   ecx: 00000000   edx: 00000000
esi: c11f0000   edi: c92105e4   ebp: c11f1e00   esp: c11f1dec
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c11f0000 task=c11f4c80)
Stack: c11f1e0c c0127205 cb384190 c11f0000 cb384000 c11f1e10 c01c11ed cb384190
       cb384190 c11f1e20 c01c120d cb384190 00000001 c11f1e4c c022e4de cb384190
       00000202 c02c7014 c11f1e5c c9210288 c11f1e50 cb384000 cb384000 cbda944c
Call Trace:
 [<c0127205>] notifier_call_chain+0x25/0x50
 [<c01c11ed>] kobject_del+0xd/0x20
 [<c01c120d>] kobject_unregister+0xd/0x20
 [<c022e4de>] unregister_netdevice+0x26e/0x290
 [<c01f6af2>] unregister_netdev+0x12/0x20
 [<cc88cbf2>] tulip_remove_one+0x42/0x80 [tulip]
 [<cc893768>] tulip_driver+0x28/0xa0 [tulip]
 [<c01c59ab>] pci_device_remove+0x1b/0x30
 [<c01ce096>] device_release_driver+0x46/0x60
 [<c01ce1fb>] bus_remove_device+0x5b/0xb0
 [<c01cd5fa>] device_del+0x6a/0xa0
 [<c01cd63d>] device_unregister+0xd/0x1c
 [<c01c616e>] pci_remove_bus_device+0x3e/0x80
 [<c01c61d9>] pci_remove_behind_bridge+0x29/0x40
 [<c0219a8f>] cb_free+0x1f/0x50
 [<c0216b01>] shutdown_socket+0x71/0xe0
 [<c0216eae>] parse_events+0x3e/0xf0
 [<c021bd9c>] yenta_bh+0x3c/0x50
 [<c012997d>] worker_thread+0x1bd/0x2a0
 [<c021bd60>] yenta_bh+0x0/0x50
 [<c0118f00>] default_wake_function+0x0/0x20
 [<c0108f56>] ret_from_fork+0x6/0x14
 [<c0118f00>] default_wake_function+0x0/0x20
 [<c01297c0>] worker_thread+0x0/0x2a0
 [<c01072c5>] kernel_thread_helper+0x5/0x10

Code: 0f 0b 0a 01 68 86 28 c0 ff 07 83 4f 04 08 89 7d f0 85 ff 0f

	J


