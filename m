Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132758AbRDNFyA>; Sat, 14 Apr 2001 01:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132738AbRDNFwk>; Sat, 14 Apr 2001 01:52:40 -0400
Received: from zeus.kernel.org ([209.10.41.242]:32728 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132759AbRDNFvk>;
	Sat, 14 Apr 2001 01:51:40 -0400
Date: Fri, 13 Apr 2001 23:35:02 -0400 (EDT)
From: Arthur Pedyczak <arthur-p@home.com>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: loop problems continue in 2.4.3
Message-ID: <Pine.LNX.4.33.0104132330560.1677-100000@cs865114-a.amp.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
here are my $0.02 regarding loop in 2.4.3.

1. mounted file
mount -t iso9660 -o loop file.img /mnt/cdrom
    worked o.k.
2. unmounted
umount /mnt/cdrom
    worked o.k.
3. mounted file
mount -t iso9660 -o loop file.img /mnt/cdrom
    worked o.k.
4. tried to unmount
umount /mnt/cdrom
   got oops:

=====================
Apr 13 20:50:03 cs865114-a kernel: Unable to handle kernel paging request at virtual address 7e92bfd7
Apr 13 20:50:03 cs865114-a kernel:  printing eip:
Apr 13 20:50:03 cs865114-a kernel: c0142cde
Apr 13 20:50:03 cs865114-a kernel: *pde = 00000000
Apr 13 20:50:03 cs865114-a kernel: Oops: 0000
Apr 13 20:50:03 cs865114-a kernel: CPU:    0
Apr 13 20:50:03 cs865114-a kernel: EIP:    0010:[invalidate_list+142/176]
Apr 13 20:50:03 cs865114-a kernel: EFLAGS: 00210203
Apr 13 20:50:03 cs865114-a kernel: eax: d26cc400   ebx: 7e92bfd7   ecx: d26cc400   edx: 00000000
Apr 13 20:50:03 cs865114-a kernel: esi: d3ab4220   edi: 7e92bfd7   ebp: c2433f14   esp: c2433eecApr 13 20:50:03 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Apr 13 20:50:03 cs865114-a kernel: Process umount (pid: 30929, stackpage=c2433000)Apr 13 20:50:03 cs865114-a kernel: Stack: 00000000 00000000 c2433f14 c2433f14 d26cc400 df9bf650 c0142d22 c0220e68Apr 13 20:50:03 cs865114-a kernel:        d26cc400 c2433f14 c2433f14 c2433f14 d26cc400 cb165220 df9bf5a0 df9bf650Apr 13 20:50:03 cs865114-a kernel:        c0135219 d26cc400 c013a662 d6636640 00000700 00200282 00000000 d141c4c0Apr 13 20:50:03 cs865114-a kernel: Call Trace: [<df9bf650>] [invalidate_inodes+34/96] [<df9bf5a0>] [<df9bf650>] [kill_super+121/288] [path_walk+1922/2160] [do_umount+449/464]
Apr 13 20:50:03 cs865114-a kernel:        [sys_umount+218/272] [filp_close+83/96] [sys_oldumount+12/16] [system_call+51/56]
Apr 13 20:50:03 cs865114-a kernel:
Apr 13 20:50:03 cs865114-a kernel: Code: 8b 3b 3b 5c 24 1c 75 9a 8b 04 24 29 05 a4 d7 27 c0 8b 44 24

===========================================

ksymoops:
===========================================
ksymoops 2.3.4 on i686 2.4.3.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3/ (default)
     -m /usr/src/linux/System.map (specified)

Apr 13 20:50:03 cs865114-a kernel: Unable to handle kernel paging request at virtual address 7e92bfd7
Apr 13 20:50:03 cs865114-a kernel: c0142cde
Apr 13 20:50:03 cs865114-a kernel: *pde = 00000000
Apr 13 20:50:03 cs865114-a kernel: Oops: 0000
Apr 13 20:50:03 cs865114-a kernel: CPU:    0
Apr 13 20:50:03 cs865114-a kernel: EIP:    0010:[invalidate_list+142/176]
Apr 13 20:50:03 cs865114-a kernel: EFLAGS: 00210203
Apr 13 20:50:03 cs865114-a kernel: eax: d26cc400   ebx: 7e92bfd7   ecx: d26cc400   edx: 00000000
Apr 13 20:50:03 cs865114-a kernel: esi: d3ab4220   edi: 7e92bfd7   ebp: c2433f14   esp: c2433eecApr 13 20:50:03 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Apr 13 20:50:03 cs865114-a kernel: Process umount (pid: 30929, stackpage=c2433000)Apr 13 20:50:03 cs865114-a kernel: Stack: 00000000 00000000 c2433f14 c2433f14 d26cc400 df9bf650 c0142d22 c0220e68Apr 13 20:50:03 cs865114-a kernel:        d26cc400 c2433f14 c2433f14 c2433f14 d26cc400 cb165220 df9bf5a0 df9bf650Apr 13 20:50:03 cs865114-a kernel:        c0135219 d26cc400 c013a662 d6636640 00000700 00200282 00000000 d141c4c0Apr 13 20:50:03 cs865114-a kernel: Call Trace: [<df9bf650>] [invalidate_inodes+34/96] [<df9bf5a0>] [<df9bf650>] [kill_super+121/288] [path_walk+1922/2160] [do_umount+449/464]
Apr 13 20:50:03 cs865114-a kernel: Code: 8b 3b 3b 5c 24 1c 75 9a 8b 04 24 29 05 a4 d7 27 c0 8b 44 24
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 3b                     mov    (%ebx),%edi
Code;  00000002 Before first symbol
   2:   3b 5c 24 1c               cmp    0x1c(%esp,1),%ebx
Code;  00000006 Before first symbol
   6:   75 9a                     jne    ffffffa2 <_EIP+0xffffffa2> ffffffa2 <END_OF_CODE+276b3b43/????>
Code;  00000008 Before first symbol
   8:   8b 04 24                  mov    (%esp,1),%eax
Code;  0000000b Before first symbol
   b:   29 05 a4 d7 27 c0         sub    %eax,0xc027d7a4
Code;  00000011 Before first symbol
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax


