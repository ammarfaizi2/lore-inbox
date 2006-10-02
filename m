Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWJBPtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWJBPtg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWJBPtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:49:36 -0400
Received: from tomts43.bellnexxia.net ([209.226.175.110]:8416 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S964821AbWJBPtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:49:35 -0400
Date: Mon, 2 Oct 2006 11:38:49 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: "Jose R. Santos" <jrs@us.ibm.com>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
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
Message-ID: <20061002153849.GA19568@Krystal>
References: <20060930180157.GA25761@Krystal> <45212F1E.3080409@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45212F1E.3080409@us.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:33:01 up 40 days, 12:41,  4 users,  load average: 0.82, 0.71, 0.54
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jose,

* Jose R. Santos (jrs@us.ibm.com) wrote:
> 
> The problem now is how do we define "high event rate".  This is 
> something that is highly dependent on the workload being run as well as 
> the system configuration for such workload.  There are a lot of places 
> in the kernel that can be turned into high event rates with with the 
> right workload even though the may not represent 99% of most user cases. 
> 
> I would guess that anything above 500 event/s per-CPU on several 
> realistic workloads is a good place to start.
> 
Yes, it seems like a good starting point. But besides the event rate, just
having the most widely used events marked in the code should also be the
target. The markup mechanism serves two purposes :
1 - identify important events in a way that follows code change.
2 - speed up instrumentation.

> 
> >On the macro-benchmark side, no significant difference in performance has 
> >been
> >found between the vanilla kernel and a kernel "marked" with the standard 
> >LTTng
> >instrumentation.
> >  
> 
> Out of curiosity,  how many cycles does it take to process a complete 
> LTTng event up until the point were it has been completely stored into 
> the trace buffer.  Since this should take a lot more than 55.74 cycles, 
> it would be interesting to know at what event rate would a static marker 
> stop showing as big of a performance advantage compared to dynamic probing.
> 

In my OLS paper, I pointed out that, in its current state, LTTng took about 278
cycles on the same Pentium 4. I think I could lower that by implementing per-cpu
atomic operations (removing the LOCK prefix, as the data is not shared between
the CPUs; the atomic operations are only useful to protect from higher priority
execution contexts on the same CPU).

Regards,

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
