Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143668AbRA1SPN>; Sun, 28 Jan 2001 13:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143692AbRA1SPE>; Sun, 28 Jan 2001 13:15:04 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:25880 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S143668AbRA1SOx>; Sun, 28 Jan 2001 13:14:53 -0500
Message-Id: <SAK.2001.01.28.calrnhkd@ahem>
Date: Sun, 28 Jan 2001 19:16:06 +0100
X-Priority: 3
From: SR (c) 2000 <admin@gamecoding.cjb.net>
X-Mailer: Mail Warrior
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: problem exporting symbols from a lkm
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer-Version: v3.55 (r)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm kinda new to this kernel hacking thing. So excuse me for any stupid questions/remarks.
The problem I have occurs because I'm trying to install the rshaper software on my linux system.
I'm running:
Distribution: red hat 6.2
Kernel ver.: 2.2.14-5.0
System: i386
compiler: gcc
compiler ver.: gcc version egcs-2.91.66 19990314/linux (egcs-1.1.2 release)

The rshaper software requires you to modify the 8390 driver kernel module.
I had no problems modifying the 8390.c source to accomodate rshaper.
The problem is that the ne2k-pci.o uses symbols from the 8390.o driver.
these symbols are exported with the EXPORT_SYMBOL macro.
When I load the modified 8390.o (insmod 8390.o)
my /proc/ksyms shows that the exported symbols from 8390.o are different
from the other symbols because they have  "_R__ver_" in front of them.
And when I load the ne2k-pci.o it complains that it can't find those symbols
that were supposed to be exported by 8390.o

I have looked around on the net and this problem seems related to the
CONFIG_MODVERSIONS bug. since I have no clue as to getting
these symbols to be exported correctly maybe someone can tell me
how to get around this problem.

the compile command I used to compile 8390.c was:
gcc -D__KERNEL__ -DEXPORT_SYMTAB -DMODULE -I/usr/src/linux/net/inet -Wall -Wstrict-prototypes -O6 -m486 -c 8390.c

greetings,
Willem van Doesburg





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
