Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbTEHItq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 04:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbTEHItq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 04:49:46 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:38551 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP id S261233AbTEHItp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 04:49:45 -0400
Message-ID: <029601c31540$b57f1280$0305a8c0@arch.sel.sony.com>
From: "Ming Lei" <lei.ming@attbi.com>
To: <linux-kernel@vger.kernel.org>
Subject: linux rt priority  thread corrupt  global variable?
Date: Thu, 8 May 2003 02:03:35 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
x-mimeole: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Platform:
Intel Pentium II; RedHat 7.2 with kernel version 2.4.7-10, libc 2.2.4-13 and
gcc 2.96.

Problem description:

a program has 3 threads of priority 12, 10, 6 respectively, and the main
process at priority 0. All the threads except main process is created with
pthread_create, and defined SCHED_FIFO as real time scheduler policy.

There is a global variable I define with 'int cpl'. All the threads and main
process may alter cpl at any time. cpl may have one of these values {0,
0xf000006e, 0xf0000068, 0xe0000000, 0xe0000060}. cpl is protected by mutex
for any access.

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

PS. please cc to this email address.
-Ming


Related questions:

Is linux kernel 2.4.10 considered strictly preemptive such as VxWorks or
other RTOS? I guess 2.4.10 may simulate preemptive with running scheduler on
every syscall or interrupt returns. Am I right?

Is printf() real-time priority thread safe?

