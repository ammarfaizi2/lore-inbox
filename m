Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWIOQdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWIOQdK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWIOQdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:33:09 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60883 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751681AbWIOQdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:33:06 -0400
Message-ID: <450AD5BA.10003@us.ibm.com>
Date: Fri, 15 Sep 2006 11:32:58 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	<450971CB.6030601@mbligh.org> <y0mmz92cjr2.fsf@ton.toronto.redhat.com>
In-Reply-To: <y0mmz92cjr2.fsf@ton.toronto.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Ch. Eigler wrote:
> "Martin J. Bligh" <mbligh@mbligh.org> writes:
>
> > without all the awk-style language crap that seems to come with
> > systemtap.
>
> I'm sorry to hear you dislike the scripting language.  But that's
> okay, you Real Men can embed literal C code inside systemtap scripts
> to do the Real Work, and leave to systemtap only sundry duties such as
> probe placement and removal.
>   

There are also a couple of projects within SystemTap that provide trace 
like functionality without the need to use the SystemTap language.  In 
the case of LKET, we've tried to make this as simple as possible by 
predefining probe points using the SystemTap language and embedded C 
code, but from a users perspective all he really need to do is just 
invoke a simple script like:

#! stap
process_snapshot() {}
addevent.tskdispatch.cpuidle {}
addevent.process {}
addevent.syscall.entry { printf ("%4b", $flags) }
addevent.syscall.exit {}
addevent.tskdispatch.cpuidle {}

The data can later be analyses in user-space with what ever method you like.  The developer instrumenting the probe point needs to know the Systemtap language, but the user of the trace just need to know which events are available to him.

We also plan to do static tracing once SystemTap supports static markers.  This may not be the perfect solution, but I'm interested in knowing how we can get there.

-JRS
