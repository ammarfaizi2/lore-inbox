Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbSK1Err>; Wed, 27 Nov 2002 23:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbSK1Err>; Wed, 27 Nov 2002 23:47:47 -0500
Received: from mail.michigannet.com ([208.49.116.30]:19722 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S265174AbSK1Erq>; Wed, 27 Nov 2002 23:47:46 -0500
Date: Wed, 27 Nov 2002 23:55:02 -0500
From: Paul <set@pobox.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [oops] BUG at mm/highmem.c:455 Re: Linux v2.5.50
Message-ID: <20021128045502.GL1432@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com>, on Wed Nov 27, 2002 [03:07:38 PM] said:
> 
> Taking a small thanksgiving break, but before that here's 2.5.50.
> 

	Hi;

	This looks pretty much like the oops I posted against the
-mcp kernel, but this is the first time I have gotten a vanilla
2.5 kernel to compile/boot for my LVM test box. (It still wont
mount root if I have devfs in there.)
	I dont have highmen on.
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
	This is reproducible by simply moving an fs with tar.
Also, this time I got copious messages after the oops, which
may help someone. I can provide more info and test things if
anyone wants me to. (Jens seemed interested at one point, but
I think he forgot about me:)

Paul
set@pobox.com

[here is only a tiny snip of endless streams of this, after the
oops]

Nov 27 23:24:48 gentoo kernel:  __end_that: dev hdc: flags = REQ_RW REQ_CMD REQ_STARTED 
Nov 27 23:24:48 gentoo kernel: sector 1608403, nr/cnr 2/0
Nov 27 23:24:48 gentoo kernel: bio c7fa3720, biotail c7fa3720, buffer c6f5c000, data 00000000, len 0
Nov 27 23:24:48 gentoo kernel: __end_that_request_first: bio idx 0 >= vcnt 0
Nov 27 23:24:48 gentoo kernel: __end_that: dev hdc: flags = REQ_RW REQ_CMD REQ_STARTED 
Nov 27 23:24:48 gentoo kernel: sector 1608403, nr/cnr 2/0
Nov 27 23:24:48 gentoo kernel: bio c7fa3720, biotail c7fa3720, buffer c6f5c000, data 00000000, len 0

[ and the oops, decoded on another machine ]

ksymoops 2.4.7 on i686 2.4.20-rc2.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

Nov 27 23:24:43 gentoo kernel: kernel BUG at mm/highmem.c:455!
Nov 27 23:24:43 gentoo kernel: invalid operand: 0000
Nov 27 23:24:43 gentoo kernel: CPU:    0
Nov 27 23:24:43 gentoo kernel: EIP:    0060:[blk_queue_bounce+18/112]    Not tainted
Nov 27 23:24:43 gentoo kernel: EIP:    0060:[<c0130ee2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 27 23:24:43 gentoo kernel: EFLAGS: 00010202
Nov 27 23:24:43 gentoo kernel: eax: c7fa3860   ebx: c03d56f8   ecx: c11a3c7c   edx: 00000001
Nov 27 23:24:43 gentoo kernel: esi: 00000002   edi: 00000400   ebp: c03d56f8   esp: c11a3c3c
Nov 27 23:24:43 gentoo kernel: ds: 0068   es: 0068   ss: 0068
Nov 27 23:24:43 gentoo kernel: Stack: c7ee72e0 c02250de c03d56f8 c11a3c7c c7ee72e0 00000002 c03d56f8 c7fa3860 
Nov 27 23:24:43 gentoo kernel:        00188ad5 c11a1860 00000004 00000001 00000000 c013bad1 c02255c1 c03d56f8 
Nov 27 23:24:43 gentoo kernel:        c7fa3860 c7e5df10 c7fa3860 c7fa3860 c881e020 c0262d75 c7fa3860 00000002 
Nov 27 23:24:43 gentoo kernel: Call Trace: [<c02250de>]  [<c013bad1>]  [<c02255c1>]  [<c0262d75>]  [<c0262f3a>]  [<c0262fe9>]  [<c02630f0>]  [<c02255c1>]  [<c0225626>]  [<c01512b2>]  [<c0151b77>]  [<c0225626>]  [<c0151e3d>]  [<c017750c>]  [<c01784a6>]  [<c0178788>]  [<c0177996>]  [<c017750c>]  [<c01327f4>]  [<c0150a6a>]  [<c0150bd1>]  [<c0150d63>]  [<c0150e38>]  [<c013270b>]  [<c01321f0>]  [<c0132298>]  [<c01322a3>]  [<c013266c>]  [<c0108925>] 
Nov 27 23:24:43 gentoo kernel: Code: 0f 0b c7 01 57 af 2e c0 8d b6 00 00 00 00 f6 83 9c 00 00 00 


>>EIP; c0130ee2 <blk_queue_bounce+12/70>   <=====

>>ebx; c03d56f8 <ide_hwifs+818/4998>
>>ebp; c03d56f8 <ide_hwifs+818/4998>

Trace; c02250de <__make_request+4a/3ec>
Trace; c013bad1 <bio_alloc+31/1cc>
Trace; c02255c1 <generic_make_request+141/154>
Trace; c0262d75 <__map_bio+3d/dc>
Trace; c0262f3a <__clone_and_map+72/b4>
Trace; c0262fe9 <__split_bio+6d/100>
Trace; c02630f0 <dm_request+74/8c>
Trace; c02255c1 <generic_make_request+141/154>
Trace; c0225626 <submit_bio+52/5c>
Trace; c01512b2 <mpage_bio_submit+22/28>
Trace; c0151b77 <mpage_writepage+41f/4b4>
Trace; c0225626 <submit_bio+52/5c>
Trace; c0151e3d <mpage_writepages+231/324>
Trace; c017750c <ext2_get_block+0/36c>
Trace; c01784a6 <ext2_update_inode+3e/330>
Trace; c0178788 <ext2_update_inode+320/330>
Trace; c0177996 <ext2_writepages+12/18>
Trace; c017750c <ext2_get_block+0/36c>
Trace; c01327f4 <do_writepages+18/2c>
Trace; c0150a6a <__sync_single_inode+6e/164>
Trace; c0150bd1 <__writeback_single_inode+71/78>
Trace; c0150d63 <sync_sb_inodes+18b/214>
Trace; c0150e38 <writeback_inodes+4c/90>
Trace; c013270b <wb_kupdate+9f/fc>
Trace; c01321f0 <__pdflush+150/1f8>
Trace; c0132298 <pdflush+0/14>
Trace; c01322a3 <pdflush+b/14>
Trace; c013266c <wb_kupdate+0/fc>
Trace; c0108925 <kernel_thread_helper+5/c>

Code;  c0130ee2 <blk_queue_bounce+12/70>
00000000 <_EIP>:
Code;  c0130ee2 <blk_queue_bounce+12/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0130ee4 <blk_queue_bounce+14/70>
   2:   c7 01 57 af 2e c0         movl   $0xc02eaf57,(%ecx)
Code;  c0130eea <blk_queue_bounce+1a/70>
   8:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c0130ef0 <blk_queue_bounce+20/70>
   e:   f6 83 9c 00 00 00 00      testb  $0x0,0x9c(%ebx)

