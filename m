Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266864AbRGKXBQ>; Wed, 11 Jul 2001 19:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266880AbRGKXBH>; Wed, 11 Jul 2001 19:01:07 -0400
Received: from pc-62-30-142-167-nm.blueyonder.co.uk ([62.30.142.167]:43766
	"EHLO merry.bs.lan") by vger.kernel.org with ESMTP
	id <S266864AbRGKXAv>; Wed, 11 Jul 2001 19:00:51 -0400
Date: Thu, 12 Jul 2001 00:00:49 +0100
From: charles@briscoe-smith.org.uk
To: linux-kernel@vger.kernel.org
Subject: BUG in inode.c
Message-ID: <20010712000049.A1540@pippin.bs.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just hit a kernel bug that I haven't noticed before.  It caused an ls
to seg fault, and some messages to appear in my system logs.  It doesn't
seem to have otherwise destabilised my system at all.

My kernel version:

----------
Linux pippin 2.4.5 #1 Sun Jun 17 14:59:16 BST 2001 i586 unknown
----------

The kernel output this into the logs:

----------
kernel BUG at inode.c:486!
invalid operand: 0000
CPU:    0
EIP:    0010:[clear_inode+51/244]
EFLAGS: 00010286
eax: 0000001b   ebx: c42a92a0   ecx: c9cf6000   edx: cb5e2ec0
esi: cc865c60   edi: c9cf7fa4   ebp: c9cf7fa4   esp: c9cf7eec
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 1226, stackpage=c9cf7000)
Stack: c01f0e4e c01f0ead 000001e6 c42a92a0 c0140397 c42a92a0 c4329540 c42a92a0 
       cc860099 c42a92a0 c013df76 c4329540 c42a92a0 c4329540 00000000 c0136c49 
       c4329540 c9cf7f68 c0137369 c411f940 c9cf7f68 00000000 c75a8000 00000000 
Call Trace: [iput+327/348] [nfs:__insmod_nfs_S.text_L33744+20537/33792] [dput+214/324] [cached_lookup+69/80] [path_walk+1333/1932] [getname+91/152] [__user_walk+58/84] 
       [sys_lstat64+21/108] [system_call+51/64] 

Code: 0f 0b 83 c4 0c f6 83 f4 00 00 00 10 75 19 68 e8 01 00 00 68 
----------

I think this message coincided with the segmentation fault in the
following sequence of commands to bash.  /u6 is nfs mounted from merry,
by the way, which runs:

----------
Linux merry 2.2.19 #1 Tue May 29 12:38:01 BST 2001 i586 unknown
----------

----------
cpb4@pippin:/u6/cpb4$ ls -la ohg* -c
-rw-rw-r--    1 cpb4     cpb4     294595500 Jul 11 20:21 ohg5.wav
-rw-rw-r--    1 cpb4     cpb4     294879240 Jul 11 20:33 ohg6.wav
cpb4@pippin:/u6/cpb4$ mkdir ohg
cpb4@pippin:/u6/cpb4$ mv -iv ohg* ohg
mv: cannot move `ohg' to a subdirectory of itself, `ohg/ohg'
`ohg5.wav' -> `ohg/ohg5.wav'
`ohg6.wav' -> `ohg/ohg6.wav'
cpb4@pippin:/u6/cpb4(1)$ cd ohg/
cpb4@pippin:/u6/cpb4/ohg$ ls -la
Segmentation fault
cpb4@pippin:/u6/cpb4/ohg(1)$ ls -la
total 576248
drwxrwxr-x    2 cpb4     cpb4         4096 Jul 11 20:34 .
drwxr-xr-x   16 cpb4     cpb4         4096 Jul 11 20:34 ..
-rw-rw-r--    1 cpb4     cpb4     294595500 Jul 11 20:21 ohg5.wav
-rw-rw-r--    1 cpb4     cpb4     294879240 Jul 11 20:33 ohg6.wav
cpb4@pippin:/u6/cpb4/ohg$ 
----------

If there's anything else about this you want to know, just ask.

Hope this helps,

--Charles
