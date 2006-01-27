Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWA0JyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWA0JyL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 04:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWA0JyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 04:54:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46235 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932328AbWA0JyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 04:54:09 -0500
Date: Fri, 27 Jan 2006 10:54:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] possible bug in trace_start_sched_wakeup
Message-ID: <20060127095449.GC24878@elte.hu>
References: <1138327022.7814.8.camel@localhost.localdomain> <1138336718.7814.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138336718.7814.41.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

>  			trace_special_pid(sch.task->pid, sch.task->prio, p->prio);
> -		if (sch.task && (sch.task->prio >= p->prio))
> +		if (sch.task && ((sch.task->prio <= p->prio) || !rt_task(p)))
>  			sch.task = NULL;

this second condition i'd not change: it just expresses the rare case 
where a higher-prio task hits the CPU that we somehow did not start to 
trace. In that case we just zap the current trace.

	Ingo
