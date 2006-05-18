Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWERI4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWERI4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWERI4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:56:47 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:16864 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751087AbWERI4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:56:47 -0400
Date: Thu, 18 May 2006 10:56:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: Darren Hart <dvhltc@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: rt20 scheduling latency testcase and failure data
Message-ID: <20060518085640.GA5171@elte.hu>
References: <200605121924.53917.dvhltc@us.ibm.com> <200605131601.31880.dvhltc@us.ibm.com> <20060515081341.GB24523@elte.hu> <200605151830.23544.dvhltc@us.ibm.com> <1147941862.4996.15.camel@frecb000686> <20060518084722.GA3343@elte.hu> <1147942687.4996.28.camel@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1147942687.4996.28.camel@frecb000686>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sébastien Dugué <sebastien.dugue@bull.net> wrote:

> > thanks for tracking this down. FYI, the latency of stopping the trace is 
> > that expensive because we are copying large amounts of trace data 
> > around, to ensure that /proc/latency_trace is always consistent and is 
> > updated atomically, and to make sure that we can update the trace from 
> > interrupt contexts too - without /proc/latency_trace accesses blocking 
> > them. The latency of stopping the trace is hidden from the tracer itself 
> > - but it cannot prevent indirect effects such as your app from missing 
> > periods, if the periods are in the 5msec range.
> > 
> 
>   Thanks for the explanation, will have to look deeper into the code 
> to understand how it works though.

there's another complexity on SMP: if trace_all_cpus is set then the 
per-cpu trace buffers are sorted chronologically as well while the 
copying into the current-max-trace-buffer, to produce easier to read 
latency_trace output.

	Ingo
