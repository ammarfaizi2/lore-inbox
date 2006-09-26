Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751657AbWIZAZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWIZAZz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 20:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWIZAZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 20:25:55 -0400
Received: from tomts40.bellnexxia.net ([209.226.175.97]:37089 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751656AbWIZAZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 20:25:54 -0400
Date: Mon, 25 Sep 2006 20:25:51 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Jeremy Fitzhardinge <jeremy@goop.org>
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Pavel Machek <pavel@suse.cz>, Joe Perches <joe@perches.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.13 for 2.6.17
Message-ID: <20060926002551.GA18276@Krystal>
References: <20060925233349.GA2352@Krystal> <20060925235617.GA3147@Krystal> <45187146.8040302@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45187146.8040302@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 20:22:28 up 33 days, 21:31,  3 users,  load average: 0.05, 0.21, 0.24
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Mathieu Desnoyers wrote:
> >Just as a precision :
> >
> >The following sequence (please refer to the code below for local symbols
> >1 and 2) :
> >
> >1:
> >preempt_disable()
> >call (*__mark_call_##name)(format, ## args);
> >preempt_enable_no_resched()
> >2:
> >
> >is insured because :
> >
> >1 is part of an inline assembly with rw dependency on __marker_sequencer
> >the call is surrounded by memory barriers.
> >2 is part of an inline assembly with rw dependency on __marker_sequencer
> >  
> 
> What do you mean the call is surrounded by memory barriers?  Do you mean 
> a call has an implicit barrier, or something else?
> 
Yes, preempt_disable() has a barrier(), on gcc :
__asm__ __volatile__("": : :"memory").


> Either way, this doesn't prevent some otherwise unrelated 
> non-memory-using code from being scheduled in there, which would not be 
> executed.  The gcc manual really strongly discourages jumping between 
> inline asms, because they have basically unpredictable results.
> 

Ok, I will do the call in assembly then.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
