Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVESSCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVESSCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 14:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVESSCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 14:02:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:43210 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261194AbVESSC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 14:02:26 -0400
Message-ID: <428CD458.6010203@free.fr>
Date: Thu, 19 May 2005 20:00:56 +0200
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@elte.hu>
Subject: Thread and process dentifiers (CPU affinity, kill)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e39ae1980843c849592344a98bbbf26f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that the thread ids in Linux are unique within the complete 
operating system, and not only within their corresponding processes. 
This is explicitely allowed by the POSIX standard (it also states that 
applications shall no rely on it).

Apparently some system calls which normally require a process id also 
work with thread ids.

- a system call requiring a PID can have  the same effect if a thread id 
of the same process was given.
Example: kill(tid,SIGTERM) will kill the entire process the thread
belongs to. I think that this is not POSIX compliant. It shall trigger
ESRCH!

Sometimes, the system call has another effect, potentialy providing
additional functionality.
Example: sched_setaffinity(). The man page and the prototype (which 
requires a pid_t) both show that a process id is required. Nothing 
indicates that it works with threads, and AFAIK there is no documented 
way to set affinity for a specific thread.
But if you give a TID to sched_setaffinity, it will put the *thread* on 
the given cpu set.
If you give a PID to sched_setaffinity, it will put the *main thread* on
the given cpu set. The other threads won't be impacted.
Even if sched_setaffinity() is no standard, I find it confusing to give
it a pid_t and that it affects only threads!


Some open questions:

- is it a guaranted behaviour within Linux that thread ids and process 
ids do not overlap? is it documented anywhere?

- is there a real confusion at API level within Linux between threads
and processes or are kill() and sched_setaffinity() isolated examples? 
or bugs?

- is Linux kill() POSIX compliant in this regard?

- do we want to limit the sched_setaffinity() functionality to
correspond to its documentation, or do we want to update the
documentation so that its covers all the functionality?


Regards


Olivier

