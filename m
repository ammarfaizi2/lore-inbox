Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWIOVZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWIOVZq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWIOVZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:25:46 -0400
Received: from tomts43-srv.bellnexxia.net ([209.226.175.110]:37309 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932278AbWIOVZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:25:45 -0400
Date: Fri, 15 Sep 2006 17:25:42 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: "Jose R. Santos" <jrs@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915212541.GA18958@Krystal>
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450B164B.7090404@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <450B164B.7090404@us.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 17:13:57 up 23 days, 18:22,  2 users,  load average: 0.35, 0.27, 0.22
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jose R. Santos (jrs@us.ibm.com) wrote:
> To some people performance is the #1 priority and to other it is 
> flexibility.  I would like to come up with a list of those probe point 
> that absolutely need to be inserted into the code statically.  Those 
> that are not absolutely critical to have statically should be 
> implemented dynamically.
> 

I agree with you that only very specific parts of the kernel have this kind of
high throughput. Using kprobes for lower thoughput tracepoints if perfectly
acceptable from my point of view, as it does not perturb the system too much.

I would suggest (as a beginning) those "standard" hi event rate tracepoints :

(taken from the highest rates in
http://sourceware.org/ml/systemtap/2005-q4/msg00451.html)

- syscall entry/exit
- irq entry/exit
- softirq entry/exit
- tasklet entry/exit
- trap entry/exit
- scheduler change
- wakeup
- network traffic (packet in/out)
- "select" and "poll" system calls
- page_alloc/page_free

(be warned : this list is probably incomplete, too exhaustive or can cause
dizziness under stress condition) :)

However, a tracing infrastructure should still provide the ability for
developers to instrument their own high traffic interrupt handler with a very
low overhead.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
