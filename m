Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319045AbSHSWCB>; Mon, 19 Aug 2002 18:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319054AbSHSWCB>; Mon, 19 Aug 2002 18:02:01 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:21209 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319045AbSHSWB7>; Mon, 19 Aug 2002 18:01:59 -0400
Subject: Re: [Lse-tech] LTP-Nightly bk test
From: Paul Larson <plars@austin.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       lse-tech@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D61338C.E53C5AB9@zip.com.au>
References: <2553170000.1029775843@flay>
	<1029777883.4073.4.camel@plars.austin.ibm.com> 
	<3D61338C.E53C5AB9@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Aug 2002 16:57:52 -0500
Message-Id: <1029794275.4073.21.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 13:06, Andrew Morton wrote:

> For the page allocation failures you'll probably need this, which
> makes block-highmem work again.
Yes, this is a 2-way PIII-550.  I tried the patch and didn't get the
page_alloc.c:97 error (although I didn't see the page_alloc one the
first time either, only the second).  However, I did get the original
oops that I was trying to reproduce.

kernel BUG at swap.c:85!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0130ff0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: c2517f44     ecx: c03b7d60       edx: c0445230
esi: 00000202   edi: 0001a000     ebp: c38210d0       esp: c390def0
ds: 0068   es: 0068   ss: 0068
Stack: c2517f44 000001fb c01337cf 00000065 c012708d c2517f44 5ca00000
80000000
       c398d728 c0445220 c0445230 7aa09047 00000000 00019000 c0127135
c0445220
       c398d728 5ca00000 00200000 40148000 f76bcba8 8054c000 c0445220
c012718d
Call Trace: [<c01337cf>] [<c012708d>] [<c0127135>] [<c012718d>]
[<c012a2a6>]
   [<c011658d>] [<c011b448>] [<c011b68a>] [<c01073e3>]
Code: 0f 0b 55 00 4f c4 31 c0 8b 03 a8 40 74 3a 8d 4b 18 8b 51 04


>>EIP; c0130ff0 <__page_cache_release+3c/c8>   <=====

>>ebx; c2517f44 <END_OF_CODE+207b628/????>
>>ecx; c03b7d60 <contig_page_data+180/340>
>>edx; c0445230 <mmu_gathers+10/ff80>
>>edi; 0001a000 Before first symbol
>>ebp; c38210d0 <END_OF_CODE+33847b4/????>
>>esp; c390def0 <END_OF_CODE+34715d4/????>

Trace; c01337cf <free_page_and_swap_cache+43/48>
Trace; c012708d <zap_pte_range+24d/2a8>
Trace; c0127135 <zap_pmd_range+4d/68>
Trace; c012718d <unmap_page_range+3d/5c>
Trace; c012a2a6 <exit_mmap+ea/208>
Trace; c011658d <mmput+49/60>
Trace; c011b448 <do_exit+d8/2f4>
Trace; c011b68a <sys_exit+e/10>
Trace; c01073e3 <syscall_call+7/b>

Code;  c0130ff0 <__page_cache_release+3c/c8>
00000000 <_EIP>:
Code;  c0130ff0 <__page_cache_release+3c/c8>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0130ff2 <__page_cache_release+3e/c8>
   2:   55                        push   %ebp
Code;  c0130ff3 <__page_cache_release+3f/c8>
   3:   00 4f c4                  add    %cl,0xffffffc4(%edi)
Code;  c0130ff6 <__page_cache_release+42/c8>
   6:   31 c0                     xor    %eax,%eax
Code;  c0130ff8 <__page_cache_release+44/c8>
   8:   8b 03                     mov    (%ebx),%eax
Code;  c0130ffa <__page_cache_release+46/c8>
   a:   a8 40                     test   $0x40,%al
Code;  c0130ffc <__page_cache_release+48/c8>
   c:   74 3a                     je     48 <_EIP+0x48> c0131038
<__page_cache_release+84/c8>
Code;  c0130ffe <__page_cache_release+4a/c8>
   e:   8d 4b 18                  lea    0x18(%ebx),%ecx
Code;  c0131001 <__page_cache_release+4d/c8>
  11:   8b 51 04                  mov    0x4(%ecx),%edx

