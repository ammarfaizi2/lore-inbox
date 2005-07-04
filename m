Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVGDOOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVGDOOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 10:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVGDOOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 10:14:43 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:13331 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S261713AbVGDODT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 10:03:19 -0400
Date: Mon, 4 Jul 2005 16:03:14 +0200 (CEST)
From: gl@dsa-ac.de
To: linux-kernel@vger.kernel.org
Subject: wake_up() from interrupt - on the next jiffie?
Message-ID: <Pine.LNX.4.56.0507041549440.1519@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This might well be my basic misunderstanding, or the test was wrong, but
the probability is pretty low, so, asking here.

I thought, if a task sleeps on, say, read() and then data come and there's
no other runnable task with a higher priority, the sleeping task should be
woken up immediately. My test showed that the task is only woken up on the
next jiffie. Kernel 2.6.11.10.

Details: a program does a cfmakeraw() on a ttyS, and does blocking reads
of 1 byte in a loop, taking timestamps with gettimeofday() after waking
up. The FIFO is switched off by configuring the UART as 16550. With a low
(e.g., 600 baud) baudrate I see indeed that the task gets individual bytes
as they arrive. However, if I set the baudrate to, say, 19200 the task is
woken up every millisecond (ix86) and then it gets 2 bytes.

Another program, opening 2 pipes, forking, and then playing ping-pong
between the 2 tasks confirms, that in this case the tasks currently
sleeping on read() is woken up immediately as the other one does a
write...

Test program sources available on request.

Is it a conscious decision or is my test wrong?
Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
