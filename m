Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTGGADJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 20:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266769AbTGGADJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 20:03:09 -0400
Received: from 130.146.174.203.mel.ntt.net.au ([203.174.146.130]:9344 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP id S264067AbTGGADD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 20:03:03 -0400
To: linux-kernel@vger.kernel.org
Subject: kernel oops with .74 snapshot.
From: Daniel Pittman <daniel@rimspace.net>
Date: Mon, 07 Jul 2003 10:17:38 +1000
Message-ID: <87n0frp4v1.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.5 (cassava)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following series of oops reports when booting a .74 snapshot.
Following is information on the latest changeset in the CVS export
server, and the reports.

Aside from that, the new IO scheduler is a huge improvement. I miss it
already. :/

        Daniel

RCS file: /home/cvs/linux-2.5/ChangeSet,v
Working file: ChangeSet
head: 1.11487

[...]

description:
BitKeeper to RCS/CVS export
----------------------------
revision 1.11487
date: 2003/07/06 20:23:55;  author: torvalds;  state: Exp;  lines: +0 -0
Simplify and speed up mmap read-around handling

[...]

BKrev: 3f08855bJ-EPEKDcfen7tS_rGIDesg
=============================================================================


The reports were:

Jul  7 09:47:31 enki kernel: Unable to handle kernel paging request at virtual address 06dd7f9a
Jul  7 09:47:31 enki kernel:  printing eip:
Jul  7 09:47:31 enki kernel: c0134960
Jul  7 09:47:31 enki kernel: *pde = 00000000
Jul  7 09:47:31 enki kernel: Oops: 0000 [#1]
Jul  7 09:47:31 enki kernel: CPU:    0
Jul  7 09:47:31 enki kernel: EIP:    0060:[kfree+48/98]    Not tainted
Jul  7 09:47:31 enki kernel: EFLAGS: 00010006
Jul  7 09:47:31 enki kernel: EIP is at kfree+0x30/0x62
Jul  7 09:47:31 enki kernel: eax: 00a00000   ebx: dcc1a900   ecx: dbedbf80   edx: 06dd7f9a
Jul  7 09:47:31 enki kernel: esi: 00000100   edi: 00000206   ebp: dbdf1e80   esp: dbe4bf50
Jul  7 09:47:31 enki kernel: ds: 007b   es: 007b   ss: 0068
Jul  7 09:47:31 enki kernel: Process netstat (pid: 637, threadinfo=dbe4a000 task=dc634780)
Jul  7 09:47:31 enki kernel: Stack: 00000000 00000001 dcc1a900 dbedbf80 dc14a810 c015e8fe 00000100 dbedbfa0 
Jul  7 09:47:31 enki kernel:        dbedbf80 dff64ec0 dc14a810 c0146636 dc14a810 dbedbf80 dbedbf80 dc73a380 
Jul  7 09:47:31 enki kernel:        00000000 dbe4a000 c0144fd8 dbedbf80 dc73a380 dbedbf80 0805f038 0805f038 
Jul  7 09:47:31 enki kernel: Call Trace:
Jul  7 09:47:31 enki kernel:  [seq_release_private+37/72] seq_release_private+0x25/0x48
Jul  7 09:47:31 enki kernel:  [__fput+173/188] __fput+0xad/0xbc
Jul  7 09:47:31 enki kernel:  [filp_close+77/121] filp_close+0x4d/0x79
Jul  7 09:47:31 enki kernel:  [sys_close+80/95] sys_close+0x50/0x5f
Jul  7 09:47:31 enki kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul  7 09:47:31 enki kernel: 
Jul  7 09:47:31 enki kernel: Code: 8b 1a 8b 03 3b 43 04 73 19 89 74 83 10 83 03 01 57 9d 8b 5c 
Jul  7 09:52:31 enki kernel: Unable to handle kernel paging request at virtual address 06dd7f9a
Jul  7 09:52:31 enki kernel:  printing eip:
Jul  7 09:52:31 enki kernel: c0134960
Jul  7 09:52:31 enki kernel: *pde = 00000000
Jul  7 09:52:31 enki kernel: Oops: 0000 [#2]
Jul  7 09:52:31 enki kernel: CPU:    0
Jul  7 09:52:31 enki kernel: EIP:    0060:[kfree+48/98]    Not tainted
Jul  7 09:52:31 enki kernel: EFLAGS: 00010006
Jul  7 09:52:31 enki kernel: EIP is at kfree+0x30/0x62
Jul  7 09:52:31 enki kernel: eax: 00a00000   ebx: d1c9d680   ecx: cad0cc80   edx: 06dd7f9a
Jul  7 09:52:31 enki kernel: esi: 00000100   edi: 00000206   ebp: dbdf1e80   esp: cb897f50
Jul  7 09:52:31 enki kernel: ds: 007b   es: 007b   ss: 0068
Jul  7 09:52:31 enki kernel: Process netstat (pid: 1763, threadinfo=cb896000 task=c81fb280)
Jul  7 09:52:31 enki kernel: Stack: 00000000 00000004 d1c9d680 cad0cc80 dc14a810 c015e8fe 00000100 cad0cca0 
Jul  7 09:52:31 enki kernel:        cad0cc80 dff64ec0 dc14a810 c0146636 dc14a810 cad0cc80 cad0cc80 d4d92100 
Jul  7 09:52:31 enki kernel:        00000000 cb896000 c0144fd8 cad0cc80 d4d92100 cad0cc80 0805f038 0805f038 
Jul  7 09:52:31 enki kernel: Call Trace:
Jul  7 09:52:31 enki kernel:  [seq_release_private+37/72] seq_release_private+0x25/0x48
Jul  7 09:52:31 enki kernel:  [__fput+173/188] __fput+0xad/0xbc
Jul  7 09:52:31 enki kernel:  [filp_close+77/121] filp_close+0x4d/0x79
Jul  7 09:52:31 enki kernel:  [sys_close+80/95] sys_close+0x50/0x5f
Jul  7 09:52:31 enki kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul  7 09:52:31 enki kernel: 
Jul  7 09:52:31 enki kernel: Code: 8b 1a 8b 03 3b 43 04 73 19 89 74 83 10 83 03 01 57 9d 8b 5c 
Jul  7 09:57:32 enki kernel:  <1>Unable to handle kernel paging request at virtual address 06dd7f9a
Jul  7 09:57:32 enki kernel:  printing eip:
Jul  7 09:57:32 enki kernel: c0134960
Jul  7 09:57:32 enki kernel: *pde = 00000000
Jul  7 09:57:32 enki kernel: Oops: 0000 [#3]
Jul  7 09:57:32 enki kernel: CPU:    0
Jul  7 09:57:32 enki kernel: EIP:    0060:[kfree+48/98]    Not tainted
Jul  7 09:57:32 enki kernel: EFLAGS: 00010006
Jul  7 09:57:32 enki kernel: EIP is at kfree+0x30/0x62
Jul  7 09:57:32 enki kernel: eax: 00a00000   ebx: c7a38500   ecx: d92f2e80   edx: 06dd7f9a
Jul  7 09:57:32 enki kernel: esi: 00000100   edi: 00000206   ebp: dbdf1e80   esp: c9a63f50
Jul  7 09:57:32 enki kernel: ds: 007b   es: 007b   ss: 0068
Jul  7 09:57:32 enki kernel: Process netstat (pid: 1766, threadinfo=c9a62000 task=d92b4780)
Jul  7 09:57:32 enki kernel: Stack: 00000000 00000004 c7a38500 d92f2e80 dc14a810 c015e8fe 00000100 d92f2ea0 
Jul  7 09:57:32 enki kernel:        d92f2e80 dff64ec0 dc14a810 c0146636 dc14a810 d92f2e80 d92f2e80 d928ed00 
Jul  7 09:57:32 enki kernel:        00000000 c9a62000 c0144fd8 d92f2e80 d928ed00 d92f2e80 0805f038 0805f038 
Jul  7 09:57:32 enki kernel: Call Trace:
Jul  7 09:57:32 enki kernel:  [seq_release_private+37/72] seq_release_private+0x25/0x48
Jul  7 09:57:32 enki kernel:  [__fput+173/188] __fput+0xad/0xbc
Jul  7 09:57:32 enki kernel:  [filp_close+77/121] filp_close+0x4d/0x79
Jul  7 09:57:32 enki kernel:  [sys_close+80/95] sys_close+0x50/0x5f
Jul  7 09:57:32 enki kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul  7 09:57:32 enki kernel: 
Jul  7 09:57:32 enki kernel: Code: 8b 1a 8b 03 3b 43 04 73 19 89 74 83 10 83 03 01 57 9d 8b 5c 
Jul  7 10:00:02 enki kernel:  <4>process `dig' is using obsolete setsockopt SO_BSDCOMPAT
Jul  7 10:02:32 enki kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jul  7 10:02:32 enki kernel:  printing eip:
Jul  7 10:02:32 enki kernel: c0134962
Jul  7 10:02:32 enki kernel: *pde = 00000000
Jul  7 10:02:32 enki kernel: Oops: 0000 [#4]
Jul  7 10:02:32 enki kernel: CPU:    0
Jul  7 10:02:32 enki kernel: EIP:    0060:[kfree+50/98]    Not tainted
Jul  7 10:02:32 enki kernel: EFLAGS: 00010006
Jul  7 10:02:32 enki kernel: EIP is at kfree+0x32/0x62
Jul  7 10:02:32 enki kernel: eax: 00a00000   ebx: 00000000   ecx: cc638c00   edx: 8f530080
Jul  7 10:02:32 enki kernel: esi: 00000100   edi: 00000206   ebp: dbdf1e80   esp: c5bd3f50
Jul  7 10:02:32 enki kernel: ds: 007b   es: 007b   ss: 0068
Jul  7 10:02:32 enki kernel: Process netstat (pid: 2462, threadinfo=c5bd2000 task=c8ddad80)
Jul  7 10:02:32 enki kernel: Stack: 00000000 00000004 c45bacc0 cc638c00 dc14a810 c015e8fe 00000100 cc638c20 
Jul  7 10:02:32 enki kernel:        cc638c00 dff64ec0 dc14a810 c0146636 dc14a810 cc638c00 cc638c00 cc4d5180 
Jul  7 10:02:32 enki kernel:        00000000 c5bd2000 c0144fd8 cc638c00 cc4d5180 cc638c00 0805f038 0805f038 
Jul  7 10:02:32 enki kernel: Call Trace:
Jul  7 10:02:32 enki kernel:  [seq_release_private+37/72] seq_release_private+0x25/0x48
Jul  7 10:02:32 enki kernel:  [__fput+173/188] __fput+0xad/0xbc
Jul  7 10:02:32 enki kernel:  [filp_close+77/121] filp_close+0x4d/0x79
Jul  7 10:02:32 enki kernel:  [sys_close+80/95] sys_close+0x50/0x5f
Jul  7 10:02:32 enki kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul  7 10:02:32 enki kernel: 
Jul  7 10:02:32 enki kernel: Code: 8b 03 3b 43 04 73 19 89 74 83 10 83 03 01 57 9d 8b 5c 24 08 


-- 
Artists are people driven by a conflict between the desire to
communicate and the even stronger desire to hide.
        -- D. W. Winnicott
