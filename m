Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293634AbSCABW1>; Thu, 28 Feb 2002 20:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310159AbSCABUu>; Thu, 28 Feb 2002 20:20:50 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:8321 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S310290AbSCABTu>; Thu, 28 Feb 2002 20:19:50 -0500
Date: Thu, 28 Feb 2002 17:19:44 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: whitney@math.berkeley.edu
To: LKML <linux-kernel@vger.kernel.org>
Subject: [OOPS 2.5.5-dj2] ext3 BUG in do_get_write_access()
Message-ID: <Pine.LNX.4.44.0202281703130.4893-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I managed to generate the oops below on 2.5.5-dj2 by doing the following:
  cp -ax / /mnt &
  <some delay, don't know if it matters>
  tune2fs -L root /dev/hdc5 

where 
  /dev/hda7 on / type ext3 (rw,noatime,nodiratime)
  /dev/hdc5 on /mnt type ext3 (rw,noatime,nodiratime)

tune2fs -L should be safe on a mounted filesystem, non?

A couple comments on the oops report:  I didn't run it through ksymoops,
as I am confident that klogd had the correct System.map file.  Also, while
the oops says "Tainted: P", that is solely due to "modprobe: Warning:
loading /lib/modules/2.5.5-dj2/kernel/net/ipv4/netfilter/ipchains.o will
taint the kernel: non-GPL license - BSD without advertisement clause".

I'd be happy to provide further information if needed, for example the
ksymoops output if for some reason the klogd symbol translation is
inadequate.

Cheers,
Wayne


Assertion failure in do_get_write_access() at transaction.c:586: "jh->b_next_transaction == ((void *)0)"
kernel BUG at transaction.c:586!
invalid operand: 0000
CPU:    0
EIP:    0010:[do_get_write_access+1626/1648]    Tainted: P  
EIP:    0010:[<c017128a>]    Tainted: P  
EFLAGS: 00010282
eax: 0000006c   ebx: d8678cc0   ecx: ddfaf900   edx: df08ff7c
esi: d8678cc0   edi: df968cc0   ebp: df900bd0   esp: ddfe9e5c
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 13610, threadinfo=ddfe8000 task=ddfaf900)
Stack: c0246dc0 c024b5ee c024b55c 0000024a c0248f60 df968d34 00000000 00000000 
       00000000 df6fa740 df968d34 df968cc0 defda3c0 df900bd0 c01712eb defda3c0 
       df900bd0 00000000 defda3c0 00000000 00004b80 d89205c0 c0166376 defda3c0 
Call Trace: [journal_get_write_access+75/128] [ext3_new_inode+1078/2496] [start_this_handle+126/336] [__jbd_kmalloc+35/112] [ext3_mkdir+245/1072] 
Call Trace: [<c01712eb>] [<c0166376>] [<c017051e>] [<c0177893>] [<c016beb5>] 
   [ext3_lookup+185/304] [vfs_mkdir+120/192] [sys_mkdir+218/256] [syscall_call+7/11] 
   [<c016b329>] [<c014aa18>] [<c014ab3a>] [<c0108eff>] 

Code: 0f 0b 4a 02 5c b5 24 c0 e9 e3 fe ff ff 8b 5d 00 e9 dd f9 ff 


