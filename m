Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313056AbSDCFQp>; Wed, 3 Apr 2002 00:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313057AbSDCFQg>; Wed, 3 Apr 2002 00:16:36 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:40677 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S313056AbSDCFQX>;
	Wed, 3 Apr 2002 00:16:23 -0500
Message-ID: <3CAA9025.3060004@tmsusa.com>
Date: Tue, 02 Apr 2002 21:16:21 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020402
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: A me-too oops from 2.4.19-pre4-ac3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've seen a few of these reports on the list -

I'm running 2.4.19-pre4-ac3 + preemptive and
the  -aa low latency patch. (Andrew's mini-lowlat)

The box had been up for about 4 days when the
oops happened, while playing quake 3 arena.
No ill effects were noted, the box is still up
and everything appears to be working.

Red Hat 7.2+ updates -
P4b 1600
Genuine Intel P4 mobo
512 MB RAM

Yes, my kernel is tainted with nvidia, but IMHO
the nvidia driver has zero connection with the
oops - So, FWIW, here's the oops:

kernel BUG at page_alloc.c:131!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012efd7>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013282
eax: 00000000   ebx: c1552120   ecx: c100000c   edx: dad607a8
esi: 00000000   edi: 00000000   ebp: 00007000   esp: dda91ed8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 2118, stackpage=dda91000)
Stack: c025f278 c1552120 00000000 00000001 c1552120 00008000 c1552120 
c1552120
       00008000 dcba1640 00007000 c0122592 c1552120 1a319027 00000008 
00000000
       48591000 de241484 48589000 00000000 48591000 de241484 00030002 
dc0dab80
Call Trace: [<c0122592>] [<c0125054>] [<c012503d>] [<c0125114>] 
[<c0106efb>]
Code: 0f 0b 83 00 22 1b 1f c0 c6 43 24 05 8b 43 18 89 f1 83 e0 eb

 >>EIP; c012efd7 <__free_pages_ok+c7/2a0>   <=====
Trace; c0122592 <zap_page_range+192/260>
Trace; c0125054 <do_munmap+214/2a0>
Trace; c012503d <do_munmap+1fd/2a0>
Trace; c0125114 <sys_munmap+34/50>
Trace; c0106efb <system_call+33/38>
Code;  c012efd7 <__free_pages_ok+c7/2a0>
00000000 <_EIP>:
Code;  c012efd7 <__free_pages_ok+c7/2a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012efd9 <__free_pages_ok+c9/2a0>
   2:   83 00 22                  addl   $0x22,(%eax)
Code;  c012efdc <__free_pages_ok+cc/2a0>
   5:   1b 1f                     sbb    (%edi),%ebx
Code;  c012efde <__free_pages_ok+ce/2a0>
   7:   c0 c6 43                  rol    $0x43,%dh
Code;  c012efe1 <__free_pages_ok+d1/2a0>
   a:   24 05                     and    $0x5,%al
Code;  c012efe3 <__free_pages_ok+d3/2a0>
   c:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c012efe6 <__free_pages_ok+d6/2a0>
   f:   89 f1                     mov    %esi,%ecx
Code;  c012efe8 <__free_pages_ok+d8/2a0>
  11:   83 e0 eb                  and    $0xffffffeb,%eax




