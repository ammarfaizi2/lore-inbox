Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131926AbRA0HjA>; Sat, 27 Jan 2001 02:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131931AbRA0Hiu>; Sat, 27 Jan 2001 02:38:50 -0500
Received: from Huntington-Beach.blue-labs.org ([208.179.0.198]:18471 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131926AbRA0Hil>; Sat, 27 Jan 2001 02:38:41 -0500
Message-ID: <3A727AF9.22B09950@linux.com>
Date: Sat, 27 Jan 2001 07:38:34 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: VM breakdown, 2.4.0 family
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the testN series and up through ac12, I experience total loss of
control when memory is nearly exhausted.

I start with 256M and eat it up with programs until there is only about
7 megs left, no swap.  From that point all user processes stall and the
disk begins to grind nonstop.  It will continue to grind for about 25-30
minutes until it goes completely silent.  No processes get killed, no VM
messages are emitted.

The only recourse is the magic key.  If I reboot before the disk goes
silent I can cleanly kill X with sysrq-E and restart.

If I wait until it goes silent, all is lost.  I have to sysrq-SUB.

Note, I do not have ANY swap enabled for these tests.

SysRq: Show Memory
Mem-info:
Free pages:       22124kB (     0kB HighMem)
( Active: 3427, inactive_dirty: 521, inactive_clean: 0, free: 5531 (383
766 1149) )
282*4kB 55*8kB 5*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB
0*2048kB = 2160kB)
1769*4kB 795*8kB 156*16kB 56*32kB 21*64kB 1*128kB 1*256kB 1*512kB
0*1024kB 0*2048kB = 19964kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0
Free swap:            0kB
65532 pages of RAM
0 pages of HIGHMEM
2113 reserved pages
3981 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:     2780kB

Note the "= 0kB)" line in the middle?  Is printk() data missing?  how
about the mismatched ( to )?

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
