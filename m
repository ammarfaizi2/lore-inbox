Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSIHWqT>; Sun, 8 Sep 2002 18:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSIHWqT>; Sun, 8 Sep 2002 18:46:19 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:61143 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315416AbSIHWqS>; Sun, 8 Sep 2002 18:46:18 -0400
Message-Id: <5.1.0.14.2.20020908234145.03fdaec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 08 Sep 2002 23:51:00 +0100
To: mingo@elte.hu, torvalds@transmeta.com
From: Anton Altaparmakov <aia21@cantab.net>
Subject: PANIC caused by dequeue_signal() in current Linus BK tree
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The current Linus BK tree panics on INIT on my UP Athlon highmem box 
(compiled with SMP and preempt enabled) -- more info available on request:

ksymoops 2.4.5 on i686 2.4.19.  Options used
      -v vmlinux (specified)
      -K (specified)
      -L (specified)
      -o /lib/modules/2.5.33/ (specified)
      -m ./System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 5a5a5a5e
c01283a7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01283a7>]    Tainted: G S
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: ffffffff   ebx: 00000002   ecx: c1b74040   edx: 5a5a5a5a
esi: c1b78000   edi: c1b79f30   ebp: f7aeffd0   esp: c1b79ed0
ds: 0068   es: 0068   ss: 0068
Stack: 00000000 40400000 40017000 f7af9400 c04f00e0 c0131309 c04f00e0 f7af9400
        c1b78000 c1b78000 00000000 c1b79f30 c01297e7 f7aeffd0 c1b74658 
c1b79f30
        c1b74658 c1b79fc4 c1b74658 c1b78000 c1b79f30 c01078d5 c1b79f30 
c1b79fc4
Call Trace: [<c0131309>] [<c01297e7>] [<c01078d5>] [<c01354eb>] [<c0135377>]
    [<c0135808>] [<c013539a>] [<c013584b>] [<c0129c30>] [<c0107b2a>]
Code: 39 5a 04 74 38 89 d5 8b 12 85 d2 75 f3 8b 54 24 34 8d 43 ff


 >>EIP; c01283a7 <dequeue_signal+87/140>   <=====

 >>eax; ffffffff <END_OF_CODE+3faa41db/????>
 >>ecx; c1b74040 <END_OF_CODE+161821c/????>
 >>edx; 5a5a5a5a Before first symbol
 >>esi; c1b78000 <END_OF_CODE+161c1dc/????>
 >>edi; c1b79f30 <END_OF_CODE+161e10c/????>
 >>ebp; f7aeffd0 <END_OF_CODE+375941ac/????>
 >>esp; c1b79ed0 <END_OF_CODE+161e0ac/????>

Trace; c0131309 <zap_pmd_range+49/60>
Trace; c01297e7 <get_signal_to_deliver+97/370>
Trace; c01078d5 <do_signal+55/b0>
Trace; c01354eb <unmap_region+13b/170>
Trace; c0135377 <unmap_vma+87/90>
Trace; c0135808 <do_munmap+138/190>
Trace; c013539a <unmap_vma_list+1a/30>
Trace; c013584b <do_munmap+17b/190>
Trace; c0129c30 <sys_rt_sigprocmask+170/2d0>
Trace; c0107b2a <work_notifysig+13/15>

Code;  c01283a7 <dequeue_signal+87/140>
00000000 <_EIP>:
Code;  c01283a7 <dequeue_signal+87/140>   <=====
    0:   39 5a 04                  cmp    %ebx,0x4(%edx)   <=====
Code;  c01283aa <dequeue_signal+8a/140>
    3:   74 38                     je     3d <_EIP+0x3d> c01283e4 
<dequeue_signal+c4/140>
Code;  c01283ac <dequeue_signal+8c/140>
    5:   89 d5                     mov    %edx,%ebp
Code;  c01283ae <dequeue_signal+8e/140>
    7:   8b 12                     mov    (%edx),%edx
Code;  c01283b0 <dequeue_signal+90/140>
    9:   85 d2                     test   %edx,%edx
Code;  c01283b2 <dequeue_signal+92/140>
    b:   75 f3                     jne    0 <_EIP>
Code;  c01283b4 <dequeue_signal+94/140>
    d:   8b 54 24 34               mov    0x34(%esp,1),%edx
Code;  c01283b8 <dequeue_signal+98/140>
   11:   8d 43 ff                  lea    0xffffffff(%ebx),%eax

  <0>Kernel panic: Attempted to kill init!

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

