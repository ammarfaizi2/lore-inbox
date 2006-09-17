Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWIQXgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWIQXgP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 19:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWIQXgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 19:36:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59858 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965157AbWIQXgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 19:36:14 -0400
Date: Mon, 18 Sep 2006 01:27:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060917232714.GA18713@elte.hu>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <Pine.LNX.4.64.0609171651370.6761@scrub.home> <20060917150953.GB20225@elte.hu> <Pine.LNX.4.64.0609171816390.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609171816390.6761@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.7 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_40 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.1 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.3442]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> What is so special between users of dynamic and static tracers, that 
> the former will never complain, if some tracepoint doesn't work 
> anymore?

If by breakage you mean accidental regressions, i was not talking about 
accidental breakages when i suggested that dynamic tracers would not see 
them. The "breakage" i talked about, and which would cause regressions 
to static tracer users but would not be noticed by dynamic tracer users 
was:

	_the moving of a static marker to a dynamic script_

(see <20060915204812.GA6909@elte.hu>, my first paragraph there. Also see 
<20060917143623.GB15534@elte.hu> for the same topic.)

this breaks static tracers, but dynamic tracers remain unaffected, 
because the dynamic probe (or the function attribute) still offers 
equivalent functionality. Hence users of dynamic tracers still have the 
same functionality - while users of static tracers see breakage. Ok?

If you meant accidental breakages, then of course users of both types of 
tracers would be affected, but even in this case there's a more subtle 
difference here, which i explained in <20060917143623.GB15534@elte.hu>:

>> In fact, with dynamic tracers, an end-user visible breakage can even 
>> be fixed _after the main kernel has been released, compiled and 
>> booted on the end-user's system_. Systemtap scripts can be updated on 
>> live systems. So there is very, very little maintainance pressure 
>> caused by dynamic tracing.

i hope this explains.

	Ingo
