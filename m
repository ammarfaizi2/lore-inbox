Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUIXDDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUIXDDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUIXDDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:03:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:25792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267679AbUIXDA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 23:00:56 -0400
Date: Thu, 23 Sep 2004 19:59:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Donald Duckie <schipperke2000@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unresolved symbol __udivsi3_i4
Message-Id: <20040923195917.26089252.rddunlap@osdl.org>
In-Reply-To: <20040924021050.689.qmail@web53608.mail.yahoo.com>
References: <20040924021050.689.qmail@web53608.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004 19:10:50 -0700 (PDT) Donald Duckie wrote:

| hi!

Hi again, Donald-

Note:  I haven't forgotten your other question.
Is is still a problem?

| can somebody please help me how to overcome this
| problem:
| unresolved symbol __udivsi3_i4

That clearly shouldn't be happening, and that symbol isn't in
snull.o when I build it (on x86).

| I compiled the snull files that i got from 
| http://www.oreilly.com.tw/editor_column/a138_read.htmland
| ran depmod -a -F /proc/ksyms 2.4.18 snull.o

How did you build snull (or all of the LDD drivers)?
What command(s)?

| And in another machine (my running machine), I got the
| following files from my compilation machine:
| snull.o
| /lib/modules/2.4.18/*
| 
| In my running machine, I ran modprobe but got this
| error:
| Using /lib/modules/2.4.18-sh/kernel/drivers/net/snull.
|   <cut>
| modprobe: unresolved symbol __udivsi3_i4
|   <cut>

So the problem machine is an sh-arch machine?
Maybe gcc 3.0.3 has some problem on sh.
Can you try this on some other architecture machine?

| The gcc version that is used is:
| [aprhodite@aphrodite2 bin]$ sh-linux-gcc -v
| Reading specs from
| /usr/lib/gcc-lib/sh-linux/3.0.3/specs
| Configured with: ../configure --prefix=/usr
| --mandir=/usr/share/man --target=sh-linux
| --host=i686-pc-linux-gnu --build=i
| 686-pc-linux-gnu --disable-c99 --disable-nls
| --enable-languages=c,c++ --with-system-zlib
| --with-gxx-include-dir=/usr/sh-
| linux/include/g++-v3
| --includedir=/usr/sh-linux/include
| --enable-threads=posix --enable-long-long
| Thread model: posix
| gcc version 3.0.3
| 
| 
| Running nm -l-s snull.o
| 00000000 a *ABS*
|   <cut>
|          U __udivsi3_i4
| /home/aphrodite/snull/snull3/snull/snull.c:355
|   <cut>

Seeing an objdump of that function (snull_hw_tx) should/could be helpful.

| the block in snull.c that contains ine 355 is:
|     352     if (lockup && ((priv->stats.tx_packets +
| 1) % lockup) == 0) {
|     353         /* Simulate a dropped transmit
| interrupt */
|     354         netif_stop_queue(dev);
|     355         PDEBUG("Simulate lockup at %ld, txp
| %ld\n", jiffies,
|     356                         (unsigned long)
| priv->stats.tx_packets);
|     357     }
| (which seems to  be okey)

Yes.

| The only modification to the downloaded snull files is
| on snull.c:
|      30 //#include <linux/malloc.h> /* kmalloc() */
|      31 #include <linux/slab.h> /* kmalloc()
| deprecated use slab.h instead*/
| 
| 
| can anyone please tell me how to deal with this
| unresolved symbol __udivsi3_i4?


--
~Randy
