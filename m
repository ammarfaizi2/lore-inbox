Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267730AbUIXCcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267730AbUIXCcV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267568AbUIXC2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 22:28:53 -0400
Received: from web53608.mail.yahoo.com ([206.190.37.41]:12948 "HELO
	web53608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267597AbUIXC1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 22:27:47 -0400
Message-ID: <20040924021050.689.qmail@web53608.mail.yahoo.com>
Date: Thu, 23 Sep 2004 19:10:50 -0700 (PDT)
From: Donald Duckie <schipperke2000@yahoo.com>
Subject: unresolved symbol __udivsi3_i4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

can somebody please help me how to overcome this
problem:
unresolved symbol __udivsi3_i4

I compiled the snull files that i got from 
http://www.oreilly.com.tw/editor_column/a138_read.htmland
ran depmod -a -F /proc/ksyms 2.4.18 snull.o

And in another machine (my running machine), I got the
following files from my compilation machine:
snull.o
/lib/modules/2.4.18/*

In my running machine, I ran modprobe but got this
error:
Using /lib/modules/2.4.18-sh/kernel/drivers/net/snull.
  <cut>
modprobe: unresolved symbol __udivsi3_i4
  <cut>

The gcc version that is used is:
[aprhodite@aphrodite2 bin]$ sh-linux-gcc -v
Reading specs from
/usr/lib/gcc-lib/sh-linux/3.0.3/specs
Configured with: ../configure --prefix=/usr
--mandir=/usr/share/man --target=sh-linux
--host=i686-pc-linux-gnu --build=i
686-pc-linux-gnu --disable-c99 --disable-nls
--enable-languages=c,c++ --with-system-zlib
--with-gxx-include-dir=/usr/sh-
linux/include/g++-v3
--includedir=/usr/sh-linux/include
--enable-threads=posix --enable-long-long
Thread model: posix
gcc version 3.0.3


Running nm -l-s snull.o
00000000 a *ABS*
  <cut>
         U __udivsi3_i4
/home/aphrodite/snull/snull3/snull/snull.c:355
  <cut>


the block in snull.c that contains ine 355 is:
    352     if (lockup && ((priv->stats.tx_packets +
1) % lockup) == 0) {
    353         /* Simulate a dropped transmit
interrupt */
    354         netif_stop_queue(dev);
    355         PDEBUG("Simulate lockup at %ld, txp
%ld\n", jiffies,
    356                         (unsigned long)
priv->stats.tx_packets);
    357     }
(which seems to  be okey)


The only modification to the downloaded snull files is
on snull.c:
     30 //#include <linux/malloc.h> /* kmalloc() */
     31 #include <linux/slab.h> /* kmalloc()
deprecated use slab.h instead*/


can anyone please tell me how to deal with this
unresolved symbol __udivsi3_i4?


thank you very much.
-donald



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
