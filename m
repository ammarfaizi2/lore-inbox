Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWIRUN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWIRUN2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbWIRUN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:13:28 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:21915 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id S1751163AbWIRUN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:13:27 -0400
Subject: Re: tracepoint maintainance models
From: Michel Dagenais <michel.dagenais@polymtl.ca>
To: Theodore Tso <tytso@mit.edu>
Cc: Ingo Molnar <mingo@elte.hu>, Karim Yaghmour <karim@opersys.com>,
       Nicholas Miell <nmiell@comcast.net>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
In-Reply-To: <20060918035216.GF9049@thunk.org>
References: <450D182B.9060300@opersys.com>
	 <20060917112128.GA3170@localhost.usen.ad.jp>
	 <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy>
	 <20060917230623.GD8791@elte.hu> <450DEEA5.7080808@opersys.com>
	 <20060918005624.GA30835@elte.hu> <450DFFC8.5080005@opersys.com>
	 <20060918033027.GB11894@elte.hu>  <20060918035216.GF9049@thunk.org>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 16:12:16 -0400
Message-Id: <1158610337.11161.86.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Poly-FromMTA: (saorge.dgi.polymtl.ca [132.207.169.35]) at Mon, 18 Sep 2006 20:12:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ... I don't understand why LTT and SystemTap can't just
> merge and play nice together....

For simple userland tasks, GDB might be all one needs. In other cases,
strace is less intrusive. Yet, in many occasions, the problem is not
reproducible under strace because the timing is changed and a better
mechanism is needed.

Similarly, most sysadmins will be delighted to dynamically activate a
few tracepoints on their live system and catch their problem. In
difficult cases (e.g. distributed application in a large cluster,
embedded systems, nasty problem in the interrupt routine of a device
driver) you need the tool with the lowest disturbance and you will be
ready to recompile and reboot if necessary. If kprobes can achieve this
lowest disturbance (i.e. superior to a static tracepoint in almost all
cases) life will be simpler for all of us.

It does not appear to be the case, however. There are a number of
contexts where kprobes cannot be set (e.g. NMI, m68k :-) and, despite
not having the same reentrancy, its performance is lower than LTTng.
Note that the kprobe performance has improved over the weekend and we
should all be glad of that!

I am looking forward to having the best possible tools, indeed converge
to "merge" and play nice, taking the best parts from each system
(dynamic tracepoints with SystemTap, static tracepoints if needed for
more critical areas, the efficient reentrant per cpu LTTng/Relay
recording infrastructure...).

