Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135209AbRAFV5Z>; Sat, 6 Jan 2001 16:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135217AbRAFV5P>; Sat, 6 Jan 2001 16:57:15 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:44231 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S135209AbRAFV5E>; Sat, 6 Jan 2001 16:57:04 -0500
Date: Sat, 06 Jan 2001 13:58:32 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: re: [PATCH] up to 50% faster sys_poll()
To: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Reply-to: dank@alumni.caltech.edu
Message-id: <3A579508.CF755874@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred (manfred@colorfullife.com) wrote:
> sys_poll spends around 1/2 of the execution time allocating / freeing a 
> few bytes temporary memory. 
> The attached patch tries to avoid these allocation by using the stack - 
> usually only a few bytes are needed, kmalloc is used for the rest. 
> The result: one poll of stdin is down from 1736 cpu ticks to 865 cpu 
> ticks (Pentium II/350 SMP, SMP kernel) 

Tested with poll() microbenchmark from 
http://www.kegel.com/dkftpbench/Poller_bench.html

time in microsec to find a single active pipe among N pipes
on a 650 MHz dual Pentium III using poll():

                number of pipes
kernel        100    1000   10000
---------------------------------
2.4.0-t10pre4  49    1184   14660
2.4.0          48    1162   14702
2.4.0-pp       48    1103   14205

2.4.0-pp is with Manfred's patch.  Seems to be a 4-6% improvement 
for large numbers of pipes, no change for 100 pipes.

Hope that was an appropriate test. 

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
