Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264774AbUGAMFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbUGAMFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 08:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUGAMFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 08:05:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:13960 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264774AbUGAMFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 08:05:43 -0400
Date: Thu, 1 Jul 2004 14:06:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'rml@tech9.net'" <rml@tech9.net>, "'akpm@osdl.org'" <akpm@osdl.org>,
       "'Con Kolivas'" <kernel@kolivas.org>,
       "'Kevin P. Dankwardt'" <k@kcomputing.com>,
       "'Oliver Neukum'" <oliver@neukum.org>,
       "'Felipe Alfaro Solana'" <felipe_alfaro@linuxmail.org>,
       "'Tigran Aivazian'" <tigran@veritas.com>,
       "'corbet@lwn.net'" <corbet@lwn.net>
Subject: Re: Linux scheduler (scheduling) questions vs threads
Message-ID: <20040701120624.GA24295@elte.hu>
References: <313680C9A886D511A06000204840E1CF08F42FBC@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313680C9A886D511A06000204840E1CF08F42FBC@whq-msgusr-02.pit.comms.marconi.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Povolotsky, Alexander <Alexander.Povolotsky@marconi.com> wrote:

> Sorry for bothering and annoying everyone on this list again with additional
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
it's called a process - but the scheduler doesnt care.

so the normal Linux scheduling policy applies to 'threads' too. Fully
preemptable, SCHED_NORMAL by default, or SCHED_FIFO/SCHED_RR if you set
it. The priority (or rt_priority) can be set per-task as well. Newly
created threads/processes may inherit (or not) the policy of the parent,
this largely depends on the library implementation.

	Ingo
