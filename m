Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbQKDCKA>; Fri, 3 Nov 2000 21:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129617AbQKDCJv>; Fri, 3 Nov 2000 21:09:51 -0500
Received: from 24.68.3.210.on.wave.home.com ([24.68.3.210]:28151 "EHLO
	phlegmish.com") by vger.kernel.org with ESMTP id <S129449AbQKDCJ0>;
	Fri, 3 Nov 2000 21:09:26 -0500
From: David Won <phlegm@home.com>
Date: Fri, 3 Nov 2000 21:04:51 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: What's causing my kernel Oops
MIME-Version: 1.0
Message-Id: <00110321045100.00754@phlegmish.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted a few of my oops here last week and received a few helpfull replys. 
I have modified my logging so my ksymoops should be more readable. It looksed 
to me that it was mostly esd and emu10k1 that were causing my greif. I have 
since tried recompiling esound from srs and grabbing the latest SB live 
drivers. I also tried it as a module and in the kernel. I'm running the atest 
kernel and patch, RH 7 and compiled using kgcc. 
One further question. Do I compile the modules with kgcc as well? I get the 
Oops either way but was curious none the less.
Thanks for any help.

Nov  1 14:09:33 phlegmish kernel: Unable to handle kernel paging request at 
virtual address 20c337ad
Nov  1 14:09:33 phlegmish kernel: c0143ab6
Nov  1 14:09:33 phlegmish kernel: *pde = 00000000
Nov  1 14:09:33 phlegmish kernel: Oops: 0002
Nov  1 14:09:33 phlegmish kernel: CPU:    0
Nov  1 14:09:33 phlegmish kernel: EIP:    0010:[<c0143ab6>]
Nov  1 14:09:33 phlegmish kernel: EFLAGS: 00010206
Nov  1 14:09:33 phlegmish kernel: eax: c3377cd9   ebx: c78253a0   ecx: 
c78253a0   edx: 20c3377d
Nov  1 14:09:33 phlegmish kernel: esi: 00000000   edi: c58c9fa4   ebp: 
00001000   esp: c58c9f5c
Nov  1 14:09:33 phlegmish kernel: ds: 0018   es: 0018   ss: 0018
Nov  1 14:09:33 phlegmish kernel: Process ps (pid: 1570, stackpage=c58c9000)
Nov  1 14:09:33 phlegmish kernel: Stack: c78253a0 c01443c4 c78253a0 c58c9f78 
c58c9f7c 00000000 c78253a0 00000000 
Nov  1 14:09:33 phlegmish kernel:        00000000 c0134b73 c76536a0 40030f20 
00001000 c78253a0 c58c8000 bffff6f8 
Nov  1 14:09:33 phlegmish kernel:        40030f20 bffff790 c76536a0 c7f3c2a0 
00000007 c012d0a7 c3544bc0 00000008 
Nov  1 14:09:33 phlegmish kernel: Call Trace: [<c01443c4>] [<c0134b73>] 
[<c012d0a7>] [<c010a407>] [<c010002b>] 
Nov  1 14:09:33 phlegmish kernel: Code: ff 42 30 8b 44 24 10 89 10 8b 81 f8 
00 00 00 8b 58 08 85 db 

>>EIP; c0143ab6 <proc_fd_link+16/68>   <=====

Trace; c01443c4 <proc_pid_readlink+38/9c>
Trace; c0134b73 <sys_readlink+7b/94>
Trace; c012d0a7 <sys_close+43/54>
Trace; c010a407 <system_call+33/38>
Trace; c010002b <startup_32+2b/13a>
Code;  c0143ab6 <proc_fd_link+16/68>
00000000 <_EIP>:
Code;  c0143ab6 <proc_fd_link+16/68>   <=====
   0:   ff 42 30                  incl   0x30(%edx)   <=====
Code;  c0143ab9 <proc_fd_link+19/68>
   3:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  c0143abd <proc_fd_link+1d/68>
   7:   89 10                     mov    %edx,(%eax)
Code;  c0143abf <proc_fd_link+1f/68>
   9:   8b 81 f8 00 00 00         mov    0xf8(%ecx),%eax
Code;  c0143ac5 <proc_fd_link+25/68>
   f:   8b 58 08                  mov    0x8(%eax),%ebx
Code;  c0143ac8 <proc_fd_link+28/68>
  12:   85 db                     test   %ebx,%ebx

Nov  1 14:09:40 phlegmish kernel: Unable to handle kernel paging request at 
virtual address d9d9ffcf
Nov  1 14:09:40 phlegmish kernel: c012d006
Nov  1 14:09:40 phlegmish kernel: *pde = 00000000
Nov  1 14:09:40 phlegmish kernel: Oops: 0000
Nov  1 14:09:40 phlegmish kernel: CPU:    0
Nov  1 14:09:40 phlegmish kernel: EIP:    0010:[<c012d006>]
Nov  1 14:09:40 phlegmish kernel: EFLAGS: 00210286
Nov  1 14:09:40 phlegmish kernel: eax: d9d9ffbb   ebx: d9d9ffbb   ecx: 
d9d9ffbb   edx: 00000400
Nov  1 14:09:41 phlegmish kernel: esi: 00000000   edi: c32acc40   ebp: 
00000001   esp: c007bee8
Nov  1 14:09:41 phlegmish kernel: ds: 0018   es: 0018   ss: 0018
Nov  1 14:09:41 phlegmish kernel: Process bash (pid: 1395, stackpage=c007b000)
Nov  1 14:09:41 phlegmish kernel: Stack: 00000007 00000000 c0118c0a d9d9ffbb 
c32acc40 c31903e0 c007a000 00000001 
Nov  1 14:09:41 phlegmish kernel:        c007bf40 c011920a c32acc40 00000001 
c007a000 00000001 c010a29c 00000001 
Nov  1 14:09:41 phlegmish kernel:        c007a000 00000000 00000001 bffff6d0 
c007bfc4 c007a550 00000001 00000000 
Nov  1 14:09:41 phlegmish kernel: Call Trace: [<c0118c0a>] [<d9d9ffbb>] 
[<c011920a>] [<c010a29c>] [<c885d100>] [<ffff0000>] [<c0109881>] 
Nov  1 14:09:41 phlegmish kernel:        [<c010994e>] [<c010a450>] 
Nov  1 14:09:41 phlegmish kernel: Code: 8b 43 14 85 c0 75 13 68 82 4f 22 c0 
e8 b5 9c fe ff 31 c0 83 

>>EIP; c012d006 <filp_close+6/64>   <=====

Trace; c0118c0a <put_files_struct+42/b0>
Trace; d9d9ffbb <END_OF_CODE+1152f207/???
Trace; c011920a <do_exit+c2/1fc>
Trace; c010a29c <do_signal+1f0/270>
Trace; c885d100 <[bttv].bss.end+2001/14f61>
Trace; ffff0000 <END_OF_CODE+3777f24c/???
Trace; c0109881 <restore_sigcontext+111/134>
Trace; c010994e <sys_sigreturn+aa/d4>
Trace; c010a450 <signal_return+14/18>
Code;  c012d006 <filp_close+6/64>
00000000 <_EIP>:
Code;  c012d006 <filp_close+6
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
