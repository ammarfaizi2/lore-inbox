Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130657AbRCGKGl>; Wed, 7 Mar 2001 05:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129677AbRCGKGc>; Wed, 7 Mar 2001 05:06:32 -0500
Received: from mlist.austria.eu.net ([193.81.83.3]:27619 "EHLO
	hausmasta.austria.eu.net") by vger.kernel.org with ESMTP
	id <S130657AbRCGKGM>; Wed, 7 Mar 2001 05:06:12 -0500
Message-ID: <3AA607E7.6B94D2D@eunet.at>
Date: Wed, 07 Mar 2001 11:05:27 +0100
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: nanosleep question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a question regarding the nanosleep() system call.

I'm writing a little tool called lcd4linux
(http://lcd4linux.sourceforge.net), where I have to drive displays
connected to the parallel port. I'm doing this in userland, using
outb().

Some of this displays require quite short delays (e.g. 40 microseconds),
which cannot be done with normal nanosleep() because of the 10 msec
timer resolution.

At the moment I implemented by own delay loop using a small assembler
loop similar to the one used in the kernel. This has two disadvantages:
assembler isn't that portable, and the loop has to be calibrated.

I took a look at the nanosleep() implementation in the kernel, and found
that it is possible to get very small delays, but only if I set the
scheduling type to SCHED_RR or SCHED_FIFO.

Here are my questions:

- why are small delays only possible up to 2 msec? what if I needed a
delay of say 5msec? I can't get it?

- how dangerous is it to run a process with SCHED_RR? As far as I
understood the nanosleep man page, it _is_ dangerous (if the process
gets stuck in an endless loop, you can't even kill it if you don't have
a shell which has a higher static priority than the stuck process
itself).

- is it possible to switch between different scheduling modes? I cound
run the program with normal SCHED_OTHER, and switch to SCHED_RR whenever
I need to write data to the parallel port? Does this make sense?

- what's the reason why these small delays is not possible with
SCHED_OTHER?


TIA, 
     Michael

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
