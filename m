Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbTBKUwJ>; Tue, 11 Feb 2003 15:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTBKUwJ>; Tue, 11 Feb 2003 15:52:09 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:57220 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266091AbTBKUwI>;
	Tue, 11 Feb 2003 15:52:08 -0500
Date: Tue, 11 Feb 2003 20:57:10 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: shaggy@austin.ibm.com
Subject: jfs breakage in 2.5.60
Message-ID: <20030211205710.GA3304@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>, shaggy@austin.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running fsx & fsstress in parallel gets a load of oopsen in the
logs, here's the first one..

		Dave

Feb 12 04:30:16 mesh kernel: BUG at fs/jfs/jfs_logmgr.c:1438 assert(log->cqueue.head == NULL)
Feb 12 04:30:16 mesh kernel: ------------[ cut here ]------------
Feb 12 04:30:16 mesh kernel: kernel BUG at fs/jfs/jfs_logmgr.c:1438!
Feb 12 04:30:16 mesh kernel: invalid operand: 0000
Feb 12 04:30:16 mesh kernel: CPU:    0
Feb 12 04:30:16 mesh kernel: EIP:    0060:[<c02963ee>]    Not tainted
Feb 12 04:30:16 mesh kernel: EFLAGS: 00010296
Feb 12 04:30:16 mesh kernel: EIP is at jfs_flush_journal+0x1de/0x2b0
Feb 12 04:30:16 mesh kernel: eax: 00000044   ebx: 00000320   ecx: c3772680   edx: c0578678
Feb 12 04:30:16 mesh kernel: esi: c3742000   edi: c72fea00   ebp: c3743f70   esp: c3743f44
Feb 12 04:30:16 mesh kernel: ds: 007b   es: 007b   ss: 0068
Feb 12 04:30:16 mesh kernel: Process fsstress (pid: 1427, threadinfo=c3742000 task=c3773980)
Feb 12 04:30:16 mesh kernel: Stack: c0518308 c0518735 0000059e c0518764 c10bbeb8 c3742000 c1287994 c72feae4 
Feb 12 04:30:16 mesh kernel:        c72fec40 c72fec00 00000001 c3743f80 c02774d5 c72fea00 00000001 c3743fb0 
Feb 12 04:30:16 mesh kernel:        c017052e c72fec00 00000001 c1287994 c72fec00 4000988c c3743fb0 c0193125 
Feb 12 04:30:16 mesh kernel: Call Trace:
Feb 12 04:30:16 mesh kernel:  [<c02774d5>] jfs_sync_fs+0x25/0x30
Feb 12 04:30:16 mesh kernel:  [<c017052e>] sync_filesystems+0x2fe/0x450
Feb 12 04:30:16 mesh kernel:  [<c0193125>] sync_inodes+0x25/0xb0
Feb 12 04:30:16 mesh kernel:  [<c01694fb>] sys_sync+0x3b/0x50
Feb 12 04:30:16 mesh kernel:  [<c010a5f7>] syscall_call+0x7/0xb
Feb 12 04:30:16 mesh kernel: 
Feb 12 04:30:16 mesh kernel: Code: 0f 0b 9e 05 35 87 51 c0 eb 8c e8 93 8b e8 ff e9 15 ff ff ff


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
