Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSHIUPk>; Fri, 9 Aug 2002 16:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSHIUPk>; Fri, 9 Aug 2002 16:15:40 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:16834 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315720AbSHIUPi>; Fri, 9 Aug 2002 16:15:38 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
From: Paul Larson <plars@austin.ibm.com>
To: Paul Larson <plars@austin.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Hubertus Franke <frankeh@us.ibm.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@zip.com.au>, andrea@suse.de,
       Dave Jones <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1028921658.19434.365.camel@plars.austin.ibm.com>
References: <Pine.LNX.4.44.0208081500550.9114-100000@home.transmeta.com> 
	<1028921658.19434.365.camel@plars.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Aug 2002 15:13:35 -0500
Message-Id: <1028924016.19434.369.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 14:34, Paul Larson wrote:
> I suspect that it would actually require more than just this.  I tried
> this with the same test I've been using and had several failed attepmts
> at low numbers by getting wierd unexpected signals (like 28), and then
> one that ran for a much longer time and produced an oops with random
> garbage to the console (trying to extract this now).
> 
> -Paul Larson
Here's the ksymoops output minus the unprintable chars that got sent
after it:

Unable to handle kernel paging request at virtual address 32313256
c015cb38
*pde = 37184001
Oops: 0000
CPU:    4
0010:[<c015cb38>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: d9768090   ebx: d9768090   ecx: 00000020   edx: 32313232
esi: c015cb10   edi: d9768090   ebp: 00000008   esp: f6cb9e34
ds: 0018   es: 0018   ss: 0018
Stack: c0151403 d9768090 d9768090 f6dabaa0 c01515ad d9768090 f6dabab8
c014f49b
d9768090 f6dabaa0 c0139fa3 00000020 00000001 000001d0 c013a21a c013a170
000001f8 f6cb9e7c 00000020 00000001 000001d0 000041e6 c014f8f0 00000010
Call Trace: [<c0151403>] [<c01515ad>] [<c014f49b>] [<c0139fa3>]
[<c013a21a>]
[<c013a170>] [<c014f8f0>] [<c0131f9e>] [<c0131fec>] [<c0132c64>]
[<c0132fa2>]
[<c0133010>] [<c0116717>] [<c0117186>] [<c011793e>] [<c0105bc5>]
[<c0107173>]
Code: 8b 42 24 85 c0 74 0b f0 ff 48 10 8b 42 24 83 48 14 08 52 e8

>>EIP; c015cb38 <proc_delete_inode+28/50>   <=====
Trace; c0151403 <generic_delete_inode+83/b0>
Trace; c01515ad <iput+5d/60>
Trace; c014f49b <prune_dcache+eb/180>
Trace; c0139fa3 <pdflush_operation+83/90>
Trace; c013a21a <wakeup_bdflush+1a/20>
Trace; c013a170 <background_writeout+0/90>
Trace; c014f8f0 <shrink_dcache_memory+20/40>
Trace; c0131f9e <shrink_caches+7e/a0>
Trace; c0131fec <try_to_free_pages+2c/50>
Trace; c0132c64 <balance_classzone+44/1f0>
Trace; c0132fa2 <__alloc_pages+192/1f0>
Trace; c0133010 <__get_free_pages+10/20>
Trace; c0116717 <dup_task_struct+17/70>
Trace; c0117186 <copy_process+56/7f0>
Trace; c011793e <do_fork+1e/a0>
Trace; c0105bc5 <sys_fork+15/30>
Trace; c0107173 <syscall_call+7/b>
Code;  c015cb38 <proc_delete_inode+28/50>
00000000 <_EIP>:
Code;  c015cb38 <proc_delete_inode+28/50>   <=====
   0:   8b 42 24                  mov    0x24(%edx),%eax   <=====
Code;  c015cb3b <proc_delete_inode+2b/50>
   3:   85 c0                     test   %eax,%eax
Code;  c015cb3d <proc_delete_inode+2d/50>
   5:   74 0b                     je     12 <_EIP+0x12> c015cb4a
<proc_delete_inode+3a/50>
Code;  c015cb3f <proc_delete_inode+2f/50>
   7:   f0 ff 48 10               lock decl 0x10(%eax)
Code;  c015cb43 <proc_delete_inode+33/50>
   b:   8b 42 24                  mov    0x24(%edx),%eax
Code;  c015cb46 <proc_delete_inode+36/50>
   e:   83 48 14 08               orl    $0x8,0x14(%eax)
Code;  c015cb4a <proc_delete_inode+3a/50>
  12:   52                        push   %edx
Code;  c015cb4b <proc_delete_inode+3b/50>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c015cb50
<proc_delete_inode+40/50>

