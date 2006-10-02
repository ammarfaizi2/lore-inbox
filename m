Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWJBP0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWJBP0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWJBP0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:26:47 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:9438 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964795AbWJBP0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:26:45 -0400
Message-ID: <45212F1E.3080409@us.ibm.com>
Date: Mon, 02 Oct 2006 10:24:14 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Karim Yaghmour <karim@opersys.com>, Pavel Machek <pavel@suse.cz>,
       Joe Perches <joe@perches.com>, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Performance analysis of Linux Kernel Markers 0.20 for 2.6.17
References: <20060930180157.GA25761@Krystal>
In-Reply-To: <20060930180157.GA25761@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> However, the performance impact for using a kprobe is non negligible when
> activated. Assuming that kprobes would have a mechanism to get the variables
> from the caller's stack, it would perform the same task in at least 4178.23
> cycles vs 55.74 for a marker and a probe (ratio : 75). While kprobes are very
> useful for the reason explained earlier, the high event rate paths in the kernel
> would clearly benefit from a marker mechanism when the are probed.
>   

The problem now is how do we define "high event rate".  This is 
something that is highly dependent on the workload being run as well as 
the system configuration for such workload.  There are a lot of places 
in the kernel that can be turned into high event rates with with the 
right workload even though the may not represent 99% of most user cases. 

I would guess that anything above 500 event/s per-CPU on several 
realistic workloads is a good place to start.


> On the macro-benchmark side, no significant difference in performance has been
> found between the vanilla kernel and a kernel "marked" with the standard LTTng
> instrumentation.
>   

Out of curiosity,  how many cycles does it take to process a complete 
LTTng event up until the point were it has been completely stored into 
the trace buffer.  Since this should take a lot more than 55.74 cycles, 
it would be interesting to know at what event rate would a static marker 
stop showing as big of a performance advantage compared to dynamic probing.

-JRS
