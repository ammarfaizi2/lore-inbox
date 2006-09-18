Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWIRPTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWIRPTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWIRPTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:19:46 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14470 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751768AbWIRPTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:19:43 -0400
Date: Mon, 18 Sep 2006 17:11:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Theodore Tso <tytso@mit.edu>, Nicholas Miell <nmiell@comcast.net>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: LTTng and SystemTAP (Everyone who is scared to read this huge thread, skip to here)
Message-ID: <20060918151059.GA10106@elte.hu>
References: <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu> <450DEEA5.7080808@opersys.com> <20060918005624.GA30835@elte.hu> <450DFFC8.5080005@opersys.com> <20060918033027.GB11894@elte.hu> <20060918035216.GF9049@thunk.org> <450E1F6F.7040401@opersys.com> <20060918043248.GB19843@elte.hu> <20060918050310.GC15930@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918050310.GC15930@Krystal>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> > Some of the extensive hooking you do in LTT could be aleviated to a 
> > great degree if you used dynamic probes. For example the syscall 
> > entry hackery in LTT looks truly scary.
> 
> Yes, agreed. The last time I checked, I thought about moving this 
> tracing code to the syscall_trace_entry/exit (used for security hooks 
> and ptrace if I remember well). I just didn't have the time to do it 
> yet.

correct, that's where all such things (auditing, seccomp, ptrace, 
sigstop, freezing, etc.) hook into. Much (all?) of the current entry.S 
hacks can go away in favor of a much easier .c patch to 
do_syscall_trace() and this would reduce a significantion portion of the 
present intrusiveness of LTTng.

	Ingo
