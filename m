Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267450AbRHJMgt>; Fri, 10 Aug 2001 08:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbRHJMg3>; Fri, 10 Aug 2001 08:36:29 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:6671 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S267500AbRHJMg1>; Fri, 10 Aug 2001 08:36:27 -0400
Date: Fri, 10 Aug 2001 14:36:37 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.2.19 reproducable oops through Tivoli BA client 3.7.2.0
Message-ID: <20010810143637.B31349@emma1.>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This morning, one of our machines Oopsed while running dsmc (Tivoli
storage manager Backup-Archive client 3.7.2.0), dsmc itself caught
SIGSEGV:

08/10/2001 03:15:54 B/A Performance thread, fatal error, signal 11

This is somewhat peculiar since it should not be possible for a
user-space process to shoot a kernel process, and it's even more
peculiar because it breaks our daily backup.

Assistance is sought.



Unable to handle kernel paging request at virtual address 000747e8
current->tss.cr3 = 0ea99000, %cr3 = 0ea99000
*pde = 0df77067
Oops: 0000
CPU:    0
EIP:    0010:[<c011e6f7>]
EFLAGS: 00010202
eax: 00008fa0   ebx: 01560000   ecx: d7ea3e80   edx: 000747e0
esi: d6c3d188   edi: cc107000   ebp: 0156f000   esp: c352fedc
ds: 0018   es: 0018   ss: 0018
Process dsmc (pid: 19885, process nr: 131, stackpage=c352f000)
Stack: 0000f000 cecce0c0 c04b5118 00000000 cecce0c0 c011eb0c cecce0c0 0156f000 
       00000000 c289c2a0 00007ffc 081fefac 00000000 00007ffc c029f5c4 c029f580 
       00000000 00020000 0001f000 00000000 00000002 01541000 00000001 01541000 
Call Trace: [<c011eb0c>] [<c011ee9b>] [<c011ede8>] [<c012738a>] [<c010a154>] 
Code: 39 72 08 75 f4 39 6a 0c 75 ef ff 42 14 b8 02 00 00 00 0f ab 

>>EIP; c011e6f7 <try_to_read_ahead+6b/108>   <=====
Trace; c011eb0c <do_generic_file_read+294/570>
Trace; c011ee9b <generic_file_read+63/7c>
Trace; c011ede8 <file_read_actor+0/50>
Trace; c012738a <sys_read+b2/d0>
Trace; c010a154 <system_call+34/40>
Code;  c011e6f7 <try_to_read_ahead+6b/108>
00000000 <_EIP>:
Code;  c011e6f7 <try_to_read_ahead+6b/108>   <=====
   0:   39 72 08                  cmp    %esi,0x8(%edx)   <=====
Code;  c011e6fa <try_to_read_ahead+6e/108>
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> c011e6f0 <try_to_read_ahead+64/108>
Code;  c011e6fc <try_to_read_ahead+70/108>
   5:   39 6a 0c                  cmp    %ebp,0xc(%edx)
Code;  c011e6ff <try_to_read_ahead+73/108>
   8:   75 ef                     jne    fffffff9 <_EIP+0xfffffff9> c011e6f0 <try_to_read_ahead+64/108>
Code;  c011e701 <try_to_read_ahead+75/108>
   a:   ff 42 14                  incl   0x14(%edx)
Code;  c011e704 <try_to_read_ahead+78/108>
   d:   b8 02 00 00 00            mov    $0x2,%eax
Code;  c011e709 <try_to_read_ahead+7d/108>
  12:   0f ab 00                  bts    %eax,(%eax)



-- 
Matthias Andree
