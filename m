Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271063AbTGPL1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 07:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271062AbTGPL1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 07:27:19 -0400
Received: from gatek.sysde.eads.net ([53.122.197.194]:7319 "HELO
	gatek.sysde.eads.net") by vger.kernel.org with SMTP id S271063AbTGPL1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 07:27:13 -0400
Date: Wed, 16 Jul 2003 13:43:18 +0200 (CEST)
From: Andreas Koehler <Andreas.Koehler@sysde.eads.net>
To: linux-kernel@vger.kernel.org
Subject: Howto check for slow io-operations
Message-ID: <Pine.LNX.4.44.0307161246390.1550-100000@koehan.vs.dasa.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sorry, if this is a little bit off-topic but I don't known where else to 
ask for!

The following situation is given:
An executable uses a small :-) number of (POSIX-)threads. One of them is 
the "input-thread" that blocks on select and delivers incoming data to a 
reentrant queue. I need this thread to avoid a too high dropping rate for 
udp data! A "processing-thread" reads the items from the queue and does 
the "real" processing. I detected that the "input-thread" seems to be 
potentially much faster than the "processing-thread" but under normal 
load, I thought, this effect is regulated by the scheduler since busy 
processes with SCHED_OTHER should have a higher priority than the 
idle-process :-). 
Unfortunately even under such conditions the number of items in the 
internal queue between the "input-thread" and the "processing-thread" 
increases continuously. Strange is, that the evaluation of /proc/stat and 
/proc/loadavg showed idle schedules between 70 and 90 percent.

How is this possible?

The only thing I could imagine is that the "processing-thread" is not 
really busy but waits for the completion of some slow input/output 
operations. Anyway - in this case it would be important to me to identify 
this slow input/output operations.

Does the kernel provide any logging facilities related to this 
identification?

Or does anbody know a solution for the original problem?

I use the following environment:
Red Hat Linux 8.0 3.2-7 with Linux version 2.4.18-14

Much thanks
Andreas

