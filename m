Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290960AbSBLK1k>; Tue, 12 Feb 2002 05:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287158AbSBLK1b>; Tue, 12 Feb 2002 05:27:31 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:55704 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S290960AbSBLK1Q>; Tue, 12 Feb 2002 05:27:16 -0500
Date: Tue, 12 Feb 2002 10:27:15 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: linux-kernel@vger.kernel.org
cc: ext3-users@redhat.com
Subject: 2.4.17: BUG()at transaction.c:609
Message-ID: <Pine.LNX.4.44.0202121020540.7408-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

very modular 2.4.17; 2xPIII-800; no HIGHMEM; gcc-2.96-98; all ext3;
modules loaded include autofs4, nfs, nfsd, eepro100, acenic, ipchains,
unix, gdth. This happened during the dump (incrcp.pl is a custom backup
script also happening at the time).

Does ext3-0.9.17 fix this?

kernel BUG at transaction.c:609!
invalid operand: 0000
CPU:    1
EIP:    0010:[unix:__insmod_unix_O/lib/modules/2.4.17/kernel/net/unix/unix.o_M+-1684041/96]    Not tainted
EFLAGS: 00010282
eax: 00000021   ebx: d69a8694   ecx: c01f1100   edx: 00038651
esi: d69a8600   edi: d4d48760   ebp: c754c940   esp: cd291dd0
ds: 0018   es: 0018   ss: 0018
Process incrcp.pl (pid: 26404, stackpage=cd291000)
Stack: e0840e10 00000261 00000000 00000000 d69a8600 df1f39e0 d69a8694 d69a8600
       d4d48760 c754c940 e08371d7 d4d48760 c754c940 00000000 00000000 d4d48760
       cd291e84 d8561600 e0849431 d4d48760 dbecea80 00000246 c012d14c c1807060
Call Trace: [unix:__insmod_unix_O/lib/modules/2.4.17/kernel/net/unix/unix.o_M+-1642992/96] [unix:__insmod_unix_O/lib/modules/2.4.17/kernel/net/unix/unix.o_M+-1682985/96] [unix:__insmod_unix_O/lib/modules/2.4.17/kernel/net/unix/unix.o_M+-1608655/96] [kmalloc+188/368] [schedule+1191/1376]
   [unix:__insmod_unix_O/lib/modules/2.4.17/kernel/net/unix/unix.o_M+-1642892/96] [unix:__insmod_unix_O/lib/modules/2.4.17/kernel/net/unix/unix.o_M+-1656581/96] [unix:__insmod_unix_O/lib/modules/2.4.17/kernel/net/unix/unix.o_M+-1608504/96] [unix:__insmod_unix_O/lib/modules/2.4.17/kernel/net/unix/unix.o_M+-1608260/96] [filldir+174/224] [__mark_inode_dirty+46/160]
   [update_atime+81/96] [unix:__insmod_unix_O/lib/modules/2.4.17/kernel/net/unix/unix.o_M+-1627672/96] [open_namei+805/1680] [dentry_open+171/400] [kfree_skbmem+12/112] [filldir+0/224]
   [vfs_readdir+126/208] [filldir+0/224] [sys_getdents+71/160] [filldir+0/224] [system_call+51/56]

Code: 0f 0b 5f 58 8b 54 24 24 bb e2 ff ff ff b8 01 00 00 00 f6 42

