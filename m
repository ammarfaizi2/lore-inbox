Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTKNCIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 21:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTKNCIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 21:08:31 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:55970 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264486AbTKNCI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 21:08:28 -0500
Date: Fri, 14 Nov 2003 03:08:26 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: OOPS USB disconnect SuSE 8.2 2.4.20-4GB kernel and USB or sound related crash
Message-ID: <20031114020826.GA25475@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I caught this oops crash in the logs some hours ago. Does it ring a bell
somewhere? Has this been fixed since?

18:55:34:
ALSA memory.c:86: kmalloc(10) from d789369c not freed
ALSA memory.c:86: kmalloc(76) from d7893680 not freed
ALSA memory.c:86: kmalloc(28) from d7890381 not freed
ALSA memory.c:86: kmalloc(440) from d7890868 not freed
usb-uhci.c: interrupt, status 3, frame# 1302

18:55:41:
usb.c: registered new driver snd-usb-audio

18:56:16:
usb.c: USB disconnect on device 00:07.2-1 address 4
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c011bbbc
*pde = 00000000
Oops: 0002 2.4.20-4GB-athlon #1 Wed Aug 6 18:27:52 UTC 2003
CPU:    0
EIP:    0010:[add_wait_queue_exclusive+28/48]    Not tainted
EIP:    0010:[<c011bbbc>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210002
eax: cc26a9e8   ebx: 00000000   ecx: c5d0fef4   edx: c5d0feec
esi: 00200202   edi: cc26a9e8   ebp: c5d0feec   esp: c5d0fee0
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 614, stackpage=c5d0f000)
Stack: cc26a9e0 c5d0e000 c0107ac6 00000001 c5d0e000 cc26a9e8 00000000 00000000 
       c5d0e000 00000000 00000000 cc26a9e0 00000001 cc26a9c0 c89fa6d8 c0107c34 
       cc26a9e0 c49e4c40 00000003 c5d1390e c70793e0 c89fa6c0 d7adaa04 00000004 
Call Trace:    [__down+54/160] [__down_failed+8/12] [joydev:__insmod_joydev_O/lib/modules/2.4.20-4GB-athlon/kernel/driv+-6768370/96] [reiserfs:__insmod_reiserfs_S.data_L1184+88367456/812579344] [joydev:__insmod_joydev_O/lib/modules/2.4.20-4GB-athlon/kernel/driv+-6762574/96]
Call Trace:    [<c0107ac6>] [<c0107c34>] [<c5d1390e>] [<c70793e0>] [<c5d14fb2>]
  [<c5d14c0c>] [<c5d15412>] [<c5d1550c>] [<c0108e1a>] [<c010730b>] [<c5d154d0>]
Code: 89 0b 89 59 04 56 9d 8b 74 24 04 8b 1c 24 83 c4 08 c3 89 f6 


>>EIP; c011bbbc <add_wait_queue_exclusive+1c/30>   <=====

>>eax; cc26a9e8 <[snd-usb-audio].data.end+14bf8c1/6444f39>
>>ecx; c5d0fef4 <[ipv6]ip6_fl_gc_timer+36ac834/36ac9a0>
>>edx; c5d0feec <[ipv6]ip6_fl_gc_timer+36ac82c/36ac9a0>
>>edi; cc26a9e8 <[snd-usb-audio].data.end+14bf8c1/6444f39>
>>ebp; c5d0feec <[ipv6]ip6_fl_gc_timer+36ac82c/36ac9a0>
>>esp; c5d0fee0 <[ipv6]ip6_fl_gc_timer+36ac820/36ac9a0>

Trace; c0107ac6 <__down+36/a0>
Trace; c0107c34 <__down_failed+8/c>
Trace; c5d1390e <[usbcore].text.lock.usb+af/c1>
Trace; c70793e0 <[pwc]pwc_driver+0/38>
Trace; c5d14fb2 <[usbcore]usb_hub_port_connect_change+82/2b0>
Trace; c5d14c0c <[usbcore]usb_hub_port_status+6c/a0>
Trace; c5d15412 <[usbcore]usb_hub_events+232/2f0>
Trace; c5d1550c <[usbcore]usb_hub_thread+3c/d0>
Trace; c0108e1a <ret_from_fork+6/20>
Trace; c010730b <arch_kernel_thread+2b/40>
Trace; c5d154d0 <[usbcore]usb_hub_thread+0/d0>

Code;  c011bbbc <add_wait_queue_exclusive+1c/30>
00000000 <_EIP>:
Code;  c011bbbc <add_wait_queue_exclusive+1c/30>   <=====
   0:   89 0b                     mov    %ecx,(%ebx)   <=====
Code;  c011bbbe <add_wait_queue_exclusive+1e/30>
   2:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  c011bbc1 <add_wait_queue_exclusive+21/30>
   5:   56                        push   %esi
Code;  c011bbc2 <add_wait_queue_exclusive+22/30>
   6:   9d                        popf   
Code;  c011bbc3 <add_wait_queue_exclusive+23/30>
   7:   8b 74 24 04               mov    0x4(%esp,1),%esi
Code;  c011bbc7 <add_wait_queue_exclusive+27/30>
   b:   8b 1c 24                  mov    (%esp,1),%ebx
Code;  c011bbca <add_wait_queue_exclusive+2a/30>
   e:   83 c4 08                  add    $0x8,%esp
Code;  c011bbcd <add_wait_queue_exclusive+2d/30>
  11:   c3                        ret    
Code;  c011bbce <add_wait_queue_exclusive+2e/30>
  12:   89 f6                     mov    %esi,%esi

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
