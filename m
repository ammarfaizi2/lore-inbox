Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSEKWwN>; Sat, 11 May 2002 18:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315237AbSEKWwM>; Sat, 11 May 2002 18:52:12 -0400
Received: from p0067.as-l042.contactel.cz ([194.108.237.67]:7552 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S315213AbSEKWwK>;
	Sat, 11 May 2002 18:52:10 -0400
Date: Sun, 12 May 2002 00:52:20 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.5.14 fs oopses
Message-ID: <20020511225220.GD1499@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  2.5.14 kernel decided to commit suicide after I tried to remove 450MB
file streamer (using bttv) just created. Kernel is tainted due to
VMware's vmmon, but vmware (even X) was not started this time since
boot.

  fsck after reboot found just one unattached inode, still consuming
450MB (exactly 914600 sectors). And no, I do not remember doing
anything with '/41/' or '/14/'.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz


Linux version 2.5.14-amd (root@ppc) (gcc version 2.95.4 20011002 (Debian prerelease)) #4 Wed May 8 23:11:29 CEST 2002
...
255MB LOWMEM available.
...
CPU: AMD Athlon(tm) Processor stepping 02
...
Promise Technology, Inc. 20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x8800-0x8807, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0x8808-0x880f, BIOS settings: hdg:pio, hdh:pio
...
Unable to handle kernel paging request at virtual address 2f34312f
 printing eip:
c012aeef
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012aeef>]    Tainted: PF 
EFLAGS: 00010046
eax: c8d47000   ebx: c7f56000   ecx: c12472a0   edx: 2f34312b
esi: 00000033   edi: 00000042   ebp: 0011e818   esp: cb3bfe4c
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 2668, threadinfo=cb3be000 task=ca944c40)
Stack: c7f56c6c c1246104 c10f15e0 c7f56c6c 00000900 00000b28 00000246 c0137b60 
       c12472a0 c7f56c6c c013187c c7f56c6c 00000000 c7f56c6c c7f56c6c c0137ae0 
       c7f56c6c c1246104 c0137965 c7f56c6c c10f15e0 00001000 c7f56c6c c10f15e0 
Call Trace: [<c0137b60>] [<c013187c>] [<c0137ae0>] [<c0137965>] [<c01379f7>] 
   [<c01362c6>] [<c0136336>] [<c01257c7>] [<c01257e5>] [<c01259c6>] [<c0125b0c>] 
   [<c0146362>] [<c014466e>] [<c013eeb4>] [<c0106db7>] 

Code: 89 42 04 89 10 8b 4c 24 20 8b 41 08 89 58 04 89 03 83 c1 08 

Trace; c0137b60 <bh_mempool_free+10/20>
Trace; c013187c <mempool_free+4c/60>
Trace; c0137ae0 <free_buffer_head+20/30>
Trace; c0137965 <drop_buffers+85/e0>
Trace; c01379f7 <try_to_free_buffers+37/70>
Trace; c01362c6 <try_to_release_page+46/50>
Trace; c0136336 <block_flushpage+66/80>
Trace; c01257c7 <do_flushpage+27/30>
Trace; c01257e5 <truncate_complete_page+15/60>
Trace; c01259c6 <truncate_list_pages+196/200>
Trace; c0125b0c <truncate_inode_pages+9c/b0>
Trace; c0146362 <iput+a2/1a0>
Trace; c014466e <dput+ce/130>
Trace; c013eeb4 <sys_unlink+a4/110>
Trace; c0106db7 <syscall_call+7/b>

Code;  c012aeef <kmem_cache_free+1ff/230>
00000000 <_EIP>:
Code;  c012aeef <kmem_cache_free+1ff/230>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c012aef2 <kmem_cache_free+202/230>
   3:   89 10                     mov    %edx,(%eax)
Code;  c012aef4 <kmem_cache_free+204/230>
   5:   8b 4c 24 20               mov    0x20(%esp,1),%ecx
Code;  c012aef8 <kmem_cache_free+208/230>
   9:   8b 41 08                  mov    0x8(%ecx),%eax
Code;  c012aefb <kmem_cache_free+20b/230>
   c:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  c012aefe <kmem_cache_free+20e/230>
   f:   89 03                     mov    %eax,(%ebx)
Code;  c012af00 <kmem_cache_free+210/230>
  11:   83 c1 08                  add    $0x8,%ecx


