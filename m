Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTABLTz>; Thu, 2 Jan 2003 06:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTABLTz>; Thu, 2 Jan 2003 06:19:55 -0500
Received: from proxy.povodiodry.cz ([62.77.115.11]:20973 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S261364AbTABLTx>;
	Thu, 2 Jan 2003 06:19:53 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Thu, 2 Jan 2003 12:28:19 +0100
To: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: NULL pointer dereference
Message-ID: <20030102112819.GC26362@pc11.op.pod.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  I tried to use cdrdao on 2.5.5x kernels but kernel gives me following
messages. Further debugging reveals that sb is NULL in __ext3_std_error()
function. I tried this on ext2 and it seems it isn't ext3 specific, on
ext2 it also doesn't work.
  cdrdao is after this in D state and is unkillable, but the CD-ROM drive
from which I tried to grab is perfectly usable.
  This happens to me only with cdrdao, otherwise system is perfectly solid.

	Cheers,
		Vita

grabbing to the ext3 partition:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Unable to handle kernel NULL pointer dereference at virtual address 00000118
 printing eip:
c018893a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c018893a>]    Not tainted
EFLAGS: 00010097
EIP is at vsnprintf+0x22a/0x41c
eax: 00000118   ebx: c0344919   ecx: 00000118   edx: fffffffe
esi: cdb21e50   edi: ffffffff   ebp: 00000118   esp: cdb21dfc
ds: 0068   es: 0068   ss: 0068
Process cdrdao (pid: 238, threadinfo=cdb20000 task=d12c4780)
Stack: c0344900 00000246 d11e0a00 c02ae2c8 d201ab70 d2609f20 ffffffff 00000000 
       c0344cff c01179c9 c0344900 00000400 c02733da cdb21e4c 00000000 c02725c6 
       d11e0a00 d201ab60 c01672a8 c02733c0 00000118 c02725c6 cdb21e6c 00000000 
Call Trace:
 [<c01179c9>] printk+0x61/0x114
 [<c01672a8>] __ext3_std_error+0x30/0x40
 [<c0162c0a>] ext3_setattr+0x19a/0x1b0
 [<c014b606>] notify_change+0xe6/0x180
 [<c013696b>] do_truncate+0x5b/0x78
 [<c0142d41>] may_open+0x165/0x17c
 [<c0143015>] open_namei+0x2bd/0x3d0
 [<c013770f>] filp_open+0x3b/0x5c
 [<c0137a63>] sys_open+0x37/0x78
 [<c0108877>] syscall_call+0x7/0xb

Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 89 44 24 10 8b 44 


grabbing to the ext2 partition:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Unable to handle kernel paging request at virtual address 0a00007c
 printing eip:
c012d596
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c012d596>]    Not tainted
EFLAGS: 00010296
EIP is at vmtruncate+0x102/0x140
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 0a000000
esi: 00000000   edi: d37a7504   ebp: 00000000   esp: d2023e50
ds: 0068   es: 0068   ss: 0068
Process cdrdao (pid: 159, threadinfo=d2022000 task=d2666140)
Stack: 00000048 d2023edc d37a7430 00000000 d37a7504 d37a74c0 00050070 0a000000 
       00000000 c0000024 00000a00 d37a7430 d2023edc d37a7430 c0175795 d37a7430 
       d2023edc d2023edc 000081a4 00000048 c014b606 d24ee9c0 d2023edc d37a7430 
Call Trace:
 [<c0175795>] ext2_setattr+0x25/0x30
 [<c014b606>] notify_change+0xe6/0x180
 [<c013696b>] do_truncate+0x5b/0x78
 [<c0142d41>] may_open+0x165/0x17c
 [<c0143015>] open_namei+0x2bd/0x3d0
 [<c013770f>] filp_open+0x3b/0x5c
 [<c0137a63>] sys_open+0x37/0x78
 [<c0108877>] syscall_call+0x7/0xb

Code: 8b 42 7c 85 c0 74 0d 8b 40 2c 85 c0 74 06 52 ff d0 83 c4 04 
