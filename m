Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbUDNGUa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 02:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbUDNGUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 02:20:30 -0400
Received: from csiromail2.vic.csiro.au ([138.194.2.13]:58832 "EHLO
	csiromail2.vic.csiro.au") by vger.kernel.org with ESMTP
	id S263909AbUDNGU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 02:20:27 -0400
Subject: [Oops] SMP lockup; NMI-watchdog caught and decoded
From: Frank Horowitz <frank.horowitz@csiro.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1081923621.14827.14.camel@bonzo.ned.dem.csiro.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Apr 2004 14:20:21 +0800
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2004 06:20:21.0692 (UTC) FILETIME=[90B1D7C0:01C421E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'Day,

A NMI-watchdog captured Oops. 

FWIW, I was moving the mouse at the time of the freeze, and had just
been mucking around with getting lm-sensors configured.

Setup: Dual Xeon 2.4s (hyperthreading on) on i7505 chipset based
motherboard. Running the nvidia binary driver (from vanilla debian
nvidia-kernel-installer).

I'm happy to help remotely debug this...

ksymoops 2.4.9 on i686 2.6.5.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.5/ (default)
     -m /boot/System.map-2.6.5 (default)
 
Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a
valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
NMI Watchdog detected LOCKUP on CPU2, eip c01475ca, registers:
CPU:    2
EIP:    0060:[<c01475ca>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000046   (2.6.5)
eax: 00000000   ebx: f7fd6400   ecx: f7ff0248   edx: f738e000
esi: f5e0d000   edi: 00000007   ebp: f738ff04   esp: f738fed8
ds: 007b   es: 007b   ss: 0068
Stack: f738fef0 c016f3b3 c2795b1c f5e0d018 f7ff02a8 f7ff0270 f7fd6410
f7ff0278
       00000296 00000000 ffffffe9 f738ff18 c0147a65 f7ff0248 000000d0
00000000
       f738ff30 c01610c2 f7ff0248 000000d0 f7fdb380 00000000 f738ff50
c015f34e
Call Trace:
 [<c016f3b3>] permission+0x2f/0x49
 [<c0147a65>] kmem_cache_alloc+0x4a/0x4c
 [<c01610c2>] get_empty_filp+0x48/0xe9
 [<c015f34e>] dentry_open+0x16/0x221
 [<c01476d9>] cache_alloc_refill+0x1c1/0x2a4
 [<c015f336>] filp_open+0x5d/0x5f
 [<c015f8a8>] sys_open+0x55/0x85
 [<c010924f>] syscall_call+0x7/0xb
Code: 83 6a 14 01 a8 08 0f 85 5d 01 00 00 8b 55 08 8b 42 58 39 46
 
 
>>EIP; c01475ca <cache_alloc_refill+b2/2a4>   <=====
 
>>ebx; f7fd6400 <__crc_pci_find_subsys+12fdb4/17053c>
>>ecx; f7ff0248 <__crc_pci_find_subsys+149bfc/17053c>
>>edx; f738e000 <__crc_redraw_screen+15c1f/1b1afa>
>>esi; f5e0d000 <__crc_cap_bprm_compute_creds+145e81/17660f>
>>ebp; f738ff04 <__crc_redraw_screen+17b23/1b1afa>
>>esp; f738fed8 <__crc_redraw_screen+17af7/1b1afa>
 
Trace; c016f3b3 <permission+2f/49>
Trace; c0147a65 <kmem_cache_alloc+4a/4c>
Trace; c01610c2 <get_empty_filp+48/e9>
Trace; c015f34e <dentry_open+16/221>
Trace; c01476d9 <cache_alloc_refill+1c1/2a4>
Trace; c015f336 <filp_open+5d/5f>
Trace; c015f8a8 <sys_open+55/85>
Trace; c010924f <syscall_call+7/b>
 
Code;  c01475ca <cache_alloc_refill+b2/2a4>
00000000 <_EIP>:
Code;  c01475ca <cache_alloc_refill+b2/2a4>   <=====
   0:   83 6a 14 01               subl   $0x1,0x14(%edx)   <=====
Code;  c01475ce <cache_alloc_refill+b6/2a4>
   4:   a8 08                     test   $0x8,%al
Code;  c01475d0 <cache_alloc_refill+b8/2a4>
   6:   0f 85 5d 01 00 00         jne    169 <_EIP+0x169>
Code;  c01475d6 <cache_alloc_refill+be/2a4>
   c:   8b 55 08                  mov    0x8(%ebp),%edx
Code;  c01475d9 <cache_alloc_refill+c1/2a4>
   f:   8b 42 58                  mov    0x58(%edx),%eax
Code;  c01475dc <cache_alloc_refill+c4/2a4>
  12:   39 46 00                  cmp    %eax,0x0(%esi)
 
 
1 warning issued.  Results may not be reliable.




