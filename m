Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbRBVJcq>; Thu, 22 Feb 2001 04:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130086AbRBVJcg>; Thu, 22 Feb 2001 04:32:36 -0500
Received: from femail12.sdc1.sfba.home.com ([24.0.95.108]:65482 "EHLO
	femail12.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S129773AbRBVJcd>; Thu, 22 Feb 2001 04:32:33 -0500
Date: Thu, 22 Feb 2001 01:32:26 -0800
From: Justin Huff <jjhuff@cs.washington.edu>
To: linux-kernel@vger.kernel.org
Subject: OOPS: kfree?
Message-ID: <20010222013226.I6160@etna>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The box is a Dell Lattitude CP laptop (P233 96meg ram). I've been doing
IrDA work using 2.4.1-ac20.  I was debugging some problems in my code(user
space) when my vim froze (other VTs were fine).  I killed the process and
the kernel oopsed. Unfortunatly, I haven't been able to reproduce it.
--Justin

------------------------------------
ksymoops 2.3.7 on i586 2.4.1-ac20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-ac20/ (default)
     -m /System.map (specified)

Unable to handle kernel paging request at virtual address d93720a0
c0126ea1
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0126ea1>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010083
eax: 00000000   ebx: c10969d0   ecx: c10b2810   edx: 0000000f
esi: c15fc3cf   edi: 00000286   ebp: 060afe1e   esp: c1385f68
ds: 0018   es: 0018   ss: 0018
Process vim (pid: 218, stackpage=c1385000)
Stack: c15fc400 00000100 c174b220 00000008 c11cad00 00015fc0 c0141c1f
c15fc400
       c0115ed7 c15fc400 00000100 c11cad00 c1384000 00000100 bffff0fc
c0116483
       c174b220 c1384000 403bc6fc 00000001 c011660b 00000100 c0108e13
00000001
Call Trace: [<c0141c1f>] [<c0115ed7>] [<c0116483>] [<c011660b>]
[<c0108e13>]
Code: 89 44 a9 18 89 69 14 8b 53 14 8b 41 10 ff 49 10 39 d0 74 0b

>>EIP; c0126ea1 <kfree+4d/c0>   <=====
Trace; c0141c1f <free_fd_array+37/48>
Trace; c0115ed7 <put_files_struct+77/b4>
Trace; c0116483 <do_exit+bb/218>
Trace; c011660b <sys_exit+f/10>
Trace; c0108e13 <system_call+33/40>
Code;  c0126ea1 <kfree+4d/c0>
00000000 <_EIP>:
Code;  c0126ea1 <kfree+4d/c0>   <=====
   0:   89 44 a9 18               movl   %eax,0x18(%ecx,%ebp,4)   <=====
Code;  c0126ea5 <kfree+51/c0>
   4:   89 69 14                  movl   %ebp,0x14(%ecx)
Code;  c0126ea8 <kfree+54/c0>
   7:   8b 53 14                  movl   0x14(%ebx),%edx
Code;  c0126eab <kfree+57/c0>
   a:   8b 41 10                  movl   0x10(%ecx),%eax
Code;  c0126eae <kfree+5a/c0>
   d:   ff 49 10                  decl   0x10(%ecx)
Code;  c0126eb1 <kfree+5d/c0>
  10:   39 d0                     cmpl   %edx,%eax
Code;  c0126eb3 <kfree+5f/c0>
  12:   74 0b                     je     1f <_EIP+0x1f> c0126ec0
<kfree+6c/c0>

