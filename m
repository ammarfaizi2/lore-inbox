Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267645AbRGNO3P>; Sat, 14 Jul 2001 10:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267647AbRGNO25>; Sat, 14 Jul 2001 10:28:57 -0400
Received: from mail.arcor-ip.de ([145.253.2.10]:23459 "EHLO mail.arcor-ip.de")
	by vger.kernel.org with ESMTP id <S267645AbRGNO2w>;
	Sat, 14 Jul 2001 10:28:52 -0400
Date: Sat, 14 Jul 2001 14:35:18 +0200
From: Stefan Frank <sfr@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: OOPS: Stock Kernel 2.4.6 with patch ext3-0.9.0
Message-ID: <20010714143518.A422@asterix.gallien.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i just received an oops after the command 'ls'. Below is the output of
ksymoops. Also note that kernel 2.4.6 was stable so far, and i just
patched it with ext3-0.9.0 two days ago. After the oops i couldn't login
on another vt any more. And just after a reboot i received another oops
where the keyboard froze completely, so no logs from this one.

ksymoops 2.4.1 on i686 2.4.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6/ (default)
     -m /boot/System.map-2.4.6 (specified)

Unable to handle kernel paging request at virtual address 07200720
c0148250
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0148250>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: d8b71cc0   ecx: 00000720   edx: 07200720
esi: d8b71cc0   edi: d8b71cc0   ebp: dbfe7040   esp: d8615ebc
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 496, stackpage=d8615000)
Stack: dbfe7040 d8b71cc0 d8b71cc0 dbfe60c0 fffffffe c014690b dbfe7040
d8b71cc0
       fffffff4 dbfe7040 c0139933 dbfe7040 d8b71cc0 d8615f2c 00000000
dbfe7040
       d8615f84 c0139ff1 dbfe60c0 d8615f2c 00000000 daff0000 00000000
00000000
Call Trace: [<c014690b>] [<c0139933>] [<c0139ff1>] [<c013a766>]
[<c012f38b>] [<c012f698>] [<c0106bab>]
Code: 66 83 3a 00 74 16 0f b7 4a 02 3b 4b 40 75 0d 8b 73 3c 8b 7a

>>EIP; c0148250 <proc_lookup+30/a0>   <=====
Trace; c014690b <proc_root_lookup+2b/50>
Trace; c0139933 <real_lookup+53/c0>
Trace; c0139ff1 <path_walk+531/750>
Trace; c013a766 <open_namei+86/550>
Trace; c012f38b <filp_open+3b/60>
Trace; c012f698 <sys_open+38/c0>
Trace; c0106bab <system_call+33/38>
Code;  c0148250 <proc_lookup+30/a0>
00000000 <_EIP>:
Code;  c0148250 <proc_lookup+30/a0>   <=====
   0:   66 83 3a 00               cmpw   $0x0,(%edx)   <=====
Code;  c0148254 <proc_lookup+34/a0>
   4:   74 16                     je     1c <_EIP+0x1c> c014826c
<proc_lookup+4c/a0>
Code;  c0148256 <proc_lookup+36/a0>
   6:   0f b7 4a 02               movzwl 0x2(%edx),%ecx
Code;  c014825a <proc_lookup+3a/a0>
   a:   3b 4b 40                  cmp    0x40(%ebx),%ecx
Code;  c014825d <proc_lookup+3d/a0>
   d:   75 0d                     jne    1c <_EIP+0x1c> c014826c
<proc_lookup+4c/a0>
Code;  c014825f <proc_lookup+3f/a0>
   f:   8b 73 3c                  mov    0x3c(%ebx),%esi
Code;  c0148262 <proc_lookup+42/a0>
  12:   8b 7a 00                  mov    0x0(%edx),%edi

Here's the output of ver_linux: 

root@asterix:/home/linux-2.4/scripts# ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux asterix 2.4.6 #1 Son Jul 8 20:11:20 CEST 2001 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.7
util-linux             2.11g
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.22
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         nfs lockd sunrpc i2c-algo-bit rtc cs46xx
ac97_codec soundcore ide-scsi i2c-isa i2c-core

Please note that during this oops i had the following additional modules
loaded: i2c-matroxfb.o matroxfb_crtc2.o and matroxfb_maven.o.
They enable the 2nd video output on the Matrox G400 videocard.

If you need more infos, i will be glad to help.

Bye, Stefan



-- 
First, I'm going to give you all the ANSWERS to today's test ...  So
just plug in your SONY WALKMANS and relax!!
