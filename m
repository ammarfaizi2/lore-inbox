Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287940AbSABTja>; Wed, 2 Jan 2002 14:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287919AbSABThf>; Wed, 2 Jan 2002 14:37:35 -0500
Received: from gargoyle.nibble.net ([63.119.67.21]:32781 "EHLO
	gargoyle.nibble.net") by vger.kernel.org with ESMTP
	id <S287933AbSABTgk>; Wed, 2 Jan 2002 14:36:40 -0500
From: nntp@nntpserver.com
Message-ID: <48266.208.251.34.34.1010000095.squirrel@www.nibble.net>
Date: Wed, 2 Jan 2002 14:34:55 -0500 (EST)
Subject: kernel panic
To: linux-kernel@vger.kernel.org
Reply-To: nntp@nntpserver.com
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I've been having a problem with kernel panics and I'm hoping someone can
suggest something.

Here is the specs for the machine:
Tyan dual Athlon (S2462)
2 MP-1800+ CPUs
2 GB ECC DDR (4 x 512MB)
2 GB of swap space
RedHat 7.2 install /w custom kernel

I've tried several kernels, but the following oops's were on 2.4.17
compiled with high memory, SMP, and P3 optimizations.  This machine is under
a very heavy CPU, IO, and network load.  I've seen it run for days and I've
seen it lockup every 3 hours.  There doesn't seem to be any pattern other
than it dies while under heavy load.  Another thing of interest is that it
does a lot of network traffic through the loopback device (127.0.0.1).  The
dmulti process listed in the oops's below is basically a proxy that uses the
loopback device to talk to other processes on the same machine.  It's
transferring 20-30 mbits of data 24/7.

Output from 'free':

             total       used       free     shared    buffers     cached
Mem:       2061364    2050892      10472          0      49072    1229432
-/+ buffers/cache:     772388    1288976
Swap:      2097016     126296    1970720

The following was logged when the machine locked up hard:

Jan  2 05:53:15 news5 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 000007e5
Jan  2 05:53:15 news5 kernel:  printing eip:
Jan  2 05:53:15 news5 kernel: c0237000
Jan  2 05:53:15 news5 kernel: *pde = 00000000
Jan  2 05:53:15 news5 kernel: Oops: 0000
Jan  2 05:53:15 news5 kernel: CPU:	1
Jan  2 05:53:15 news5 kernel: EIP:	0010:[<c0237000>]    Not tainted Jan
2 05:53:15 news5 kernel: EFLAGS: 00010286
Jan  2 05:53:15 news5 kernel: eax: 000006bd   ebx: 00000009   ecx:
e4a0e540
edx: 000007dd
Jan  2 05:53:15 news5 kernel: esi: e4a0e540   edi: 00000200   ebp:
00000001
esp: f2a65f30
Jan  2 05:53:15 news5 kernel: ds: 0018   es: 0018   ss: 0018
Jan  2 05:53:15 news5 kernel: Process dmulti (pid: 874,
stackpage=f2a65000) Jan  2 05:53:15 news5 kernel: Stack: c0141dd7
e4a0e540 00000000 f2a65f54 00000145 f2a64000 00000064 00000129
Jan  2 05:53:15 news5 kernel:        00000000 00000000 d8797000 00000020
bffffce8 d313f300 00000400 c0142259
Jan  2 05:53:15 news5 kernel:        00000282 f2a65f90 f2a65f8c f1aeef60
00000030 00000080 d313f000 00000064
Jan  2 05:53:15 news5 kernel: Call Trace: [<c0141dd7>] [<c0142259>]
[<c0106f1b>] Jan  2 05:53:15 news5 kernel:
Jan  2 05:53:15 news5 kernel: Code: 8b 80 28 01 00 00 ff 74 24 08 52 51
ff 50 1c 83 c4 0c c3 8d

I've never used ksymoops before, but it wrote the following trace when fed
the above oops:

>>EIP; c0237000 <sock_poll+10/30>   <=====
Trace; c0141dd7 <do_select+127/240>
Trace; c0142259 <sys_select+339/480>
Trace; c0106f1b <system_call+33/38>
Code;  c0237000 <sock_poll+10/30>
00000000 <_EIP>:
Code;  c0237000 <sock_poll+10/30>   <=====
   0:   8b 80 28 01 00 00         mov    0x128(%eax),%eax   <=====
Code;  c0237006 <sock_poll+16/30>
   6:   ff 74 24 08               pushl  0x8(%esp,1)
Code;  c023700a <sock_poll+1a/30>
   a:   52                        push   %edx
Code;  c023700b <sock_poll+1b/30>
   b:   51                        push   %ecx


Jan  2 05:53:15 news5 kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 000006ef
Jan  2 05:53:15 news5 kernel:  printing eip:
Jan  2 05:53:15 news5 kernel: c0148b86
Jan  2 05:53:15 news5 kernel: *pde = 00000000
Jan  2 05:53:15 news5 kernel: Oops: 0000
Jan  2 05:53:15 news5 kernel: CPU:	1
Jan  2 05:53:15 news5 kernel: EIP:	0010:[<c0148b86>]    Not tainted Jan
2 05:53:15 news5 kernel: EFLAGS: 00010202
Jan  2 05:53:15 news5 kernel: eax: f01027a0   ebx: 007fffff   ecx:
00000000
edx: 00000000
Jan  2 05:53:15 news5 kernel: esi: 000006bd   edi: 00000000   ebp:
e4a0e540
esp: f2a65da8
Jan  2 05:53:15 news5 kernel: ds: 0018   es: 0018   ss: 0018
Jan  2 05:53:15 news5 kernel: Process dmulti (pid: 874,
stackpage=f2a65000) Jan  2 05:53:15 news5 kernel: Stack: 00000001
007fffff e4a0e540 00000000 00000129 c01338bb 00000000 e4a0e540
Jan  2 05:53:15 news5 kernel:        00000000 007fffff f7547280 0000000a
c011838d e4a0e540 f7547280 00000000
Jan  2 05:53:15 news5 kernel:        f2a64000 f2a64000 0000000b c0118b8f
f7547280 0000000f c029a0f0 f2a65efc
Jan  2 05:53:15 news5 kernel: Call Trace: [<c01338bb>] [<c011838d>]
[<c0118b8f>] [<c0111e10>] [<c0107464>]
Jan  2 05:53:15 news5 kernel:	 [<c0112208>] [<c012d871>] [<c012d9c0>]
[<c0111e50>] [<c010700c>] [<c0237000>]
Jan  2 05:53:15 news5 kernel:	 [<c0141dd7>] [<c0142259>] [<c0106f1b>] Jan
2 05:53:15 news5 kernel:
Jan  2 05:53:15 news5 kernel: Code: 0f b7 46 32 25 00 f0 00 00 66 3d 00
40 74 0b b8 ec ff ff ff

ksymoops wrote from the above:

>>EIP; c0148b86 <fcntl_dirnotify+46/180>   <=====
Trace; c01338bb <filp_close+7b/a0>
Trace; c011838d <put_files_struct+4d/d0>
Trace; c0118b8f <do_exit+10f/240>
Trace; c0111e10 <bust_spinlocks+50/60>
Trace; c0107464 <die+54/70>
Trace; c0112208 <do_page_fault+3b8/500>
Trace; c012d871 <__alloc_pages+41/180>
Trace; c012d9c0 <__get_free_pages+10/20>
Trace; c0111e50 <do_page_fault+0/500>
Trace; c010700c <error_code+34/3c>
Trace; c0237000 <sock_poll+10/30>
Trace; c0141dd7 <do_select+127/240>
Trace; c0142259 <sys_select+339/480>
Trace; c0106f1b <system_call+33/38>
Code;  c0148b86 <fcntl_dirnotify+46/180>
00000000 <_EIP>:
Code;  c0148b86 <fcntl_dirnotify+46/180>   <=====
   0:   0f b7 46 32               movzwl 0x32(%esi),%eax   <=====
Code;  c0148b8a <fcntl_dirnotify+4a/180>
   4:   25 00 f0 00 00            and    $0xf000,%eax
Code;  c0148b8f <fcntl_dirnotify+4f/180>
   9:   66 3d 00 00               cmp    $0x0,%ax

The following was logged when the machine just removed one process.  The
process could not be restarted because the network port 119 was not released
when the process died.  I had to restart the machine.

Jan  2 02:28:31 news5 kernel: Unable to handle kernel paging request at
virtual address 3f4d0b35
Jan  2 02:28:31 news5 kernel:  printing eip:
Jan  2 02:28:31 news5 kernel: c0237000
Jan  2 02:28:31 news5 kernel: *pde = 00000000
Jan  2 02:28:31 news5 kernel: Oops: 0000
Jan  2 02:28:31 news5 kernel: CPU:	0
Jan  2 02:28:31 news5 kernel: EIP:	0010:[<c0237000>]    Not tainted
Jan  2 02:28:31 news5 kernel: EFLAGS: 00010286
Jan  2 02:28:31 news5 kernel: eax: 3f4d0a0d   ebx: 00000003   ecx: ee7f44a0
edx: 3f4d0b2d
Jan  2 02:28:31 news5 kernel: esi: ee7f44a0   edi: 10000000   ebp: 00000000
esp: ee9a7f30
Jan  2 02:28:31 news5 kernel: ds: 0018   es: 0018   ss: 0018
Jan  2 02:28:31 news5 kernel: Process dmulti (pid: 885, stackpage=ee9a7000)
Jan  2 02:28:31 news5 kernel: Stack: c0141dd7 ee7f44a0 00000000 ee9a7f54
00000145 ee9a6000 00000062 0000007c
Jan  2 02:28:31 news5 kernel:        00000000 00000000 e3d65000 00000020
bffffce8 d6eb8b00 00000400 c0142259
Jan  2 02:28:31 news5 kernel:        000001ed ee9a7f90 ee9a7f8c ec293160
00000011 00000080 d6eb8800 00000064
Jan  2 02:28:31 news5 kernel: Call Trace: [<c0141dd7>] [<c0142259>] [<c0106f1b>]
Jan  2 02:28:31 news5 kernel:
Jan  2 02:28:31 news5 kernel: Code: 8b 80 28 01 00 00 ff 74 24 08 52 51 ff
50 1c 83 c4 0c c3 8d

ksymoops wrote:
>>EIP; c0237000 <sock_poll+10/30>   <=====
Trace; c0141dd7 <do_select+127/240>
Trace; c0142259 <sys_select+339/480>
Trace; c0106f1b <system_call+33/38>
Code;  c0237000 <sock_poll+10/30>
00000000 <_EIP>:
Code;  c0237000 <sock_poll+10/30>   <=====
   0:   8b 80 28 01 00 00         mov    0x128(%eax),%eax   <=====
Code;  c0237006 <sock_poll+16/30>
   6:   ff 74 24 08               pushl  0x8(%esp,1)
Code;  c023700a <sock_poll+1a/30>
   a:   52                        push   %edx
Code;  c023700b <sock_poll+1b/30>
   b:   51                        push   %ecx
Code;  c023700c <sock_poll+1c/30>
   c:   ff 00                     incl   (%eax)




Jan  2 02:28:31 news5 kernel:  <1>Unable to handle kernel paging request at
virtual address 3f4d0a3f
Jan  2 02:28:31 news5 kernel:  printing eip:
Jan  2 02:28:31 news5 kernel: c0148b86
Jan  2 02:28:31 news5 kernel: *pde = 00000000
Jan  2 02:28:31 news5 kernel: Oops: 0000
Jan  2 02:28:31 news5 kernel: CPU:	0
Jan  2 02:28:31 news5 kernel: EIP:	0010:[<c0148b86>]    Not tainted
Jan  2 02:28:31 news5 kernel: EFLAGS: 00010202
Jan  2 02:28:31 news5 kernel: eax: ee0065e0   ebx: 0000000f   ecx: 00000000
edx: 00000000
Jan  2 02:28:31 news5 kernel: esi: 3f4d0a0d   edi: 00000000   ebp: ee7f44a0
esp: ee9a7da8
Jan  2 02:28:31 news5 kernel: ds: 0018   es: 0018   ss: 0018
Jan  2 02:28:31 news5 kernel: Process dmulti (pid: 885, stackpage=ee9a7000)
Jan  2 02:28:31 news5 kernel: Stack: 00000001 0000000f ee7f44a0 00000000
0000007c c01338bb 00000000 ee7f44a0
Jan  2 02:28:31 news5 kernel:        00000000 0000000f f33405c0 00000004
c011838d ee7f44a0 f33405c0 00000000
Jan  2 02:28:31 news5 kernel:        ee9a6000 ee9a6000 0000000b c0118b8f
f33405c0 00000000 0000002e f3349f64
Jan  2 02:28:31 news5 kernel: Call Trace: [<c01338bb>] [<c011838d>]
[<c0118b8f>] [<c0107477>] [<c0112208>]
Jan  2 02:28:31 news5 kernel:	 [<c0239efc>] [<c023a070>] [<c023d992>] [<c0119e7b>]
[<c01089bd>] [<c010ac18>]
Jan  2 02:28:31 news5 kernel:	 [<c0111e50>] [<c010700c>] [<c0237000>] [<c0141dd7>]
[<c0142259>] [<c0106f1b>]
Jan  2 02:28:31 news5 kernel:
Jan  2 02:28:31 news5 kernel: Code: 0f b7 46 32 25 00 f0 00 00 66 3d 00 40
74 0b b8 ec ff ff ff

ksymoops wrote the follow from the above:

>>EIP; c0148b86 <fcntl_dirnotify+46/180>   <=====
Trace; c01338bb <filp_close+7b/a0>
Trace; c011838d <put_files_struct+4d/d0>
Trace; c0118b8f <do_exit+10f/240>
Trace; c0107477 <die+67/70>
Trace; c0112208 <do_page_fault+3b8/500>
Trace; c0239efc <kfree_skbmem+c/70>
Trace; c023a070 <__kfree_skb+110/120>
Trace; c023d992 <net_tx_action+62/140>
Trace; c0119e7b <do_softirq+7b/e0>
Trace; c01089bd <do_IRQ+dd/f0>
Trace; c010ac18 <call_do_IRQ+5/d>
Trace; c0111e50 <do_page_fault+0/500>
Trace; c010700c <error_code+34/3c>
Trace; c0237000 <sock_poll+10/30>
Trace; c0141dd7 <do_select+127/240>
Trace; c0142259 <sys_select+339/480>
Trace; c0106f1b <system_call+33/38>
Code;  c0148b86 <fcntl_dirnotify+46/180>
00000000 <_EIP>:
Code;  c0148b86 <fcntl_dirnotify+46/180>   <=====
   0:   0f b7 46 32               movzwl 0x32(%esi),%eax   <=====
Code;  c0148b8a <fcntl_dirnotify+4a/180>
   4:   25 00 f0 00 00            and    $0xf000,%eax
Code;  c0148b8f <fcntl_dirnotify+4f/180>
   9:   66 3d 00 40               cmp    $0x4000,%ax


Does this help any?

Thanks,
Steve.


