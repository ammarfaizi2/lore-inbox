Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131123AbRARRja>; Thu, 18 Jan 2001 12:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132284AbRARRjU>; Thu, 18 Jan 2001 12:39:20 -0500
Received: from jane.hollins.EDU ([192.160.94.78]:12815 "EHLO earth.hollins.edu")
	by vger.kernel.org with ESMTP id <S131123AbRARRjI>;
	Thu, 18 Jan 2001 12:39:08 -0500
Message-ID: <3A672A30.60002@hollins.edu>
Date: Thu, 18 Jan 2001 12:38:56 -0500
From: "Scott A. Sibert" <kernel@hollins.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-pre8 i686; en-US; m18) Gecko/20010116
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NMI Watchdog detected LOCKUP on CPU0
In-Reply-To: <3A6717C0.5020209@hollins.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I tried the NFS mount command again but without dnetc running.  
(BTW, I'm running rpm -Uhv to update some packages from another linux 
machine; I download the updates on it and all other machines load the 
updates from it.)

This time I got a stack dump to run through ksymoops:

ksymoops 2.3.4 on i686 2.4.0-ac9.  Options used
    -V (default)
    -k /proc/ksyms (default)
    -l /proc/modules (default)
    -o /lib/modules/2.4.0-ac9/ (default)
    -m /boot/System.map-2.4.0-ac9 (specified)

NMI Watchdog detected LOCKUP on CPU0, registers:
CPU:    0
EIP:    0010:[<c0134820>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000296
eax: 00000000   ebx: c03029a8   ecx: 000000ff   edx: 000001fd
esi: 000001fd   edi: 00000000   ebp: ffffffff   esp: c0ca3d08
ds: 0018   es: 0018   ss: 0018
Process rpm (pid: 1120, stackpage=c0ca3000)
Stack: 00000000 c0302780 d3d6b920 c0cb50e0 00000025 00000000 c01352bc 
00000005
      00000001 c0302a0c d3d6b920 c0cb50e0 00000025 400de000 c01289a2 
c0f4c378
      00000002 c0ef7400 c0128b24 c0cb50e0 d3d6b920 c0f4c378 00000001 
400de000
Call Trace: [<c01352bc>] [<c01289a2>] [<c0128b24>] [<c024e08f>] 
[<c024e4f8>] [<c011607d>] [<d4800000>]
      [<c016e861>] [<c010961d>] [<c0116e02>] [<c0115f20>] [<c0109248>] 
[<c012e03e>] [<c012e010>] [<c012bb0e>]
      [<c014e7bc>] [<c012e0d2>] [<c012e010>] [<c016dd42>] [<c013b996>] 
[<c011d44b>] [<c0109113>]
Code: 85 c0 89 44 24 04 75 a8 8b 04 24 5f 5d 5b 5e 5f 5d c3 8d b4

 >>EIP; c0134820 <free_shortage+b0/d0>   <=====
Trace; c01352bc <__alloc_pages+8c/480>
Trace; c01289a2 <do_anonymous_page+32/80>
Trace; c0128b24 <handle_mm_fault+134/240>
Trace; c024e08f <ip_local_deliver+1f/1d0>
Trace; c024e4f8 <ip_rcv+2b8/350>
Trace; c011607d <do_page_fault+15d/450>
Trace; d4800000 <_end+1445eaec/144b9b4c>
Trace; c016e861 <nfs_pagein_inode+41/120>
Trace; c010961d <do_nmi+3d/110>
Trace; c0116e02 <schedule+3c2/5d0>
Trace; c0115f20 <do_page_fault+0/450>
Trace; c0109248 <error_code+34/3c>
Trace; c012e03e <file_read_actor+2e/60>
Trace; c012e010 <file_read_actor+0/60>
Trace; c012bb0e <do_generic_file_read+25e/5d0>
Trace; c014e7bc <do_select+21c/360>
Trace; c012e0d2 <generic_file_read+62/80>
Trace; c012e010 <file_read_actor+0/60>
Trace; c016dd42 <nfs_file_read+92/b0>
Trace; c013b996 <sys_read+96/d0>
Trace; c011d44b <sys_gettimeofday+1b/90>
Trace; c0109113 <system_call+33/38>
Code;  c0134820 <free_shortage+b0/d0>
00000000 <_EIP>:
Code;  c0134820 <free_shortage+b0/d0>   <=====
  0:   85 c0                     test   %eax,%eax   <=====
Code;  c0134822 <free_shortage+b2/d0>
  2:   89 44 24 04               mov    %eax,0x4(%esp,1)
Code;  c0134826 <free_shortage+b6/d0>
  6:   75 a8                     jne    ffffffb0 <_EIP+0xffffffb0> 
c01347d0 <free_shortage+60/d0>
Code;  c0134828 <free_shortage+b8/d0>
  8:   8b 04 24                  mov    (%esp,1),%eax
Code;  c013482b <free_shortage+bb/d0>
  b:   5f                        pop    %edi
Code;  c013482c <free_shortage+bc/d0>
  c:   5d                        pop    %ebp
Code;  c013482d <free_shortage+bd/d0>
  d:   5b                        pop    %ebx
Code;  c013482e <free_shortage+be/d0>
  e:   5e                        pop    %esi
Code;  c013482f <free_shortage+bf/d0>
  f:   5f                        pop    %edi
Code;  c0134830 <free_shortage+c0/d0>
  10:   5d                        pop    %ebp
Code;  c0134831 <free_shortage+c1/d0>
  11:   c3                        ret   
Code;  c0134832 <free_shortage+c2/d0>
  12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi

I was able to copy-paste the message on the screen into a file so I 
didn't have to type it in manually onto another computer.  I rebooted 
the machine after this just in case something somewhere might've been 
unhappy about this.  While it was shutting down, the NFS mount point 
refused to umount, saying the device was busy.  The only thing that 
could've been using that mount point was the rpm command that I ran.  I 
cd'd back to /root before doing the shutdown -r now command.

This machine is a dual P2/300 w/320MB memory and no bigmem support 
compiled in.  NFS is compiled into the kernel (not a module) as is the 
eepro100 network driver.

--Scott

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
