Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262163AbSJNU6f>; Mon, 14 Oct 2002 16:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262176AbSJNU6e>; Mon, 14 Oct 2002 16:58:34 -0400
Received: from mail128.mail.bellsouth.net ([205.152.58.88]:24848 "EHLO
	imf28bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S262163AbSJNU6a>; Mon, 14 Oct 2002 16:58:30 -0400
Date: Mon, 14 Oct 2002 17:04:15 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: [2.5.42-bk2] poisoned oops in nfsd?
Message-ID: <Pine.LNX.4.43.0210141656000.4629-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.42-bk2, I tried to play a wav file for the first time since reboot,
and get this oops in NFSd.

Kernel compiled with Preempt, and slab debugging.

Unable to handle kernel paging request at virtual address 5a5a5a66
 printing eip:
c0266a61
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c0266a61>]    Not tainted
EFLAGS: 00010202
EIP is at auth_domain_drop+0x9/0x50
eax: 5a5a5a5a   ebx: c9e39e3c   ecx: 5a5a5a5a   edx: c02d3580
esi: c03d9090   edi: 00000001   ebp: c9e39f5c   esp: c9609f9c
ds: 0068   es: 0068   ss: 0068
Process nfsd (pid: 956, threadinfo=c9608000 task=c9641960)
Stack: c9e39e3c c0266ab7 5a5a5a5a c02d3580 c0266e2d 5a5a5a5a c9e39e3c c02687b0
       c9e39e3c c02d35e0 c9608000 fffffff5 00000000 c018a5b6 c018a4cc 00000000
       00000000 00000000 c960dfe4 c9607fe4 c9641960 c0105499 c979ea00 00000000
Call Trace:
 [<c0266ab7>] auth_domain_put+0xf/0x14
 [<c0266e2d>] ip_map_put+0x41/0x4c
 [<c02687b0>] cache_clean+0x1b8/0x1e0
 [<c018a5b6>] nfsd+0xea/0x340
 [<c018a4cc>] nfsd+0x0/0x340
 [<c0105499>] kernel_thread_helper+0x5/0xc

Code: ff 49 0c 8b 41 0c 85 c0 75 0b 8b 41 04 3b 42 2c 7d 03 89 42
 <6>note: nfsd[956] exited with preempt_count 1


CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y

CONFIG_SOUND=y
CONFIG_SOUND_PRIME=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_CS4232=y


--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


