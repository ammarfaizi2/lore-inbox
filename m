Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312770AbSDHKPp>; Mon, 8 Apr 2002 06:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312603AbSDHKPo>; Mon, 8 Apr 2002 06:15:44 -0400
Received: from 78.adsl0.kh.worldonline.dk ([213.237.10.78]:65319 "EHLO
	mail.schau.dk") by vger.kernel.org with ESMTP id <S312544AbSDHKPn>;
	Mon, 8 Apr 2002 06:15:43 -0400
Message-Id: <200204081016.g38AGiR22372@mail.schau.dk>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.18 - opl3sa2 related?
From: brian@schau.dk
Date: Mon, 8 Apr 2002 12:16:44 -0200
X-Originating-IP: 10.1.1.30
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I got the following oops in 2.4.18 - output from ksymoops:

ksymoops 2.4.1 on i586 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel paging request at virtual address c202a106
c01ba725
*pde = 0166c067
Oops: 0000
CPU:    0
EIP:    0010:[<c01ba725>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010297
eax: c202a106   ebx: c0e900a0   ecx: c202a106   edx: fffffffe
esi: ffffffff   edi: c0e41f14   ebp: ffffffff   esp: c0e41eb8
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 309, stackpage=c0e41000)
Stack: c0e90094 c0333360 00000008 c0e91000 fffffffd 00000000 ffffffff 0000000a 
       c01ba936 c0e90094 3f16ff6c c01c38c6 c0e41f08 c01ba950 c0e90094 c01c38b7 
       c0e41f08 c01168aa c0e90094 c01c38b7 00000100 00000101 c202a106 c0e90000 
Call Trace: [<c01ba936>] [<c01ba950>] [<c01168aa>] [<c011690c>] [<c0146374>] 
   [<c0144308>] [<c012c406>] [<c0106b73>] 
Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 8b 54 24 14 89 c6 

>>EIP; c01ba725 <vsnprintf+209/3e4>   <=====
Trace; c01ba936 <vsprintf+16/1c>
Trace; c01ba950 <sprintf+14/18>
Trace; c01168aa <do_resource_list+4a/7c>
Trace; c011690c <get_resource_list+30/38>
Trace; c0146374 <ioports_read_proc+24/3c>
Trace; c0144308 <proc_file_read+cc/1a4>
Trace; c012c406 <sys_read+96/e4>
Trace; c0106b73 <system_call+33/40>
Code;  c01ba725 <vsnprintf+209/3e4>
00000000 <_EIP>:
Code;  c01ba725 <vsnprintf+209/3e4>   <=====
   0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
Code;  c01ba728 <vsnprintf+20c/3e4>
   3:   74 07                     je     c <_EIP+0xc> c01ba731 <vsnprintf+215/3e4>
Code;  c01ba72a <vsnprintf+20e/3e4>
   5:   40                        inc    %eax
Code;  c01ba72b <vsnprintf+20f/3e4>
   6:   4a                        dec    %edx
Code;  c01ba72c <vsnprintf+210/3e4>
   7:   83 fa ff                  cmp    $0xffffffff,%edx
Code;  c01ba72f <vsnprintf+213/3e4>
   a:   75 f4                     jne    0 <_EIP>
Code;  c01ba731 <vsnprintf+215/3e4>
   c:   29 c8                     sub    %ecx,%eax
Code;  c01ba733 <vsnprintf+217/3e4>
   e:   8b 54 24 14               mov    0x14(%esp,1),%edx
Code;  c01ba737 <vsnprintf+21b/3e4>
  12:   89 c6                     mov    %eax,%esi


1 warning issued.  Results may not be reliable.


It happens if I do a    cat /proc/ioports    after a   modprobe opl3sa2 io=0x370 mss_io=0x530 mpu_io=0x330 irq=5 dma=0 dma2=1


What to do now?   Will upgrading help?


Kind regards,
Brian

