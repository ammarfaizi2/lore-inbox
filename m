Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136074AbREJMNJ>; Thu, 10 May 2001 08:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136149AbREJMJN>; Thu, 10 May 2001 08:09:13 -0400
Received: from zeus.kernel.org ([209.10.41.242]:61671 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136148AbREJMDR>;
	Thu, 10 May 2001 08:03:17 -0400
Date: Thu, 10 May 2001 10:35:55 +0200
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: linux-kernel@vger.kernel.org
Subject: something like an oops
Message-ID: <20010510103555.C27612@tux.bitfreak.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AWniW0JNca5xppdA"
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AWniW0JNca5xppdA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hello,

I get kernel NULL-pointers when I close my video application ('studio') and
then, X usually locks.
Only way to get back into the machine is ssh'ing and typing 'reboot' (after
examining dmesg, of course) or resetting the box. The
keyboard/mouse/video-card are locked by X, it seems, there's no way to
'free' then and killing X remotely doesn't seem to help anything. Rebooting
is the only thing that helped me so far. And rebooting should be for
changing hardware ;-).
The video editor uses zoran hardware to playback the video (using Serguei
Miridonov's zoran driver, version 0.8, for a Miro/Pinnacle DC10+). The
video editor closes 'nicely', i.e. it returns control to the terminal and
gives the quit message. Directly after returning control to the terminal, X
locks up.
I was using X 4.01 (am just upgrading to 4.03 to retest it in there) with
kernel 2.4.4, and I'm using the XFree 'nv' driver. The video editor uses
the video4linux/Xvideo extension in Xfree to display video in the
(gtk-)application.

The kernel says (dmesg):
-------------------------------------------------------
DC10plus[0]: ioctl VIDIOCGAUDIO not supported
DC10plus[0]: ioctl VIDIOCGFREQ not supported
DC10plus[0]: jpg_qbuf: buffers not yet allocated
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c01114f8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01114f8>]
EFLAGS: 00010006
eax: c4481980   ebx: 00000000   ecx: 00000000   edx: c4481984
esi: c70f9ecf   edi: c5efc054   ebp: c70f9d6c   esp: c70f9d50
ds: 0018   es: 0018   ss: 0018
Process studio (pid: 788, stackpage=c70f9000)
Stack: c4481984 00000001 00000282 00000001 c4481980 c70f9ecf c3c47241
c4481000 
       c01688b3 c1227ed0 00000002 c5c0e000 00000046 00000000 c70f9d94
00000046 
       c5c0e000 00000001 c011b2fb c5c0e000 00000202 00000000 0011b385
0000001d 
Call Trace: [<c01688b3>] [<c011b2fb>] [<c013c346>] [<c015b3b5>]
[<c01225bc>] [<c01dc377>] [<c016b25d>] 
       [<c01679c0>] [<c0169415>] [<c016565e>] [<c01692b0>] [<c012ef56>]
[<c0106c37>] 

Code: 8b 01 85 45 f0 74 4f 31 c0 9c 5e fa c7 01 00 00 00 00 8b 51 
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c01114f8
*pde = 055dc067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01114f8>]
EFLAGS: 00013012
eax: c3f33ee4   ebx: 00000000   ecx: 00000000   edx: c3f33ee8
esi: c409c0e0   edi: c5efc00c   ebp: c5c0fdf4   esp: c5c0fdd8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 706, stackpage=c5c0f000)
Stack: c3f33ee8 00000001 00003286 00000001 c3f33ee4 c409c0e0 c6370ec0
c409c0e0 
       c01accb9 00000000 c15df780 00000040 c6370ec0 c15df780 00000040
c01ddc15 
       c409c0e0 00000040 c5c0fe34 c409c134 00000000 c409c0e0 c409c420
00000000 
Call Trace: [<c01accb9>] [<c01ddc15>] [<c01aa3ac>] [<c01ad21b>]
[<c01aa6c3>] [<c01aa75b>] [<c012f11c>] 
       [<c01aa516>] [<c011137b>] [<c012f283>] [<c0106c37>] 

Code: 8b 01 85 45 f0 74 4f 31 c0 9c 5e fa c7 01 00 00 00 00 8b 51 
DC10plus[0]: timeout: codec isr=0x04, csr=0x04
-------------------------------------------------------------------

I ran ksymoops on these thingies, although I'm not really sure whether it
has any use since it's not really an oops (or is it?). They are attached as
log[45].

Is this X, kernel or my application? (since it crashes X and the kernel
gives errors too, I guess it's a combination?)

Anyway, if I could get rid of this I'd be very happy, it's always bad to
see your self-written application crash the box.

--
Ronald
--AWniW0JNca5xppdA
Content-Type: application/octet-stream; charset=us-ascii
Content-Disposition: attachment; filename=log5

ksymoops 2.3.4 on i686 2.4.4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c01114f8
*pde = 055dc067
Oops: 0000
CPU:    0
EIP:    0010:[<c01114f8>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013012
eax: c3f33ee4   ebx: 00000000   ecx: 00000000   edx: c3f33ee8
esi: c409c0e0   edi: c5efc00c   ebp: c5c0fdf4   esp: c5c0fdd8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 706, stackpage=c5c0f000)
Stack: c3f33ee8 00000001 00003286 00000001 c3f33ee4 c409c0e0 c6370ec0 c409c0e0 
       c01accb9 00000000 c15df780 00000040 c6370ec0 c15df780 00000040 c01ddc15 
       c409c0e0 00000040 c5c0fe34 c409c134 00000000 c409c0e0 c409c420 00000000 
Call Trace: [<c01accb9>] [<c01ddc15>] [<c01aa3ac>] [<c01ad21b>] [<c01aa6c3>] [<c
01aa75b>] [<c012f11c>] 
       [<c01aa516>] [<c011137b>] [<c012f283>] [<c0106c37>] 
Code: 8b 01 85 45 f0 74 4f 31 c0 9c 5e fa c7 01 00 00 00 00 8b 51 

>>EIP; c01114f8 <__wake_up+38/a0>   <=====
Trace; c01accb9 <sock_def_readable+29/60>
Trace; c01ddc15 <unix_stream_sendmsg+235/2e0>
Trace; c01aa3ac <sock_sendmsg+6c/90>
Trace; c01ad21b <kfree_skbmem+b/60>
Trace; c01aa6c3 <sock_readv_writev+93/a0>
Code;  c01114f8 <__wake_up+38/a0>
00000000 <_EIP>:
Code;  c01114f8 <__wake_up+38/a0>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c01114fa <__wake_up+3a/a0>
   2:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c01114fd <__wake_up+3d/a0>
   5:   74 4f                     je     56 <_EIP+0x56> c011154e <__wake_up+8e/a0>
Code;  c01114ff <__wake_up+3f/a0>
   7:   31 c0                     xor    %eax,%eax
Code;  c0111501 <__wake_up+41/a0>
   9:   9c                        pushf  
Code;  c0111502 <__wake_up+42/a0>
   a:   5e                        pop    %esi
Code;  c0111503 <__wake_up+43/a0>
   b:   fa                        cli    
Code;  c0111504 <__wake_up+44/a0>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c011150a <__wake_up+4a/a0>
  12:   8b 51 00                  mov    0x0(%ecx),%edx


--AWniW0JNca5xppdA
Content-Type: application/octet-stream; charset=us-ascii
Content-Disposition: attachment; filename=log4

ksymoops 2.3.4 on i686 2.4.4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c01114f8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01114f8>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: c4481980   ebx: 00000000   ecx: 00000000   edx: c4481984
esi: c70f9ecf   edi: c5efc054   ebp: c70f9d6c   esp: c70f9d50
ds: 0018   es: 0018   ss: 0018
Process studio (pid: 788, stackpage=c70f9000)
Stack: c4481984 00000001 00000282 00000001 c4481980 c70f9ecf c3c47241 c4481000 
       c01688b3 c1227ed0 00000002 c5c0e000 00000046 00000000 c70f9d94 00000046 
       c5c0e000 00000001 c011b2fb c5c0e000 00000202 00000000 0011b385 0000001d 
Call Trace: [<c01688b3>] [<c011b2fb>] [<c013c346>] [<c015b3b5>] [<c01225bc>] [<c
01dc377>] [<c016b25d>] 
       [<c01679c0>] [<c0169415>] [<c016565e>] [<c01692b0>] [<c012ef56>] [<c0106c
Code: 8b 01 85 45 f0 74 4f 31 c0 9c 5e fa c7 01 00 00 00 00 8b 51 

>>EIP; c01114f8 <__wake_up+38/a0>   <=====
Trace; c01688b3 <n_tty_receive_buf+ab3/af0>
Trace; c011b2fb <deliver_signal+4b/60>
Trace; c013c346 <send_sigio_to_task+d6/e0>
Trace; c015b3b5 <sys_shmctl+35/8f0>
Trace; c01225bc <add_to_page_cache+8c/a0>
Code;  c01114f8 <__wake_up+38/a0>
00000000 <_EIP>:
Code;  c01114f8 <__wake_up+38/a0>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c01114fa <__wake_up+3a/a0>
   2:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c01114fd <__wake_up+3d/a0>
   5:   74 4f                     je     56 <_EIP+0x56> c011154e <__wake_up+8e/a0>
Code;  c01114ff <__wake_up+3f/a0>
   7:   31 c0                     xor    %eax,%eax
Code;  c0111501 <__wake_up+41/a0>
   9:   9c                        pushf  
Code;  c0111502 <__wake_up+42/a0>
   a:   5e                        pop    %esi
Code;  c0111503 <__wake_up+43/a0>
   b:   fa                        cli    
Code;  c0111504 <__wake_up+44/a0>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c011150a <__wake_up+4a/a0>
  12:   8b 51 00                  mov    0x0(%ecx),%edx


--AWniW0JNca5xppdA--

