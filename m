Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUIJHqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUIJHqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUIJHp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:45:59 -0400
Received: from gizmo05bw.bigpond.com ([144.140.70.40]:24525 "HELO
	gizmo05bw.bigpond.com") by vger.kernel.org with SMTP
	id S267291AbUIJHna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:43:30 -0400
Message-ID: <41415B15.1050402@bigpond.net.au>
Date: Fri, 10 Sep 2004 17:43:17 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
References: <413FA9AE.90304@bigpond.net.au> <20040909010610.28ca50e1.akpm@osdl.org> <4140EE3E.5040602@bigpond.net.au> <20040909171450.6546ee7a.akpm@osdl.org> <4141092B.2090608@bigpond.net.au> <20040909200650.787001fc.akpm@osdl.org> <41413F64.40504@bigpond.net.au> <20040909231858.770ab381.akpm@osdl.org> <414149A0.1050006@bigpond.net.au> <20040909235217.5a170840.akpm@osdl.org>
In-Reply-To: <20040909235217.5a170840.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050503040804070406070907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050503040804070406070907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
>>>Please keep going ;)
>>
>> > 
>>
>> All the way through and it's still occurring.  After the second patch 
>> the symptoms changed slightly and it was a different gdm program that 
>> triggered the oops.  But with all patches applied it's back to the 
>> original symptoms.
> 
> 
> Drat - I expected one of those would be the culprit.  Your .config works
> happily here on a FC1 box, of course :(
> 
> It would be useful if you could experiment with CONFIG_DEBUG_SLAB and
> CONFIG_DEBUG_PAGEALLOC.

With both of those enabled and all four patches applied the oops and the 
scheduling while atomic have stopped BUT I'm now getting 4  identical 
oops in kfree which seem to be associated with a segment fault in mount 
while my start up script is mounting some iso files with loopback.

Oops and result of running it through ksymoops are attached.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------050503040804070406070907
Content-Type: text/plain;
 name="kfree.oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kfree.oops.txt"

Sep 10 17:22:29 mudlark kernel: Unable to handle kernel paging request at virtual address f2d8bef4
Sep 10 17:22:29 mudlark kernel:  printing eip:
Sep 10 17:22:29 mudlark kernel: c013957f
Sep 10 17:22:29 mudlark kernel: *pde = 00507067
Sep 10 17:22:29 mudlark kernel: *pte = 32d8b000
Sep 10 17:22:29 mudlark kernel: Oops: 0000 [#1]
Sep 10 17:22:29 mudlark kernel: PREEMPT DEBUG_PAGEALLOC
Sep 10 17:22:29 mudlark kernel: Modules linked in: tulip ohci_hcd
Sep 10 17:22:29 mudlark kernel: CPU:    0
Sep 10 17:22:29 mudlark kernel: EIP:    0060:[<c013957f>]    Not tainted VLI
Sep 10 17:22:30 mudlark kernel: EFLAGS: 00010082   (2.6.9-rc1-bk16) 
Sep 10 17:22:30 mudlark kernel: EIP is at cache_free_debugcheck+0x207/0x2a3
Sep 10 17:22:30 mudlark kernel: eax: f2d8bef4   ebx: 80052c00   ecx: f2d8bef8   edx: 00000ef8
Sep 10 17:22:32 mudlark kernel: esi: f2d3164c   edi: f2d8b000   ebp: c18ff680   esp: f2e95cfc
Sep 10 17:22:33 mudlark kernel: ds: 007b   es: 007b   ss: 0068
Sep 10 17:22:34 mudlark rc: Starting webmin:  succeeded
Sep 10 17:22:34 mudlark kernel: Process mount (pid: 2671, threadinfo=f2e94000 task=f2da1a60)
Sep 10 17:22:34 mudlark kernel: Stack: c18ff680 f2d8b000 00000000 00000246 32d8b000 c18ff680 c1903054 f2d8bef8 
Sep 10 17:22:34 mudlark kernel:        00000282 c013a185 c18ff680 f2d8bef8 c01b2a6d 00000000 f2d8bef8 f2d8bfe5 
Sep 10 17:22:34 mudlark kernel:        f2d8bef8 c01b2a6d f2d8bef8 00000041 00000800 f2fafec0 00000005 0000001f 
Sep 10 17:22:34 mudlark kernel: Call Trace:
Sep 10 17:22:34 mudlark kernel:  [<c013a185>] kfree+0x59/0x9b
Sep 10 17:22:34 mudlark kernel:  [<c01b2a6d>] parse_rock_ridge_inode_internal+0x1c9/0x654
Sep 10 17:22:34 mudlark kernel:  [<c01b2a6d>] parse_rock_ridge_inode_internal+0x1c9/0x654
Sep 10 17:22:34 mudlark kernel:  [<c01b3090>] parse_rock_ridge_inode+0x27/0x67
Sep 10 17:22:34 mudlark kernel:  [<c01b1ad6>] isofs_read_inode+0x283/0x3f7
Sep 10 17:22:34 mudlark kernel:  [<c01b1d0c>] isofs_iget+0x71/0x7b
Sep 10 17:22:34 mudlark kernel:  [<c01b1c4a>] isofs_iget5_test+0x0/0x3b
Sep 10 17:22:34 mudlark kernel:  [<c01b1c85>] isofs_iget5_set+0x0/0x16
Sep 10 17:22:34 mudlark kernel:  [<c01b0e83>] isofs_fill_super+0x3f0/0x6bb
Sep 10 17:22:34 mudlark kernel:  [<c0139db1>] kmem_cache_alloc+0x60/0x86
Sep 10 17:22:34 mudlark kernel:  [<c0155795>] sb_set_blocksize+0x2e/0x5d
Sep 10 17:22:34 mudlark kernel:  [<c01551f8>] get_sb_bdev+0x103/0x135
Sep 10 17:22:34 mudlark kernel:  [<c0169670>] alloc_vfsmnt+0x90/0xc7
Sep 10 17:22:35 mudlark kernel:  [<c01b1d45>] isofs_get_sb+0x2f/0x36
Sep 10 17:22:35 mudlark init: open(/dev/pts/0): No such file or directory
Sep 10 17:22:35 mudlark init: open(/dev/pts/0): No such file or directory
Sep 10 17:22:35 mudlark kernel:  [<c01b0a93>] isofs_fill_super+0x0/0x6bb
Sep 10 17:22:35 mudlark kernel:  [<c0155418>] do_kern_mount+0x57/0xd1
Sep 10 17:22:35 mudlark kernel:  [<c016a808>] do_new_mount+0x9c/0xe1
Sep 10 17:22:35 mudlark kernel:  [<c016aece>] do_mount+0x145/0x194
Sep 10 17:22:35 mudlark kernel:  [<c0139db1>] kmem_cache_alloc+0x60/0x86
Sep 10 17:22:35 mudlark kernel:  [<c016ad30>] copy_mount_options+0x63/0xbc
Sep 10 17:22:35 mudlark kernel:  [<c016b2ae>] sys_mount+0xb9/0x125
Sep 10 17:22:35 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 17:22:35 mudlark kernel: Code: e9 03 ff ff ff 89 7c 24 04 89 2c 24 e8 86 e4 ff ff 8b 54 24 30 89 10 8b 5d 38 e9 d2 fe ff ff 89 7c 24 04 89 2c 24 e8 0f e4 ff ff <81> 38 a5 c2 0f 17 74 7a c7 44 24 08 fc 18 39 c0 89 6c 24 04 c7 
Sep 10 17:22:35 mudlark kernel:  <7>ISO 9660 Extensions: Microsoft Joliet Level 3

--------------050503040804070406070907
Content-Type: text/plain;
 name="ksymoops.kfree.op.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.kfree.op.txt"

ksymoops 2.4.8 on i686 2.6.9-rc1-bk16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9-rc1-bk16/ (default)
     -m /boot/System.map-2.6.9-rc1-bk16 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Sep 10 17:22:29 mudlark kernel: Unable to handle kernel paging request at virtual address f2d8bef4
Sep 10 17:22:29 mudlark kernel: c013957f
Sep 10 17:22:29 mudlark kernel: *pde = 00507067
Sep 10 17:22:29 mudlark kernel: Oops: 0000 [#1]
Sep 10 17:22:29 mudlark kernel: CPU:    0
Sep 10 17:22:29 mudlark kernel: EIP:    0060:[<c013957f>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 10 17:22:30 mudlark kernel: EFLAGS: 00010082   (2.6.9-rc1-bk16) 
Sep 10 17:22:30 mudlark kernel: eax: f2d8bef4   ebx: 80052c00   ecx: f2d8bef8   edx: 00000ef8
Sep 10 17:22:32 mudlark kernel: esi: f2d3164c   edi: f2d8b000   ebp: c18ff680   esp: f2e95cfc
Sep 10 17:22:33 mudlark kernel: ds: 007b   es: 007b   ss: 0068
Sep 10 17:22:34 mudlark kernel: Stack: c18ff680 f2d8b000 00000000 00000246 32d8b000 c18ff680 c1903054 f2d8bef8 
Sep 10 17:22:34 mudlark kernel:        00000282 c013a185 c18ff680 f2d8bef8 c01b2a6d 00000000 f2d8bef8 f2d8bfe5 
Sep 10 17:22:34 mudlark kernel:        f2d8bef8 c01b2a6d f2d8bef8 00000041 00000800 f2fafec0 00000005 0000001f 
Sep 10 17:22:34 mudlark kernel: Call Trace:
Sep 10 17:22:34 mudlark kernel:  [<c013a185>] kfree+0x59/0x9b
Sep 10 17:22:34 mudlark kernel:  [<c01b2a6d>] parse_rock_ridge_inode_internal+0x1c9/0x654
Sep 10 17:22:34 mudlark kernel:  [<c01b2a6d>] parse_rock_ridge_inode_internal+0x1c9/0x654
Sep 10 17:22:34 mudlark kernel:  [<c01b3090>] parse_rock_ridge_inode+0x27/0x67
Sep 10 17:22:34 mudlark kernel:  [<c01b1ad6>] isofs_read_inode+0x283/0x3f7
Sep 10 17:22:34 mudlark kernel:  [<c01b1d0c>] isofs_iget+0x71/0x7b
Sep 10 17:22:34 mudlark kernel:  [<c01b1c4a>] isofs_iget5_test+0x0/0x3b
Sep 10 17:22:34 mudlark kernel:  [<c01b1c85>] isofs_iget5_set+0x0/0x16
Sep 10 17:22:34 mudlark kernel:  [<c01b0e83>] isofs_fill_super+0x3f0/0x6bb
Sep 10 17:22:34 mudlark kernel:  [<c0139db1>] kmem_cache_alloc+0x60/0x86
Sep 10 17:22:34 mudlark kernel:  [<c0155795>] sb_set_blocksize+0x2e/0x5d
Sep 10 17:22:34 mudlark kernel:  [<c01551f8>] get_sb_bdev+0x103/0x135
Sep 10 17:22:34 mudlark kernel:  [<c0169670>] alloc_vfsmnt+0x90/0xc7
Sep 10 17:22:35 mudlark kernel:  [<c01b1d45>] isofs_get_sb+0x2f/0x36
Sep 10 17:22:35 mudlark kernel:  [<c01b0a93>] isofs_fill_super+0x0/0x6bb
Sep 10 17:22:35 mudlark kernel:  [<c0155418>] do_kern_mount+0x57/0xd1
Sep 10 17:22:35 mudlark kernel:  [<c016a808>] do_new_mount+0x9c/0xe1
Sep 10 17:22:35 mudlark kernel:  [<c016aece>] do_mount+0x145/0x194
Sep 10 17:22:35 mudlark kernel:  [<c0139db1>] kmem_cache_alloc+0x60/0x86
Sep 10 17:22:35 mudlark kernel:  [<c016ad30>] copy_mount_options+0x63/0xbc
Sep 10 17:22:35 mudlark kernel:  [<c016b2ae>] sys_mount+0xb9/0x125
Sep 10 17:22:35 mudlark kernel:  [<c0103fad>] sysenter_past_esp+0x52/0x71
Sep 10 17:22:35 mudlark kernel: Code: e9 03 ff ff ff 89 7c 24 04 89 2c 24 e8 86 e4 ff ff 8b 54 24 30 89 10 8b 5d 38 e9 d2 fe ff ff 89 7c 24 04 89 2c 24 e8 0f e4 ff ff <81> 38 a5 c2 0f 17 74 7a c7 44 24 08 fc 18 39 c0 89 6c 24 04 c7 


>>EIP; c013957f <cache_free_debugcheck+207/2a3>   <=====

>>eax; f2d8bef4 <pg0+328b9ef4/3fb2c400>
>>ecx; f2d8bef8 <pg0+328b9ef8/3fb2c400>
>>esi; f2d3164c <pg0+3285f64c/3fb2c400>
>>edi; f2d8b000 <pg0+328b9000/3fb2c400>
>>ebp; c18ff680 <pg0+142d680/3fb2c400>
>>esp; f2e95cfc <pg0+329c3cfc/3fb2c400>

Trace; c013a185 <kfree+59/9b>
Trace; c01b2a6d <parse_rock_ridge_inode_internal+1c9/654>
Trace; c01b2a6d <parse_rock_ridge_inode_internal+1c9/654>
Trace; c01b3090 <parse_rock_ridge_inode+27/67>
Trace; c01b1ad6 <isofs_read_inode+283/3f7>
Trace; c01b1d0c <isofs_iget+71/7b>
Trace; c01b1c4a <isofs_iget5_test+0/3b>
Trace; c01b1c85 <isofs_iget5_set+0/16>
Trace; c01b0e83 <isofs_fill_super+3f0/6bb>
Trace; c0139db1 <kmem_cache_alloc+60/86>
Trace; c0155795 <sb_set_blocksize+2e/5d>
Trace; c01551f8 <get_sb_bdev+103/135>
Trace; c0169670 <alloc_vfsmnt+90/c7>
Trace; c01b1d45 <isofs_get_sb+2f/36>
Trace; c01b0a93 <isofs_fill_super+0/6bb>
Trace; c0155418 <do_kern_mount+57/d1>
Trace; c016a808 <do_new_mount+9c/e1>
Trace; c016aece <do_mount+145/194>
Trace; c0139db1 <kmem_cache_alloc+60/86>
Trace; c016ad30 <copy_mount_options+63/bc>
Trace; c016b2ae <sys_mount+b9/125>
Trace; c0103fad <sysenter_past_esp+52/71>

Code;  c0139554 <cache_free_debugcheck+1dc/2a3>
00000000 <_EIP>:
Code;  c0139554 <cache_free_debugcheck+1dc/2a3>
   0:   e9 03 ff ff ff            jmp    ffffff08 <_EIP+0xffffff08>
Code;  c0139559 <cache_free_debugcheck+1e1/2a3>
   5:   89 7c 24 04               mov    %edi,0x4(%esp)
Code;  c013955d <cache_free_debugcheck+1e5/2a3>
   9:   89 2c 24                  mov    %ebp,(%esp)
Code;  c0139560 <cache_free_debugcheck+1e8/2a3>
   c:   e8 86 e4 ff ff            call   ffffe497 <_EIP+0xffffe497>
Code;  c0139565 <cache_free_debugcheck+1ed/2a3>
  11:   8b 54 24 30               mov    0x30(%esp),%edx
Code;  c0139569 <cache_free_debugcheck+1f1/2a3>
  15:   89 10                     mov    %edx,(%eax)
Code;  c013956b <cache_free_debugcheck+1f3/2a3>
  17:   8b 5d 38                  mov    0x38(%ebp),%ebx
Code;  c013956e <cache_free_debugcheck+1f6/2a3>
  1a:   e9 d2 fe ff ff            jmp    fffffef1 <_EIP+0xfffffef1>
Code;  c0139573 <cache_free_debugcheck+1fb/2a3>
  1f:   89 7c 24 04               mov    %edi,0x4(%esp)
Code;  c0139577 <cache_free_debugcheck+1ff/2a3>
  23:   89 2c 24                  mov    %ebp,(%esp)
Code;  c013957a <cache_free_debugcheck+202/2a3>
  26:   e8 0f e4 ff ff            call   ffffe43a <_EIP+0xffffe43a>
Code;  c013957f <cache_free_debugcheck+207/2a3>   <=====
  2b:   81 38 a5 c2 0f 17         cmpl   $0x170fc2a5,(%eax)   <=====
Code;  c0139585 <cache_free_debugcheck+20d/2a3>
  31:   74 7a                     je     ad <_EIP+0xad>
Code;  c0139587 <cache_free_debugcheck+20f/2a3>
  33:   c7 44 24 08 fc 18 39      movl   $0xc03918fc,0x8(%esp)
Code;  c013958e <cache_free_debugcheck+216/2a3>
  3a:   c0 
Code;  c013958f <cache_free_debugcheck+217/2a3>
  3b:   89 6c 24 04               mov    %ebp,0x4(%esp)
Code;  c0139593 <cache_free_debugcheck+21b/2a3>
  3f:   c7                        .byte 0xc7


1 error issued.  Results may not be reliable.

--------------050503040804070406070907--

