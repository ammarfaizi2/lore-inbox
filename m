Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUIJHfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUIJHfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUIJHeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:34:06 -0400
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:50568 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S263664AbUIJHcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:32:19 -0400
Date: Fri, 10 Sep 2004 10:33:44 +0300 (EEST)
From: Mihai Rusu <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: LKML <linux-kernel@vger.kernel.org>
Subject: DRM & X.Org 6.8.0 oops
Message-ID: <Pine.LNX.4.58L0.0409101026090.4089@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

There seems to be some DRM problem with X.Org 6.8.0 on 2.6.8.1. I recently 
switched from XFree86 and there I did not noticed the same thing.

System information: P4 2.8 Ghz HT, Intel 865G on-board graphics, ASUS 
P4-P800VM mobo, having compiled preempt, SMP (for HT, which works) and SMT 
scheduler.

It seems to happen when starting xdm/gdm.

ksymoops parsed kernel message:
mtrr: base(0xf0020000) is not aligned on a size(0x400000) boundary
[drm:i830_dma_initialize] *ERROR* can not find dma buffer map!
[drm:i830_irq_emit] *ERROR* i830_irq_emit called without lock held
Unable to handle kernel paging request at virtual address f000e2d3
c022b89e
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c022b89e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013296   (2.6.8.1) 
eax: f000e2c3   ebx: 00000000   ecx: 00000010   edx: dd6fb280
esi: c0428280   edi: cd21e000   ebp: c042840c   esp: cd21fed0
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 c022d827 c0428280 00003282 cd21e000 cd21e000 c0428280 c0227df3 
       c0428280 c0428910 c0428918 cc85c080 cc85c0a0 dd62e660 00000000 00000001 
       0000000a 00000000 ddbce0b0 c0116d1e 00000000 00000000 cd34b280 cc85c1dc 
Call Trace:
 [<c022d827>] i830_dma_quiescent+0x17/0xa6
 [<c0227df3>] i830_lock+0x1ff/0x2a5
 [<c0116d1e>] default_wake_function+0x0/0x12
 [<c0116d1e>] default_wake_function+0x0/0x12
 [<c0227b7e>] i830_ioctl+0xcf/0x145
 [<c0166a16>] sys_ioctl+0x113/0x281
 [<c010411f>] syscall_call+0x7/0xb
Code: 8b 40 10 8b 90 34 20 00 00 81 e2 fc ff 1f 00 89 51 14 8b 43 


>>EIP; c022b89e <i830_kernel_lost_context+11/61>   <=====

>>eax; f000e2c3 <pg0+2fbba2c3/3fbaa000>
>>edx; dd6fb280 <pg0+1d2a7280/3fbaa000>
>>esi; c0428280 <i830_device+0/1a80>
>>edi; cd21e000 <pg0+cdca000/3fbaa000>
>>ebp; c042840c <i830_device+18c/1a80>
>>esp; cd21fed0 <pg0+cdcbed0/3fbaa000>

Trace; c022d827 <i830_dma_quiescent+17/a6>
Trace; c0227df3 <i830_lock+1ff/2a5>
Trace; c0116d1e <default_wake_function+0/12>
Trace; c0116d1e <default_wake_function+0/12>
Trace; c0227b7e <i830_ioctl+cf/145>
Trace; c0166a16 <sys_ioctl+113/281>
Trace; c010411f <syscall_call+7/b>

Code;  c022b89e <i830_kernel_lost_context+11/61>
00000000 <_EIP>:
Code;  c022b89e <i830_kernel_lost_context+11/61>   <=====
   0:   8b 40 10                  mov    0x10(%eax),%eax   <=====
Code;  c022b8a1 <i830_kernel_lost_context+14/61>
   3:   8b 90 34 20 00 00         mov    0x2034(%eax),%edx
Code;  c022b8a7 <i830_kernel_lost_context+1a/61>
   9:   81 e2 fc ff 1f 00         and    $0x1ffffc,%edx
Code;  c022b8ad <i830_kernel_lost_context+20/61>
   f:   89 51 14                  mov    %edx,0x14(%ecx)
Code;  c022b8b0 <i830_kernel_lost_context+23/61>
  12:   8b 43 00                  mov    0x0(%ebx),%eax

-- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
