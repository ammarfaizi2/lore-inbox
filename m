Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVARMdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVARMdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 07:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVARMdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 07:33:04 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:10402 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261280AbVARMcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 07:32:54 -0500
Date: Tue, 18 Jan 2005 13:32:53 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.28 Oops in fs/locks.c:time_out_leases()
Message-ID: <20050118123253.GA31499@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

got an Oops the same time for 9 days, at the same EIP:

ksymoops 2.4.9 on i686 2.4.28-x97.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.28-x97/ (default)
     -m /boot/System.map-2.4.28-x97 (default)

kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 0000003c
kernel: c0153cb8
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[time_out_leases+24/128]    Not tainted
kernel: EFLAGS: 00010202
kernel: eax: c1b42a14   ebx: 00000010   ecx: 00000000   edx: c349139c
kernel: esi: c1b42ad0   edi: c06f6000   ebp: c06f7f0c   esp: c06f7f04
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process find (pid: 17476, stackpage=c06f7000)
kernel: Stack: c1b42a14 00018801 c06f7f38 c0153d79 c1b42a14 00000000 00000000 c06f7f38 
kernel:        00000000 c349139c ffffffff 00018801 c1b42a14 c06f7f64 c014d8c7 c1b42a14 
kernel:        00018801 00000000 00000000 00000004 c2f51898 00018800 c160f000 080665cb 
kernel: Call Trace:    [__get_lease+89/640] [open_namei+487/1376] [filp_open+47/80] [sys_open+61/160] [system_call+51/64]
kernel: Code: f6 43 2c 20 74 23 f6 43 2d 10 74 1d 8b 53 50 85 d2 75 1d 89 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; c1b42a14 <_end+164147c/4347ac8>
>>edx; c349139c <_end+2f8fe04/4347ac8>
>>esi; c1b42ad0 <_end+1641538/4347ac8>
>>edi; c06f6000 <_end+1f4a68/4347ac8>
>>ebp; c06f7f0c <_end+1f6974/4347ac8>
>>esp; c06f7f04 <_end+1f696c/4347ac8>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 43 2c 20               testb  $0x20,0x2c(%ebx)
Code;  00000004 Before first symbol
   4:   74 23                     je     29 <_EIP+0x29>
Code;  00000006 Before first symbol
   6:   f6 43 2d 10               testb  $0x10,0x2d(%ebx)
Code;  0000000a Before first symbol
   a:   74 1d                     je     29 <_EIP+0x29>
Code;  0000000c Before first symbol
   c:   8b 53 50                  mov    0x50(%ebx),%edx
Code;  0000000f Before first symbol
   f:   85 d2                     test   %edx,%edx
Code;  00000011 Before first symbol
  11:   75 1d                     jne    30 <_EIP+0x30>
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)


Details:
-	compiled with gcc version 3.3.4 (Debian 1:3.3.4-3)
-	only ext3 and NFSv3 mounts (and automounter). 
-	The "find" causing the oops appears to be started from cron.daily
	and only touches local filesystems.
-	SMP kernel running on UP (pentium II)

-- 
Frank
