Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269409AbUINPdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269409AbUINPdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269404AbUINPdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:33:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39860 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269416AbUINPcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:32:14 -0400
Date: Tue, 14 Sep 2004 17:32:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com, cw@f00f.org, anton@samba.org
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040914153214.GA15558@elte.hu>
References: <1095045628.1173.637.camel@cube> <20040913075743.GA15722@elte.hu> <1095083649.1174.1293.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095083649.1174.1293.camel@cube>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Albert Cahalan <albert@users.sf.net> wrote:

> > > I'd much prefer LRU allocation. There are
> > > lots of system calls that take PID values.
> > > All such calls are hazardous. They're pretty
> > > much broken by design.
> > 
> > this is a pretty sweeping assertion. Would you
> > care to mention a few examples of such hazards?
> 
> kill(12345,9)
> setpriority(PRIO_PROCESS,12345,-20)
> sched_setscheduler(12345, SCHED_FIFO, &sp)
> 
> Prior to the call being handled, the process may
> die and be replaced. Some random innocent process,
> or a not-so-innocent one, will get acted upon by
> mistake. This is broken and dangerous.

easy to fix: SIGSTOP the task, check it's really
the one you want and then do the setpriority / 
setscheduler call and SIGCONT it. Any privileged
code that is about to spread some of its privileges
via asynchronous system-calls need to be careful.

	Ingo
