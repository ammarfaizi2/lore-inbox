Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283723AbRLRDWA>; Mon, 17 Dec 2001 22:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283733AbRLRDVv>; Mon, 17 Dec 2001 22:21:51 -0500
Received: from [213.97.199.90] ([213.97.199.90]:3200 "HELO fargo")
	by vger.kernel.org with SMTP id <S283723AbRLRDVm> convert rfc822-to-8bit;
	Mon, 17 Dec 2001 22:21:42 -0500
From: "David =?ISO-8859-1?Q?G=F3mez" ?= <davidge@jazzfree.com>
Date: Tue, 18 Dec 2001 04:20:56 +0100 (CET)
X-X-Sender: <huma@fargo>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: David Gomez <davidge@jazzfree.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Loopback deadlock again
In-Reply-To: <Pine.LNX.4.21.0112171904030.3720-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0112180410220.421-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Dec 2001, Marcelo Tosatti wrote:
>
> Get the backtrace of the loopback thread (using magic sysrq) and use
> ksymoops to decode it using the System.map of your running kernel...
>
> Thanks

Dec 17 22:05:09 fargo kernel: loop0         D C19190A4     0   375      1                 358 (L-TLB)
Dec 17 22:05:09 fargo kernel: Call Trace: [__wait_on_buffer+104/144] [__block_prepare_write+601/608] [__alloc_pages+65/384] [block_commit_write+1/48] [ext2_get_block+64/1040]
Dec 17 22:05:09 fargo kernel: Call Trace: [<c01304f8>] [<c0131d69>] [<c012ac61>] [<c0132271>] [<c014e260>]
Dec 17 22:05:09 fargo kernel:    [<e08522df>] [ext2_get_block+64/1040] [do_IRQ+104/176] [<e0852574>] [<e0852aa0>] [<e08529d0>]
Dec 17 22:05:09 fargo kernel:    [<e08522df>] [<c014e260>] [<c0108188>] [<e0852574>] [<e0852aa0>] [<e08529d0>]
Dec 17 22:05:09 fargo kernel:    [kernel_thread+38/48] [<e08529d0>]
Dec 17 22:05:09 fargo kernel:    [<c0105516>] [<e08529d0>]
Dec 17 22:05:09 fargo kernel: cp            D CFC53C8C  4780   376    368                     (NOTLB)
Dec 17 22:05:09 fargo kernel: Call Trace: [__wait_on_buffer+104/144] [getblk+24/64] [bread+114/128] [load_inode_bitmap+18/368] [ext2_free_inode+8/368]
Dec 17 22:05:09 fargo kernel: Call Trace: [<c01304f8>] [<c01312c8>] [<c0131532>] [<c014d462>] [<c014d5c8>]
Dec 17 22:05:09 fargo kernel:    [ext2_new_inode+245/912] [ext2_set_link+40/192] [ext2_mkdir+127/272] [sys_mkdir+11/208] [sys_mkdir+196/208] [system_call+51/56]
Dec 17 22:05:10 fargo kernel:    [<c014d9c5>] [<c014cdb8>] [<c014fb0f>] [<c013931b>] [<c01393d4>] [<c0106cfb>]

ksymoops 2.4.1 on i686 2.4.17-rc1loopdeadlock.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-rc1loopdeadlock/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (compare_maps): mismatch on symbol journal_enable_debug  , jbd says e082d424, /lib/modules/2.4.17-rc1loopdeadlock/kernel/fs/jbd/jbd.o says e082d410.  Ignoring /lib/modules/2.4.17-rc1loopdeadlock/kernel/fs/jbd/jbd.o entry
Dec 17 22:05:09 fargo kernel: Call Trace: [__wait_on_buffer+104/144] [__block_prepare_write+601/608] [__alloc_pages+65/384] [block_commit_write+1/48] [ext2_get_block+64/1040]
Dec 17 22:05:09 fargo kernel: Call Trace: [<c01304f8>] [<c0131d69>] [<c012ac61>] [<c0132271>] [<c014e260>]
Dec 17 22:05:09 fargo kernel:    [<e08522df>] [ext2_get_block+64/1040] [do_IRQ+104/176] [<e0852574>] [<e0852aa0>] [<e08529d0>]
Dec 17 22:05:09 fargo kernel:    [<e08522df>] [<c014e260>] [<c0108188>] [<e0852574>] [<e0852aa0>] [<e08529d0>]
Dec 17 22:05:09 fargo kernel:    [<c0105516>] [<e08529d0>]
Dec 17 22:05:09 fargo kernel: Call Trace: [__wait_on_buffer+104/144] [getblk+24/64] [bread+114/128] [load_inode_bitmap+18/368] [ext2_free_inode+8/368]
Dec 17 22:05:09 fargo kernel: Call Trace: [<c01304f8>] [<c01312c8>] [<c0131532>] [<c014d462>] [<c014d5c8>]
Dec 17 22:05:10 fargo kernel:    [<c014d9c5>] [<c014cdb8>] [<c014fb0f>] [<c013931b>] [<c01393d4>] [<c0106cfb>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c01304f8 <__wait_on_buffer+68/90>
Trace; c0131d69 <__block_prepare_write+239/260>
Trace; c012ac61 <__alloc_pages+41/180>
Trace; c0132271 <block_prepare_write+21/40>
Trace; c014e260 <ext2_get_block+0/410>
Trace; e08522df <[loop]lo_send+df/1e0>
Trace; e08522df <[loop]lo_send+df/1e0>
Trace; c014e260 <ext2_get_block+0/410>
Trace; c0108188 <do_IRQ+68/b0>
Trace; e0852574 <[loop]do_bh_filebacked+54/90>
Trace; e0852aa0 <[loop]loop_thread+d0/1e0>
Trace; e08529d0 <[loop]loop_thread+0/1e0>
Trace; c0105516 <kernel_thread+26/30>
Trace; e08529d0 <[loop]loop_thread+0/1e0>
Trace; c01304f8 <__wait_on_buffer+68/90>
Trace; c01312c8 <getblk+18/40>
Trace; c0131532 <bread+52/80>
Trace; c014d462 <read_inode_bitmap+32/60>
Trace; c014d5c8 <load_inode_bitmap+138/170>
Trace; c014d9c5 <ext2_new_inode+b5/390>
Trace; c014cdb8 <ext2_inode_by_name+18/30>
Trace; c014fb0f <ext2_mkdir+3f/110>
Trace; c013931b <vfs_mkdir+6b/a0>
Trace; c01393d4 <sys_mkdir+84/d0>
Trace; c0106cfb <system_call+33/38>


2 warnings issued.  Results may not be reliable.





David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra



