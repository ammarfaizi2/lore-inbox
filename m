Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSEWR64>; Thu, 23 May 2002 13:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316972AbSEWR64>; Thu, 23 May 2002 13:58:56 -0400
Received: from grisu.bik-gmbh.de ([194.233.237.82]:36878 "EHLO
	grisu.bik-gmbh.de") by vger.kernel.org with ESMTP
	id <S316971AbSEWR6z>; Thu, 23 May 2002 13:58:55 -0400
Date: Thu, 23 May 2002 19:59:27 +0200
To: linux-kernel@vger.kernel.org
Subject: [2.4.28/smbfs] Unable to handle kernel paging request
Message-ID: <20020523175927.GA16387@bik-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Florian Hars <hars@bik-gmbh.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I access a certain directory on a smb share that resides on a
NT4.0 server (using for example du or ls -l, but not ls), the
accessing process segfaults and the kernel says somthing like:

May 23 17:34:36 counter kernel: Unable to handle kernel paging request at virtual address d0000000
May 23 17:34:36 counter kernel:  printing eip:
May 23 17:34:36 counter kernel: d0909a00
May 23 17:34:36 counter kernel: *pde = 00000000
May 23 17:34:36 counter kernel: Oops: 0000
May 23 17:34:36 counter kernel: CPU:    0
May 23 17:34:36 counter kernel: EIP:    0010:[<d0909a00>]    Not tainted
May 23 17:34:36 counter kernel: EFLAGS: 00010282
May 23 17:34:36 counter kernel: eax: 4aa2314d   ebx: d0000000   ecx: f6a1e3fd   edx: a886d6a9
May 23 17:34:36 counter kernel: esi: 3dcb3943   edi: caff9e30   ebp: caff9ec8   esp: caff9de0
May 23 17:34:36 counter kernel: ds: 0018   es: 0018   ss: 0018
May 23 17:34:36 counter kernel: Process du (pid: 23269, stackpage=caff9000)
May 23 17:34:36 counter kernel: Stack: c0144220 caff9e98 d0917180 00000000 00000000 00000000 00000000 ce84a6c0 
May 23 17:34:36 counter kernel:        cd250d20 00000000 08bd26bc cfc5b8a0 00000000 00000000 c5c48000 00000002 
May 23 17:34:36 counter kernel:        00000000 00000000 00000001 00000004 d0908235 c0b471a0 caff9fb0 c0144220 
May 23 17:34:36 counter kernel: Call Trace: [filldir64+0/276] [<d0908235>] [filldir64+0/276] [filldir64+0/276] [find_or_crea
te_page+227/252] 
May 23 17:34:36 counter kernel:    [<d09082c2>] [filldir64+0/276] [<d0909183>] [filldir64+0/276] [vfs_readdir+148/220] [fill
dir64+0/276] 
May 23 17:34:36 counter kernel:    [sys_getdents64+79/179] [filldir64+0/276] [sys_fcntl64+127/136] [system_call+51/56] 
May 23 17:34:36 counter kernel: 
May 23 17:34:36 counter kernel: Code: 0f b6 03 43 89 c2 c1 e2 04 01 f2 c1 e8 04 01 c2 8d 04 92 8d

This is reproducible, although some of the numbers change.

After that, any process that tried to access the mountpoint of the
samba share froze in state D, and it was impossible to unmount the
share.

The kernel id based on the debian kernel source, calls itself
"2.4.18-xfs-1.1 #1 SMP" and has evms, although that should not be
involved in this problem.

I can access that directory from another computer running 2.4.18-pre9
without xfs, evms and SMP.

I didn't do anything strange with the vm on either machine.

Yours, Florian Hars.
