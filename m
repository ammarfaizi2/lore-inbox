Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWIOOfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWIOOfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWIOOfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:35:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56290 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751537AbWIOOfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:35:52 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: karim@opersys.com
Cc: Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <450ABA2A.9060406@opersys.com>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>
	 <20060914135548.GA24393@elte.hu>
	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>
	 <20060914171320.GB1105@elte.hu>
	 <Pine.LNX.4.64.0609141935080.6761@scrub.home>
	 <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com>
	 <1158320406.29932.16.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609151339190.6761@scrub.home>
	 <1158323938.29932.23.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609151425180.6761@scrub.home>
	 <1158327696.29932.29.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609151523050.6761@scrub.home>
	 <1158331277.29932.66.camel@localhost.localdomain>
	 <450ABA2A.9060406@opersys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:58:44 +0100
Message-Id: <1158332324.29932.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-15 am 10:35 -0400, ysgrifennodd Karim Yaghmour:
> Care to explain how I can use to implement the equivalent of this:
> 
> @@ -1709,6 +1712,7 @@ switch_tasks:
>    		++*switch_count;
> 
>    		prepare_arch_switch(rq, next);
> +		TRACE_SCHEDCHANGE(prev, next);
>    		prev = context_switch(rq, prev, next);
>    		barrier();

The gdb debug data lets you find each line and also the variable
assignments (except when highly optimised in some cases). Try
breakpointing there with kgdb and using "where"... A kgdb script is the
wrong way to do instrumentation but it does demonstrate the information
is already out there, automatically generated and self maintaining.

You do need the gdb -g debug data, but equally if it was static you'd
need to recompile with the tracepoint because it would be off by
default, and there is a very small risk in both cases you'll disturb or
change the code behaviour/flow.

> Also, care to explain how kprobes can be used to access same data
> without having to actually customize a probe point for every binary?

Thats why we have things like systemtap.

All we appear to lack is systemtap ability to parse debug data so it can
be told "trace on line 9 of sched.c and record rq and next"

Alan

