Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290683AbSAYOMm>; Fri, 25 Jan 2002 09:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290682AbSAYOMc>; Fri, 25 Jan 2002 09:12:32 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:40410 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S290680AbSAYOMX>; Fri, 25 Jan 2002 09:12:23 -0500
Message-ID: <3C516807.BDC6BD29@oracle.com>
Date: Fri, 25 Jan 2002 15:13:27 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops from 2.5.3-pre5 in kmem_cache_create
In-Reply-To: <20020124212108.B901@earthlink.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
> 
> This oops came at boot time.

I couldn't boot -pre4 and can't boot -pre5, oops looks very
 similar to Randy's -- Dell Laptop, PIII/750, gcc-3.0.3, non
 tainted kernel.

I'm quite positive I hand-copied everything correctly, with the
 possible exception of the first value in the third "Stack" line.


ksymoops 2.4.1 on i686 2.5.3-pre3.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.3-pre5 (specified)
     -m /boot/System.map-2.5.3-pre5 (specified)

No modules in ksyms, skipping objects
CPU:    0
EIP:    0010:[<c012c27f>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: 00000000   ecx: 00000014   edx: c027d2cc
esi: c0254133   edi: c0254148   ebp: 00002000   esp: c13cbf9c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c13cb000)
Stack: 00000000 c02c058c 00000000 c0105000 0008e000 c018bded c0254133 00000174 
       00000000 00002000 c018bda0 00000000 c02981c6 c02c058c c02906d2 c023f245 
       c0105030 00010f00 c028ffd8 c0105000 0008e000 c0107186 00000000 c0105020 
Call Trace: [<c0105000>] [<c018bded>] [<c018bd20>] [<c0105030>] [<c0105000>] [<c0107186>] [<c0105020>]
Code: 0f 0b f7 c5 ff 0f ff ff 74 02 0f 0b 68 f0 01 00 00 68 80 ae

>>EIP; c012c27f <kmem_cache_create+3f/350>   <=====
Trace; c0105000 <_stext+0/0>
Trace; c018bded <init_inodecache+1d/40>
Trace; c018bd20 <reiserfs_put_super+110/140>
Trace; c0105030 <init+10/140>
Trace; c0105000 <_stext+0/0>
Trace; c0107186 <kernel_thread+26/30>
Trace; c0105020 <init+0/140>
Code;  c012c27f <kmem_cache_create+3f/350>
00000000 <_EIP>:
Code;  c012c27f <kmem_cache_create+3f/350>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c281 <kmem_cache_create+41/350>
   2:   f7 c5 ff 0f ff ff         test   $0xffff0fff,%ebp
Code;  c012c287 <kmem_cache_create+47/350>
   8:   74 02                     je     c <_EIP+0xc> c012c28b <kmem_cache_create+4b/350>
Code;  c012c289 <kmem_cache_create+49/350>
   a:   0f 0b                     ud2a   
Code;  c012c28b <kmem_cache_create+4b/350>
   c:   68 f0 01 00 00            push   $0x1f0
Code;  c012c290 <kmem_cache_create+50/350>
  11:   68 80 ae 00 00            push   $0xae80

> kysmoops ran with /usr/src/linux/System.map = 2.5.3-pre5.
> 
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> ksymoops: No such file or directory
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0124f45>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010202
> eax: 00000000   ebx: 00000000   ecx: 00000014   edx: 00000000
> esi: c021ffd4   edi: c01f22c8   ebp: 00002000   esp: c177df94
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 1, stackpage=c177d000)
> Stack: c02514b4 c021ffd4 00000000 0008e000 c177dfb0 c16069a0 00000020 c02116ac
>        c015bf35 c01f22b3 00000184 00000000 00002000 c015bef0 00000000 c0227d96
>        c02514b4 c0220646 00010f00 c0220682 c0105023 00010f00 c021ffd4 c0106ee0
> Call Trace: [<c015bf35>] [<c015bef0>] [<c0105023>] [<c0106ee0>]
> Code: 0f 0b f7 c5 ff 0f ff ff 74 02 0f 0b 68 f0 01 00 00 68 40 f8
> 
> >>EIP; c0124f44 <kmem_cache_create+60/314>   <=====
> Trace; c015bf34 <init_inodecache+1c/34>
> Trace; c015bef0 <init_once+0/28>
> Trace; c0105022 <init+6/114>
> Trace; c0106ee0 <kernel_thread+28/38>
> Code;  c0124f44 <kmem_cache_create+60/314>
> 00000000 <_EIP>:
> Code;  c0124f44 <kmem_cache_create+60/314>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c0124f46 <kmem_cache_create+62/314>
>    2:   f7 c5 ff 0f ff ff         test   $0xffff0fff,%ebp
> Code;  c0124f4c <kmem_cache_create+68/314>
>    8:   74 02                     je     c <_EIP+0xc> c0124f50 <kmem_cache_create+6c/314>
> Code;  c0124f4e <kmem_cache_create+6a/314>
>    a:   0f 0b                     ud2a
> Code;  c0124f50 <kmem_cache_create+6c/314>
>    c:   68 f0 01 00 00            push   $0x1f0
> Code;  c0124f54 <kmem_cache_create+70/314>
>   11:   68 40 f8 00 00            push   $0xf840
> 
>  <0>Kernel panic: Attempted to kill init!

--alessandro

 "this machine will, will not communicate
   these thoughts and the strain I am under
  be a world child, form a circle before we all go under"
                         (Radiohead, "Street Spirit [fade out]")
