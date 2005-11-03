Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbVKCSKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbVKCSKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbVKCSKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:10:24 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:59910 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1030402AbVKCSKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:10:23 -0500
Date: Thu, 3 Nov 2005 18:10:17 +0000 (GMT)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: trond.myklebust@fys.uio.no
cc: linux-kernel@vger.kernel.org
Subject: Kernel BUG
Message-ID: <Pine.LNX.4.10.10511031746300.3457-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

I am running a sparc-linux kernel using an NFS Root and it is falling over
with the trace below.

My Kernel is not a standard kernel (I have had to tweek it to get the
SBUS GC3 and the 82077 floppy to work on my OPUS Sparc 1 clone).

Can you advise me on any known issues in the NFS Client code that might
enter NULL pointers into the 'slot->slots[i]' in __lookup_tag.

If there are none that you are aware of, are there any specific areas that
I should investigate with printk statements.

The Kernel is cross compiled on an Athlon 64 3400+ (32bit linux at the
moment) using GCC-4.0.2 and Binutils-2.16.1. Compilation takes about 10
minutes so there is no real issue in making changes to the kernel to find
the source of the problem.

A compiler/binutils bug should not be ruled out. I might try
gcc-3.4.3/binutils-2.15.

Please let me know if you would like further information.

Regards
	Mark Fortescue.
--------------------------------------------------------------------------
kernel BUG at /L64/src/linux-2.6/linux-2.6.13.4-p01/lib/radix-tree.c:575!
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
ld(45): Kernel bad trap [#1]
PSR: 004000c4 PC: f00e0ff4 NPC: f00e0ff8 Y: 00000000    Not tainted
PC: <radix_tree_gang_lookup_tag+0x144/0x1ac>
%G: 00000001 f022ec00  f022eccc 00400fe2  f002fd18 f022ec00  ff020000
00000000
%O: 0000004d f01fbd78  0000023f 00000000  00000001 00000000  ff021a48
f00e0fec
RPC: <radix_tree_gang_lookup_tag+0x13c/0x1ac>
%L: 00000001 ff021b14  0000003f 00000001  00000002 00000000  ff020000
e0162000
%I: 00000000 ff021b14  00000000 00000001  00000008 ff021b10  ff021ab0
f00b10d4
Caller[f00b10d4]: nfs_wait_on_requests+0x98/0xb8
Caller[f00b2a70]: nfs_sync_inode+0x20/0x74
Caller[f00b063c]: nfs_readpage+0x44/0x44c
Caller[f004fc8c]: do_generic_mapping_read+0x290/0x564
Caller[f005084c]: __generic_file_aio_read+0x168/0x1cc
Caller[f0050a2c]: generic_file_aio_read+0x44/0x54
Caller[f006e298]: do_sync_read+0x94/0xc8
Caller[f006e62c]: vfs_read+0xa0/0x15c
Caller[f006f200]: sys_read+0x30/0x64
Caller[f001144c]: syscall_is_too_hard+0x34/0x40
Caller[e0096e58]: 0xe0096e58
Instruction DUMP: 90122178  7ffcc514  01000000 <91d02005> 9402a001
80a28010  0280000f  c4244001  8600e001 

--------------------------------------------------------------------------


