Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTDYQcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 12:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTDYQcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 12:32:18 -0400
Received: from mta02.telering.at ([212.95.31.39]:31169 "EHLO smtp.telering.at")
	by vger.kernel.org with ESMTP id S263301AbTDYQcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 12:32:16 -0400
Date: Fri, 25 Apr 2003 16:30:54 +0200
From: Bernhard Kaindl <kaindl@telering.at>
X-X-Sender: bkaindl@hase.a11.local
To: Andreas Gietl <Listen@e-admin.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4-rc1] fix side effects of the kmod/ptrace secfix
In-Reply-To: <200304251640.22021.Listen@e-admin.de>
Message-ID: <Pine.LNX.4.53.0304251607540.26723@hase.a11.local>
References: <200304250037.45133.Listen@e-admin.de>
 <Pine.LNX.4.53.0304251215200.2582@hase.a11.local> <200304251640.22021.Listen@e-admin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Apr 2003, Andreas Gietl wrote:
>
> it shows:
>   PID TTY      STAT   TIME COMMAND
>  2092 ttyp0    S      0:00 su guest -c ps $PPID;wc -m </proc/$PPID/cmdline
>       0

Ah ok, I tested this with LC_CTYPE=de_DE.UTF-8, in this case wc has
to read the contents of the file. When a single-byte locale is used,
wc just does fstat64() to get the file size(which returns 0 for the file).

> but cat shows:
> su guest -c 'ps $PPID; cat /proc/$PPID/cmdline'
>   PID TTY      STAT   TIME COMMAND
>  2144 ttyp0    S      0:00 su guest -c ps $PPID; cat /proc/$PPID/cmdline
> suguest-cps $PPID; cat /proc/$PPID/cmdline
>
> what happened?

This is ok, access_proces_vm() is working.

> > [pid  2599] --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
> > [pid  2599] write(1, "\n", 1
>
> it shows:
> localhost root # strace -fewrite su -c /bin/echo 2>&1 | grep pid
> [pid  2159] write(1, "\n", 1

Looks ok also, the task->mm->dumpable check is removed from prace_check_attach

> Looks like my results are slightly diffent, Does this mean i did not apply the
> patch correctly? I applied it twice manually, because patch did not succeed

The above shows that at least the two-liner task_dumpable diff is applied.
> and compiled the kernel 3 times...

Sorry for the different output, I should have made my tests safer against
system variants. It should have applied clean, maybe some white space issue
or so, I'll check it. shutdown didn't change? What does it on your system?

Bernd
