Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVAYNSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVAYNSl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVAYNSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:18:41 -0500
Received: from balu1.urz.unibas.ch ([131.152.1.51]:63968 "EHLO
	balu1.urz.unibas.ch") by vger.kernel.org with ESMTP id S261932AbVAYNSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:18:36 -0500
Date: Tue, 25 Jan 2005 14:17:22 +0100
From: Peter Englmaier <Peter.Englmaier@unibas.ch>
Subject: Kernel Crash with Oops and possible file corruption
To: linux-kernel@vger.kernel.org
Message-id: <20050125131722.GA7343@astro.unibas.ch>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.4.1i
X-SMTP-Vilter-Version: 1.1.8
X-SMTP-Vilter-Virus-Backend: savse
X-SMTP-Vilter-Status: clean
X-SMTP-Vilter-savse-Virus-Status: clean
X-SMTP-Vilter-Unwanted-Backend: attachment
X-SMTP-Vilter-attachment-Unwanted-Status: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel Developers,

I've got a machine which crashes from time to time when somebody
accesses it (either via graphical console or remote login).
Sometimes fsck found corrupted files which may be related, because
the oops indicates that something goes wrong with memory.

The ksymoops output is attached below.

The crash happens only once a week or so. However, I cannot provide any
hints how to trigger the crash, yet.

Is this known? Does it make sense to upgrade the kernel?

Distribution: 
  Fedora Core 2 with all updates (but not the newest kernel).
System: Hyperthreading Pentium 4 with 3 GHz.

The problems started a while after I did a fresh install of Fedora.
The old system (Debian woody) was stable and used an older kernel
(can't tell which; probably 2.2.x).

Best, 
Peter.

ksymoops 2.4.9 on i686 2.6.5-1.358smp.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.5-1.358smp/ (default)
     -m /boot/System.map-2.6.5-1.358smp (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 8c22f03c
0213b924
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<0213b924>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006   (2.6.5-1.358smp)
eax: 8c22f038   ebx: 3c135000   ecx: 3c135080   edx: 37662000
esi: 41727e80   edi: 0000001b   ebp: 0000000b   esp: 41ecef18
ds: 007b   es: 007b   ss: 0068
Stack: 41809d64 4175c000 41809d64 1c889080 0000001b 0213ba2e 41809d54 41727e80
       41809d54 41809d64 1c889080 00000206 0213bc60 1c889134 41ecef84 00000129
       00000000 021631c1 1c889134 0216344f 25f2db34 25f2db3c 022f7068 021637c8
Call Trace:
 [<0213ba2e>] cache_flusharray+0x71/0xbe
 [<0213bc60>] kmem_cache_free+0x2b/0x39
 [<021631c1>] destroy_inode+0x36/0x45
 [<0216344f>] dispose_list+0x4e/0x73
 [<021637c8>] prune_icache+0x18f/0x1e8
 [<0213a076>] pdflush+0x0/0x1e
 [<02139fdf>] __pdflush+0xfb/0x192
 [<0213a090>] pdflush+0x1a/0x1e
 [<021397fb>] wb_kupdate+0x0/0xf4
 [<0213a076>] pdflush+0x0/0x1e
 [<0212db21>] kthread+0x73/0x9b
 [<0212daae>] kthread+0x0/0x9b
 [<021041f1>] kernel_thread_helper+0x5/0xb
Code: 89 50 04 89 02 31 d2 2b 4b 0c c7 03 00 01 10 00 c7 43 04 00


>>EIP; 0213b924 <kmem_cache_destroy+62b/782>   <=====

Trace; 0213ba2e <kmem_cache_destroy+735/782>
Trace; 0213bc60 <kmem_cache_free+2b/39>
Trace; 021631c1 <flush_dentry_attributes+484/493>
Trace; 0216344f <clear_inode+f7/1c9>
Trace; 021637c8 <__invalidate_device+202/30c>
Trace; 0213a076 <mapping_tagged+1ff/325>
Trace; 02139fdf <mapping_tagged+168/325>
Trace; 0213a090 <mapping_tagged+219/325>
Trace; 021397fb <balance_dirty_pages_ratelimited+13c/386>
Trace; 0213a076 <mapping_tagged+1ff/325>
Trace; 0212db21 <param_set_copystring+1257/1fc6>
Trace; 0212daae <param_set_copystring+11e4/1fc6>
Trace; 021041f1 <enable_hlt+1e0/1e6>

Code;  0213b924 <kmem_cache_destroy+62b/782>
00000000 <_EIP>:
Code;  0213b924 <kmem_cache_destroy+62b/782>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  0213b927 <kmem_cache_destroy+62e/782>
   3:   89 02                     mov    %eax,(%edx)
Code;  0213b929 <kmem_cache_destroy+630/782>
   5:   31 d2                     xor    %edx,%edx
Code;  0213b92b <kmem_cache_destroy+632/782>
   7:   2b 4b 0c                  sub    0xc(%ebx),%ecx
Code;  0213b92e <kmem_cache_destroy+635/782>
   a:   c7 03 00 01 10 00         movl   $0x100100,(%ebx)
Code;  0213b934 <kmem_cache_destroy+63b/782>
  10:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)

