Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287720AbSAFFaO>; Sun, 6 Jan 2002 00:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287724AbSAFFaE>; Sun, 6 Jan 2002 00:30:04 -0500
Received: from gecius-0.dsl.speakeasy.net ([216.254.67.146]:54257 "EHLO
	maniac.gecius.de") by vger.kernel.org with ESMTP id <S287720AbSAFF36>;
	Sun, 6 Jan 2002 00:29:58 -0500
To: linux-kernel@vger.kernel.org
Subject: kernel bug in dcache?
From: Jens Gecius <jens@gecius.de>
Date: Sun, 06 Jan 2002 00:29:58 -0500
Message-ID: <87ofk8f3mx.fsf@maniac.gecius.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

Had a pretty strange experience, which I found out to be a kernel-bug.

I wanted to start a terminal in X, which resulted in a gnome-msg
saying something like "can't open terminal, if using kernel so-and-so
maybe related to mis-configured unixpt?" Afterward, I was unable to
use _any_ console, but everything else worked fine. I know, the kernel
is tainted (nvidia, but I think this is unrelated). Maybe, this is
known already. 

If you don't want to care due to the nvidia-module loaded, fine, I
know the issue, but in that case, please, don't bother to start some
thread about it. :-)

Here's the syslog:
Jan  5 20:17:34 maniac kernel: kernel BUG at dcache.c:654!
Jan  5 20:17:34 maniac kernel: invalid operand: 0000
Jan  5 20:17:34 maniac kernel: CPU:    0
Jan  5 20:17:34 maniac kernel: EIP:    0010:[d_instantiate+33/204]    Tainted: PF
Jan  5 20:17:34 maniac kernel: EFLAGS: 00010282
Jan  5 20:17:34 maniac kernel: eax: 0000001c   ebx: f184423c   ecx: c0328324   edx: 0000c92e
Jan  5 20:17:34 maniac kernel: esi: ecc4b790   edi: ecc4b790   ebp: f7967824   esp: c4a63ea4
Jan  5 20:17:34 maniac kernel: ds: 0018   es: 0018   ss: 0018
Jan  5 20:17:34 maniac kernel: Process gnome-pty-helpe (pid: 7084, stackpage=c4a63000)
Jan  5 20:17:34 maniac kernel: Stack: c02c44f8 0000028e cf4229ac f184423c c0194d27 ecc4b790 f184423c fffffff4 
Jan  5 20:17:34 maniac kernel:        f796788c f7967824 ecc4b790 f7da0c9c c032d260 e1658d04 00000000 0002e005 
Jan  5 20:17:34 maniac kernel:        c5e8b000 f7db6d74 00000246 00000000 f796788c f7967824 c4a63f74 f79ca3d0 
Jan  5 20:17:34 maniac kernel: Call Trace: [devfs_lookup+535/596] [in_group_p+30/40] [d_alloc+24/504] [real_lookup+176/404] [link_path_walk+2205/2992] 
Jan  5 20:17:34 maniac kernel:    [getname+93/156] [path_walk+26/28] [__user_walk+53/80] [sys_stat64+25/112] [sys_ioctl+722/740] [system_call+51/56] 
Jan  5 20:17:34 maniac kernel: 
Jan  5 20:17:34 maniac kernel: Code: 0f 0b 83 c4 08 81 3d a4 b6 38 c0 ad 4e ad de 74 26 68 56 86 

And here's ksymoops:
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000004 Before first symbol
   5:   81 3d a4 b6 38 c0 ad      cmpl   $0xdead4ead,0xc038b6a4
Code;  0000000c Before first symbol
   c:   4e ad de 
Code;  0000000e Before first symbol
   f:   74 26                     je     37 <_EIP+0x37> 00000036 Before first symbol
Code;  00000010 Before first symbol
  11:   68 56 86 00 00            push   $0x8656

-- 
Tschoe,                http://gecius.de/gpg-key.txt - Fingerprint:
 Jens                  1AAB 67A2 1068 77CA 6B0A  41A4 18D4 A89B 28D0 F097
