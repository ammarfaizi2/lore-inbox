Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSLFWL4>; Fri, 6 Dec 2002 17:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbSLFWL4>; Fri, 6 Dec 2002 17:11:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:54709 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262807AbSLFWLx>;
	Fri, 6 Dec 2002 17:11:53 -0500
Subject: Re: [OOPS] Problem Booting 2.5.50 / ext3_reserve_inode_write
From: Andy Pfiffer <andyp@osdl.org>
To: Alex Goddard <agoddard@purdue.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211291336040.1182-100000@dust.ebiz-gw.wintek.com>
References: <Pine.LNX.4.44.0211291336040.1182-100000@dust.ebiz-gw.wintek.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 06 Dec 2002 14:19:34 -0800
Message-Id: <1039213174.29939.9.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-29 at 06:11, Alex Goddard wrote:
> 2.5.45-49 worked fine.  Here's the output, I can provide .config and 
> anything else at request.
> 
> Oops: 0000
> CPU: 0
> EIP: 0060:[<c017c04d>]   Not Tainted
> EFLAGS: 00010202
> EIP: is at ext3_get_inode_loc+0x2d/0x1a0
> eax: e7237610  ebx: 00000000  ecx: 00000000  edx: 5a5a5a5a
> esi: 5a5a5a5a  edi: e721dec0  edp: e721de78  esp: e721de4c
> ds: 0068  es: 0068  ss: 0068
> Process mount (pid: 248, threadinfo=e721c000, task=e7708700)
> Stack: 
> 
>   e7f9c9a4 e7237590 e7c65c80 e7dcde00 e7f9c9a4 e7234594 e7249e84 00000296
>   00000000 e75c2584 e7249ec0 e7249eac c017cd4a e7234610 e7249ec0 c01823bd
>   e7f9c9a4 e7237594 e7249ea8 c015ace6 e7234610 e7249ec0 e75c2584 e7234610
> 
> Call Trace:
> 	[<c017cd4a>] ext3_reserve_inode_write+0x2a/0xe0
> 	[<c01823bd>] ext3_destroy_inode+0x1d/0x20
> 	[<c015ace6>] destory_inode+0x36/0x50
> 	[<c017ce28>] ext3_mark_inode_dirty+0x28/0x50
> 	[<c017fe12>] ext3_add_nondir+0x52/0x60
> 	[<c0151601>] vfs_create+0x61/0xb0
> 	[<c0151b63>] open_namei+0x363/0x3c0
> 	[<c0142fe1>] filp_open+0x41/0x70
> 	[<c0143413>] sys_open+0x53/0x90
> 	[<c010940b>] sys_call+0x7/0xb
> 
> Code: 8b 86 24 01 00 00 3b 50 50 72 0d 8b 9e 24 01 00 00 8b 43 2c
> 
> I can't tell if this affects performance or anything one way or another
> because my machine dies after the above oops, but I also get another trace
> earlier in the boot, during the initialization of my framebuffer console:

Alex,

Did you get any response on this OOPS?  I can't find any, and I'm
curious because it is happening on one of my systems during bootup as
well.

I thought I might have some lingering ext3 bogons stuck on my disk from
a few kernel revs ago, but the problem still occurs.

Here's a portion of mine:

Checking file systems...
fsck 1.26 (3-Feb-2002)
/dev/sda5: clean, 16968/66264 files, 104885/265041 blocks
/dev/sda1: clean, 57/10040 files, 24384/40131 blocks
/dev/sdb1: clean, 11/2223872 files, 78008/4441964 blocks
/dev/sda10: clean, 548636/1198208 files, 2144477/2393677 blocks
/dev/sda9: clean, 51895/263296 files, 310582/526120 blocks
/dev/sda8: clean, 140195/525888 files, 590977/1050241 blocks
/dev/sda7: clean, EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,5), internal
journal
2748/131616 files, 111429/263056 blocks                             
done     
at virtual address 5a5a5b9e to handle kernel paging requestes/2.5.50
 printing eip:             
c0186ebe      
*pde = 00000000
Oops: 0000     
CPU:    0 
EIP:    0060:[<c0186ebe>]    Not tainted
EFLAGS: 00010202                        
EIP is at ext3_get_inode_loc+0x1e/0x140
eax: 5a5a5a5a   ebx: 00000000   ecx: 5a5a5a5a   edx: e7dc7810
esi: e76d3eec   edi: e7643edc   ebp: e74de320   esp: e7643e80
ds: 0068   es: 0068   ss: 0068                               
Process mount (pid: 76, threadinfo=e7642000 task=e76c3300)
Stack: 00000000 e76d3eec e7643edc e74de320 e76d3eec c0187ac0 e74de320
e7643edc 
       e7643edc e74de320 e76d3eec e76d3eec e74de320 e74de320 c01675d0
e74de320 
       c0187b6a e76d3eec e74de320 e7643edc e74de320 ffffffef 00000000
c018a6d9 
Call
Trace:                                                                    
 [<c0187ac0>] ext3_reserve_inode_write+0x20/0xb0
 [<c01675d0>] generic_delete_inode+0xdc/0xe4    
 [<c0187b6a>] ext3_mark_inode_dirty+0x1a/0x34
 [<c018a6d9>] ext3_add_nondir+0x3d/0x48      
 [<c018a8d9>] ext3_create+0x1f5/0x29c  
 [<c015ba3b>] vfs_create+0x67/0x8c   
 [<c015bd3f>] open_namei+0x167/0x4b0
 [<c014c0eb>] filp_open+0x3b/0x5c   
 [<c014c5bb>] sys_open+0x37/0x70 
 [<c0108f5b>] syscall_call+0x7/0xb
                                  
Code: 8b 90 44 01 00 00 89 cb 89 c6 3b 5a 50 72 1e 8b 54 24 18 8b 
failed                                                              
Mounting local file systems...
/etc/init.d/boot.d/S05boot.localfs: line 179:    76 Segmentation fault


Andy



