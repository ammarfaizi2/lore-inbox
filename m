Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbVJKI4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVJKI4W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 04:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVJKI4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 04:56:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37115 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751423AbVJKI4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 04:56:21 -0400
Subject: Re: Latency data - 2.6.14-rc3-rt13
From: Sven-Thorsten Dietrich <sven@mvista.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com>
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>
	 <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com>
	 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>
	 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com>
	 <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
	 <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 01:56:19 -0700
Message-Id: <1129020979.10291.6.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-10 at 20:45 -0700, Mark Knecht wrote:
> On 10/10/05, Mark Knecht <markknecht@gmail.com> wrote:
> >
> > ( softirq-timer/0-3    |#0): new 3997 us maximum-latency critical section.
> 
> So the root cause of this 4mS delay is the 250Hz timer. If I change
> the system to use the 1Khz timer then the time in this section drops,
> as expected, to 1mS.
> 
> ( softirq-timer/0-3    |#0): new 998 us maximum-latency critical section.
>  => started at timestamp 121040020: <acpi_processor_idle+0x20/0x379>
>  =>   ended at timestamp 121041019: <thread_return+0xb5/0x11a>
> 
> So, thinking very interesting here I think.
> 

Maximum preemption latencies near the timer period 
are sometimes indicative of mismatched 
preempt_disable/preempt_enable pairs in the code.

Usually the scheduler warns about that on the console, however.

Sven

> Back to the drawing board as to my xruns.
> 
> - Mark
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
***********************************
Sven-Thorsten Dietrich
Real-Time Software Architect
MontaVista Software, Inc.
1237 East Arques Ave.
Sunnyvale, CA 94085

Phone: 408.992.4515
Fax: 408.328.9204

http://www.mvista.com
Platform To Innovate
*********************************** 

