Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbRE0DLQ>; Sat, 26 May 2001 23:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262733AbRE0DLG>; Sat, 26 May 2001 23:11:06 -0400
Received: from cpe.atm0-0-0-148189.arcnxx1.customer.tele.dk ([193.89.254.68]:9453
	"HELO serverrummet.dk") by vger.kernel.org with SMTP
	id <S262731AbRE0DKv>; Sat, 26 May 2001 23:10:51 -0400
Date: Sun, 27 May 2001 05:10:30 +0200 (CEST)
From: Rene <kaos@intet.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5 + ReiserFS + SMP + umount = oops
Message-ID: <Pine.LNX.4.21.0105270432020.13333-100000@virkelig.intet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list :)

I just upgraded an SMP-machine from 2.4.4 to 2.4.5.
It's a 
2xPII@300MHz 
Asus P2B-D motherboard 
128mb RAM.
unknown PCI gfx-card
Promise ATA-100 IDE-controller

Problem #1
I have 2 disk on the ATA-controller (30 and 45GB - both IBM) running a
Reiser-partition each.
I can do reiserfsck and debugreiserfs just fine and get an 'ok' back from
both ('ok' from fsck and 'VALID' from debug..). I can mount the
reiser-partitions, but - when I umount the first partition I get:
# umount /stuff (/dev/hde1)
journal_begin called without kernel lock held
kernel BUG at journal.c:423!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01813d0>]
EFLAGS: 00010282
eax: 0000001d   ebx: c1ea5f28   ecx: 00000001   edx: 00000001
esi: c6104e00   edi: 3b105b44   ebp: 0000000a   esp: c1ea5ec0
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 9217, stackpage=c1ea5000)
Stack: c022210c c02222a4 000001a7 c018395f c02232c1 c1ea5f28 c6104e00
c0250220
       c6104e34 3b105b44 00000000 c5eada60 c1ea4000 c6104e00 c1ea4000
c0183b6a
       c1ea5f28 c6104e00 0000000a 00000000 c0174728 c1ea5f28 c6104e00
0000000a
Call Trace: [<c018395f>] [<c0183b6a>] [<c0174728>] [<c0138b3a>]
[<c0138b71>] [<c0137e1c>] [<c013de6c>]
       [<c013901d>] [<c0124052>] [<c0139054>] [<c0106ceb>]

Code: 0f 0b 83 c4 0c c3 89 f6 31 c0 c3 90 31 c0 c3 90 56 be 00 f3


I took a look at fs/reiserfs/journal.c and compared (diff) it to the same
file from 2.4.4 and found the line where the message is generated (line
423). The problem is that a diff on those two journal.c's revealed no
difference whatsoever which leads me to the conclusion that this bug might
not have so much to do with ReiserFS afterall.

These things worked fine in 2.4.4 btw.
back in 2.4.2 I followed the Changes and did an upgrade to binutils,
e2fsprogs and util-linux, and these upgrades should still be ok.


Problem #2
Certain keystrokes like ctrl+c does not work when logged in from the
console - only when logged in throuhg ssh. This is really not that
important as the machine only acts as a monitor-less fileserver.



If You need additional information - please let me know.

regards
  /Rene 



-- 
Rene Mikkelsen, 
Tlf: +45 40501985
---------------------------------------------------------------
http://www.eslug.dk - the choice of a GNU generation
http://dustpuppy.dk - UF på dansk
---------------------------------------------------------------

