Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129703AbQKXWqz>; Fri, 24 Nov 2000 17:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130359AbQKXWqp>; Fri, 24 Nov 2000 17:46:45 -0500
Received: from step.polymtl.ca ([132.207.4.32]:22759 "EHLO step.polymtl.ca")
        by vger.kernel.org with ESMTP id <S129703AbQKXWqe>;
        Fri, 24 Nov 2000 17:46:34 -0500
Date: Fri, 24 Nov 2000 17:16:32 -0500
From: Marc Heckmann <pfeif@step.polymtl.ca>
To: Mark Ellis <mark.uzumati@virgin.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS on bringing down ppp
Message-ID: <20001124171631.D6276@step.polymtl.ca>
In-Reply-To: <20001124105539.A18945@ElCapitan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001124105539.A18945@ElCapitan>; from mark.uzumati@virgin.net on Fri, Nov 24, 2000 at 10:55:39AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2000 at 10:55:39AM +0000, Mark Ellis wrote:
> Hi all, consistently getting the following when pppd is terminated. Happens
> in 2.4.0-test11, fine in 2.4.0-test9, don't know about test10. Same happens
> for pppd 2.4.0b4 and 2.4.0, both recompiled for test11. Is this related to
> the modutils incompatability (modutils 2.3.19) ? 

I get the same oops w/ 2.4.0-test11pre7, pppd-2.3.11 and pppd-2.4.0, not
quite sure if it happens on _every_ pppd termination, but it does happen
a lot. Modutils-2.3.2[01]. ksymoops below, notice that it is preceded by
a waitpid failed, don't wether it is important or not... My kernel is
compiled on a fairly stock RH-7.0 with kgcc.

system:

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux fsck.ikr.org 2.4.0-test11 #2 Sun Nov 19 00:16:38 EST 2000 i586
unknown
Kernel modules         2.3.20
Gnu C                  egcs-2.91.66
Gnu Make               3.79.1
Binutils               2.10.0.18
Linux C Library        2.1.94
Dynamic linker         ldd (GNU libc) 2.1.94
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ppp_deflate bsd_comp ppp_async ppp_generic slhc
ide-cd cdrom soundcore de4x5 raid1 BusLogic


Nov 23 16:05:13 fsck kernel: waitpid(1808) failed, -512
Nov 23 16:05:13 fsck kernel: Unable to handle kernel NULL pointer
dereference at
 virtual address 00000008
Nov 23 16:05:13 fsck kernel:  printing eip:
Nov 23 16:05:13 fsck kernel: c011556e
Nov 23 16:05:13 fsck kernel: *pde = 00000000
Nov 23 16:05:13 fsck kernel: Oops: 0000
Nov 23 16:05:13 fsck kernel: CPU:    0
Nov 23 16:05:13 fsck kernel: EIP:    0010:[exec_usermodehelper+734/944]
Nov 23 16:05:13 fsck kernel: EFLAGS: 00010246
Nov 23 16:05:13 fsck kernel: eax: 00000000   ebx: c1177b20   ecx: c1fb4fb0
edx: c1fb4fa4
Nov 23 16:05:13 fsck kernel: esi: c2694000   edi: c2694000   ebp: 00000000
esp: c2695fb0
Nov 23 16:05:13 fsck kernel: ds: 0018   es: 0018   ss: 0018
Nov 23 16:05:13 fsck kernel: Process pppd (pid: 1808, stackpage=c2695000)
Nov 23 16:05:13 fsck kernel: Stack: 00000100 c34e7d90 c34e6000 c1a640c0
c3eca9a0 c36fc160 c1177b20 c3eca9a0 
Nov 23 16:05:13 fsck kernel:        c3eca9a0 c1177b20 c3eca9a0 c3eca9a0
c0115890 c0222840 c34e7e4c c34e7e38 
Nov 23 16:05:13 fsck kernel:        c0108e87 c34e7dbc c34e7dbc c34e7e4c 
Nov 23 16:05:13 fsck kernel: Call Trace: [exec_helper+20/24]
[kernel_thread+35/48] 
Nov 23 16:05:13 fsck kernel: Code: 3b 68 08 7d 2a 8b 40 14 83 3c a8 00 74
15 b8 06 00 00 00 89


ksymoops:

ksymoops 2.3.5 on i586 2.2.16-22.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.0-test11/ (specified)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
Nov 23 16:05:13 fsck kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000008
Nov 23 16:05:13 fsck kernel: c011556e
Nov 23 16:05:13 fsck kernel: *pde = 00000000
Nov 23 16:05:13 fsck kernel: Oops: 0000
Nov 23 16:05:13 fsck kernel: CPU:    0
Nov 23 16:05:13 fsck kernel: EIP:    0010:[exec_usermodehelper+734/944]
Nov 23 16:05:13 fsck kernel: EFLAGS: 00010246
Nov 23 16:05:13 fsck kernel: eax: 00000000   ebx: c1177b20   ecx: c1fb4fb0
edx: c1fb4fa4
Nov 23 16:05:13 fsck kernel: esi: c2694000   edi: c2694000   ebp: 00000000
esp: c2695fb0
Nov 23 16:05:13 fsck kernel: ds: 0018   es: 0018   ss: 0018
Nov 23 16:05:13 fsck kernel: Process pppd (pid: 1808, stackpage=c2695000)
Nov 23 16:05:13 fsck kernel: Stack: 00000100 c34e7d90 c34e6000 c1a640c0
c3eca9a0 c36fc160 c1177b20 c3eca9a0 
Nov 23 16:05:13 fsck kernel:        c3eca9a0 c1177b20 c3eca9a0 c3eca9a0
c0115890 c0222840 c34e7e4c c34e7e38 
Nov 23 16:05:13 fsck kernel:        c0108e87 c34e7dbc c34e7dbc c34e7e4c 
Nov 23 16:05:13 fsck kernel: Call Trace: [exec_helper+20/24]
[kernel_thread+35/48] 
Nov 23 16:05:13 fsck kernel: Code: 3b 68 08 7d 2a 8b 40 14 83 3c a8 00 74
15 b8 06 00 00 00 89
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   3b 68 08                  cmp    0x8(%eax),%ebp
Code;  00000003 Before first symbol
   3:   7d 2a                     jge    2f <_EIP+0x2f> 0000002f Before
first symbol
Code;  00000005 Before first symbol
   5:   8b 40 14                  mov    0x14(%eax),%eax
Code;  00000008 Before first symbol
   8:   83 3c a8 00               cmpl   $0x0,(%eax,%ebp,4)
Code;  0000000c Before first symbol
   c:   74 15                     je     23 <_EIP+0x23> 00000023 Before
first symbol
Code;  0000000e Before first symbol
   e:   b8 06 00 00 00            mov    $0x6,%eax
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)

	-Marc

> CONFIG_PPP and CONFIG_PPP_ASYNC are built in, CONFIG_PPP_DEFLATE and
> CONFIG_PPP_BSDCOMP as modules, but oopses whether they are loaded or not.
> 
> ksymoops 2.3.4 on i686 2.4.0-test11.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.0-test11/ (default)
>      -m /usr/src/linux/System.map (specified)
> 
> Warning (compare_maps): snd symbol pm_register not found in
> /lib/modules/2.4.0-test11/sound/snd.o.  Ignoring
> /lib/modules/2.4.0-test11/sound/snd.o entry
> Warning (compare_maps): snd symbol pm_send not found in
> /lib/modules/2.4.0-test11/sound/snd.o.  Ignoring
> /lib/modules/2.4.0-test11/sound/snd.o entry
> Warning (compare_maps): snd symbol pm_unregister not found in
> /lib/modules/2.4.0-test11/sound/snd.o.  Ignoring
> /lib/modules/2.4.0-test11/sound/snd.o entry
> c0114c6c
> *pde = 00000000
> Oops:  0000
> CPU:    0
> EIP:    0010:[<c0114c6c>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: c4bb1544   ebx: c4e72000   ecx: c5fe83a0   edx: 00000000
> esi: 00000006   edi: 00000000   ebp: c5fe83a0   esp: c4e73fb8
> ds: 0018   es: 0018   ss: 0018
> Process pppd (pid: 1099, stackpage=c4e73000)
> Stack: 00000100 c4e6delc c4e6de4c c5b27e20 c5fe83a0 c11c35c0 c11c35c0
>        c11c35c0 c11c35c0 c0114f60 c0225f60 c4e6dedc c4e6dec8 c0108914
>        c4e6de4c 00000078 c4e6dedc
> Call Trace: [<c0114f60>] [<c0108914>]
> Code: 8b 4f 08 39 ca 7d 22 8b 47 14 83 3c 90 00 74 14 89 f0 89 d3
> 
> >>EIP; c0114c6c <exec_usermodehelper+29c/368>   <=====
> Trace; c0114f60 <exec_helper+14/18>
> Trace; c0108914 <kernel_thread+28/38>
> Code;  c0114c6c <exec_usermodehelper+29c/368>
> 00000000 <_EIP>:
> Code;  c0114c6c <exec_usermodehelper+29c/368>   <=====
>    0:   8b 4f 08                  mov    0x8(%edi),%ecx   <=====
> Code;  c0114c6f <exec_usermodehelper+29f/368>
>    3:   39 ca                     cmp    %ecx,%edx
> Code;  c0114c71 <exec_usermodehelper+2a1/368>
>    5:   7d 22                     jge    29 <_EIP+0x29> c0114c95
> <exec_usermodehelper+2c5/368>
> Code;  c0114c73 <exec_usermodehelper+2a3/368>
>    7:   8b 47 14                  mov    0x14(%edi),%eax
> Code;  c0114c76 <exec_usermodehelper+2a6/368>
>    a:   83 3c 90 00               cmpl   $0x0,(%eax,%edx,4)
> Code;  c0114c7a <exec_usermodehelper+2aa/368>
>    e:   74 14                     je     24 <_EIP+0x24> c0114c90
> <exec_usermodehelper+2c0/368>
> Code;  c0114c7c <exec_usermodehelper+2ac/368>
>   10:   89 f0                     mov    %esi,%eax
> Code;  c0114c7e <exec_usermodehelper+2ae/368>
>   12:   89 d3                     mov    %edx,%ebx
> 
> 
> 3 warnings issued.  Results may not be reliable.
> 
> 
> Any ideas ?
> 
> Mark
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
