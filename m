Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267508AbRGMRbO>; Fri, 13 Jul 2001 13:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267510AbRGMRbE>; Fri, 13 Jul 2001 13:31:04 -0400
Received: from picard.csihq.com ([204.17.222.1]:30171 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S267508AbRGMRaw>;
	Fri, 13 Jul 2001 13:30:52 -0400
Message-ID: <125101c10bc1$85eab630$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "Andrew Morton" <andrewm@uow.edu.au>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com> <3B4BD13F.6CC25B6F@uow.edu.au> <021801c10a03$62434540$e1de11cc@csihq.com> <3B4C729B.6352A443@uow.edu.au> <05c401c10ac1$0e81ad70$e1de11cc@csihq.com> <3B4D8B5D.E9530B60@uow.edu.au> <036e01c10b96$72ce57d0$e1de11cc@csihq.com> <111501c10ba3$664a1370$e1de11cc@csihq.com> <3B4F0273.1DF40F8E@uow.edu.au>
Subject: Re: 2.4.6 and ext3-2.4-0.9.1-246
Date: Fri, 13 Jul 2001 13:30:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the oops:
Message on console:
yeti kernel: EXT3-fs error (device md(9,0)): ext3_new_inode: reserved inode
or inode > inodes count - block_group = 0,inode=1

Here line 575:
        J_ASSERT_JH(jh, !buffer_locked(jh2bh(jh)));

Kernel BUG at transaction.c:575!
invalid operand: 0000
CPU: 1
EIP: 0010:[<c015b21d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000021 ebx: df83e850 ecx: 00000001 edx: 00000001
esi: d13fa880 edi: cf83e850 ebp: f7856600 esp: f73e5cac
ds: 0018 es: 0018 ss: 0018
Process syslogd (pid: 57, stackpage=f73e5000)
Stack: c0245fcb c0246140 0000023f f7856600 d13fa880 cf83e850 f78576694
c3217a58
        00000000 00000000 00000000 d73f42a0 c015b689 d13fa880 cf83e850
00000000
        00000912 f7856800 00000913 f73e5d34 c01529e9 d13fa880 f784eec0
d13fa880
Call Trace: c015b689 c01529e9 c01540ee c01543eb c01546ac c0154952 c015b62a
        c0135694 c0154b46 c0135c88 c01364d6 c0154f96 c0154ad4 c01270b2
        c0154f96 c0154ad4 c01270b2 c01531be c01331b6 c01531a4 c01332c5
c0106c7b
Code: 0f 0b 83 c4 0c f0 fe 0d a0 aa 28 c0 0f 88 35 f5 0c 00 8b 53

>>EIP; c015b21d <do_get_write_access+205/638>   <=====
Trace; c015b689 <journal_get_write_access+39/5c>
Trace; c01529e9 <ext3_new_block+349/55c>
Trace; c01540ee <ext3_alloc_block+1e/24>
Trace; c01543eb <ext3_alloc_branch+3f/24c>
Trace; c01546ac <ext3_splice_branch+b4/130>
Trace; c0154952 <ext3_get_block_handle+22a/3ac>
Trace; c015b62a <do_get_write_access+612/638>
Code;  c015b21d <do_get_write_access+205/638>
00000000 <_EIP>:
Code;  c015b21d <do_get_write_access+205/638>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015b21f <do_get_write_access+207/638>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c015b222 <do_get_write_access+20a/638>
   5:   f0 fe 0d a0 aa 28 c0      lock decb 0xc028aaa0
Code;  c015b229 <do_get_write_access+211/638>
   c:   0f 88 35 f5 0c 00         js     cf547 <_EIP+0xcf547> c022a764
<stext_lock+33bc/92c6>
Code;  c015b22f <do_get_write_access+217/638>
  12:   8b 53 00                  mov    0x0(%ebx),%edx


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message -----
From: "Andrew Morton" <andrewm@uow.edu.au>
To: "Mike Black" <mblack@csihq.com>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>;
<ext2-devel@lists.sourceforge.net>
Sent: Friday, July 13, 2001 10:15 AM
Subject: Re: 2.4.6 and ext3-2.4-0.9.1-246


Mike Black wrote:
>
> I give up!  I'm getting file system corruption now on the ext3
partition...
> and I've got a kernel oops (soon to be decoded) This is the worst file
> corruption I've ever seen other than having a disk go bad.

There was a truncate-related bug fixed in 0.9.2.  What workload
were you using at the time?

