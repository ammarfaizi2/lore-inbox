Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTKHUGJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 15:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTKHUGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 15:06:09 -0500
Received: from srv1.rt.mipt.ru ([194.85.82.97]:53637 "EHLO srv1.rt.mipt.ru")
	by vger.kernel.org with ESMTP id S262198AbTKHUGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 15:06:06 -0500
Date: Sat, 8 Nov 2003 23:06:10 +0300
From: Amosov Evgeniy <efreet@mastak.ru>
To: linux-kernel@vger.kernel.org
Subject: Real Time in 2.4.18
Message-Id: <20031108230610.27393b37.efreet@mastak.ru>
Organization: mastak
X-Mailer: Sylpheed version 0.8.1claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good day.
I am working on improved Real-Time support in Linux for kernel 2.4.18 ( i388, sparc).
I have  written  my own POSIX  pthreads support in kernel, library as an interface for use the new systemcall (like libpthread)  and  measure  the time of switching two pthreads ( pthread_bcast - pthread_wait  circle in two threads)
I have done some changes in schedule,  disabled BH and  intercepted  all interrupts and exeptions in entry.S.

All looks fine, the time of switching is about 3mks, the maximum time is 20 mks,  but sometimes ...., after about 20 seconds, I see a 
single surge about 300mks.
I have no idea what is a source of this surge.
There are only my two switching SHED_FIFO tasks  and standart kernel threads  in the system(keventd, kswapd, bdflush etc...),  but during the test in RUNNING state were only my two pthreads; there are no interrupts or exeptions during the test,
all BHs is disabled, but the measurements show that it is an interrupt becouse  my tasks preempt in random places   for a long time.
It is not a timer_interrupt.

It is strange:  no interrupts(exept timer ofcouse, but it is not it) but it looks like an interrupt :)

I intercept interrupts in irq.c:do_IRQ(),   entry.S: system_call() and exeptions in entry.S: error_code.
May be I something lose ?
Have anybody some ideas?

P.S.
Sorry for my english :)


-- 
Amosov Evgeniy (aka Efreet)

