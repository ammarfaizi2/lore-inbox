Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbUAGRGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbUAGRGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:06:05 -0500
Received: from 213-240-193-212.ddns.cablebg.net ([213.240.193.212]:42627 "EHLO
	office.itanets.com") by vger.kernel.org with ESMTP id S265597AbUAGRFv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:05:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Delian Krustev <krustev@krustev.net>
To: linux-kernel@vger.kernel.org
Subject: oops in kupdated
Date: Wed, 7 Jan 2004 19:05:42 +0200
User-Agent: KMail/1.4.3
Cc: andrea@e-mind.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200401071905.42189.krustev@krustev.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the oops:

[root@smtp tmp]# ksymoops -L -O -K -m /boot/System.map-2.4.23-smp-dmapper-pom-2 <stack
ksymoops 2.4.4 on i686 2.4.24-smp-dmapper-pom-1.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.23-smp-dmapper-pom-2 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000004
f883bf9b
*pde = 00000000
Oops: 0002
CPU:    3
EIP:    0010:[<f883bf9b>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: f8a803a8   ecx: f8d12f38   edx: 00000000
esi: 03353080   edi: 00000814   ebp: 00000009   esp: f7e9dd50
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 9, stackpage=f7e9d000)
Stack: 00000020 00000000 c232eb70 c232ea00 02b42f20 00000001 f8838921 f7e9ddb2
       f7e9dd98 03350180 c232ea00 f7e6d800 c03a7e0c c03a7e00 f799f600 f7974000
       03350180 00002b40 033530a0 033530a0 c0121006 00000001 c03a7ef0 c03a7e2c
Call Trace:    [<f8838921>] [<c0121006>] [<c0277f3f>] [<c01b17a2>] [<c011d0eb>]
  [<f8838a1f>] [<c01c4e0a>] [<c01c4e73>] [<c013d554>] [<c013d5fa>] [<c0140e17>]
  [<c0141161>] [<c0108aa6>] [<c0141010>] [<c0105000>] [<c0107146>] [<c0141010>]
Code: 89 42 04 89 10 c7 01 00 00 00 00 c7 41 04 00 00 00 00 8b 03

>>EIP; f883bf9b <END_OF_CODE+38456427/????>   <=====
Trace; f8838921 <END_OF_CODE+38452dad/????>
Trace; c0121006 <update_wall_time+16/50>
Trace; c0277f3f <net_rx_action+9f/160>
Trace; c01b17a2 <add_interrupt_randomness+22/30>
Trace; c011d0eb <do_softirq+6b/d0>
Trace; f8838a1f <END_OF_CODE+38452eab/????>
Trace; c01c4e0a <generic_make_request+10a/120>
Trace; c01c4e73 <submit_bh+53/e0>
Trace; c013d554 <write_locked_buffers+24/30>
Trace; c013d5fa <write_some_buffers+9a/f0>
Trace; c0140e17 <sync_old_buffers+87/d0>
Trace; c0141161 <kupdate+151/190>
Trace; c0108aa6 <ret_from_fork+6/20>
Trace; c0141010 <kupdate+0/190>
Trace; c0105000 <_stext+0/0>
Trace; c0107146 <arch_kernel_thread+26/30>
Trace; c0141010 <kupdate+0/190>
Code;  f883bf9b <END_OF_CODE+38456427/????>
00000000 <_EIP>:
Code;  f883bf9b <END_OF_CODE+38456427/????>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  f883bf9e <END_OF_CODE+3845642a/????>
   3:   89 10                     mov    %edx,(%eax)
Code;  f883bfa0 <END_OF_CODE+3845642c/????>
   5:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  f883bfa6 <END_OF_CODE+38456432/????>
   b:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  f883bfad <END_OF_CODE+38456439/????>
  12:   8b 03                     mov    (%ebx),%eax


The kernel is patched with:
:pserver:cvs@tech.sistina.com:/data/cvs/device-mapper/patches/linux-2.4.22-VFS-lock.patch v1.1
:pserver:cvs@tech.sistina.com:/data/cvs/device-mapper/patches/linux-2.4.22-devmapper-ioctl.patch v1.1

I suppose the VFS-lock patch may be the root of the problems.

There are several patches from patch-o-matic-20030912 from netfilter.org applied to the tree
but I think they are not related.
I could provide the kernel config, info about the hardware, etc, if needed.

Regards,
Delian Krustev
