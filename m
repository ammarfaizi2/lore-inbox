Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTGTFcv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 01:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTGTFcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 01:32:51 -0400
Received: from mcp.34sp.com ([212.187.158.4]:46598 "HELO mcp.34sp.com")
	by vger.kernel.org with SMTP id S262273AbTGTFcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 01:32:46 -0400
From: Michael Morris <Starborn@anime-city.co.uk>
Organization: Anime-City
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm2
Date: Sun, 20 Jul 2003 06:47:43 +0100
User-Agent: KMail/1.5.2
References: <20030719174350.7dd8ad59.akpm@osdl.org> <20030720024102.GA18576@triplehelix.org> <20030720042918.GA19219@triplehelix.org>
In-Reply-To: <20030720042918.GA19219@triplehelix.org>
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307200647.43410.Starborn@anime-city.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 July 2003 5:29 am, Joshua Kwan wrote:
> On Sat, Jul 19, 2003 at 07:41:02PM -0700, Joshua Kwan wrote:
> > 2.6.0-test1-mm2 requires attached patch to build with software suspend.
>
> That and it just spilled its guts all over me.
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000014 printing eip:
> c0194e8f
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c0194e8f>]    Not tainted VLI
> EFLAGS: 00210202
> EIP is at journal_dirty_metadata+0x41/0x207
> eax: c0a6e000   ebx: cf4b3e00   ecx: 00000000   edx: cf96ef60
> esi: 00000000   edi: cf732e80   ebp: cf96a910   esp: c0a6fe78
> ds: 007b   es: 007b   ss: 0068
> Process cvs (pid: 8960, threadinfo=c0a6e000 task=c7d01940)
> Stack: c1373600 cf85bb90 c0152a7a c0151389 cf96ef60 cf96ef60 cf96a910
> 00000001 cf85bb90 c0186674 cf96a910 cf96ef60 00001000 c0a6febc 00000001
> 00000001 00000000 00000030 00000000 00000000 0000001a 000e0224 cf955ed0
> 00004000 Call Trace:
>  [<c0152a7a>] __getblk+0x2b/0x51
>  [<c0151389>] wake_up_buffer+0xf/0x26
>  [<c0186674>] ext3_getblk+0xdb/0x284
>  [<c0186850>] ext3_bread+0x33/0xb6
>  [<c018c17c>] ext3_mkdir+0xd1/0x2c6
>  [<c018c0ab>] ext3_mkdir+0x0/0x2c6
>  [<c015f01c>] vfs_mkdir+0x6a/0xbc
>  [<c015f125>] sys_mkdir+0xb7/0xf6
>  [<c014558f>] sys_munmap+0x44/0x64
>  [<c0109167>] syscall_call+0x7/0xb
>
> Code: 28 8b 54 24 2c 8b 5d 00 f6 45 18 04 8b 72 24 8b 3b 0f 85 d8 00 00
> 00 f6 07 02 0f 85 cf 00 00 00 b8 00 e0 ff ff 21 e0 83 40 14 01 <8b> 46
> 14 3b 45 00 0f 84 6e 01 00 00 b8 00 e0 ff ff 21 e0 83 40
>  <6>note: cvs[8960] exited with preempt_count 1
> bad: scheduling while atomic!
> Call Trace:
>  [<c011a503>] schedule+0x3f6/0x3fb
>  [<c0141b8c>] unmap_page_range+0x43/0x69
>  [<c0141d63>] unmap_vmas+0x1b1/0x209
>  [<c0145874>] exit_mmap+0x7c/0x190
>  [<c011bec4>] mmput+0x7b/0xe4
>  [<c011f9ec>] do_exit+0x120/0x3f8
>  [<c01188e4>] do_page_fault+0x0/0x459
>  [<c0109a06>] do_divide_error+0x0/0xfa
>  [<c0118a10>] do_page_fault+0x12c/0x459
>  [<c0189275>] ext3_mark_iloc_dirty+0x28/0x35
>  [<c01893aa>] ext3_mark_inode_dirty+0x4f/0x51
>  [<c0186087>] ext3_splice_branch+0x123/0x1da
>  [<c0152935>] bh_lru_install+0xaf/0xeb
>  [<c01188e4>] do_page_fault+0x0/0x459
>  [<c0109391>] error_code+0x2d/0x38
>  [<c015007b>] vfs_read+0xef/0x119
>  [<c0194e8f>] journal_dirty_metadata+0x41/0x207
>  [<c0152a7a>] __getblk+0x2b/0x51
>  [<c0151389>] wake_up_buffer+0xf/0x26
>  [<c0186674>] ext3_getblk+0xdb/0x284
>  [<c0186850>] ext3_bread+0x33/0xb6
>  [<c018c17c>] ext3_mkdir+0xd1/0x2c6
>  [<c018c0ab>] ext3_mkdir+0x0/0x2c6
>  [<c015f01c>] vfs_mkdir+0x6a/0xbc
>  [<c015f125>] sys_mkdir+0xb7/0xf6
>  [<c014558f>] sys_munmap+0x44/0x64
>  [<c0109167>] syscall_call+0x7/0xb
>
> Any ideas?
>
> -Josh

Have hit this a few times already in -mm2. Always happens under reasonably 
heavy disk load on an ext3 mount. I've gone back to -mm1 since just about all 
compile jobs fail on this kernel. 

Here's my oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c019d4c8
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c019d4c8>]    Not tainted VLI
EFLAGS: 00010202
EIP is at journal_dirty_metadata+0x38/0x210
eax: d469e000   ebx: 00000000   ecx: 00000000   edx: d53ffb68
esi: db387440   edi: c16cb9c0   ebp: d6b503e4   esp: d469fe64
ds: 007b   es: 007b   ss: 0068
Process mkdir (pid: 20706, threadinfo=d469e000 task=d5376650)
Stack: c01560a7 c17d3740 001b91a6 c01546df d53ffb68 d53ffb68 d6b503e4 00000001
       d34ad248 c018ef57 d6b503e4 d53ffb68 00000000 00001000 d469feac 00000001
       00000001 00000000 00000030 c018d603 dda75890 d34ad248 001b91a6 00000000
Call Trace:
 [<c01560a7>] __getblk+0x37/0x70
 [<c01546df>] wake_up_buffer+0xf/0x30
 [<c018ef57>] ext3_getblk+0x127/0x2c0
 [<c018d603>] ext3_new_inode+0x1b3/0x700
 [<c018f123>] ext3_bread+0x33/0xc0
 [<c0194fd6>] ext3_mkdir+0x106/0x2e0
 [<c0194ed0>] ext3_mkdir+0x0/0x2e0
 [<c01635fa>] vfs_mkdir+0x6a/0xc0
 [<c0163716>] sys_mkdir+0xc6/0x100
 [<c0146612>] sys_brk+0x112/0x120
 [<c010ac6b>] syscall_call+0x7/0xb

Code: 24 2c f6 45 18 04 8b 75 00 8b 5a 28 8b 3e 0f 84 df 01 00 00 b8 01 00 00 
00 85 c0 0f 85 d1 00 00 00 b8 00 e0 ff ff 21 e0 ff 40 14 <8b> 43 14 3b 45 00 
0f 84 6c 01 00 00 b8 00 e0 ff ff 21 e0 ff 40
 <6>note: mkdir[20706] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011b286>] schedule+0x3f6/0x400
 [<c0143ef3>] unmap_page_range+0x43/0x70
 [<c01440e0>] unmap_vmas+0x1c0/0x220
 [<c0147ecb>] exit_mmap+0x7b/0x190
 [<c011ce3a>] mmput+0x7a/0xf0
 [<c0120c2b>] do_exit+0x12b/0x3d0
 [<c010b4bc>] die+0xfc/0x100
 [<c011967a>] do_page_fault+0x14a/0x453
 [<c0191dd8>] ext3_mark_iloc_dirty+0x28/0x40
 [<c0191f20>] ext3_mark_inode_dirty+0x50/0x60
 [<c018e8af>] ext3_splice_branch+0x11f/0x1e0
 [<c0155f29>] bh_lru_install+0xa9/0xe0
 [<c0119530>] do_page_fault+0x0/0x453
 [<c010ae15>] error_code+0x2d/0x38
 [<c019d4c8>] journal_dirty_metadata+0x38/0x210
 [<c01560a7>] __getblk+0x37/0x70
 [<c01546df>] wake_up_buffer+0xf/0x30
 [<c018ef57>] ext3_getblk+0x127/0x2c0
 [<c018d603>] ext3_new_inode+0x1b3/0x700
 [<c018f123>] ext3_bread+0x33/0xc0
 [<c0194fd6>] ext3_mkdir+0x106/0x2e0
 [<c0194ed0>] ext3_mkdir+0x0/0x2e0
 [<c01635fa>] vfs_mkdir+0x6a/0xc0
 [<c0163716>] sys_mkdir+0xc6/0x100
 [<c0146612>] sys_brk+0x112/0x120
 [<c010ac6b>] syscall_call+0x7/0xb

