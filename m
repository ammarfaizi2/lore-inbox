Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRIGAW3>; Thu, 6 Sep 2001 20:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRIGAWU>; Thu, 6 Sep 2001 20:22:20 -0400
Received: from haybaler.sackheads.org ([205.158.174.201]:45830 "HELO
	haybaler.sackheads.org") by vger.kernel.org with SMTP
	id <S269515AbRIGAWI>; Thu, 6 Sep 2001 20:22:08 -0400
Date: Thu, 6 Sep 2001 20:22:27 -0400
From: Jimmie Mayfield <mayfield+kernel@sackheads.org>
To: linux-kernel@vger.kernel.org
Subject: OOPS: 2.4.8-ac11 with XFree86 4.0.3/4.1.0 Matrox XVideo extensions
Message-ID: <20010906202227.A8488@sackheads.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I recently discovered 'MPlayer' and have been experimenting with it.
I've noticed that my system is very prone to hangs if I attempt to use
the XVideo output module.  I suspect there is some badness going on in
the Matrox Xserver but I thought I'd bounce it off the kernel list to
see if someone recognized a kernel problem buried in here.

<aside>
Earlier I had noticed similar hangs if I used the matrox-specific mga_vid.o 
"backend scaler" kernel module that comes with avifile and MPlayer.  I had 
largely ignored the problem and given up on mga_vid.o, assuming that it was 
just a buggy module.  The mga_vid.o module was not loaded at the time of
the crashes in this report.
</aside>

Setup:
IWill KK-266R (KT-133a)
Athlon 1.4Ghz
384 MB PC-133 running at the slowest memory timings
512 MB swap
16MB Matrox G400
2.4.8-ac11
Both reiserfs 3.6 and ext2 filesystems
XFree86 4.0.3 and 4.1.0


Though the hangs themselves are fairly repeatable, tonight is the first time
I've managed to get an OOPS message.  At the time of this particular hang,
I was running XF86 4.1.0.  The major applications running at this time were
MPlayer and XMMS 1.2.4.  XMMS was idle at the time.  MPlayer was running
in 'xv' mode (to use XVideo extensions) and was using Linux-native
decoder library.


OOPS #1

Unable to handle kernel paging request at virtual address 5d8b535a
c02015cc
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[unix_stream_recvmsg+268/880]
EIP:    0010:[<c02015cc>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010083
eax: 5d8b5356   ebx: c0c1bcb1   ecx: c581d814   edx: 00000286
esi: 00000800   edi: d7c95f5c   ebp: c581d814   esp: d7c95ee4
ds: 0018   es: 0018   ss: 0018  
Process xmms (pid: 3159, stackpage=d7c95000)
Stack: d05d2da0 00000800 d7c95f5c d7c95f80 c581da74 c581d814 d389d940 00000000
       ffffffa1 00000001 00000000 00000000 00000000 c581d7c0 c01c3ead d05d2da0
       d7c95f80 00000800 00000040 d7c95f48 d05d2da0 00000800 00000000 00000800
Call Trace: [sock_recvmsg+61/176] [sock_read+142/160] [sys_read+150/208] [system_ca
ll+51/56]
Call Trace: [<c01c3ead>] [<c01c3fbe>] [<c012fd76>] [<c0106c3b>] 
Code: 89 48 04 89 01 c7 03 00 00 00 00 c7 43 04 00 00 00 00 c7 43

>>EIP; c02015cc <unix_stream_recvmsg+10c/370>   <=====
Trace; c01c3ead <sock_recvmsg+3d/b0>
Trace; c01c3fbe <sock_read+8e/a0>
Trace; c012fd76 <sys_read+96/d0>
Trace; c0106c3b <system_call+33/38>
Code;  c02015cc <unix_stream_recvmsg+10c/370>
00000000 <_EIP>:
Code;  c02015cc <unix_stream_recvmsg+10c/370>   <=====
   0:   89 48 04                  mov    %ecx,0x4(%eax)   <=====
Code;  c02015cf <unix_stream_recvmsg+10f/370>
   3:   89 01                     mov    %eax,(%ecx)
Code;  c02015d1 <unix_stream_recvmsg+111/370>
   5:   c7 03 00 00 00 00         movl   $0x0,(%ebx)
Code;  c02015d7 <unix_stream_recvmsg+117/370>
   b:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c02015de <unix_stream_recvmsg+11e/370>
  12:   c7 43 00 00 00 00 00      movl   $0x0,0x0(%ebx)


OOPS #2

Unable to handle kernel paging request at virtual address 95959599
c01c66e0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[sock_def_readable+16/80]
EIP:    0010:[<c01c66e0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013286
eax: 95959599   ebx: 95959595   ecx: c581d7c0   edx: 00003246
esi: c581d7c0   edi: c581d814   ebp: c5a89140   esp: d2a51e64
ds: 0018   es: 0018   ss: 0018
Process X (pid: 3051, stackpage=d2a51000)
Stack: d6bc4540 00000020 c02011a9 c581d7c0 00000020 d2a51ec0 d2a51ef4 d2a51ec0
       d05d2f60 c581d7c0 00000000 c581d7c0 c581d140 00000000 c01c3e49 d05d2f60
       d2a51ef4 00000020 d2a51ec0 00000000 d05d2f60 d05d2e40 00000020 00000beb
Call Trace: [unix_stream_sendmsg+553/736] [sock_sendmsg+105/144] [sock_readv_writev
+157/176] [sock_writev+49/64] [do_readv_writev+355/560]
Call Trace: [<c02011a9>] [<c01c3e49>] [<c01c419d>] [<c01c4221>] [<c012ffe3>]
   [<c01057ec>] [<c011158c>] [<c0130151>] [<c0106c3b>]
Code: 39 43 04 74 11 b9 01 00 00 00 ba 01 00 00 00 89 d8 e8 ca af

>>EIP; c01c66e0 <sock_def_readable+10/50>   <=====
Trace; c02011a9 <unix_stream_sendmsg+229/2e0>
Trace; c01c3e49 <sock_sendmsg+69/90>
Trace; c01c419d <sock_readv_writev+9d/b0>
Trace; c01c4221 <sock_writev+31/40>
Trace; c012ffe3 <do_readv_writev+163/230>
Trace; c01057ec <__switch_to+2c/c0>
Trace; c011158c <schedule+25c/390>
Trace; c0130151 <sys_writev+41/60>
Trace; c0106c3b <system_call+33/38>
Code;  c01c66e0 <sock_def_readable+10/50>
00000000 <_EIP>:
Code;  c01c66e0 <sock_def_readable+10/50>   <=====
   0:   39 43 04                  cmp    %eax,0x4(%ebx)   <=====
Code;  c01c66e3 <sock_def_readable+13/50>
   3:   74 11                     je     16 <_EIP+0x16> c01c66f6 <sock_def_readable+26/50>
Code;  c01c66e5 <sock_def_readable+15/50>
   5:   b9 01 00 00 00            mov    $0x1,%ecx
Code;  c01c66ea <sock_def_readable+1a/50>
   a:   ba 01 00 00 00            mov    $0x1,%edx
Code;  c01c66ef <sock_def_readable+1f/50>
   f:   89 d8                     mov    %ebx,%eax
Code;  c01c66f1 <sock_def_readable+21/50>
  11:   e8 ca af 00 00            call   afe0 <_EIP+0xafe0> c01d16c0 <ip_route_output_slow+3f0/630>


If there's any other information I can provide, please let me know.

Also, please CC me on any replies since I'm only able to read the kernel
list a few times a week.


Jimmie

-- 
Jimmie Mayfield  
http://www.sackheads.org/mayfield       email: mayfield+kernel@sackheads.org
My mail provider does not welcome UCE -- http://www.sackheads.org/uce

