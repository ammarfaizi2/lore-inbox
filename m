Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265956AbUGEIWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265956AbUGEIWH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 04:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUGEIWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 04:22:07 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:48534 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S265956AbUGEIWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 04:22:02 -0400
Message-ID: <313680C9A886D511A06000204840E1CF08F42FD0@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'rml@tech9.net'" <rml@tech9.net>, "'akpm@osdl.org'" <akpm@osdl.org>,
       "'Con Kolivas'" <kernel@kolivas.org>,
       "'Kevin P. Dankwardt'" <k@kcomputing.com>,
       "'Oliver Neukum'" <oliver@neukum.org>,
       "'Felipe Alfaro Solana'" <felipe_alfaro@linuxmail.org>,
       "'Tigran Aivazian'" <tigran@veritas.com>,
       "'corbet@lwn.net'" <corbet@lwn.net>, "'Ingo Molnar'" <mingo@elte.hu>
Subject: Maximum frequency of re-scheduling (minimum time quantum) questio
	n
Date: Mon, 5 Jul 2004 04:13:08 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In Linux 2.6 kernel, configured with SCHED_RR, - could rescheduling be set
to be attempted (and executed when appropriate) at EVERY CLOCK TICK, thus
allowing the "other" process/thread (if available and ready at the moment)
with the higher (highest at that time) priority or, otherwise, with the same
priority (the "next" process/thread in the same Round Robin queue, from
which the "current" process/thread was "picked" ) to preempt the "current"
process/thread ?

If EVERY CLOCK TICK is not conceptually possible (please note, that I am not
claiming that frequent rescheduling is "good", I am just asking to what
measure it is possible ...) - then what is the minimum "rescheduling" time
quantum (measured in clock ticks) is settable/possible ?

What is the default value (which I presume was chosen as "optimal" ?) ?

Thanks,
Best Regards,
Alex Povolotsky
-----Original Message-----
From: Ingo Molnar [mailto:mingo@elte.hu]
Sent: Thursday, July 01, 2004 8:06 AM
To: Povolotsky, Alexander
Cc: 'linux-kernel@vger.kernel.org'; 'rml@tech9.net'; 'akpm@osdl.org';
'Con Kolivas'; 'Kevin P. Dankwardt'; 'Oliver Neukum'; 'Felipe Alfaro
Solana'; 'Tigran Aivazian'; 'corbet@lwn.net'
Subject: Re: Linux scheduler (scheduling) questions vs threads



* Povolotsky, Alexander <Alexander.Povolotsky@marconi.com> wrote:

> Sorry for bothering and annoying everyone on this list again with
additional
> questions ...
> 
> Let assume there is one (and only one) application (user space ) process
> running on the Linux 2.6 - with multiple threads within it, created via
> "clone" (this happens, I presume, for example, if one uses Monta Vista
> library for porting PSOS to Linux).
> 
> What scheduling policies those threads (within the same process) will be
> governed by (if any )?

in Linux there's no difference between the scheduling of 'threads' and
'processes'. Both are internally a 'task'. If two tasks share the same
MM (this is possible via the use of clone()) then they are called
threads. If a task has its own MM (normally created via fork()) then
it's called a process - but the scheduler doesn't care.

so the normal Linux scheduling policy applies to 'threads' too. Fully
preemptable, SCHED_NORMAL by default, or SCHED_FIFO/SCHED_RR if you set
it. The priority (or rt_priority) can be set per-task as well. Newly
created threads/processes may inherit (or not) the policy of the parent,
this largely depends on the library implementation.

	Ingo
