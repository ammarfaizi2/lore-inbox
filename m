Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318731AbSHLPvJ>; Mon, 12 Aug 2002 11:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSHLPvI>; Mon, 12 Aug 2002 11:51:08 -0400
Received: from the.earth.li ([212.135.138.190]:16904 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id <S318731AbSHLPuX>;
	Mon, 12 Aug 2002 11:50:23 -0400
Date: Mon, 12 Aug 2002 16:54:11 +0100
From: Simon Huggins <huggie@earth.li>
To: linux-kernel@vger.kernel.org
Subject: Oops in kmem_extra_free_checks with 2.4.19
Message-ID: <20020812155411.GN17691@paranoidfreak.co.uk>
Mail-Followup-To: huggie@earth.li, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i-nntp
X-Attribution: huggie
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this oops which seems to ressemble this one:
http://marc.theaimsgroup.com/?l=linux-kernel&m=100527116830707&w=2
(although perhaps I'm just wrong)

Hadn't had any problems like this on 2.4.17 which I was running
previously.  I did have another odd crash on 2.4.19 but that time I had
the nvidia binary gunk loaded - this time I did not.

Who maintains mm/slab.c?  I wasn't really sure who to send this to which
is why it's here.

Anyway here you go, there were a series of oopsen.  Hope it makes some
sense to /someone/.

Please cc me (I've set mail-followup-to).

ksymoops 2.4.5 on i686 2.4.19.  Options used
     -V (default)
     -k /var/log/ksymoops/20020812143155.ksyms (specified)
     -l /var/log/ksymoops/20020812143155.modules (specified)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 12 15:48:14 bounce kernel: EFLAGS: 00010012
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 00000190   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c3970350   edi: c3970000   ebp: 00000190   esp: d5009f30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process xmms (pid: 16525, stackpage=d5009000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c3970350 c3970354 c14270c0 0000000a c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c3970350 d5008000 c3970368 befffaa0 00000000 0000000b 00000020 c3970354 
Aug 12 15:48:14 bounce kernel:        00000282 c013f6ea c3970354 c013fb4f c3970354 00000004 d5008000 00000000 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013f6ea>] [<c013fb4f>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c3970350 <_end+366122c/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; d5009f30 <_end+14cfae0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013f6ea <select_bits_free+a/10>
Trace; c013fb4f <sys_select+45f/470>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:14 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Aug 12 15:48:14 bounce kernel: EFLAGS: 00010002
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 000000a0   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c3970260   edi: c3970000   ebp: 000000a0   esp: d347ff30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process xmms (pid: 780, stackpage=d347f000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c3970260 c3970264 c14270c0 00000004 c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c3970260 00000000 083041e0 083041d0 d347ffbc ffffffff 00000020 c3970264 
Aug 12 15:48:14 bounce kernel:        00000282 c013ff98 c3970264 d347e000 00000008 083041d0 c01f78f1 d36bdadc 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013ff98>] [<c01f78f1>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c3970260 <_end+366113c/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; d347ff30 <_end+13170e0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013ff98 <sys_poll+2c8/2f0>
Trace; c01f78f1 <sock_ioctl+21/30>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:14 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Aug 12 15:48:14 bounce kernel: EFLAGS: 00010002
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 00000000   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c39701c0   edi: c3970000   ebp: 00000000   esp: d4e6ff30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process enlightenment (pid: 617, stackpage=d4e6f000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c39701c0 c39701c4 c14270c0 00000000 c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c39701c0 d4e6e000 c39701d8 bfffe7e0 00000001 00000004 00000020 c39701c4 
Aug 12 15:48:14 bounce kernel:        00000282 c013f6ea c39701c4 c013fb4f c39701c4 00000004 d4e6e000 00000000 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013f6ea>] [<c013fb4f>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c39701c0 <_end+366109c/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; d4e6ff30 <_end+14b60e0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013f6ea <select_bits_free+a/10>
Trace; c013fb4f <sys_select+45f/470>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:14 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Aug 12 15:48:14 bounce kernel: EFLAGS: 00013002
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 00000028   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c39701e8   edi: c3970000   ebp: 00000028   esp: c70d7f30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process galeon-bin (pid: 16149, stackpage=c70d7000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c39701e8 c39701ec c14270c0 00000001 c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c39701e8 00000000 0823e658 0823e618 c70d7fbc ffffffff 00000020 c39701ec 
Aug 12 15:48:14 bounce kernel:        00003282 c013ff98 c39701ec c70d6000 0002c4c9 0823e618 c01f78f1 c381e5d4 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013ff98>] [<c01f78f1>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c39701e8 <_end+36610c4/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; c70d7f30 <_end+6dc8e0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013ff98 <sys_poll+2c8/2f0>
Trace; c01f78f1 <sock_ioctl+21/30>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:14 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Aug 12 15:48:14 bounce kernel: EFLAGS: 00010006
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 00000140   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c3970300   edi: c3970000   ebp: 00000140   esp: d46a3f30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process xterm (pid: 6475, stackpage=d46a3000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c3970300 c3970304 c14270c0 00000008 c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c3970300 00000004 c3970318 0807fea4 00000001 00000005 00000020 c3970304 
Aug 12 15:48:14 bounce kernel:        00000282 c013f6ea c3970304 c013fb4f c3970304 00000004 d46a2000 00000000 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013f6ea>] [<c013fb4f>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c3970300 <_end+36611dc/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; d46a3f30 <_end+14394e0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013f6ea <select_bits_free+a/10>
Trace; c013fb4f <sys_select+45f/470>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:14 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Aug 12 15:48:14 bounce kernel: EFLAGS: 00010002
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 00000118   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c39702d8   edi: c3970000   ebp: 00000118   esp: d4acbf30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process xterm (pid: 6356, stackpage=d4acb000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c39702d8 c39702dc c14270c0 00000007 c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c39702d8 00000004 c39702f0 0807fea4 00000001 00000005 00000020 c39702dc 
Aug 12 15:48:14 bounce kernel:        00000282 c013f6ea c39702dc c013fb4f c39702dc 00000004 d4aca000 00000000 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013f6ea>] [<c013fb4f>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c39702d8 <_end+36611b4/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; d4acbf30 <_end+147bce0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013f6ea <select_bits_free+a/10>
Trace; c013fb4f <sys_select+45f/470>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:14 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Aug 12 15:48:14 bounce kernel: EFLAGS: 00010016
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 00000168   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c3970328   edi: c3970000   ebp: 00000168   esp: c881ff30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process mutt (pid: 16281, stackpage=c881f000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c3970328 c397032c c14270c0 00000009 c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c3970328 00000000 bfffe9a4 bfffe99c c881ffbc ffffffff 00000020 c397032c 
Aug 12 15:48:14 bounce kernel:        00000282 c013ff98 c397032c c881e000 000927c0 bfffe99c d4aca270 c0114696 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013ff98>] [<c0114696>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c3970328 <_end+3661204/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; c881ff30 <_end+8510e0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013ff98 <sys_poll+2c8/2f0>
Trace; c0114696 <schedule+2c6/2f0>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Aug 12 15:48:14 bounce kernel: EFLAGS: 00010006
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 00000050   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c3970210   edi: c3970000   ebp: 00000050   esp: cb08ff30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process xterm (pid: 16362, stackpage=cb08f000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c3970210 c3970214 c14270c0 00000002 c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c3970210 00000004 c3970228 0807fea4 00000001 00000005 00000020 c3970214 
Aug 12 15:48:14 bounce kernel:        00000286 c013f6ea c3970214 c013fb4f c3970214 00000004 cb08e000 00000000 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013f6ea>] [<c013fb4f>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c3970210 <_end+36610ec/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; cb08ff30 <_end+ad80e0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013f6ea <select_bits_free+a/10>
Trace; c013fb4f <sys_select+45f/470>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:14 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Aug 12 15:48:14 bounce kernel: EFLAGS: 00010016
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 000001e0   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c39703a0   edi: c3970000   ebp: 000001e0   esp: c4c0ff30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process ssh (pid: 16523, stackpage=c4c0f000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c39703a0 c39703a4 c14270c0 0000000c c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c39703a0 00000004 c39703b8 08091354 00000001 00000005 00000020 c39703a4 
Aug 12 15:48:14 bounce kernel:        00000282 c013f6ea c39703a4 c013fb4f c39703a4 00000004 c4c0e000 00000000 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013f6ea>] [<c013fb4f>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c39703a0 <_end+366127c/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; c4c0ff30 <_end+4900e0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013f6ea <select_bits_free+a/10>
Trace; c013fb4f <sys_select+45f/470>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:14 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Aug 12 15:48:14 bounce kernel: EFLAGS: 00010006
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 00000078   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c3970238   edi: c3970000   ebp: 00000078   esp: d46a9f30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process xterm (pid: 660, stackpage=d46a9000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c3970238 c397023c c14270c0 00000003 c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c3970238 00000004 c3970250 0807fea4 00000002 00000005 00000020 c397023c 
Aug 12 15:48:14 bounce kernel:        00000286 c013f6ea c397023c c013fb4f c397023c 00000004 d46a8000 00000000 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013f6ea>] [<c013fb4f>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c3970238 <_end+3661114/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; d46a9f30 <_end+1439ae0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013f6ea <select_bits_free+a/10>
Trace; c013fb4f <sys_select+45f/470>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:14 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Aug 12 15:48:14 bounce kernel: EFLAGS: 00010002
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 000000f0   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c39702b0   edi: c3970000   ebp: 000000f0   esp: d7c1bf30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process ssh (pid: 16526, stackpage=d7c1b000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c39702b0 c39702b4 c14270c0 00000006 c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c39702b0 00000004 c39702c8 08088c44 00000001 00000005 00000020 c39702b4 
Aug 12 15:48:14 bounce kernel:        00000286 c013f6ea c39702b4 c013fb4f c39702b4 00000004 d7c1a000 00000000 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013f6ea>] [<c013fb4f>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c39702b0 <_end+366118c/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; d7c1bf30 <_end+1790ce0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013f6ea <select_bits_free+a/10>
Trace; c013fb4f <sys_select+45f/470>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:14 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Aug 12 15:48:14 bounce kernel: EFLAGS: 00010012
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 000001b8   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c3970378   edi: c3970000   ebp: 000001b8   esp: d413df30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process E-Cpu.epplet (pid: 658, stackpage=d413d000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c3970378 c397037c c14270c0 0000000b c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c3970378 d413c000 c3970390 bffff890 00000001 00000004 00000020 c397037c 
Aug 12 15:48:14 bounce kernel:        00000282 c013f6ea c397037c c013fb4f c397037c 00000004 d413c000 00000000 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013f6ea>] [<c013fb4f>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c3970378 <_end+3661254/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; d413df30 <_end+13e2ee0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013f6ea <select_bits_free+a/10>
Trace; c013fb4f <sys_select+45f/470>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:14 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:14 bounce kernel: c012b5e2
Aug 12 15:48:14 bounce kernel: Oops: 0000
Aug 12 15:48:14 bounce kernel: CPU:    0
Aug 12 15:48:14 bounce kernel: EIP:    0010:[<c012b5e2>]    Not tainted
Aug 12 15:48:14 bounce kernel: EFLAGS: 00010012
Aug 12 15:48:14 bounce kernel: eax: 08054fa8   ebx: c39701c0   ecx: 00000208   edx: c14270c0
Aug 12 15:48:14 bounce kernel: esi: c39703c8   edi: c3970000   ebp: 00000208   esp: c45e5f30
Aug 12 15:48:14 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:14 bounce kernel: Process galeon-bin (pid: 16158, stackpage=c45e5000)
Aug 12 15:48:14 bounce kernel: Stack: c3970000 c39703c8 c39703cc c14270c0 0000000d c012bd08 c14270c0 c3970000 
Aug 12 15:48:14 bounce kernel:        c39703c8 00000000 083b2950 083b2948 c45e5fbc fffffffe 00000020 c39703cc 
Aug 12 15:48:14 bounce kernel:        00000286 c013ff98 c39703cc c45e4000 000007d0 083b2948 c45e5fc4 00000240 
Aug 12 15:48:14 bounce kernel: Call Trace:    [<c012bd08>] [<c013ff98>] [<c010bf18>] [<c01086cf>]
Aug 12 15:48:14 bounce kernel: Code: 8b 44 87 18 83 f8 ff 75 e9 31 c0 5b 5e 5f 5d 59 c3 8d b6 00 


>>EIP; c012b5e2 <kmem_extra_free_checks+62/80>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c39701c0 <_end+366109c/18519edc>
>>edx; c14270c0 <_end+1117f9c/18519edc>
>>esi; c39703c8 <_end+36612a4/18519edc>
>>edi; c3970000 <_end+3660edc/18519edc>
>>esp; c45e5f30 <_end+42d6e0c/18519edc>

Trace; c012bd08 <kfree+178/1f0>
Trace; c013ff98 <sys_poll+2c8/2f0>
Trace; c010bf18 <end_8259A_irq+18/20>
Trace; c01086cf <system_call+33/38>

Code;  c012b5e2 <kmem_extra_free_checks+62/80>
00000000 <_EIP>:
Code;  c012b5e2 <kmem_extra_free_checks+62/80>   <=====
   0:   8b 44 87 18               mov    0x18(%edi,%eax,4),%eax   <=====
Code;  c012b5e6 <kmem_extra_free_checks+66/80>
   4:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b5e9 <kmem_extra_free_checks+69/80>
   7:   75 e9                     jne    fffffff2 <_EIP+0xfffffff2> c012b5d4 <kmem_extra_free_checks+54/80>
Code;  c012b5eb <kmem_extra_free_checks+6b/80>
   9:   31 c0                     xor    %eax,%eax
Code;  c012b5ed <kmem_extra_free_checks+6d/80>
   b:   5b                        pop    %ebx
Code;  c012b5ee <kmem_extra_free_checks+6e/80>
   c:   5e                        pop    %esi
Code;  c012b5ef <kmem_extra_free_checks+6f/80>
   d:   5f                        pop    %edi
Code;  c012b5f0 <kmem_extra_free_checks+70/80>
   e:   5d                        pop    %ebp
Code;  c012b5f1 <kmem_extra_free_checks+71/80>
   f:   59                        pop    %ecx
Code;  c012b5f2 <kmem_extra_free_checks+72/80>
  10:   c3                        ret    
Code;  c012b5f3 <kmem_extra_free_checks+73/80>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Aug 12 15:48:15 bounce kernel:  <1>Unable to handle kernel paging request at virtual address be97019c
Aug 12 15:48:15 bounce kernel: c012b8d6
Aug 12 15:48:15 bounce kernel: Oops: 0000
Aug 12 15:48:15 bounce kernel: CPU:    0
Aug 12 15:48:15 bounce kernel: EIP:    0010:[<c012b8d6>]    Not tainted
Aug 12 15:48:15 bounce kernel: EFLAGS: 00010002
Aug 12 15:48:15 bounce kernel: eax: 000000a5   ebx: c14270c0   ecx: 00000020   edx: be97019c
Aug 12 15:48:15 bounce kernel: esi: be970198   edi: be97019c   ebp: 00020c00   esp: d7dd5eb4
Aug 12 15:48:15 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:15 bounce kernel: Process bash (pid: 573, stackpage=d7dd5000)
Aug 12 15:48:15 bounce kernel: Stack: d7dd4000 00000001 000000f0 00000014 00000020 00000002 00000246 c015f91e 
Aug 12 15:48:15 bounce kernel:        00000014 000000f0 00000000 d7a85400 d08f30c4 d7dd4000 c0159d33 c024ebcc 
Aug 12 15:48:15 bounce kernel:        00000014 000000f0 00000001 00000000 d7a85200 d08f30c4 d08f30c4 c0155088 
Aug 12 15:48:15 bounce kernel: Call Trace:    [<c015f91e>] [<c0159d33>] [<c0155088>] [<c0143a0e>] [<c0144deb>]
Aug 12 15:48:15 bounce kernel:   [<c013b5aa>] [<c013b72a>] [<c013bae5>] [<c0138a69>] [<c01086cf>]
Aug 12 15:48:15 bounce kernel: Code: f2 ae 74 05 bf 01 00 00 00 4f 89 7c 24 14 8b 4c 24 10 8d 44 


>>EIP; c012b8d6 <kmalloc+126/1e0>   <=====

>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>edx; be97019c Before first symbol
>>esi; be970198 Before first symbol
>>edi; be97019c Before first symbol
>>ebp; 00020c00 Before first symbol
>>esp; d7dd5eb4 <_end+17ac6d90/18519edc>

Trace; c015f91e <__jbd_kmalloc+1e/80>
Trace; c0159d33 <journal_start+73/d0>
Trace; c0155088 <ext3_dirty_inode+58/d0>
Trace; c0143a0e <__mark_inode_dirty+2e/80>
Trace; c0144deb <update_atime+4b/50>
Trace; c013b5aa <link_path_walk+6fa/860>
Trace; c013b72a <path_walk+1a/20>
Trace; c013bae5 <__user_walk+35/50>
Trace; c0138a69 <sys_stat64+19/70>
Trace; c01086cf <system_call+33/38>

Code;  c012b8d6 <kmalloc+126/1e0>
00000000 <_EIP>:
Code;  c012b8d6 <kmalloc+126/1e0>   <=====
   0:   f2 ae                     repnz scas %es:(%edi),%al   <=====
Code;  c012b8d8 <kmalloc+128/1e0>
   2:   74 05                     je     9 <_EIP+0x9> c012b8df <kmalloc+12f/1e0>
Code;  c012b8da <kmalloc+12a/1e0>
   4:   bf 01 00 00 00            mov    $0x1,%edi
Code;  c012b8df <kmalloc+12f/1e0>
   9:   4f                        dec    %edi
Code;  c012b8e0 <kmalloc+130/1e0>
   a:   89 7c 24 14               mov    %edi,0x14(%esp,1)
Code;  c012b8e4 <kmalloc+134/1e0>
   e:   8b 4c 24 10               mov    0x10(%esp,1),%ecx
Code;  c012b8e8 <kmalloc+138/1e0>
  12:   8d 44 00 00               lea    0x0(%eax,%eax,1),%eax

Aug 12 15:48:15 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:15 bounce kernel: c012b86f
Aug 12 15:48:15 bounce kernel: Oops: 0000
Aug 12 15:48:15 bounce kernel: CPU:    0
Aug 12 15:48:15 bounce kernel: EIP:    0010:[<c012b86f>]    Not tainted
Aug 12 15:48:15 bounce kernel: EFLAGS: 00010007
Aug 12 15:48:15 bounce kernel: eax: 08054fa8   ebx: c14270c0   ecx: c3970000   edx: 000031e5
Aug 12 15:48:15 bounce kernel: esi: 046b7400   edi: 000000f0   ebp: 00000014   esp: d7dd5d10
Aug 12 15:48:15 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:15 bounce kernel: Process init (pid: 16528, stackpage=d7dd5000)
Aug 12 15:48:15 bounce kernel: Stack: d7dd4000 00000001 000000f0 00000014 c01524b7 00000803 00000246 c015f91e 
Aug 12 15:48:15 bounce kernel:        00000014 000000f0 00000000 d7f84400 d76eabd4 d7dd4000 c0159d33 c024ebcc 
Aug 12 15:48:15 bounce kernel:        00000014 000000f0 00000001 00000000 d7f84200 d76eabd4 00000000 c0155088 
Aug 12 15:48:15 bounce kernel: Call Trace:    [<c01524b7>] [<c015f91e>] [<c0159d33>] [<c0155088>] [<c0143a0e>]
Aug 12 15:48:15 bounce kernel:   [<c0144deb>] [<c0126cc3>] [<c0126fc5>] [<c0126eb0>] [<c0139250>] [<c01396c6>]
Aug 12 15:48:15 bounce kernel:   [<c0139b2e>] [<c01073df>] [<c01086cf>]
Aug 12 15:48:15 bounce kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 


>>EIP; c012b86f <kmalloc+bf/1e0>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>ecx; c3970000 <_end+3660edc/18519edc>
>>edx; 000031e5 Before first symbol
>>esi; 046b7400 Before first symbol
>>esp; d7dd5d10 <_end+17ac6bec/18519edc>

Trace; c01524b7 <ext3_get_branch+57/d0>
Trace; c015f91e <__jbd_kmalloc+1e/80>
Trace; c0159d33 <journal_start+73/d0>
Trace; c0155088 <ext3_dirty_inode+58/d0>
Trace; c0143a0e <__mark_inode_dirty+2e/80>
Trace; c0144deb <update_atime+4b/50>
Trace; c0126cc3 <do_generic_file_read+3f3/400>
Trace; c0126fc5 <generic_file_read+85/140>
Trace; c0126eb0 <file_read_actor+0/90>
Trace; c0139250 <kernel_read+50/60>
Trace; c01396c6 <prepare_binprm+106/110>
Trace; c0139b2e <do_execve+11e/1f0>
Trace; c01073df <sys_execve+2f/60>
Trace; c01086cf <system_call+33/38>

Code;  c012b86f <kmalloc+bf/1e0>
00000000 <_EIP>:
Code;  c012b86f <kmalloc+bf/1e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012b873 <kmalloc+c3/1e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012b876 <kmalloc+c6/1e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b879 <kmalloc+c9/1e0>
   a:   75 16                     jne    22 <_EIP+0x22> c012b891 <kmalloc+e1/1e0>
Code;  c012b87b <kmalloc+cb/1e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012b87e <kmalloc+ce/1e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c012b880 <kmalloc+d0/1e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)

Aug 12 15:48:15 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:15 bounce kernel: c012b86f
Aug 12 15:48:15 bounce kernel: Oops: 0000
Aug 12 15:48:15 bounce kernel: CPU:    0
Aug 12 15:48:15 bounce kernel: EIP:    0010:[<c012b86f>]    Not tainted
Aug 12 15:48:15 bounce kernel: EFLAGS: 00010007
Aug 12 15:48:15 bounce kernel: eax: 08054fa8   ebx: c14270c0   ecx: c3970000   edx: 000031e6
Aug 12 15:48:15 bounce kernel: esi: 046b7400   edi: 000001f0   ebp: fffffff4   esp: d7dd5ce8
Aug 12 15:48:15 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:15 bounce kernel: Process init (pid: 16529, stackpage=d7dd5000)
Aug 12 15:48:15 bounce kernel: Stack: d7dd4000 d7592e0c c024a9e8 fffffff4 c1599044 00000400 00000246 c0148bbf 
Aug 12 15:48:15 bounce kernel:        00000013 000001f0 c028cd38 c01489c0 d7dd5e6c 00000000 c024a9e4 00000803 
Aug 12 15:48:15 bounce kernel:        00000246 c015f91e 00000014 000000f0 00000000 00000000 00000000 ffffffff 
Aug 12 15:48:15 bounce kernel: Call Trace:    [<c0148bbf>] [<c01489c0>] [<c015f91e>] [<c0159d33>] [<c0126ac3>]
Aug 12 15:48:15 bounce kernel:   [<c0126cc3>] [<c012d840>] [<c0139907>] [<c0139b8c>] [<c0139ba3>] [<c01073df>]
Aug 12 15:48:15 bounce kernel:   [<c01086cf>]
Aug 12 15:48:15 bounce kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 


>>EIP; c012b86f <kmalloc+bf/1e0>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>ecx; c3970000 <_end+3660edc/18519edc>
>>edx; 000031e6 Before first symbol
>>esi; 046b7400 Before first symbol
>>ebp; fffffff4 <END_OF_CODE+277b58fd/????>
>>esp; d7dd5ce8 <_end+17ac6bc4/18519edc>

Trace; c0148bbf <load_elf_binary+1ff/a90>
Trace; c01489c0 <load_elf_binary+0/a90>
Trace; c015f91e <__jbd_kmalloc+1e/80>
Trace; c0159d33 <journal_start+73/d0>
Trace; c0126ac3 <do_generic_file_read+1f3/400>
Trace; c0126cc3 <do_generic_file_read+3f3/400>
Trace; c012d840 <__alloc_pages+40/170>
Trace; c0139907 <search_binary_handler+67/170>
Trace; c0139b8c <do_execve+17c/1f0>
Trace; c0139ba3 <do_execve+193/1f0>
Trace; c01073df <sys_execve+2f/60>
Trace; c01086cf <system_call+33/38>

Code;  c012b86f <kmalloc+bf/1e0>
00000000 <_EIP>:
Code;  c012b86f <kmalloc+bf/1e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012b873 <kmalloc+c3/1e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012b876 <kmalloc+c6/1e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b879 <kmalloc+c9/1e0>
   a:   75 16                     jne    22 <_EIP+0x22> c012b891 <kmalloc+e1/1e0>
Code;  c012b87b <kmalloc+cb/1e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012b87e <kmalloc+ce/1e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c012b880 <kmalloc+d0/1e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)

Aug 12 15:48:15 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:15 bounce kernel: c012b86f
Aug 12 15:48:15 bounce kernel: Oops: 0000
Aug 12 15:48:15 bounce kernel: CPU:    0
Aug 12 15:48:15 bounce kernel: EIP:    0010:[<c012b86f>]    Not tainted
Aug 12 15:48:15 bounce kernel: EFLAGS: 00010007
Aug 12 15:48:15 bounce kernel: eax: 08054fa8   ebx: c14270c0   ecx: c3970000   edx: 000031e7
Aug 12 15:48:15 bounce kernel: esi: 046b7400   edi: 000001f0   ebp: fffffff4   esp: d7dd5ce8
Aug 12 15:48:15 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:15 bounce kernel: Process init (pid: 16530, stackpage=d7dd5000)
Aug 12 15:48:15 bounce kernel: Stack: d7dd4000 d75928e4 c024a9e8 fffffff4 c1599044 00000400 00000246 c0148bbf 
Aug 12 15:48:15 bounce kernel:        00000013 000001f0 c028cd38 c01489c0 d7dd5e6c 00000000 c024a9e4 00000803 
Aug 12 15:48:15 bounce kernel:        00000246 c015f91e 00000014 000000f0 00000000 00000000 00000000 ffffffff 
Aug 12 15:48:15 bounce kernel: Call Trace:    [<c0148bbf>] [<c01489c0>] [<c015f91e>] [<c0159d33>] [<c0126ac3>]
Aug 12 15:48:15 bounce kernel:   [<c0126cc3>] [<c012d840>] [<c0139907>] [<c0139b8c>] [<c0139ba3>] [<c01073df>]
Aug 12 15:48:15 bounce kernel:   [<c01086cf>]
Aug 12 15:48:15 bounce kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 


>>EIP; c012b86f <kmalloc+bf/1e0>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>ecx; c3970000 <_end+3660edc/18519edc>
>>edx; 000031e7 Before first symbol
>>esi; 046b7400 Before first symbol
>>ebp; fffffff4 <END_OF_CODE+277b58fd/????>
>>esp; d7dd5ce8 <_end+17ac6bc4/18519edc>

Trace; c0148bbf <load_elf_binary+1ff/a90>
Trace; c01489c0 <load_elf_binary+0/a90>
Trace; c015f91e <__jbd_kmalloc+1e/80>
Trace; c0159d33 <journal_start+73/d0>
Trace; c0126ac3 <do_generic_file_read+1f3/400>
Trace; c0126cc3 <do_generic_file_read+3f3/400>
Trace; c012d840 <__alloc_pages+40/170>
Trace; c0139907 <search_binary_handler+67/170>
Trace; c0139b8c <do_execve+17c/1f0>
Trace; c0139ba3 <do_execve+193/1f0>
Trace; c01073df <sys_execve+2f/60>
Trace; c01086cf <system_call+33/38>

Code;  c012b86f <kmalloc+bf/1e0>
00000000 <_EIP>:
Code;  c012b86f <kmalloc+bf/1e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012b873 <kmalloc+c3/1e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012b876 <kmalloc+c6/1e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b879 <kmalloc+c9/1e0>
   a:   75 16                     jne    22 <_EIP+0x22> c012b891 <kmalloc+e1/1e0>
Code;  c012b87b <kmalloc+cb/1e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012b87e <kmalloc+ce/1e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c012b880 <kmalloc+d0/1e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)

Aug 12 15:48:15 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:15 bounce kernel: c012b86f
Aug 12 15:48:15 bounce kernel: Oops: 0000
Aug 12 15:48:15 bounce kernel: CPU:    0
Aug 12 15:48:15 bounce kernel: EIP:    0010:[<c012b86f>]    Not tainted
Aug 12 15:48:15 bounce kernel: EFLAGS: 00010007
Aug 12 15:48:15 bounce kernel: eax: 08054fa8   ebx: c14270c0   ecx: c3970000   edx: 000031e8
Aug 12 15:48:15 bounce kernel: esi: 046b7400   edi: 000001f0   ebp: fffffff4   esp: d7dd5ce8
Aug 12 15:48:15 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:15 bounce kernel: Process init (pid: 16531, stackpage=d7dd5000)
Aug 12 15:48:15 bounce kernel: Stack: d7dd4000 d7592af4 c024a9e8 fffffff4 c1599044 00000400 00000246 c0148bbf 
Aug 12 15:48:15 bounce kernel:        00000013 000001f0 c028cd38 c01489c0 d7dd5e6c 00000000 c024a9e4 00000803 
Aug 12 15:48:15 bounce kernel:        00000246 c015f91e 00000014 000000f0 00000000 00000000 00000000 ffffffff 
Aug 12 15:48:15 bounce kernel: Call Trace:    [<c0148bbf>] [<c01489c0>] [<c015f91e>] [<c0159d33>] [<c0126ac3>]
Aug 12 15:48:15 bounce kernel:   [<c0126cc3>] [<c012d840>] [<c0139907>] [<c0139b8c>] [<c0139ba3>] [<c01073df>]
Aug 12 15:48:15 bounce kernel:   [<c01086cf>]
Aug 12 15:48:15 bounce kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 


>>EIP; c012b86f <kmalloc+bf/1e0>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>ecx; c3970000 <_end+3660edc/18519edc>
>>edx; 000031e8 Before first symbol
>>esi; 046b7400 Before first symbol
>>ebp; fffffff4 <END_OF_CODE+277b58fd/????>
>>esp; d7dd5ce8 <_end+17ac6bc4/18519edc>

Trace; c0148bbf <load_elf_binary+1ff/a90>
Trace; c01489c0 <load_elf_binary+0/a90>
Trace; c015f91e <__jbd_kmalloc+1e/80>
Trace; c0159d33 <journal_start+73/d0>
Trace; c0126ac3 <do_generic_file_read+1f3/400>
Trace; c0126cc3 <do_generic_file_read+3f3/400>
Trace; c012d840 <__alloc_pages+40/170>
Trace; c0139907 <search_binary_handler+67/170>
Trace; c0139b8c <do_execve+17c/1f0>
Trace; c0139ba3 <do_execve+193/1f0>
Trace; c01073df <sys_execve+2f/60>
Trace; c01086cf <system_call+33/38>

Code;  c012b86f <kmalloc+bf/1e0>
00000000 <_EIP>:
Code;  c012b86f <kmalloc+bf/1e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012b873 <kmalloc+c3/1e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012b876 <kmalloc+c6/1e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b879 <kmalloc+c9/1e0>
   a:   75 16                     jne    22 <_EIP+0x22> c012b891 <kmalloc+e1/1e0>
Code;  c012b87b <kmalloc+cb/1e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012b87e <kmalloc+ce/1e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c012b880 <kmalloc+d0/1e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)

Aug 12 15:48:15 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:15 bounce kernel: c012b86f
Aug 12 15:48:15 bounce kernel: Oops: 0000
Aug 12 15:48:15 bounce kernel: CPU:    0
Aug 12 15:48:15 bounce kernel: EIP:    0010:[<c012b86f>]    Not tainted
Aug 12 15:48:15 bounce kernel: EFLAGS: 00010007
Aug 12 15:48:15 bounce kernel: eax: 08054fa8   ebx: c14270c0   ecx: c3970000   edx: 000031e9
Aug 12 15:48:15 bounce kernel: esi: 046b7400   edi: 000001f0   ebp: fffffff4   esp: d7dd5ce8
Aug 12 15:48:15 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:15 bounce kernel: Process init (pid: 16532, stackpage=d7dd5000)
Aug 12 15:48:15 bounce kernel: Stack: d7dd4000 d162d2b4 c024a9e8 fffffff4 c1599044 00000400 00000246 c0148bbf 
Aug 12 15:48:15 bounce kernel:        00000013 000001f0 c028cd38 c01489c0 d7dd5e6c 00000000 c024a9e4 00000803 
Aug 12 15:48:15 bounce kernel:        00000246 c015f91e 00000014 000000f0 00000000 00000000 00000000 ffffffff 
Aug 12 15:48:15 bounce kernel: Call Trace:    [<c0148bbf>] [<c01489c0>] [<c015f91e>] [<c0159d33>] [<c0126ac3>]
Aug 12 15:48:15 bounce kernel:   [<c0126cc3>] [<c012d840>] [<c0139907>] [<c0139b8c>] [<c0139ba3>] [<c01073df>]
Aug 12 15:48:15 bounce kernel:   [<c01086cf>]
Aug 12 15:48:15 bounce kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 


>>EIP; c012b86f <kmalloc+bf/1e0>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>ecx; c3970000 <_end+3660edc/18519edc>
>>edx; 000031e9 Before first symbol
>>esi; 046b7400 Before first symbol
>>ebp; fffffff4 <END_OF_CODE+277b58fd/????>
>>esp; d7dd5ce8 <_end+17ac6bc4/18519edc>

Trace; c0148bbf <load_elf_binary+1ff/a90>
Trace; c01489c0 <load_elf_binary+0/a90>
Trace; c015f91e <__jbd_kmalloc+1e/80>
Trace; c0159d33 <journal_start+73/d0>
Trace; c0126ac3 <do_generic_file_read+1f3/400>
Trace; c0126cc3 <do_generic_file_read+3f3/400>
Trace; c012d840 <__alloc_pages+40/170>
Trace; c0139907 <search_binary_handler+67/170>
Trace; c0139b8c <do_execve+17c/1f0>
Trace; c0139ba3 <do_execve+193/1f0>
Trace; c01073df <sys_execve+2f/60>
Trace; c01086cf <system_call+33/38>

Code;  c012b86f <kmalloc+bf/1e0>
00000000 <_EIP>:
Code;  c012b86f <kmalloc+bf/1e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012b873 <kmalloc+c3/1e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012b876 <kmalloc+c6/1e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b879 <kmalloc+c9/1e0>
   a:   75 16                     jne    22 <_EIP+0x22> c012b891 <kmalloc+e1/1e0>
Code;  c012b87b <kmalloc+cb/1e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012b87e <kmalloc+ce/1e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c012b880 <kmalloc+d0/1e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)

Aug 12 15:48:15 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:15 bounce kernel: c012b86f
Aug 12 15:48:15 bounce kernel: Oops: 0000
Aug 12 15:48:15 bounce kernel: CPU:    0
Aug 12 15:48:15 bounce kernel: EIP:    0010:[<c012b86f>]    Not tainted
Aug 12 15:48:15 bounce kernel: EFLAGS: 00010007
Aug 12 15:48:15 bounce kernel: eax: 08054fa8   ebx: c14270c0   ecx: c3970000   edx: 000031ea
Aug 12 15:48:15 bounce kernel: esi: 046b7400   edi: 000001f0   ebp: fffffff4   esp: d7dd5ce8
Aug 12 15:48:15 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:15 bounce kernel: Process init (pid: 16533, stackpage=d7dd5000)
Aug 12 15:48:15 bounce kernel: Stack: d7dd4000 d162d3bc c024a9e8 fffffff4 c1599044 00000400 00000246 c0148bbf 
Aug 12 15:48:15 bounce kernel:        00000013 000001f0 c028cd38 c01489c0 d7dd5e6c 00000000 c024a9e4 00000803 
Aug 12 15:48:15 bounce kernel:        00000246 c015f91e 00000014 000000f0 00000000 00000000 00000000 ffffffff 
Aug 12 15:48:15 bounce kernel: Call Trace:    [<c0148bbf>] [<c01489c0>] [<c015f91e>] [<c0159d33>] [<c0126ac3>]
Aug 12 15:48:15 bounce kernel:   [<c0126cc3>] [<c012d840>] [<c0139907>] [<c0139b8c>] [<c0139ba3>] [<c01073df>]
Aug 12 15:48:15 bounce kernel:   [<c01086cf>]
Aug 12 15:48:15 bounce kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 


>>EIP; c012b86f <kmalloc+bf/1e0>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>ecx; c3970000 <_end+3660edc/18519edc>
>>edx; 000031ea Before first symbol
>>esi; 046b7400 Before first symbol
>>ebp; fffffff4 <END_OF_CODE+277b58fd/????>
>>esp; d7dd5ce8 <_end+17ac6bc4/18519edc>

Trace; c0148bbf <load_elf_binary+1ff/a90>
Trace; c01489c0 <load_elf_binary+0/a90>
Trace; c015f91e <__jbd_kmalloc+1e/80>
Trace; c0159d33 <journal_start+73/d0>
Trace; c0126ac3 <do_generic_file_read+1f3/400>
Trace; c0126cc3 <do_generic_file_read+3f3/400>
Trace; c012d840 <__alloc_pages+40/170>
Trace; c0139907 <search_binary_handler+67/170>
Trace; c0139b8c <do_execve+17c/1f0>
Trace; c0139ba3 <do_execve+193/1f0>
Trace; c01073df <sys_execve+2f/60>
Trace; c01086cf <system_call+33/38>

Code;  c012b86f <kmalloc+bf/1e0>
00000000 <_EIP>:
Code;  c012b86f <kmalloc+bf/1e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012b873 <kmalloc+c3/1e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012b876 <kmalloc+c6/1e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b879 <kmalloc+c9/1e0>
   a:   75 16                     jne    22 <_EIP+0x22> c012b891 <kmalloc+e1/1e0>
Code;  c012b87b <kmalloc+cb/1e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012b87e <kmalloc+ce/1e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c012b880 <kmalloc+d0/1e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)

Aug 12 15:48:15 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:15 bounce kernel: c012b86f
Aug 12 15:48:15 bounce kernel: Oops: 0000
Aug 12 15:48:15 bounce kernel: CPU:    0
Aug 12 15:48:15 bounce kernel: EIP:    0010:[<c012b86f>]    Not tainted
Aug 12 15:48:15 bounce kernel: EFLAGS: 00010007
Aug 12 15:48:15 bounce kernel: eax: 08054fa8   ebx: c14270c0   ecx: c3970000   edx: 000031eb
Aug 12 15:48:15 bounce kernel: esi: 046b7400   edi: 000001f0   ebp: fffffff4   esp: d7dd5ce8
Aug 12 15:48:15 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:15 bounce kernel: Process init (pid: 16534, stackpage=d7dd5000)
Aug 12 15:48:15 bounce kernel: Stack: d7dd4000 d162d4c4 c024a9e8 fffffff4 c1599044 00000400 00000246 c0148bbf 
Aug 12 15:48:15 bounce kernel:        00000013 000001f0 c028cd38 c01489c0 d7dd5e6c 00000000 c024a9e4 00000803 
Aug 12 15:48:15 bounce kernel:        00000246 c015f91e 00000014 000000f0 00000000 00000000 00000000 ffffffff 
Aug 12 15:48:15 bounce kernel: Call Trace:    [<c0148bbf>] [<c01489c0>] [<c015f91e>] [<c0159d33>] [<c0126ac3>]
Aug 12 15:48:15 bounce kernel:   [<c0126cc3>] [<c012d840>] [<c0139907>] [<c0139b8c>] [<c0139ba3>] [<c01073df>]
Aug 12 15:48:15 bounce kernel:   [<c01086cf>]
Aug 12 15:48:15 bounce kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 


>>EIP; c012b86f <kmalloc+bf/1e0>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>ecx; c3970000 <_end+3660edc/18519edc>
>>edx; 000031eb Before first symbol
>>esi; 046b7400 Before first symbol
>>ebp; fffffff4 <END_OF_CODE+277b58fd/????>
>>esp; d7dd5ce8 <_end+17ac6bc4/18519edc>

Trace; c0148bbf <load_elf_binary+1ff/a90>
Trace; c01489c0 <load_elf_binary+0/a90>
Trace; c015f91e <__jbd_kmalloc+1e/80>
Trace; c0159d33 <journal_start+73/d0>
Trace; c0126ac3 <do_generic_file_read+1f3/400>
Trace; c0126cc3 <do_generic_file_read+3f3/400>
Trace; c012d840 <__alloc_pages+40/170>
Trace; c0139907 <search_binary_handler+67/170>
Trace; c0139b8c <do_execve+17c/1f0>
Trace; c0139ba3 <do_execve+193/1f0>
Trace; c01073df <sys_execve+2f/60>
Trace; c01086cf <system_call+33/38>

Code;  c012b86f <kmalloc+bf/1e0>
00000000 <_EIP>:
Code;  c012b86f <kmalloc+bf/1e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012b873 <kmalloc+c3/1e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012b876 <kmalloc+c6/1e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b879 <kmalloc+c9/1e0>
   a:   75 16                     jne    22 <_EIP+0x22> c012b891 <kmalloc+e1/1e0>
Code;  c012b87b <kmalloc+cb/1e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012b87e <kmalloc+ce/1e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c012b880 <kmalloc+d0/1e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)

Aug 12 15:48:15 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:15 bounce kernel: c012b86f
Aug 12 15:48:15 bounce kernel: Oops: 0000
Aug 12 15:48:15 bounce kernel: CPU:    0
Aug 12 15:48:15 bounce kernel: EIP:    0010:[<c012b86f>]    Not tainted
Aug 12 15:48:15 bounce kernel: EFLAGS: 00010007
Aug 12 15:48:15 bounce kernel: eax: 08054fa8   ebx: c14270c0   ecx: c3970000   edx: 000031ec
Aug 12 15:48:15 bounce kernel: esi: 046b7400   edi: 000001f0   ebp: fffffff4   esp: d7dd5ce8
Aug 12 15:48:15 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:15 bounce kernel: Process init (pid: 16535, stackpage=d7dd5000)
Aug 12 15:48:15 bounce kernel: Stack: d7dd4000 d162daf4 c024a9e8 fffffff4 c1599044 00000400 00000246 c0148bbf 
Aug 12 15:48:15 bounce kernel:        00000013 000001f0 c028cd38 c01489c0 d7dd5e6c 00000000 c024a9e4 00000803 
Aug 12 15:48:15 bounce kernel:        00000246 c015f91e 00000014 000000f0 00000000 00000000 00000000 ffffffff 
Aug 12 15:48:15 bounce kernel: Call Trace:    [<c0148bbf>] [<c01489c0>] [<c015f91e>] [<c0159d33>] [<c0126ac3>]
Aug 12 15:48:15 bounce kernel:   [<c0126cc3>] [<c012d840>] [<c0139907>] [<c0139b8c>] [<c0139ba3>] [<c01073df>]
Aug 12 15:48:15 bounce kernel:   [<c01086cf>]
Aug 12 15:48:15 bounce kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 


>>EIP; c012b86f <kmalloc+bf/1e0>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>ecx; c3970000 <_end+3660edc/18519edc>
>>edx; 000031ec Before first symbol
>>esi; 046b7400 Before first symbol
>>ebp; fffffff4 <END_OF_CODE+277b58fd/????>
>>esp; d7dd5ce8 <_end+17ac6bc4/18519edc>

Trace; c0148bbf <load_elf_binary+1ff/a90>
Trace; c01489c0 <load_elf_binary+0/a90>
Trace; c015f91e <__jbd_kmalloc+1e/80>
Trace; c0159d33 <journal_start+73/d0>
Trace; c0126ac3 <do_generic_file_read+1f3/400>
Trace; c0126cc3 <do_generic_file_read+3f3/400>
Trace; c012d840 <__alloc_pages+40/170>
Trace; c0139907 <search_binary_handler+67/170>
Trace; c0139b8c <do_execve+17c/1f0>
Trace; c0139ba3 <do_execve+193/1f0>
Trace; c01073df <sys_execve+2f/60>
Trace; c01086cf <system_call+33/38>

Code;  c012b86f <kmalloc+bf/1e0>
00000000 <_EIP>:
Code;  c012b86f <kmalloc+bf/1e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012b873 <kmalloc+c3/1e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012b876 <kmalloc+c6/1e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b879 <kmalloc+c9/1e0>
   a:   75 16                     jne    22 <_EIP+0x22> c012b891 <kmalloc+e1/1e0>
Code;  c012b87b <kmalloc+cb/1e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012b87e <kmalloc+ce/1e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c012b880 <kmalloc+d0/1e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)

Aug 12 15:48:15 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:15 bounce kernel: c012b86f
Aug 12 15:48:15 bounce kernel: Oops: 0000
Aug 12 15:48:15 bounce kernel: CPU:    0
Aug 12 15:48:15 bounce kernel: EIP:    0010:[<c012b86f>]    Not tainted
Aug 12 15:48:15 bounce kernel: EFLAGS: 00010007
Aug 12 15:48:15 bounce kernel: eax: 08054fa8   ebx: c14270c0   ecx: c3970000   edx: 000031ed
Aug 12 15:48:15 bounce kernel: esi: 046b7400   edi: 000001f0   ebp: fffffff4   esp: d7dd5ce8
Aug 12 15:48:15 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:15 bounce kernel: Process init (pid: 16536, stackpage=d7dd5000)
Aug 12 15:48:15 bounce kernel: Stack: d7dd4000 d162d5cc c024a9e8 fffffff4 c1599044 00000400 00000246 c0148bbf 
Aug 12 15:48:15 bounce kernel:        00000013 000001f0 c028cd38 c01489c0 d7dd5e6c 00000000 c024a9e4 00000803 
Aug 12 15:48:15 bounce kernel:        00000246 c015f91e 00000014 000000f0 00000000 00000000 00000000 ffffffff 
Aug 12 15:48:15 bounce kernel: Call Trace:    [<c0148bbf>] [<c01489c0>] [<c015f91e>] [<c0159d33>] [<c0126ac3>]
Aug 12 15:48:15 bounce kernel:   [<c0126cc3>] [<c012d840>] [<c0139907>] [<c0139b8c>] [<c0139ba3>] [<c01073df>]
Aug 12 15:48:15 bounce kernel:   [<c01086cf>]
Aug 12 15:48:15 bounce kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 


>>EIP; c012b86f <kmalloc+bf/1e0>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>ecx; c3970000 <_end+3660edc/18519edc>
>>edx; 000031ed Before first symbol
>>esi; 046b7400 Before first symbol
>>ebp; fffffff4 <END_OF_CODE+277b58fd/????>
>>esp; d7dd5ce8 <_end+17ac6bc4/18519edc>

Trace; c0148bbf <load_elf_binary+1ff/a90>
Trace; c01489c0 <load_elf_binary+0/a90>
Trace; c015f91e <__jbd_kmalloc+1e/80>
Trace; c0159d33 <journal_start+73/d0>
Trace; c0126ac3 <do_generic_file_read+1f3/400>
Trace; c0126cc3 <do_generic_file_read+3f3/400>
Trace; c012d840 <__alloc_pages+40/170>
Trace; c0139907 <search_binary_handler+67/170>
Trace; c0139b8c <do_execve+17c/1f0>
Trace; c0139ba3 <do_execve+193/1f0>
Trace; c01073df <sys_execve+2f/60>
Trace; c01086cf <system_call+33/38>

Code;  c012b86f <kmalloc+bf/1e0>
00000000 <_EIP>:
Code;  c012b86f <kmalloc+bf/1e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012b873 <kmalloc+c3/1e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012b876 <kmalloc+c6/1e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b879 <kmalloc+c9/1e0>
   a:   75 16                     jne    22 <_EIP+0x22> c012b891 <kmalloc+e1/1e0>
Code;  c012b87b <kmalloc+cb/1e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012b87e <kmalloc+ce/1e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c012b880 <kmalloc+d0/1e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)

Aug 12 15:48:15 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:15 bounce kernel: c012b86f
Aug 12 15:48:15 bounce kernel: Oops: 0000
Aug 12 15:48:15 bounce kernel: CPU:    0
Aug 12 15:48:15 bounce kernel: EIP:    0010:[<c012b86f>]    Not tainted
Aug 12 15:48:15 bounce kernel: EFLAGS: 00010007
Aug 12 15:48:15 bounce kernel: eax: 08054fa8   ebx: c14270c0   ecx: c3970000   edx: 000031ee
Aug 12 15:48:15 bounce kernel: esi: 046b7400   edi: 000001f0   ebp: fffffff4   esp: d7dd5ce8
Aug 12 15:48:15 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:15 bounce kernel: Process init (pid: 16537, stackpage=d7dd5000)
Aug 12 15:48:15 bounce kernel: Stack: d7dd4000 d162d6d4 c024a9e8 fffffff4 c1599044 00000400 00000246 c0148bbf 
Aug 12 15:48:15 bounce kernel:        00000013 000001f0 c028cd38 c01489c0 d7dd5e6c 00000000 c024a9e4 00000803 
Aug 12 15:48:15 bounce kernel:        00000246 c015f91e 00000014 000000f0 00000000 00000000 00000000 ffffffff 
Aug 12 15:48:15 bounce kernel: Call Trace:    [<c0148bbf>] [<c01489c0>] [<c015f91e>] [<c0159d33>] [<c0126ac3>]
Aug 12 15:48:15 bounce kernel:   [<c0126cc3>] [<c012d840>] [<c0139907>] [<c0139b8c>] [<c0139ba3>] [<c01073df>]
Aug 12 15:48:15 bounce kernel:   [<c01086cf>]
Aug 12 15:48:15 bounce kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 


>>EIP; c012b86f <kmalloc+bf/1e0>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>ecx; c3970000 <_end+3660edc/18519edc>
>>edx; 000031ee Before first symbol
>>esi; 046b7400 Before first symbol
>>ebp; fffffff4 <END_OF_CODE+277b58fd/????>
>>esp; d7dd5ce8 <_end+17ac6bc4/18519edc>

Trace; c0148bbf <load_elf_binary+1ff/a90>
Trace; c01489c0 <load_elf_binary+0/a90>
Trace; c015f91e <__jbd_kmalloc+1e/80>
Trace; c0159d33 <journal_start+73/d0>
Trace; c0126ac3 <do_generic_file_read+1f3/400>
Trace; c0126cc3 <do_generic_file_read+3f3/400>
Trace; c012d840 <__alloc_pages+40/170>
Trace; c0139907 <search_binary_handler+67/170>
Trace; c0139b8c <do_execve+17c/1f0>
Trace; c0139ba3 <do_execve+193/1f0>
Trace; c01073df <sys_execve+2f/60>
Trace; c01086cf <system_call+33/38>

Code;  c012b86f <kmalloc+bf/1e0>
00000000 <_EIP>:
Code;  c012b86f <kmalloc+bf/1e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012b873 <kmalloc+c3/1e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012b876 <kmalloc+c6/1e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b879 <kmalloc+c9/1e0>
   a:   75 16                     jne    22 <_EIP+0x22> c012b891 <kmalloc+e1/1e0>
Code;  c012b87b <kmalloc+cb/1e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012b87e <kmalloc+ce/1e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c012b880 <kmalloc+d0/1e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)

Aug 12 15:48:16 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:16 bounce kernel: c012b86f
Aug 12 15:48:16 bounce kernel: Oops: 0000
Aug 12 15:48:16 bounce kernel: CPU:    0
Aug 12 15:48:16 bounce kernel: EIP:    0010:[<c012b86f>]    Not tainted
Aug 12 15:48:16 bounce kernel: EFLAGS: 00010007
Aug 12 15:48:16 bounce kernel: eax: 08054fa8   ebx: c14270c0   ecx: c3970000   edx: 000031ef
Aug 12 15:48:16 bounce kernel: esi: 046b7400   edi: 000001f0   ebp: fffffff4   esp: d6e1ff58
Aug 12 15:48:16 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:16 bounce kernel: Process upsmon (pid: 518, stackpage=d6e1f000)
Aug 12 15:48:16 bounce kernel: Stack: 00000001 d6e1e000 bffffd24 fffffff4 d6e1ffa8 00000000 00000246 c013f6d4 
Aug 12 15:48:16 bounce kernel:        00000018 000001f0 c013f7d9 00000004 d6e1e000 00000000 bffffd24 bffffdac 
Aug 12 15:48:16 bounce kernel:        d6e1ffb0 00000004 d6e1e000 00000000 d6e1ffb8 d6e1e000 00000000 bffffe34 
Aug 12 15:48:16 bounce kernel: Call Trace:    [<c013f6d4>] [<c013f7d9>] [<c01086cf>]
Aug 12 15:48:16 bounce kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 


>>EIP; c012b86f <kmalloc+bf/1e0>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>ecx; c3970000 <_end+3660edc/18519edc>
>>edx; 000031ef Before first symbol
>>esi; 046b7400 Before first symbol
>>ebp; fffffff4 <END_OF_CODE+277b58fd/????>
>>esp; d6e1ff58 <_end+16b10e34/18519edc>

Trace; c013f6d4 <select_bits_alloc+14/20>
Trace; c013f7d9 <sys_select+e9/470>
Trace; c01086cf <system_call+33/38>

Code;  c012b86f <kmalloc+bf/1e0>
00000000 <_EIP>:
Code;  c012b86f <kmalloc+bf/1e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012b873 <kmalloc+c3/1e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012b876 <kmalloc+c6/1e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b879 <kmalloc+c9/1e0>
   a:   75 16                     jne    22 <_EIP+0x22> c012b891 <kmalloc+e1/1e0>
Code;  c012b87b <kmalloc+cb/1e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012b87e <kmalloc+ce/1e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c012b880 <kmalloc+d0/1e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)

Aug 12 15:48:49 bounce kernel:  <1>Unable to handle kernel paging request at virtual address e3ac3eb8
Aug 12 15:48:49 bounce kernel: c012b86f
Aug 12 15:48:49 bounce kernel: Oops: 0000
Aug 12 15:48:49 bounce kernel: CPU:    0
Aug 12 15:48:49 bounce kernel: EIP:    0010:[<c012b86f>]    Not tainted
Aug 12 15:48:49 bounce kernel: EFLAGS: 00010007
Aug 12 15:48:49 bounce kernel: eax: 08054fa8   ebx: c14270c0   ecx: c3970000   edx: 000031f0
Aug 12 15:48:49 bounce kernel: esi: 046b7400   edi: 000000f0   ebp: 00000014   esp: d6239e64
Aug 12 15:48:49 bounce kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 15:48:49 bounce kernel: Process uptimed (pid: 534, stackpage=d6239000)
Aug 12 15:48:49 bounce kernel: Stack: d6238000 00000001 000000f0 00000014 c3b27e44 c015ad1c 00000246 c015f91e 
Aug 12 15:48:49 bounce kernel:        00000014 000000f0 00000000 d7f84c00 d6361dec d6238000 c0159d33 c024ebcc 
Aug 12 15:48:49 bounce kernel:        00000014 000000f0 00000001 00000048 00000000 d6361dec 00000048 c0154d98 
Aug 12 15:48:49 bounce kernel: Call Trace:    [<c015ad1c>] [<c015f91e>] [<c0159d33>] [<c0154d98>] [<c01450a2>]
Aug 12 15:48:49 bounce kernel:   [<c0130c09>] [<c013b9f4>] [<c013bfb4>] [<c0131a9b>] [<c0131df6>] [<c01086cf>]
Aug 12 15:48:49 bounce kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 16 8b 41 04 8b 11 89 42 04 


>>EIP; c012b86f <kmalloc+bf/1e0>   <=====

>>eax; 08054fa8 Before first symbol
>>ebx; c14270c0 <_end+1117f9c/18519edc>
>>ecx; c3970000 <_end+3660edc/18519edc>
>>edx; 000031f0 Before first symbol
>>esi; 046b7400 Before first symbol
>>esp; d6239e64 <_end+15f2ad40/18519edc>

Trace; c015ad1c <journal_dirty_metadata+15c/180>
Trace; c015f91e <__jbd_kmalloc+1e/80>
Trace; c0159d33 <journal_start+73/d0>
Trace; c0154d98 <ext3_setattr+c8/190>
Trace; c01450a2 <notify_change+52/f0>
Trace; c0130c09 <do_truncate+49/60>
Trace; c013b9f4 <lookup_hash+44/90>
Trace; c013bfb4 <open_namei+404/530>
Trace; c0131a9b <filp_open+3b/60>
Trace; c0131df6 <sys_open+36/90>
Trace; c01086cf <system_call+33/38>

Code;  c012b86f <kmalloc+bf/1e0>
00000000 <_EIP>:
Code;  c012b86f <kmalloc+bf/1e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c012b873 <kmalloc+c3/1e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c012b876 <kmalloc+c6/1e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c012b879 <kmalloc+c9/1e0>
   a:   75 16                     jne    22 <_EIP+0x22> c012b891 <kmalloc+e1/1e0>
Code;  c012b87b <kmalloc+cb/1e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c012b87e <kmalloc+ce/1e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c012b880 <kmalloc+d0/1e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)


Simon.

-- 
oOoOo "A short description of how to reproduce it, and I'll be on  oOoOo
 oOoOo it like a fly on a week old dead donkey" -- Linus Torvalds oOoOo
  oOoOo                                                          oOoOo
          htag.pl 0.0.22 ::::::: http://www.earth.li/~huggie/
