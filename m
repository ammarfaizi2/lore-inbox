Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbTIMHMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 03:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTIMHMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 03:12:55 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:36023 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262002AbTIMHMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 03:12:53 -0400
Subject: Re: "busy" load counters
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: xuan--lkml--2003.09.12@baldauf.org
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1063436451.314.9010.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Sep 2003 03:00:51 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xuân Baldauf writes:

> Currently, tools like "top" show stats like
>
>   Cpu(s):  92.1% user,   6.9% system,   0.0% nice,   1.0% idle
>
> Unfortunately, these stats are not sufficient to determine wether the 
> system is "busy". Determining wether the system is "busy" is very useful 
> in case an interactive application (e.g. a shell or some shell command) 
> does not respond.
> Maybe it just hangs (waits for input) or does serious work (e.g. uses 
> the CPU or accesses the disk). Disk access is not visible in "top". 
> Depending on the machine, on disk accesses, there might be a slight or 
> significant rise in the "system" portion of those stats, but this is not 
> trustable.

The feature is available, but you'll need to upgrade
to procps-3.1.12 and linux-2.6.0-test4 at least.

http://www.kernel.org/pub/linux/kernel/v2.6/
http://procps.sf.net/

Once you've done that, both "top" and "vmstat" will
supply the info you want. There are 7 basic %CPU stats
right now:

us  regular user apps
sy  system (general kernel stuff)
ni  nice user apps (low-priority tasks)
id  idle
wa  waiting for IO to complete
hi  hard interrupt (IRQ) handlers
si  soft interrupt (network stack, mostly?) handlers

The "top" program shows all of those. The "vmstat"
program mixes "ni" into "us", and mixes "hi" and "si"
into "sy". An example for each:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0   6896   2668 108896    0    0     0     1   34    14 10  3 87  0

top - 02:56:17 up 12 days, 13:43, 25 users,  load average: 0.37, 0.25, 0.22
Tasks: 129 total,   4 running, 124 sleeping,   1 stopped,   0 zombie
Cpu(s):  8.6% us,  5.6% sy,  0.0% ni, 85.8% id,  0.0% wa,  0.0% hi,  0.0% si
Mem:    513924k total,   507068k used,     6856k free,     2664k buffers
Swap:        0k total,        0k used,        0k free,   108844k cached


