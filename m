Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262843AbSITQKH>; Fri, 20 Sep 2002 12:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262898AbSITQKG>; Fri, 20 Sep 2002 12:10:06 -0400
Received: from tailtiu.davidcoulson.net ([194.159.178.180]:33461 "EHLO
	mail.mx.davidcoulson.net") by vger.kernel.org with ESMTP
	id <S262843AbSITQKE>; Fri, 20 Sep 2002 12:10:04 -0400
Message-ID: <3D8B49AE.5010209@davidcoulson.net>
Date: Fri, 20 Sep 2002 17:15:42 +0100
From: David Coulson <david@davidcoulson.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020907
X-Accept-Language: en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: UML devel <user-mode-linux-devel@lists.sourceforge.net>
Subject: Host kernel bug with UML
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been experiencing VM problems with the host linux kernel when 
running UMLs. These have generally been swap_dup errors under vanilla 
kernel trees, so I proceeded to patch my kernel with the rmap patch to 
see if this would make any difference.

I experienced the following problem this afternoon, on a system running 
2.4.19-ck7-rmap, which required a reboot before UML would continue to 
work correctly. If anyone needs more information, let me know - I can't 
actually reproduce this on demand, but it seems to occur reasonably 
frequently. I'm confident that it is not a hardware issue, as I have 
tested the system under load, and have had it happily swap out a couple 
of Gb to disk, then back into RAM without any problems. Someone 
suggested that it may be because I'm swapping to a LVM LV, but I've no 
idea if that is actually a contributing factor or not.

kernel BUG at mmap.c:732!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012af18>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: eb93ff9c   ebx: ec689140   ecx: ec689638   edx: ec689620
esi: 40155000   edi: ec689638   ebp: c0dc6dc0   esp: eb93ff60
ds: 0018   es: 0018   ss: 0018
Process linux-4um-1G (pid: 8994, stackpage=eb93f000)
Stack: c0dc6dc0 00001000 00001000 ffff0001 c012b2ba c0dc6dc0 40155000 
eb93ff9c
        c0dc6dc0 c0dc6ddc 00001000 ffff0001 c0107e62 eb93ffc4 9a8e3d28 
ec689620
        c012b50e c0dc6dc0 40155000 00001000 eb93e000 00000000 00000010 
9a1ae554
Call Trace:    [<c012b2ba>] [<c0107e62>] [<c012b50e>] [<c0108a1b>]
Code: 0f 0b dc 02 21 cd 25 c0 89 d8 eb 0c 8b 44 24 1c c7 00 00 00


 >>EIP; c012af18 <find_vma_prev+90/b0>   <=====

 >>eax; eb93ff9c <_end+2b5e8cec/384aad50>
 >>ebx; ec689140 <_end+2c331e90/384aad50>
 >>ecx; ec689638 <_end+2c332388/384aad50>
 >>edx; ec689620 <_end+2c332370/384aad50>
 >>edi; ec689638 <_end+2c332388/384aad50>
 >>ebp; c0dc6dc0 <_end+a6fb10/384aad50>
 >>esp; eb93ff60 <_end+2b5e8cb0/384aad50>

Trace; c012b2ba <do_munmap+56/274>
Trace; c0107e62 <sys_sigreturn+e6/114>
Trace; c012b50e <sys_munmap+36/54>
Trace; c0108a1b <system_call+33/38>

Code;  c012af18 <find_vma_prev+90/b0>
00000000 <_EIP>:
Code;  c012af18 <find_vma_prev+90/b0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c012af1a <find_vma_prev+92/b0>
    2:   dc 02                     faddl  (%edx)
Code;  c012af1c <find_vma_prev+94/b0>
    4:   21 cd                     and    %ecx,%ebp
Code;  c012af1e <find_vma_prev+96/b0>
    6:   25 c0 89 d8 eb            and    $0xebd889c0,%eax
Code;  c012af23 <find_vma_prev+9b/b0>
    b:   0c 8b                     or     $0x8b,%al
Code;  c012af25 <find_vma_prev+9d/b0>
    d:   44                        inc    %esp
Code;  c012af26 <find_vma_prev+9e/b0>
    e:   24 1c                     and    $0x1c,%al
Code;  c012af28 <find_vma_prev+a0/b0>
   10:   c7 00 00 00 00 00         movl   $0x0,(%eax)


David

-- 
David Coulson                                  http://davidcoulson.net/
d@vidcoulson.com                       http://journal.davidcoulson.net/

