Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130386AbQLWDAL>; Fri, 22 Dec 2000 22:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130636AbQLWDAB>; Fri, 22 Dec 2000 22:00:01 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:1220 "HELO
	squeaker.ratbox.org") by vger.kernel.org with SMTP
	id <S130386AbQLWC7w>; Fri, 22 Dec 2000 21:59:52 -0500
Date: Fri, 22 Dec 2000 21:29:33 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: tigran@veritas.com, linux-kernel@vger.kernel.org
Subject: Oops with microcode update driver on 2.2.19pre3
Message-ID: <Pine.LNX.4.21.0012222125260.1138-100000@squeaker.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am getting the following oops while trying to update the microcode of a
PII@266mhz using the microcode update driver.  Below is the output of
ksymoops. This was built using egcs-1.1.2.  

Also in case it matters I've applied the ide-2.2.18 patch so I can use my
Promise ATA66 controller and the latest reiserfs patch..

Regards,

Aaron

ksymoops 0.7c on i686 2.2.19pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19pre3/ (default)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel paging request at virtual address c823e12c
current->tss.cr3 = 05e9b000, %cr3 = 05e9b000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01078b1>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000006   ebx: 00000000   ecx: 00000000   edx: bf87933c
esi: c023e120   edi: c6c31000   ebp: c5e9c000   esp: c5e9df4c
ds: 0018   es: 0018   ss: 0018
Process microcode_ctl (pid: 1011, process nr: 48, stackpage=c5e9d000)
Stack: c6c31000 c5e9c000 00250000 06101c8c 00000000 c8a50000 c8a34000 00000000 
       c010782d 00000000 0001b800 c5e84540 c6c31000 c5e9c000 c0107c21 c5bcabb0 
       ffffffea c01245c9 c5e84540 bf85db3c 0001b800 c5e84554 c5e9c000 00000003 
Call Trace: [<c8a50000>] [<c8a34000>] [<c010782d>] [<c0107c21>] [<c01245c9>] [<c0107b38>] [<c01094e8>] 
Code: a1 2c e1 23 c8 a8 01 74 5a 6a 00 68 20 78 20 c0 e8 d2 bc 00 

>>EIP; c01078b1 <do_update_one+39/20c>   <=====
Trace; c8a50000 <END_OF_CODE+87ae578/????>
Trace; c8a34000 <END_OF_CODE+8792578/????>
Trace; c010782d <do_microcode_update+d/58>
Trace; c0107c21 <microcode_write+e9/120>
Trace; c01245c9 <sys_write+e5/118>
Trace; c0107b38 <microcode_write+0/120>
Trace; c01094e8 <system_call+34/38>
Code;  c01078b1 <do_update_one+39/20c>
00000000 <_EIP>:
Code;  c01078b1 <do_update_one+39/20c>   <=====
   0:   a1 2c e1 23 c8            mov    0xc823e12c,%eax   <=====
Code;  c01078b6 <do_update_one+3e/20c>
   5:   a8 01                     test   $0x1,%al
Code;  c01078b8 <do_update_one+40/20c>
   7:   74 5a                     je     63 <_EIP+0x63> c0107914 <do_update_one+9c/20c>
Code;  c01078ba <do_update_one+42/20c>
   9:   6a 00                     push   $0x0
Code;  c01078bc <do_update_one+44/20c>
   b:   68 20 78 20 c0            push   $0xc0207820
Code;  c01078c1 <do_update_one+49/20c>
  10:   e8 d2 bc 00 00            call   bce7 <_EIP+0xbce7> c0113598 <printk+0/16c>



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
