Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273207AbRIJFUo>; Mon, 10 Sep 2001 01:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273208AbRIJFUe>; Mon, 10 Sep 2001 01:20:34 -0400
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:12731 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id <S273207AbRIJFUZ>; Mon, 10 Sep 2001 01:20:25 -0400
Message-Id: <200109100520.BAA28255@melbourne-city-street.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG, page_alloc.c, 2.4.10-pre5
Date: Mon, 10 Sep 2001 01:21:05 -0400
From: Christopher J Peikert <cpeikert@MIT.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First, my hardware and kernel config:

AMD Athlon 1.4G, VIA KT266 chipset, UDMA100 EIDE, 512M DDR RAM, 8139
NIC

2.4.10-pre5 with KT266 AGP patch and au8820 1.1.2 sound driver

The problem: while scp'ing several files over my local net, scp dies
after transmitting about 50M, and in /var/log/messages I get:

kernel: kernel BUG at page_alloc.c:204!
kernel: invalid operand: 0000
kernel: CPU:    0
kernel: EIP:    0010:[rmqueue+570/624]
kernel: EFLAGS: 00010282
kernel: eax: 00000020   ebx: 00000001   ecx: da674000 edx: d36ef540
kernel: esi: c1002a08   edi: c024a9a4   ebp: 00000000 esp: da675e98
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process ssh (pid: 1275, stackpage=da675000)
kernel: Stack: c0206d46 c0206e1a 000000cc c024a980 c024aba4 00000000 d0c474e8 0000009e
kernel:        00000286 c024a9a4 00000000 c024a980 c01299e3 000001f0 da675f6c d8edbec0
kernel:        d0c474e8 00000001 c024ab9c 000001f0 c0129966 00000000 c0129c0a c013ce93
kernel: Call Trace: [__alloc_pages+115/656] [_alloc_pages+22/32] [__get_free_pages+10/32] [__pollwait+51/144] [tcp_poll+46/336]
kernel:    [sock_poll+35/48] [do_select+230/480] [sys_select+810/1136] [system_call+51/56]
kernel:
kernel: Code: 0f 0b 83 c4 0c 90 89 f0 eb 1c 47 83 44 24 18 0c 83 ff 09 0f

Doing it again, I get something slightly different:

kernel: kernel BUG at page_alloc.c:81!
kernel: invalid operand: 0000
kernel: CPU:    0
kernel: EIP:    0010:[__free_pages_ok+168/768]
kernel: EFLAGS: 00010282
kernel: eax: 0000001f   ebx: c1002a08   ecx: d8698000 edx: df7e4540
kernel: esi: d3125de4   edi: 00000000   ebp: 00000000 esp: d8699e20
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process scp (pid: 1338, stackpage=d8699000)
kernel: Stack: c0206d46 c0206e1a 00000051 c1002a08 d3125de4 00000000 00000000 00000000
kernel:        c1002a08 c1002a08 c0121b68 c1002a08 c0129c6a c0121d8f c1002a08 d8699e94
kernel:        00000000 00000000 d3125de4 00000000 c1002a08 d8699e94 c0121e6d d3125de4
kernel: Call Trace: [remove_inode_page+40/48] [__free_pages+26/32] [truncate_list_pages+319/448] [truncate_inode_pages+93/160] [vmtruncate+157/320]
kernel:    [inode_setattr+54/176] [notify_change+124/192] [do_truncate+73/96] [lookup_hash+68/144] [open_namei+1081/1376] [filp_open+59/96]
kernel:    [sys_open+56/192] [system_call+51/56]
kernel:
kernel: Code: 0f 0b 83 c4 0c 8d 76 00 8b 43 18 a8 20 74 19 6a 53 68 1a 6e

In fact, now every major application I try to load (e.g., konquerer)
causes this error message.

Thoughts?  I would appreciate a direct reply, as I'm not subscribed
to the list.

thanks,
-Chris
cpeikert@mit.edu
