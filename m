Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUAOXmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbUAOXmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:42:53 -0500
Received: from intra.cyclades.com ([64.186.161.6]:53134 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265253AbUAOXmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 18:42:45 -0500
Date: Thu, 15 Jan 2004 21:23:31 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "David S. Miller" <davem@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, sim@netnation.com, dwmw2@infradead.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Linux 2.4.25-pre5
In-Reply-To: <20040115145519.79beddc3.davem@redhat.com>
Message-ID: <Pine.LNX.4.58L.0401152110020.17528@logos.cnet>
References: <Pine.LNX.4.58L.0401151816320.17528@logos.cnet>
 <20040115145519.79beddc3.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Jan 2004, David S. Miller wrote:

> On Thu, 15 Jan 2004 18:19:40 -0200 (BRST)
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> > Here is -pre5.
>
> If this is anything like the current 2.4.x BK tree, people will need this
> in order to get a successful build:
>
> --- Makefile.~1~	Thu Jan 15 12:13:10 2004
> +++ Makefile	Thu Jan 15 12:13:12 2004
> @@ -1,6 +1,6 @@
>  VERSION = 2
>  PATCHLEVEL = 4
> -UBLEVEL = 25
> +SUBLEVEL = 25
>  EXTRAVERSION = -pre5
>
>  KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

I forgot to "bk push" (I never forget, you know).

Sir Woodhouse,

I just managed to crash a SMP box running dbench.

I guess this is related to your deadlock fix?

Unable to handle kernel NULL pointer dereference at virtual address
00000000 c011a673
*pde = 1efe0001
Oops: 0000
CPU:  6
EIP:  0010:[<c011a673>]

Not tainted
Using defaults from ksymoops -t elf32-i386-a i386
EFLAGS: 00010097 eax: ec4f81d4 ebx: df0f7dd0 ecx: 00000000 edx:
00000003 esi: cd09a1a0 edi: ec4f81d0 ebp: defe3e30 esp: defe3e18 ds: 0018
es: 0018 ss: 0018
Process sh (pid: 2325, stackpage=defe3000)
Stack:
00000001 00000282 00000003 ec4f8120 cd09a1a0 cd09e800 f6ef1002 c0163e24
       ec4f8120 ec4f8120 defd9990 00000001 42132674 f5d426e0 cd09a1a0f6efb483
       cd09a1f3 c0166010 cd09e800 00001002 cd09a1a0 ffffffea 00000000 cd09c440

Call Trace:    [<c0163e24>] [<c0166010>] [<c015620b>] [<c016400e>]
[<c014c3a3>]
  [<c014ccdf>] [<c014d16b>] [<c014d66d>] [<c0140ea4>] [<c014c02f>]
[<c01411f4>]
  [<c0108c83>]
Code: 8b 01 85 45 f0 74 69 31 d2 9c 5e fa f0 fe 0d 80 7c 3a c0 0f

>>EIP; c011a673 <__wake_up+33/c0>   <=====
Trace; c0163e24 <proc_get_inode+64/140>
Trace; c0166010 <proc_lookup+c0/e0>
Trace; c015620b <d_alloc+1b/180>
Trace; c016400e <proc_root_lookup+2e/50>
Trace; c014c3a3 <real_lookup+73/100>
Trace; c014ccdf <link_path_walk+76f/a20>
Trace; c014d16b <path_lookup+1b/30>
Trace; c014d66d <open_namei+6d/640>
Trace; c0140ea4 <filp_open+34/60>
Trace; c014c02f <getname+5f/a0>
Trace; c01411f4 <sys_open+34/a0>
Trace; c0108c83 <system_call+33/40>
Code;  c011a673 <__wake_up+33/c0>
00000000 <_EIP>:
Code;  c011a673 <__wake_up+33/c0>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c011a675 <__wake_up+35/c0>
   2:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c011a678 <__wake_up+38/c0>
   5:   74 69                     je     70 <_EIP+0x70> c011a6e3
<__wake_up+a3/c0>
Code;  c011a67a <__wake_up+3a/c0>
   7:   31 d2                     xor    %edx,%edx
Code;  c011a67c <__wake_up+3c/c0>
   9:   9c                        pushf
Code;  c011a67d <__wake_up+3d/c0>
   a:   5e                        pop    %esi
Code;  c011a67e <__wake_up+3e/c0>
   b:   fa                        cli
Code;  c011a67f <__wake_up+3f/c0>
   c:   f0 fe 0d 80 7c 3a c0      lock decb 0xc03a7c80
Code;  c011a686 <__wake_up+46/c0>
  13:   0f 00 00                  sldtl  (%eax)


proc_get_inode() does not call __wake_up(), so I'm wondering whats going
on here.

0xc0163e17 <proc_get_inode+87>: mov    0x20(%edi),%eax
0xc0163e1a <proc_get_inode+90>: push   %ebx
0xc0163e1b <proc_get_inode+91>: call   *0x8(%eax)
0xc0163e1e <proc_get_inode+94>: push   %ebx
0xc0163e1f <proc_get_inode+95>: call   0xc01584c0 <unlock_new_inode>
****> 0xc0163e24 <proc_get_inode+100>:        pop    %edi
0xc0163e25 <proc_get_inode+101>:        pop    %eax
0xc0163e26 <proc_get_inode+102>:        test   %ebx,%ebx

