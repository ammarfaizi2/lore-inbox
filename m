Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWISTYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWISTYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWISTYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:24:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7592 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751019AbWISTYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:24:09 -0400
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: Re: [PATCH] Linux Kernel Markers 0.2 for Linux 2.6.17
References: <20060919183447.GA16095@Krystal>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 19 Sep 2006 15:23:18 -0400
In-Reply-To: <20060919183447.GA16095@Krystal>
Message-ID: <y0m4pv3ek49.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> writes:

> Following some very interesting ideas from Martin that shows that
> even static function calls and inlined functions can be used in
> interesting ways with markers to deploy dynamic tracers with easy
> access to local function variables [...]

While that has been an interesting idea, its implementation would need
to be sketched out far beyond the speculative, in order to override
what I perceive as the rough consensus reached during earlier in the
thread.

> [...]  These last emails convince me even more that a markup
> mechanism must interface with every kind of instrumentation hooking
> we can think about, both dynamic and static. [...]

If you don't allow yourself to presume on-the-fly function
recompilation, then these markers would need to be made run-time
rather than compile-time configurable.  That is, not like this:

> +/* Menu configured markers */
> +#ifndef CONFIG_MARK
> +#define MARK	MARK_INACTIVE
> +#elif defined(CONFIG_MARK_PRINT)
> +#define MARK	MARK_PRINT
> +#elif defined(CONFIG_MARK_FPROBE)
> +#define MARK	MARK_FPROBE
> +#elif defined(CONFIG_MARK_KPROBE)
> +#define MARK	MARK_KPROBE
> +#elif defined(CONFIG_MARK_JPROBE)
> +#define MARK	MARK_JPROBE
> +#endif

- FChE
