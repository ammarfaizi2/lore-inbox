Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279067AbRKIB6L>; Thu, 8 Nov 2001 20:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279079AbRKIB6B>; Thu, 8 Nov 2001 20:58:01 -0500
Received: from CorKy.NeT ([212.150.53.130]:63506 "HELO marcellos.corky.net")
	by vger.kernel.org with SMTP id <S279067AbRKIB5x>;
	Thu, 8 Nov 2001 20:57:53 -0500
Date: Fri, 9 Nov 2001 03:57:50 +0200
From: marc@corky.net
To: linux-kernel@vger.kernel.org
Subject: Oops, in kmem_extra_free_checks, 2.4.13.
Message-ID: <20011109035750.A7366@marcellos.corky.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Skimming the recent oops reports on this mailing list's archives
has shown nothing similar,  this happened more than once here, but
I'm unable to reproduce it, the compiled kernel is UP, and so is
the system.

 I'm not subscribed to the list,  so send me an email if any further
information is needed.

invalid operand: 0000
CPU:    0
EIP:    0010:[<c0127cf2>]    Not tainted
EFLAGS: 00010046
eax: ce252000   ebx: ce252000   ecx: 00000000   edx: c14062e0
esi: ce252000   edi: cd0d25dc   ebp: 00000000   esp: cd807f68
ds: 0018   es: 0018   ss: 0018
Process vim (pid: 2504, stackpage=cd807000)
Stack: cd0d25dc ce252000 ce252000 c14062e0 00000000 c01281c0 c14062e0 cd0d25dc 
       ce252000 fffffffb ce252000 bfffefc8 bffff154 ce252000 00000010 00001000 
       00000246 c012ef58 c14062e0 ce252000 cd806000 0813b800 c0106bd3 0813b800 
Call Trace: [<c01281c0>] [<c012ef58>] [<c0106bd3>] 

Code: 0f 0b 8b 4c 8f 18 83 f9 ff 75 ef 5b 5e 5f 31 c0 5d 59 c3 8d 
 
Which decodes to:

>>EIP; c0127cf2 <kmem_extra_free_checks+4e/64>   <=====
Trace; c01281c0 <kmem_cache_free+160/1dc>
Trace; c012ef58 <sys_open+6c/98>
Trace; c0106bd2 <system_call+32/40>
Code;  c0127cf2 <kmem_extra_free_checks+4e/64>
00000000 <_EIP>:
Code;  c0127cf2 <kmem_extra_free_checks+4e/64>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0127cf4 <kmem_extra_free_checks+50/64>
   2:   8b 4c 8f 18               movl   0x18(%edi,%ecx,4),%ecx
Code;  c0127cf8 <kmem_extra_free_checks+54/64>
   6:   83 f9 ff                  cmpl   $0xffffffff,%ecx
Code;  c0127cfa <kmem_extra_free_checks+56/64>
   9:   75 ef                     jne    fffffffa <_EIP+0xfffffffa> c0127cec <kmem_extra_free_checks+48/64>
Code;  c0127cfc <kmem_extra_free_checks+58/64>
   b:   5b                        popl   %ebx
Code;  c0127cfe <kmem_extra_free_checks+5a/64>
   c:   5e                        popl   %esi
Code;  c0127cfe <kmem_extra_free_checks+5a/64>
   d:   5f                        popl   %edi
Code;  c0127d00 <kmem_extra_free_checks+5c/64>
   e:   31 c0                     xorl   %eax,%eax
Code;  c0127d02 <kmem_extra_free_checks+5e/64>
  10:   5d                        popl   %ebp
Code;  c0127d02 <kmem_extra_free_checks+5e/64>
  11:   59                        popl   %ecx
Code;  c0127d04 <kmem_extra_free_checks+60/64>
  12:   c3                        ret    
Code;  c0127d04 <kmem_extra_free_checks+60/64>
  13:   8d 00                     leal   (%eax),%eax


	bye,
		Marc.

-- 
marc @ corky.net

fingerprint = D1F0 5689 967F B87A 98EB  C64D 256A D6BF 80DE 6D3C

          /"\
          \ /     ASCII Ribbon Campaign
           X      Against HTML Mail
          / \
