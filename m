Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSHZOrX>; Mon, 26 Aug 2002 10:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318117AbSHZOrW>; Mon, 26 Aug 2002 10:47:22 -0400
Received: from wh8043.stw.uni-rostock.de ([139.30.108.43]:12424 "EHLO
	wh8043.stw.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S317589AbSHZOrV>; Mon, 26 Aug 2002 10:47:21 -0400
Date: Mon, 26 Aug 2002 16:51:24 +0200
From: Bjoern Krombholz <bjkro@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Oops while accessing /proc/stat (2.4.19)
Message-ID: <20020826145124.GA16273@wh8043.stw.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i'm currently have a problem that every program that tries to read from
/proc/stat like `uptime', `free', `cat /proc/stat' etc. segfaults.


strace shows:
--->
open("/proc/stat", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
brk(0x8050000)                          = 0x8050000
read(3,  <unfinished ...>
<---


First oops:
--->
ksymoops 2.4.6 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (specified)

kernel: c01f2ad9
kernel: Oops: 0002
kernel: CPU:    0
kernel: EIP:    0010:[number+1049/1088]    Tainted: PF
kernel: EFLAGS: 00010203
kernel: eax: 00001000   ebx: 00000000   ecx: 003db837   edx: cdb65f6c
kernel: esi: cdb65f6c   edi: c2e370e0   ebp: 003db837   esp: cdb65ee4
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process gkrellm (pid: 815, stackpage=cdb65000)
kernel: Stack: c0151923 cbbb6000 00001000 c01ff613 cdb65f18 001f2b86 0397e6cc 00000001
kernel:        00000000 cbbb6000 cdb65f6c cdb65f5c c01ff613 003db838 0397e6cc 001f2b86
kernel:        011f4d1f 00000000 00000c00 cbbb6000 00001000 001f2b86 c0224b2c cdb65f6c
kernel: Call Trace:    [proc_sprintf+51/80] [proc_file_read+248/416] [sys_read+150/240]
kernel: Code: c6 00 20 ff 84 24 c4 00 00 00 89 e8 4d 85 c0 7f d8 8b 84 24
Using defaults from ksymoops -t elf32-i386 -a i386


>>edx; cdb65f6c <_end+d8c6294/20597328>
>>esi; cdb65f6c <_end+d8c6294/20597328>
>>edi; c2e370e0 <_end+2b97408/20597328>
>>esp; cdb65ee4 <_end+d8c620c/20597328>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   c6 00 20                  movb   $0x20,(%eax)
Code;  00000003 Before first symbol
   3:   ff 84 24 c4 00 00 00      incl   0xc4(%esp,1)
Code;  0000000a Before first symbol
   a:   89 e8                     mov    %ebp,%eax
Code;  0000000c Before first symbol
   c:   4d                        dec    %ebp
Code;  0000000d Before first symbol
   d:   85 c0                     test   %eax,%eax
Code;  0000000f Before first symbol
   f:   7f d8                     jg     ffffffe9 <_EIP+0xffffffe9> ffffffe9 <END_OF_CODE+1ef57b06/????>
Code;  00000011 Before first symbol
  11:   8b 84 24 00 00 00 00      mov    0x0(%esp,1),%eax
<---


System:
CPU:    AMD Athlon XP
MB:     DFI AD70-SC (Via KT266 + 8233)
Kernel: 2.4.19 (extra modules: alsa-0.9.0rc1, lm_sensors-2.6.4)



Thx,
Bjoern Krombholz

