Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268470AbUIXGO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268470AbUIXGO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUIXGMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:12:55 -0400
Received: from web53606.mail.yahoo.com ([206.190.37.39]:23947 "HELO
	web53606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268470AbUIXGIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:08:34 -0400
Message-ID: <20040924044952.73739.qmail@web53606.mail.yahoo.com>
Date: Thu, 23 Sep 2004 21:49:52 -0700 (PDT)
From: Donald Duckie <schipperke2000@yahoo.com>
Subject: Re: unresolved symbol __udivsi3_i4
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040923202342.2327585b.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi randy!

thank you very much for your help.

it is indeed the % (mod) operator that generates the
unresolved symbol. it is also true with the /
(division) operator.  

is there any patch on this for
2.4.18-sh? or how will i do away with this problem
aside from commenting it out from the code?

btw, the previous unresolved symbol problems were
already solved. i just didn't copy the depmod
generated files in the running machine, that was why
those occured.

thank you.



--- "Randy.Dunlap" <rddunlap@osdl.org> wrote:

> On Thu, 23 Sep 2004 19:10:50 -0700 (PDT) Donald
> Duckie wrote:
> 
> | hi!
> | 
> | can somebody please help me how to overcome this
> | problem:
> | unresolved symbol __udivsi3_i4
> | 
> | I compiled the snull files that i got from 
> |
>
http://www.oreilly.com.tw/editor_column/a138_read.htmland
> | ran depmod -a -F /proc/ksyms 2.4.18 snull.o
> | 
> | And in another machine (my running machine), I got
> the
> | following files from my compilation machine:
> | snull.o
> | /lib/modules/2.4.18/*
> | 
> | In my running machine, I ran modprobe but got this
> | error:
> | Using
> /lib/modules/2.4.18-sh/kernel/drivers/net/snull.
> |   <cut>
> | modprobe: unresolved symbol __udivsi3_i4
> |   <cut>
> 
> Let me try this again.  I suspect that the problem
> is the '%' (mod)
> operator at line 351.  Can you just delete part of
> that if-test
> to prove or disprove my suspicion?
> 
> 
> | The gcc version that is used is:
> | [aprhodite@aphrodite2 bin]$ sh-linux-gcc -v
> | Reading specs from
> | /usr/lib/gcc-lib/sh-linux/3.0.3/specs
> | Configured with: ../configure --prefix=/usr
> | --mandir=/usr/share/man --target=sh-linux
> | --host=i686-pc-linux-gnu --build=i
> | 686-pc-linux-gnu --disable-c99 --disable-nls
> | --enable-languages=c,c++ --with-system-zlib
> | --with-gxx-include-dir=/usr/sh-
> | linux/include/g++-v3
> | --includedir=/usr/sh-linux/include
> | --enable-threads=posix --enable-long-long
> | Thread model: posix
> | gcc version 3.0.3
> | 
> | 
> | Running nm -l-s snull.o
> | 00000000 a *ABS*
> |   <cut>
> |          U __udivsi3_i4
> | /home/aphrodite/snull/snull3/snull/snull.c:355
> |   <cut>
> | 
> | 
> | the block in snull.c that contains ine 355 is:
> |     352     if (lockup && ((priv->stats.tx_packets
> +
> | 1) % lockup) == 0) {
> |     353         /* Simulate a dropped transmit
> | interrupt */
> |     354         netif_stop_queue(dev);
> |     355         PDEBUG("Simulate lockup at %ld,
> txp
> | %ld\n", jiffies,
> |     356                         (unsigned long)
> | priv->stats.tx_packets);
> |     357     }
> | (which seems to  be okey)
> | 
> | 
> | The only modification to the downloaded snull
> files is
> | on snull.c:
> |      30 //#include <linux/malloc.h> /* kmalloc()
> */
> |      31 #include <linux/slab.h> /* kmalloc()
> | deprecated use slab.h instead*/
> | 
> | 
> | can anyone please tell me how to deal with this
> | unresolved symbol __udivsi3_i4?
> | 
> | 
> | thank you very much.
> | -donald
> 
> --
> ~Randy
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
