Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbTEEUif (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTEEUif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:38:35 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:30374 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S261281AbTEEUic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:38:32 -0400
Message-ID: <013201c31348$379b3f00$0305a8c0@arch.sel.sony.com>
From: "Ming Lei" <lei.ming@attbi.com>
To: <linux-kernel@vger.kernel.org>
Subject: can linux RT thread corrupt  global variable?
Date: Mon, 5 May 2003 13:52:18 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Platform:
Intel Pentium II; RedHat 7.2 with kernel version 2.4.7-10, libc 2.2.4-13 and
gcc 2.96.

Problem description:

a program has a thread of priority 12, a thread of priority 10, a thread of
priority 6, and the main process at priority 0. All the threads except main
process is created with pthread_create, and defined SCHED_FIFO as real time
scheduler policy.

There is a global variable I define as 'int cpl'. All the threads and main
process may alter cpl at any time. cpl may have one of these values {0,
0xf000006e, 0xf0000068, 0xe0000000, 0xe0000060}.

<Problem=> at some point of execution which cpl should be a value say
e0000060, but the actual value retained at cpl is another say e0000000; that
is, the value is changed without the program actually done anything on it.
The retained value I observed is kind of historic value(one of these value
in the above set), not the arbituary value. The problem had occured just
after context switch, also occured during a thread execution.

<Confirm> I used Intel debug register to track any writing to the cpl memory
address globally, which is the way GDB use for x86 hardware watchpoint
implementation. I could see all the writing from my program to change cpl,
but failed to see the source from which the problem occured. So I dont know
what cause the problem.

Can anyone listening give me a direction or hint on this annoying situation?
Any help is thanked here.

PS. please cc to this email address.
-Ming


Related questions:

Is linux kernel 2.4.10 considered strictly preemptive such as VxWorks or
other RTOS? I guess 2.4.10 may simulate preemptive with running scheduler on
every syscall or interrupt returns. Am I right?

Is printf() real-time priority thread safe?

