Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWIVHPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWIVHPa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 03:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWIVHPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 03:15:30 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:17895 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750795AbWIVHP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 03:15:29 -0400
Date: Fri, 22 Sep 2006 09:07:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
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
Message-ID: <20060922070714.GB4167@elte.hu>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921214248.GA10097@Krystal>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4986]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:

> I clearly expressed my position in the previous emails, so did you. 
> You argued about a use of tracing that is not relevant to my vision of 
> reality, which is :
> 
> - Embedded systems developers won't want a breakpoint-based probe

are you arguing that i'm trying to force breakpoint-based probing on 
you? I dont. In fact i explicitly mentioned that i'd accept and support 
a 5-byte NOP in the body of the marker, in the following mails:

    "just go for [...] the 5-NOP variant"
      http://marc.theaimsgroup.com/?l=linux-kernel&m=115859771924187&w=2
        (my reply to your second proposal)

    "or at most one NOP"
      http://marc.theaimsgroup.com/?l=linux-kernel&m=115865412332230&w=2
        (my reply to your third proposal)

    "at most a NOP inserted"
      http://marc.theaimsgroup.com/?l=linux-kernel&m=115886524224874&w=2
        (my reply to your fifth proposal)

That enables the probe to be turned into a function call - not an INT3 
breakpoint. Does it take some effort to implement that on your part? 
Yes, of course, but getting code upstream is never easy, /especially/ in 
cases where most of the users wont use a particular feature.

> - High performance computing users won't want a breakpoint-based probe

I am not forcing breakpoint-based probing, at all. I dont want _static, 
build-time function call based_ probing, and there is a big difference. 
And one reason why i want to avoid "static, build-time function call 
based probing" is because high-performance computing users dont want any 
overhead at all in the kernel fastpath.

> - djprobe is far away from being in an acceptable state on 
>   architectures with very inconvenient erratas (x86).

djprobes over a NOP marker are perfectly usable and safe: just add a 
simple constraint to them to only allow a djprobes insertion if it 
replaces a 5-byte NOP.

> - kprobe and djprobe cannot access local variables in every cases

it is possible with the marker mechanism i outlined before:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=115886524224874&w=2

have i missed to address any concern of yours?

	Ingo
