Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268383AbSIRTJR>; Wed, 18 Sep 2002 15:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268540AbSIRTJQ>; Wed, 18 Sep 2002 15:09:16 -0400
Received: from mail024.mail.bellsouth.net ([205.152.58.64]:1675 "EHLO
	imf24bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S268383AbSIRTJP>; Wed, 18 Sep 2002 15:09:15 -0400
Date: Wed, 18 Sep 2002 15:14:02 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: [2.5.36] Oops in lock_get_status after unsetting promiscuous
Message-ID: <Pine.LNX.4.43.0209181506510.7823-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When playing with 2.5.36, with preempt enabled and with RML's latest
patch, I got this oops after loading ntop, stopping ntop, then doing a
lsof. The machine survived the oops.

eth0: Setting promiscuous mode.
device eth0 entered promiscuous mode
device eth0 left promiscuous mode
Unable to handle kernel NULL pointer dereference at virtual address 00000008
c014b9ba
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c014b9ba>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: 00000000   ecx: c534fee0   edx: c534fedc
esi: c757514c   edi: c9b6f6a0   ebp: c757514c   esp: c534fea0
ds: 0068   es: 0068   ss: 0068
Stack: 0302331d 00000000 c9b6f578 c9b6f574 c757511d c9b6f580 c9b6f6a4 c9b6f6a0
       c014bd0c c757514c c9b6f6a0 00000008 c0280ed1 00000400 00000008 c757514c
       0000014c c534e000 00000400 00000400 c7575000 c015e8e9 c7575000 c534ff3c
Call Trace: [<c014bd0c>] [<c015e8e9>] [<c015c08d>] [<c0138148>] [<c014029b>]
   [<c01383ba>] [<c01073df>]
Code: 8b 58 08 8b 44 24 30 50 8b 4c 24 30 51 68 ea 0d 28 c0 56 e8


>>EIP; c014b9ba <lock_get_status+1a/260>   <=====

Trace; c014bd0c <get_locks_status+7c/160>
Trace; c015e8e9 <locks_read_proc+39/90>
Trace; c015c08d <proc_file_read+19d/1b0>
Trace; c0138148 <vfs_read+98/170>
Trace; c014029b <sys_fstat64+2b/30>
Trace; c01383ba <sys_read+2a/40>
Trace; c01073df <syscall_call+7/b>

Code;  c014b9ba <lock_get_status+1a/260> 00000000 <_EIP>:
Code;  c014b9ba <lock_get_status+1a/260>   <=====
   0:   8b 58 08                  mov    0x8(%eax),%ebx   <=====
Code;  c014b9bd <lock_get_status+1d/260>
   3:   8b 44 24 30               mov    0x30(%esp,1),%eax
Code;  c014b9c1 <lock_get_status+21/260>
   7:   50                        push   %eax
Code;  c014b9c2 <lock_get_status+22/260>
   8:   8b 4c 24 30               mov    0x30(%esp,1),%ecx
Code;  c014b9c6 <lock_get_status+26/260>
   c:   51                        push   %ecx
Code;  c014b9c7 <lock_get_status+27/260>
   d:   68 ea 0d 28 c0            push   $0xc0280dea
Code;  c014b9cc <lock_get_status+2c/260>
  12:   56                        push   %esi
Code;  c014b9cd <lock_get_status+2d/260>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c014b9d2 <lock_get_status+32/260>


1 error issued.  Results may not be reliable.



System has all ext3 partitions, Debian Testing on a single P2.

Linux version 2.5.36 (root@razor) (gcc version 3.0.4) #1 Wed Sep 18 10:40:39 EST 2002

00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 01)
00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X (rev 5c)
02:0a.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]




--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


