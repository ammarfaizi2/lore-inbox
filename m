Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316833AbSGLTvp>; Fri, 12 Jul 2002 15:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316826AbSGLTvh>; Fri, 12 Jul 2002 15:51:37 -0400
Received: from 200-206-134-238.dsl.telesp.net.br ([200.206.134.238]:26240 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S316825AbSGLTux>; Fri, 12 Jul 2002 15:50:53 -0400
Date: Fri, 12 Jul 2002 16:53:37 -0300
From: Christian Reis <kiko@async.com.br>
To: linux-kernel@vger.kernel.org
Subject: kswapd/reiserfs oopsen in 2.4.18-ac2
Message-ID: <20020712165337.A757@anthem.async.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

Anybody seen this happen with them? This is a moderately-loaded
Athlon1.4G with 512M and 512M swap, which serves NFS to around 20
workstations, and runs some sessions of Mozilla with X forwarded to some
clients. The tape drive was erasing at the moment of the crash, but I'm
not sure if it has to do with anything.

The box runs ReiserFS over software RAID1, and is currently on
2.4.18-ac2. I'm moving on to ac3 just in case, and will probably look at
2.4.19-rc immediately after if the problem isn't solved.

Looking through the logs, I am seeing a ReiserFS oops about 14 hours
earlier, which may or not be related. I haven't had an oops in over 2
years now :-/

Does the signature look familiar to anybody?

Jul 12 16:28:03 anthem kernel: Unable to handle kernel paging request at virtual address 5f796f72
Jul 12 16:28:03 anthem kernel:  printing eip:
Jul 12 16:28:03 anthem kernel: 5f796f72
Jul 12 16:28:03 anthem kernel: *pde = 00000000
Jul 12 16:28:03 anthem kernel: Oops: 0000
Jul 12 16:28:03 anthem kernel: CPU:    0
Jul 12 16:28:03 anthem kernel: EIP:    0010:[<5f796f72>]    Not tainted
Jul 12 16:28:03 anthem kernel: EFLAGS: 00010206
Jul 12 16:28:03 anthem kernel: eax: 5f796f72   ebx: c93f42c0   ecx: c93f42d0   edx: c93f42d0
Jul 12 16:28:03 anthem kernel: esi: 4003b0b8   edi: c1ab3040   ebp: 00002964   esp: c16b5f7c
Jul 12 16:28:03 anthem kernel: ds: 0018   es: 0018   ss: 0018
Jul 12 16:28:03 anthem kernel: Process kswapd (pid: 4, stackpage=c16b5000)
Jul 12 16:28:03 anthem kernel: Stack: c0143727 c93f42c0 c630e6d8 c630e6c0 c93f42c0 c0141766 c93f42c0 000001d0 
Jul 12 16:28:03 anthem kernel:        c02b0900 00000000 000003c6 c0141a4b 00003fae c0129938 00000006 000001d0 
Jul 12 16:28:03 anthem kernel:        000001d0 00000376 c02b0900 00000000 0008e000 c0129c1e 000001d0 00010f00 
Jul 12 16:28:03 anthem kernel: Call Trace: [iput+55/416] [prune_dcache+198/320] [shrink_dcache_memory+27/48] [do_try_to_free_pages+24/384] [kswapd+254/768] 
Jul 12 16:28:03 anthem kernel:    [rest_init+0/48] [kernel_thread+35/48] 
Jul 12 16:28:03 anthem kernel: 
Jul 12 16:28:03 anthem kernel: Code:  Bad EIP value.

And the reiserfs oops:

Jul 12 01:54:55 anthem kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000028
Jul 12 01:54:55 anthem kernel:  printing eip:
Jul 12 01:54:55 anthem kernel: c01431be
Jul 12 01:54:55 anthem kernel: *pde = 00000000
Jul 12 01:54:55 anthem kernel: Oops: 0000
Jul 12 01:54:55 anthem kernel: CPU:    0
Jul 12 01:54:55 anthem kernel: EIP:    0010:[find_inode+30/96]    Not tainted
Jul 12 01:54:55 anthem kernel: EFLAGS: 00010207
Jul 12 01:54:55 anthem kernel: eax: dff8ee00   ebx: 00000000   ecx: 0000000f   edx: 00001327
Jul 12 01:54:55 anthem kernel: esi: 00000000   edi: c018f500   ebp: dff8ee00   esp: ca845e28
Jul 12 01:54:55 anthem kernel: ds: 0018   es: 0018   ss: 0018
Jul 12 01:54:55 anthem kernel: Process tar (pid: 7902, stackpage=ca845000)
Jul 12 01:54:55 anthem kernel: Stack: ca845ea0 c018f500 00001327 df20e800 c01435f7 df20e800 00001327 dff8ee00 
Jul 12 01:54:55 anthem kernel:        c018f500 ca845e80 ca845ea0 ca845f04 ca845ee0 00000000 dff8ee00 c018f547 
Jul 12 01:54:55 anthem kernel:        df20e800 00001327 c018f500 ca845e80 ca845ea0 00000001 00001316 c018b307 
Jul 12 01:54:55 anthem kernel: Call Trace: [reiserfs_find_actor+0/32] [iget4+71/208] [reiserfs_find_actor+0/32] [reiserfs_iget+39/112] [reiserfs_find_actor+0/32] 
Jul 12 01:54:55 anthem kernel:    [reiserfs_lookup+151/224] [real_lookup+83/208] [link_path_walk+1224/1792] [path_walk+26/32] [__user_walk+53/80] [sys_newlstat+25/128] 
Jul 12 01:54:55 anthem kernel:    [sys_close+67/96] [system_call+47/52] 
Jul 12 01:54:55 anthem kernel: 
Jul 12 01:54:55 anthem kernel: Code: 39 53 28 75 24 8b 54 24 14 39 93 9c 00 00 00 75 18 85 ff 74 

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
