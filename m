Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266665AbSL3D54>; Sun, 29 Dec 2002 22:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266675AbSL3D54>; Sun, 29 Dec 2002 22:57:56 -0500
Received: from outbound03.telus.net ([199.185.220.222]:41461 "EHLO
	priv-edtnes11-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id <S266665AbSL3D5w>; Sun, 29 Dec 2002 22:57:52 -0500
Subject: Re: 2.4.21-pre2 hdparm Kernel Oops
From: Bob <gillb4@telusplanet.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Dec 2002 21:06:21 -0700
Message-Id: <1041221183.1447.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. This is the oops (recorded with digital camera and re-typed in as
/var/log/messages et. al. had nothing).  The controller is:
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)

The error message when I run /sbin/hdparm -d1 -c3 -m16 -k1 /dev/hdb
and /sbin/hdparm -d1 -c3 -m16 -k1 /dev/hda is:

 IO_support     =  3 (32-bit w/sync)
 using_dma      =  1 (on)
 keepsettings   =  1 (on)
kernel BUG in header file at line 155
kernel BUG at panic.c:141!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011af67>]       Not tainted
EFLAGS: 00010282
eax: 00000026   ebx: 00000000   ecx: f7bdc000  edx: 00000000
esi: c031c760   edi: 00001000   ebp: 00000000  esp: f7bddd50
ds: 0018  es: 0018  ss: 0018
Process hdparm (pid: 1160, stackpage=f7bdd000)
Stack: c02560a0 0000009b c01b8181 0000009b 00000000 00000014 0000008c
00000007
       f7eb8000 f7eba000 c031c810 00000000 c031c760 c01b8374 c031c760
f7eb0400
       00000002 c0180579 00000000 c031c760 c031c760 c031c810 f7eb0400
c031c760
Call Trace:    [<c01b8181>] [<c01b8374>] [<c0180579>] [<c01b889f>]
[<c01af8b9>]
  [<c01a543e>] [<c0180579>] [<c01ae511>] [<c01ae68b>] [<c01aebb2>]
[<c01b7f40>]
  [<c01089d5>] [<c0108b54>] [<c0117480>] [<c010b1f8>] [<c0117480>]
[<c01174a3>]
  [<c012ac1b>] [<c012ba86>] [<c012bdd3>] [<c0117480>] [<c0107504>]

Code: 0f 0b 8d 00 bf 6d 25 c0 90 eb fe 8d b4 26 00 00 00 00 8d bc
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


The results of ksymoops on the above:
[root@localhost bob]# uname -r
2.4.21-pre2
[root@localhost bob]# ksymoops -v /data/kernel/temp/linux/vmlinux -m
/boot/System.map-2.4.21-pre2 /home/bob/oops.file
ksymoops 2.4.8 on i686 2.4.21-pre2.  Options used
     -v /data/kernel/temp/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre2/ (default)
     -m /boot/System.map-2.4.21-pre2 (specified)

kernel BUG in header file at line 155
kernel BUG at panic.c:141!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011af67>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000026   ebx: 00000000     ecx: f7bdc000  edx: 00000000
esi: c031c760   edi: 00001000     ebp: 00000000  esp: f7bddd50
ds: 0018  es: 0018  ss: 0018
Process hdparm (pid: 1160, stackpage=f7bdd000)
Stack: c02560a0 0000009b c01b8181 0000009b 00000000 00000014 0000008c
00000007
       f7eb8000 f7eba000 c031c810 00000000 c031c760 c01b8374 c031c760
f7eb0400
       00000002 c0180579 00000000 c031c760 c031c760 c031c810 f7eb0400
c031c760
Call Trace:    [<c01b8181>] [<c01b8374>] [<c0180579>] [<c01b889f>]
[<c01af8b9>]
  [<c01a543e>] [<c0180579>] [<c01ae511>] [<c01ae68b>] [<c01aebb2>]
[<c01b7f40>]
  [<c01089d5>] [<c0108b54>] [<c0117480>] [<c010b1f8>] [<c0117480>]
[<c01174a3>]
  [<c012ac1b>] [<c012ba86>] [<c012bdd3>] [<c0117480>] [<c0107504>]
Code: 0f 0b 8d 00 bf 6d 25 c0 90 eb fe 8d b4 26 00 00 00 00 8d bc


>>EIP; c011af67 <__out_of_line_bug+17/30>   <=====

>>ecx; f7bdc000 <_end+378b4e8c/3855ae8c>
>>esi; c031c760 <ide_hwifs+0/2af8>
>>esp; f7bddd50 <_end+378b6bdc/3855ae8c>

Trace; c01b8181 <ide_build_sglist+181/1a0>
Trace; c01b8374 <ide_build_dmatable+54/1a0>
Trace; c0180579 <add_timer_randomness+d9/f0>
Trace; c01b889f <__ide_dma_read+3f/150>
Trace; c01af8b9 <do_rw_disk+1f9/760>
Trace; c01a543e <ide_wait_stat+fe/130>
Trace; c0180579 <add_timer_randomness+d9/f0>
Trace; c01ae511 <start_request+1c1/240>
Trace; c01ae68b <ide_do_request+ab/1a0>
Trace; c01aebb2 <ide_intr+f2/130>
Trace; c01b7f40 <ide_dma_intr+0/c0>
Trace; c01089d5 <handle_IRQ_event+45/70>
Trace; c0108b54 <do_IRQ+64/a0>
Trace; c0117480 <do_page_fault+0/523>
Trace; c010b1f8 <call_do_IRQ+5/d>
Trace; c0117480 <do_page_fault+0/523>
Trace; c01174a3 <do_page_fault+23/523>
Trace; c012ac1b <zap_pte_range+eb/110>
Trace; c012ba86 <unmap_fixup+136/150>
Trace; c012bdd3 <do_munmap+283/2a0>
Trace; c0117480 <do_page_fault+0/523>
Trace; c0107504 <error_code+34/3c>

Code;  c011af67 <__out_of_line_bug+17/30>
00000000 <_EIP>:
Code;  c011af67 <__out_of_line_bug+17/30>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011af69 <__out_of_line_bug+19/30>
   2:   8d 00                     lea    (%eax),%eax
Code;  c011af6b <__out_of_line_bug+1b/30>
   4:   bf 6d 25 c0 90            mov    $0x90c0256d,%edi
Code;  c011af70 <__out_of_line_bug+20/30>
   9:   eb fe                     jmp    9 <_EIP+0x9> c011af70
<__out_of_line_bug+20/30>
Code;  c011af72 <__out_of_line_bug+22/30>
   b:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c011af79 <__out_of_line_bug+29/30>
  12:   8d bc 00 00 00 00 00      lea    0x0(%eax,%eax,1),%edi

 <0>Kernel panic: Aiee, killing interrupt handler!

[root@localhost root]# 


Thanks,
Bob




