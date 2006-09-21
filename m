Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWIUS7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWIUS7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWIUS7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:59:06 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:25573 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751466AbWIUS7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:59:05 -0400
Date: Thu, 21 Sep 2006 20:50:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Martin Bligh <mbligh@google.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe management)
Message-ID: <20060921185029.GB12048@elte.hu>
References: <20060921160009.GA30115@Krystal> <20060921175648.GB22226@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921175648.GB22226@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Frank Ch. Eigler <fche@redhat.com> wrote:

> > +#define MARK_SYM(name) \
> > +		here: asm volatile \
> > +			(MARK_KPROBE_PREFIX#name " = %0" : : "m" (*&&here)); \
> 
> Regarding MARK_SYM, if I read Ingo's message correctly, this is the 
> only type of marker he believes is necessary, since it would put a 
> place for kprobes to put a breakpoint.  FWIW, this still appears to be 
> applicable only if the int3 overheads are tolerable, and if parameter 
> data extraction is unnecessary or sufficiently robust "by accident".

let me qualify that: parameters must be prepared there too - but no 
actual function call inserted. (at most a NOP inserted). The register 
filling doesnt even have to be function-calling-convention compliant - 
that makes the symbolic probe almost zero-impact to register 
allocation/scheduling, the only thing it should ensure is that the 
parameters that are annotated to be available in register, stack or 
memory _somewhere_. (i.e. not hidden or destroyed at that point by gcc) 
Does a simple asm() that takes read-only parameters but only adds a NOP 
achieve this result?

	Ingo
