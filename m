Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274986AbTHLBxt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 21:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274990AbTHLBxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 21:53:48 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:40879 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S274986AbTHLBxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 21:53:30 -0400
Date: Mon, 11 Aug 2003 21:53:26 -0400
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test3-bk1 pppd oops
Message-ID: <20030812015326.GA25408@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.81 (Swaps)
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1061085207.0773e9@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got this oops trying to run pppd with ppp compile as modules and using devfs

Unable to handle kernel paging request at virtual address e0972f00
c015be76
*pde = 1e62f067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c015be76>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: de858cc0   ebx: e0972f00   ecx: 0000006c   edx: c6819f14
esi: 00000000   edi: 00006c00   ebp: de858cc0   esp: c6819ec8
ds: 007b   es: 007b   ss: 0068
Stack: c015fd60 dc680cc0 00000000 c015bd6f de858cc0 c023bac0 00006c00 de858cc0 
       00000000 c015bd50 000000ff 00000000 00000000 00000000 defdf380 c015bbf2 
       defe1c00 00006c00 c6819f14 00000000 defdf380 ffffffed d48ee180 defe4f00 
Call Trace:
 [<c015fd60>] do_lookup+0x30/0xb0
 [<c015bd6f>] exact_lock+0xf/0x20
 [<c023bac0>] kobj_lookup+0xe0/0x170
 [<c015bd50>] exact_match+0x0/0x10
 [<c015bbf2>] chrdev_open+0xe2/0x150
 [<c01a08b0>] devfs_open+0xb0/0xd0
 [<c01527a0>] dentry_open+0x110/0x1a0
 [<c0152688>] filp_open+0x68/0x70
 [<c0152a5b>] sys_open+0x5b/0x90
 [<c010b1bf>] syscall_call+0x7/0xb
Code: 83 3b 02 74 41 ff 83 00 01 00 00 89 04 24 e8 97 f4 06 00 85 


>>EIP; c015be76 <cdev_get+16/60>   <=====

>>eax; de858cc0 <__crc_blk_queue_free_tags+24d866/32ac60>
>>ebx; e0972f00 <__crc_xfrm_policy_list+1bf0c/57a7b>
>>edx; c6819f14 <__crc_class_unregister+3bc3a/8ae451>
>>ebp; de858cc0 <__crc_blk_queue_free_tags+24d866/32ac60>
>>esp; c6819ec8 <__crc_class_unregister+3bbee/8ae451>

Trace; c015fd60 <do_lookup+30/b0>
Trace; c015bd6f <exact_lock+f/20>
Trace; c023bac0 <kobj_lookup+e0/170>
Trace; c015bd50 <exact_match+0/10>
Trace; c015bbf2 <chrdev_open+e2/150>
Trace; c01a08b0 <devfs_open+b0/d0>
Trace; c01527a0 <dentry_open+110/1a0>
Trace; c0152688 <filp_open+68/70>
Trace; c0152a5b <sys_open+5b/90>
Trace; c010b1bf <syscall_call+7/b>

Code;  c015be76 <cdev_get+16/60>
00000000 <_EIP>:
Code;  c015be76 <cdev_get+16/60>   <=====
   0:   83 3b 02                  cmpl   $0x2,(%ebx)   <=====
Code;  c015be79 <cdev_get+19/60>
   3:   74 41                     je     46 <_EIP+0x46>
Code;  c015be7b <cdev_get+1b/60>
   5:   ff 83 00 01 00 00         incl   0x100(%ebx)
Code;  c015be81 <cdev_get+21/60>
   b:   89 04 24                  mov    %eax,(%esp,1)
Code;  c015be84 <cdev_get+24/60>
   e:   e8 97 f4 06 00            call   6f4aa <_EIP+0x6f4aa>
Code;  c015be89 <cdev_get+29/60>
  13:   85 00                     test   %eax,(%eax)

-- 
  Matthew Harrell                          If at first you don't succeed,
  Bit Twiddlers, Inc.                       try management.
  mharrell@bittwiddlers.com     
