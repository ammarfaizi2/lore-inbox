Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312772AbSDOOXD>; Mon, 15 Apr 2002 10:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312773AbSDOOXD>; Mon, 15 Apr 2002 10:23:03 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:34822 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S312772AbSDOOXC>; Mon, 15 Apr 2002 10:23:02 -0400
Date: Mon, 15 Apr 2002 15:22:59 +0100 (BST)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: <linux-kernel@vger.kernel.org>
Subject: JFS crash on 2.5.6
Message-ID: <Pine.LNX.4.33.0204151500020.10194-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My gateway suffered the below this morning, during
an "apt-get update".  The logs suggest that it spat
out oopses for a full minute before finally dying.

There seem to have been a fair few changes to JFS
between 2.5.6 and 2.5.8, so I will upgrade this
evening, but am posting this just in case it's not
something which has been fixed.

Here are the first few.

Matthew.


assert(blkno + nblocks <= bmp->db_mapsize)
kernel BUG at jfs_dmap.c:464!
invalid operand: 0000
CPU:    0
assert(blkno + nblocks <= bmp->db_mapsize)
kernel BUG at jfs_dmap.c:464!
invalid operand: 0000
CPU:    0
assert(blkno + nblocks <= bmp->db_mapsize)
kernel BUG at jfs_dmap.c:464!
invalid operand: 0000
CPU:    0
EIP:    0010:[dbUpdatePMap+103/1244]    Not tainted
EFLAGS: 00010286
eax: 0000002b   ebx: 0044495f   ecx: ffffffd2   edx: c3f18000
esi: 00000000   edi: c3ba4000   ebp: 00000003   esp: c3f19ee8
ds: 0018   es: 0018   ss: 0018
Process jfsCommit (pid: 9, threadinfo=c3f18000 task=c11f5140)
Stack: c0206e83 c0206e60 0000005f 0044495f c1e9ed80 00000003 c3f18000 c3f5fe78
       00000000 00000286 00000003 00000001 c0173579 c3f5fe78 00000000 00000000
       c0167edd c3f5fe78 00000000 c3b00eb0 c480e334 c3ba4000 c1e6c000 c3b00678
Call Trace: [release_metapage+457/476] [dbFree+561/604] [txFreeMap+133/600] [txUpdateMap+201/548] [txLazyCommit+169/176]
   [txLazyCommit+33/176] [jfs_lazycommit+304/396] [kernel_thread+40/56]

Code: 0f 0b d0 01 8f 6e 20 c0 83 c4 08 8b 84 24 80 00 00 00 8b 94
 kernel BUG at exit.c:524!
invalid operand: 0000
CPU:    0
EIP:    0010:[do_exit+677/692]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c3f18000   ecx: c0226650   edx: c3f18000
esi: c10b4200   edi: c3f19eb4   ebp: c11f5140   esp: c3f19dec
ds: 0018   es: 0018   ss: 0018
Process jfsCommit (pid: 9, threadinfo=c3f18000 task=c11f5140)
Stack: c3f18000 00000000 c3f19eb4 00000003 c010758f 0000000b c3f19eb4 00000000
       c01077a4 c010782c c01f5371 c3f19eb4 00000000 c3f18000 00000000 00000004
       00000000 00030002 c0167f6f c027deb4 0088219b c018efb4 c022e2e0 c026e4e9
Call Trace: [die+111/112] [do_invalid_op+0/148] [do_invalid_op+136/148] [dbUpdatePMap+103/1244] [vt_console_print+720/740]
   [schedule+521/588] [preempt_schedule+29/32] [error_code+52/64] [dbUpdatePMap+103/1244] [release_metapage+457/476] [dbFree+561/604]
   [txFreeMap+133/600] [txUpdateMap+201/548] [txLazyCommit+169/176] [txLazyCommit+33/176] [jfs_lazycommit+304/396] [kernel_thread+40/56]

Code: 0f 0b 0c 02 b7 b8 1f c0 e9 a7 fd ff ff 89 f6 8b 44 24 04 85
EIP:    0010:[dbUpdatePMap+103/1244]    Not tainted
EFLAGS: 00010286
eax: 0000002b   ebx: 0044495f   ecx: ffffffd2   edx: c3f18000
esi: 00000000   edi: c3ba4000   ebp: 00000003   esp: c3f19ee8
ds: 0018   es: 0018   ss: 0018
Process jfsCommit (pid: 9, threadinfo=c3f18000 task=c11f5140)
Stack: c0206e83 c0206e60 0000005f 0044495f c1e9ed80 00000003 c3f18000 c3f5fe78
       00000000 00000286 00000003 00000001 c0173579 c3f5fe78 00000000 00000000
       c0167edd c3f5fe78 00000000 c3b00eb0 c480e334 c3ba4000 c1e6c000 c3b00678
Call Trace: [release_metapage+457/476] [dbFree+561/604] [txFreeMap+133/600] [txUpdateMap+201/548] [txLazyCommit+169/176]
   [txLazyCommit+33/176] [jfs_lazycommit+304/396] [kernel_thread+40/56]

Code: 0f 0b d0 01 8f 6e 20 c0 83 c4 08 8b 84 24 80 00 00 00 8b 94
 kernel BUG at exit.c:524!
invalid operand: 0000
CPU:    0
EIP:    0010:[do_exit+677/692]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c3f18000   ecx: c0226650   edx: c3f18000
esi: c10b4200   edi: c3f19eb4   ebp: c11f5140   esp: c3f19dec
ds: 0018   es: 0018   ss: 0018
Process jfsCommit (pid: 9, threadinfo=c3f18000 task=c11f5140)
Stack: c3f18000 00000000 c3f19eb4 00000003 c010758f 0000000b c3f19eb4 00000000
       c01077a4 c010782c c01f5371 c3f19eb4 00000000 c3f18000 00000000 00000004
       00000000 00030002 c0167f6f c027deb4 0088219b c018efb4 c022e2e0 c026e4e9
Call Trace: [die+111/112] [do_invalid_op+0/148] [do_invalid_op+136/148] [dbUpdatePMap+103/1244] [vt_console_print+720/740]
   [schedule+521/588] [preempt_schedule+29/32] [error_code+52/64] [dbUpdatePMap+103/1244] [release_metapage+457/476] [dbFree+561/604]
   [txFreeMap+133/600] [txUpdateMap+201/548] [txLazyCommit+169/176] [txLazyCommit+33/176] [jfs_lazycommit+304/396] [kernel_thread+40/56]

Code: 0f 0b 0c 02 b7 b8 1f c0 e9 a7 fd ff ff 89 f6 8b 44 24 04 85
EIP:    0010:[dbUpdatePMap+103/1244]    Not tainted
EFLAGS: 00010286
eax: 0000002b   ebx: 0044495f   ecx: ffffffd2   edx: c3f18000
esi: 00000000   edi: c3ba4000   ebp: 00000003   esp: c3f19ee8
ds: 0018   es: 0018   ss: 0018
Process jfsCommit (pid: 9, threadinfo=c3f18000 task=c11f5140)
Stack: c0206e83 c0206e60 0000005f 0044495f c1e9ed80 00000003 c3f18000 c3f5fe78
       00000000 00000286 00000003 00000001 c0173579 c3f5fe78 00000000 00000000
       c0167edd c3f5fe78 00000000 c3b00eb0 c480e334 c3ba4000 c1e6c000 c3b00678
Call Trace: [release_metapage+457/476] [dbFree+561/604] [txFreeMap+133/600] [txUpdateMap+201/548] [txLazyCommit+169/176]
   [txLazyCommit+33/176] [jfs_lazycommit+304/396] [kernel_thread+40/56]

Code: 0f 0b d0 01 8f 6e 20 c0 83 c4 08 8b 84 24 80 00 00 00 8b 94
 kernel BUG at exit.c:524!
invalid operand: 0000
CPU:    0
EIP:    0010:[do_exit+677/692]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c3f18000   ecx: c0226650   edx: c3f18000
esi: c10b4200   edi: c3f19eb4   ebp: c11f5140   esp: c3f19dec
ds: 0018   es: 0018   ss: 0018
Process jfsCommit (pid: 9, threadinfo=c3f18000 task=c11f5140)
Stack: c3f18000 00000000 c3f19eb4 00000003 c010758f 0000000b c3f19eb4 00000000
       c01077a4 c010782c c01f5371 c3f19eb4 00000000 c3f18000 00000000 00000004
       00000000 00030002 c0167f6f c027deb4 0088219b c018efb4 c022e2e0 c026e4e9
Call Trace: [die+111/112] [do_invalid_op+0/148] [do_invalid_op+136/148] [dbUpdatePMap+103/1244] [vt_console_print+720/740]
   [schedule+521/588] [preempt_schedule+29/32] [error_code+52/64] [dbUpdatePMap+103/1244] [release_metapage+457/476] [dbFree+561/604]
   [txFreeMap+133/600] [txUpdateMap+201/548] [txLazyCommit+169/176] [txLazyCommit+33/176] [jfs_lazycommit+304/396] [kernel_thread+40/56]

Code: 0f 0b 0c 02 b7 b8 1f c0 e9 a7 fd ff ff 89 f6 8b 44 24 04 85

