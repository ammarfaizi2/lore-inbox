Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130218AbRAOXU5>; Mon, 15 Jan 2001 18:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130549AbRAOXUq>; Mon, 15 Jan 2001 18:20:46 -0500
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:9344 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S130218AbRAOXUe>; Mon, 15 Jan 2001 18:20:34 -0500
Message-ID: <3A6385C2.4B9DF202@home.com>
Date: Mon, 15 Jan 2001 18:20:34 -0500
From: Arthur Pedyczak <arthur-p@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Oops in 2.4.0 (fs corruption?)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I have been running 2.4.0 for 8 days with no problem. Then standard
RedHat cron job (slocate.cron) generated an oops:
====================================================================================

ksymoops 2.3.4 on i686 2.4.0.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /usr/src/linux/System.map (specified)

Jan 15 04:02:06 cs865114-a kernel: Unable to handle kernel paging
request at virtual address 4029e934
Jan 15 04:02:06 cs865114-a kernel: c0136f40
Jan 15 04:02:06 cs865114-a kernel: *pde = 03ede067
Jan 15 04:02:06 cs865114-a kernel: Oops: 0000
Jan 15 04:02:06 cs865114-a kernel: CPU:    0
Jan 15 04:02:07 cs865114-a kernel: EIP:    0010:[sys_newlstat+48/112]
Jan 15 04:02:07 cs865114-a kernel: EFLAGS: 00010206
Jan 15 04:02:07 cs865114-a kernel: eax: 4029e900   ebx: c543bfa4   ecx:
c9e2f920   edx: cebc98c0
Jan 15 04:02:07 cs865114-a kernel: esi: 00000000   edi: 080662cc   ebp:
bffffae4   esp: c543bf9c
Jan 15 04:02:07 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 04:02:07 cs865114-a kernel: Process slocate (pid: 22482,
stackpage=c543b000)
Jan 15 04:02:07 cs865114-a kernel: Stack: c543a000 080662d4 cebc98c0
cff36d40 00000008 bffff25c bffff24c 00000008
Jan 15 04:02:07 cs865114-a kernel:        00000001 c0108d63 080662cc
bffffaa4 0805dbc0 080662d4 080662cc bffffae4
Jan 15 04:02:07 cs865114-a kernel:        0000006b 0000002b 0000002b
0000006b 400b21fd 00000023 00000202 bffffa88
Jan 15 04:02:07 cs865114-a kernel: Call Trace: [system_call+51/56]
Jan 15 04:02:07 cs865114-a kernel: Code: 8b 40 34 85 c0 74 0a 52 ff d0
89 c6 83 c4 04 eb 02 31 f6 85
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 34                  mov    0x34(%eax),%eax
Code;  00000003 Before first symbol
   3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
   5:   74 0a                     je     11 <_EIP+0x11> 00000011 Before
first symbol
Code;  00000007 Before first symbol
   7:   52                        push   %edx
Code;  00000008 Before first symbol
   8:   ff d0                     call   *%eax
Code;  0000000a Before first symbol
   a:   89 c6                     mov    %eax,%esi
Code;  0000000c Before first symbol
   c:   83 c4 04                  add    $0x4,%esp
Code;  0000000f Before first symbol
   f:   eb 02                     jmp    13 <_EIP+0x13> 00000013 Before
first symbol
Code;  00000011 Before first symbol
  11:   31 f6                     xor    %esi,%esi
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)
===============================================================================


I tried to figure out what was the proble, and it looks like some sort
of filesystem corruption in /dev/ida subdir. When I did 'ls /dev/ida' 
I somewhat similar oops:
===============================================================================

ksymoops 2.3.4 on i686 2.4.0.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /usr/src/linux/System.map (specified)

Jan 15 06:30:21 cs865114-a kernel: Unable to handle kernel paging
request at virtual address 4029e934
Jan 15 06:30:21 cs865114-a kernel: c01372c0
Jan 15 06:30:21 cs865114-a kernel: *pde = 03151067
Jan 15 06:30:21 cs865114-a kernel: Oops: 0000
Jan 15 06:30:21 cs865114-a kernel: CPU:    0
Jan 15 06:30:21 cs865114-a kernel: EIP:    0010:[sys_lstat64+48/112]
Jan 15 06:30:21 cs865114-a kernel: EFLAGS: 00010206
Jan 15 06:30:21 cs865114-a kernel: eax: 4029e900   ebx: c1e17fa4   ecx:
c9e2f920   edx: cebc98c0
Jan 15 06:30:21 cs865114-a kernel: esi: 00000000   edi: bffff8cc   ebp:
bffff8b4   esp: c1e17f9c
Jan 15 06:30:21 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Jan 15 06:30:21 cs865114-a kernel: Process ls (pid: 22596,
stackpage=c1e17000)
Jan 15 06:30:21 cs865114-a kernel: Stack: c1e16000 40107bec cebc98c0
cff36d40 00000003 bffff46c bffff45c 00000008
Jan 15 06:30:21 cs865114-a kernel:        00000001 c0108d63 bffff8cc
4013de70 40104420 40107bec bffff8cc bffff8b4
Jan 15 06:30:21 cs865114-a kernel:        000000c4 0000002b 0000002b
000000c4 400b66ac 00000023 00000212 bffff858
Jan 15 06:30:21 cs865114-a kernel: Call Trace: [system_call+51/56]
Jan 15 06:30:21 cs865114-a kernel: Code: 8b 40 34 85 c0 74 0a 52 ff d0
89 c6 83 c4 04 eb 02 31 f6 85
Using defaults from ksymoops -t elf32-i386 -a i386
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 34                  mov    0x34(%eax),%eax
Code;  00000003 Before first symbol
   3:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
   5:   74 0a                     je     11 <_EIP+0x11> 00000011 Before
first symbol
Code;  00000007 Before first symbol
   7:   52                        push   %edx
Code;  00000008 Before first symbol
   8:   ff d0                     call   *%eax
Code;  0000000a Before first symbol
   a:   89 c6                     mov    %eax,%esi
Code;  0000000c Before first symbol
   c:   83 c4 04                  add    $0x4,%esp
Code;  0000000f Before first symbol
   f:   eb 02                     jmp    13 <_EIP+0x13> 00000013 Before
first symbol
Code;  00000011 Before first symbol
  11:   31 f6                     xor    %esi,%esi
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)

========================================================================================

any ideas/suggestions ??
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
