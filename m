Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTB0GW1>; Thu, 27 Feb 2003 01:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbTB0GW1>; Thu, 27 Feb 2003 01:22:27 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:32194 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261368AbTB0GWZ>;
	Thu, 27 Feb 2003 01:22:25 -0500
Message-ID: <3E5DB057.60503@us.ibm.com>
Date: Wed, 26 Feb 2003 22:29:43 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: oprofile-list@lists.sourceforge.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops running oprofile in 2.5.62
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened while running dbench on 2.5.62.  I haven't seen it before,
but I thought I'd report it anyway.  I'm using the 0.5 version of the
userspace tools.

I'm pretty sure it happened on this line in oprofile_add_sample():
	cpu_buf->buffer[cpu_buf->pos].eip = eip;

Unable to handle kernel paging request at virtual address f8c3c000
c0212022
*pde = 00000000
Oops: 0002
CPU:    13
EIP:    0060:[<c0212022>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 40082d94   ebx: 00000340   ecx: 00002000   edx: f8c2c000
esi: 00000000   edi: c0310f00   ebp: 00000000   esp: e2fbdf60
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 00000000 c03a22c8 c02139f0 40082d94 00000000 00000000
       0000000d e2fbc000 e2fbdfc4 bffff7a0 bffffbb8 40082d94 c0213291
       0000000d c03a22c8 e2fbdfc4 c010a1eb e2fbdfc4 0000000d 40122020
       00000000 c010962e e2fbdfc4
Call Trace:
 [<c02139f0>] ppro_check_ctrs+0x4c/0x80
 [<c0213291>] nmi_callback+0x21/0x28
 [<c010a1eb>] do_nmi+0x2b/0x48
 [<c010962e>] nmi+0x1e/0x30
Code: 89 04 ca 8b 8b c4 0b 31 c0 8b 93 d0 0b 31 c0 8b 44 24 18 89
p

>>EIP; c0212022 <oprofile_add_sample+102/128>   <=====

>>edi; c0310f00 <cpu_buffer+340/800>

Trace; c02139f0 <ppro_check_ctrs+4c/80>
Trace; c0213291 <nmi_callback+21/28>
Trace; c010a1eb <do_nmi+2b/48>
Trace; c010962e <nmi+1e/30>

Code;  c0212022 <oprofile_add_sample+102/128>
00000000 <_EIP>:
Code;  c0212022 <oprofile_add_sample+102/128>   <=====
   0:   89 04 ca                  mov    %eax,(%edx,%ecx,8)   <=====
Code;  c0212025 <oprofile_add_sample+105/128>
   3:   8b 8b c4 0b 31 c0         mov    0xc0310bc4(%ebx),%ecx
Code;  c021202b <oprofile_add_sample+10b/128>
   9:   8b 93 d0 0b 31 c0         mov    0xc0310bd0(%ebx),%edx
Code;  c0212031 <oprofile_add_sample+111/128>
   f:   8b 44 24 18               mov    0x18(%esp,1),%eax
Code;  c0212035 <oprofile_add_sample+115/128>
  13:   89 00                     mov    %eax,(%eax)



-- 
Dave Hansen
haveblue@us.ibm.com

