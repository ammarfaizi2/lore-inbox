Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263558AbTCUI3D>; Fri, 21 Mar 2003 03:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263559AbTCUI3D>; Fri, 21 Mar 2003 03:29:03 -0500
Received: from mail.mediaways.net ([193.189.224.113]:51925 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S263558AbTCUI3C>; Fri, 21 Mar 2003 03:29:02 -0500
Subject: Re: kswapd oops in 2.4.20 SMP+NFS
From: Soeren Sonnenburg <kernel@nn7.de>
To: Oleg Drokin <green@namesys.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030321112834.A17330@namesys.com>
References: <1048170204.5161.11.camel@calculon>
	 <20030321112834.A17330@namesys.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048235772.9345.10.camel@fortknox>
Mime-Version: 1.0
Date: 21 Mar 2003 09:36:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 09:28, Oleg Drokin wrote:
> Hello!
> > nfsd-fh: found a name that I didn't expect: sys/oz
> > nfsd-fh: found a name that I didn't expect: bin/x86
> > nfsd-fh: found a name that I didn't expect: bin/x86
> > nfsd-fh: found a name that I didn't expect: etc/bla
> > VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> 
> Hm, what is the underlying host filesystem?

reiserfs of course ;-)
> Thank you.

Here we go:

Unable to handle kernel paging request at virtual address 00268eb7
c014f5a3
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c014f5a3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: e34b05c0   ecx: e34b05d0   edx: d1da1c40
esi: d6c03e00   edi: 00268ea7   ebp: 0000318e   esp: f7edff34
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=f7edf000)
Stack: d1da1c58 e34b05c0 e34b05c0 c017a75f e34b05c0 d1da1c58 d1da1c40 c014cf20 
       d1da1c40 e34b05c0 00000006 000001d0 00000020 00000006 c014d2ab 000108c9 
       c0132046 00000006 000001d0 00000006 00000020 000001d0 c02d94b4 c02d94b4 
Call Trace:    [<c017a75f>] [<c014cf20>] [<c014d2ab>] [<c0132046>] [<c013209c>]
  [<c01321a1>] [<c0132206>] [<c013232d>] [<c0105708>]
Code: 8b 47 10 85 c0 74 06 53 ff d0 83 c4 04 68 f0 a3 2d c0 8d 43 

>>EIP; c014f5a2 <iput+32/1f0>   <=====
Trace; c017a75e <journal_blocks_per_page+b92e/25f20>
Trace; c014cf20 <prune_dcache+e0/180>
Trace; c014d2aa <shrink_dcache_parent+3a/60>
Trace; c0132046 <kmem_find_general_cachep+1696/2150>
Trace; c013209c <kmem_find_general_cachep+16ec/2150>
Trace; c01321a0 <kmem_find_general_cachep+17f0/2150>
Trace; c0132206 <kmem_find_general_cachep+1856/2150>
Trace; c013232c <kmem_find_general_cachep+197c/2150>
Trace; c0105708 <kernel_thread+28/1f0>
Code;  c014f5a2 <iput+32/1f0>
00000000 <_EIP>:
Code;  c014f5a2 <iput+32/1f0>   <=====
   0:   8b 47 10                  mov    0x10(%edi),%eax   <=====
Code;  c014f5a4 <iput+34/1f0>
   3:   85 c0                     test   %eax,%eax
Code;  c014f5a6 <iput+36/1f0>
   5:   74 06                     je     d <_EIP+0xd> c014f5ae <iput+3e/1f0>
Code;  c014f5a8 <iput+38/1f0>
   7:   53                        push   %ebx
Code;  c014f5aa <iput+3a/1f0>
   8:   ff d0                     call   *%eax
Code;  c014f5ac <iput+3c/1f0>
   a:   83 c4 04                  add    $0x4,%esp
Code;  c014f5ae <iput+3e/1f0>
   d:   68 f0 a3 2d c0            push   $0xc02da3f0
Code;  c014f5b4 <iput+44/1f0>
  12:   8d 43 00                  lea    0x0(%ebx),%eax

Soeren.

