Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265358AbSIRGNv>; Wed, 18 Sep 2002 02:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265359AbSIRGNv>; Wed, 18 Sep 2002 02:13:51 -0400
Received: from outboundx.mv.meer.net ([209.157.152.12]:47120 "EHLO
	outboundx.mv.meer.net") by vger.kernel.org with ESMTP
	id <S265358AbSIRGNt>; Wed, 18 Sep 2002 02:13:49 -0400
Message-ID: <3D881ABB.5C65CD87@jwz.org>
Date: Tue, 17 Sep 2002 23:18:35 -0700
From: Jamie Zawinski <jwz@jwz.org>
Organization: my own bad self
X-Mailer: Mozilla 3.02 (X11; N; Linux 2.4.9-13smp i686)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel oops, 2.4.19
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while back I described some weird kernel oopses I was getting with 
the Red Hat version of 2.4.18; a few people said that it could be due
to Red Hat changes, and that I should try a kernel.org kernel.  Well,
I finally did -- downloaded 2.4.19 from kernel.org yesterday, compiled
and booted it, and today my X server got shot down with a
similar-looking syslog entry (which follows.)

I've checked my RAM with memtest86 3.0 with no errors.

Details on the machine config and the previous crashes I had with 
RH's 2.4.18-3 and 2.4.18-5 are here:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=69852

I managed to run "top" on another terminal after X had hung, but 
before it had died (or at least, before the screen cleared) and it
showed:

   10:59pm  up 1 day,  3:22,  1 user,  load average: 3.98, 2.19, 1.45
  78 processes: 68 sleeping, 7 running, 0 zombie, 3 stopped
  CPU states: 16.3% user,  2.1% system,  3.0% nice, 34.8% idle
  Mem:   321588K av,  289888K used,   31700K free,       0K shrd,   15564K buff
  Swap:  369380K av,   11136K used,  358244K free                  223164K cached

so it doesn't look like memory was a problem.

Here's the latest oops.  Any suggestions?

-- 
Jamie Zawinski
jwz@jwz.org             http://www.jwz.org/
jwz@dnalounge.com       http://www.dnalounge.com/

--------------------------------------------------------

ksymoops 2.4.4 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Sep 17 22:58:09 gronk kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000014
Sep 17 22:58:09 gronk kernel: c01fcd45
Sep 17 22:58:09 gronk kernel: *pde = 00000000
Sep 17 22:58:09 gronk kernel: Oops: 0000
Sep 17 22:58:09 gronk kernel: CPU:    0
Sep 17 22:58:09 gronk kernel: EIP:    0010:[<c01fcd45>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 17 22:58:09 gronk kernel: EFLAGS: 00013206
Sep 17 22:58:09 gronk kernel: eax: 00000014   ebx: c01c0ec0   ecx: 00000000   edx: 00000014
Sep 17 22:58:09 gronk kernel: esi: cfb8bf08   edi: cfb8bf14   ebp: cb6568a0   esp: cfb8be78
Sep 17 22:58:09 gronk kernel: ds: 0018   es: 0018   ss: 0018
Sep 17 22:58:09 gronk kernel: Process X (pid: 975, stackpage=cfb8b000)
Sep 17 22:58:09 gronk kernel: Stack: cfb8bf08 00000014 c01fd939 cfb8bf08 cb6568a0 cd9b7634 cb6568a0 00000001 
Sep 17 22:58:13 gronk kernel:        00000000 ffffffa1 00000001 0000ef00 00000000 cd9b75e0 00000001 d01b55a0 
Sep 17 22:58:29 gronk kernel:        d073a260 c0125478 cfb8bf08 0003ef4c cfb8bf1c c34dd5c0 c01becc1 c34dd5c0 
Sep 17 22:58:41 gronk kernel: Call Trace:    [<c01fd939>] [<c0125478>] [<c01becc1>] [<c01143da>] [<c01bedc8>]
Sep 17 22:58:42 gronk kernel:   [<c0142562>] [<c0134976>] [<c010891b>]
Sep 17 22:58:43 gronk kernel: Code: 8b 18 4b 78 26 eb 14 8d 74 26 00 8b 46 0c 8d b6 00 00 00 00 

>>EIP; c01fcd45 <unix_detach_fds+25/60>   <=====
Trace; c01fd939 <unix_stream_recvmsg+2d9/3a0>
Trace; c0125478 <handle_mm_fault+58/c0>
Trace; c01becc1 <sock_recvmsg+31/b0>
Trace; c01143da <do_page_fault+18a/4cb>
Trace; c01bedc8 <sock_read+88/a0>
Trace; c0142562 <sys_select+472/480>
Trace; c0134976 <sys_read+96/f0>
Trace; c010891b <system_call+33/38>
Code;  c01fcd45 <unix_detach_fds+25/60>
00000000 <_EIP>:
Code;  c01fcd45 <unix_detach_fds+25/60>   <=====
   0:   8b 18                     mov    (%eax),%ebx   <=====
Code;  c01fcd47 <unix_detach_fds+27/60>
   2:   4b                        dec    %ebx
Code;  c01fcd48 <unix_detach_fds+28/60>
   3:   78 26                     js     2b <_EIP+0x2b> c01fcd70 <unix_detach_fds+50/60>
Code;  c01fcd4a <unix_detach_fds+2a/60>
   5:   eb 14                     jmp    1b <_EIP+0x1b> c01fcd60 <unix_detach_fds+40/60>
Code;  c01fcd4c <unix_detach_fds+2c/60>
   7:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01fcd50 <unix_detach_fds+30/60>
   b:   8b 46 0c                  mov    0xc(%esi),%eax
Code;  c01fcd53 <unix_detach_fds+33/60>
   e:   8d b6 00 00 00 00         lea    0x0(%esi),%esi


1 warning issued.  Results may not be reliable.
