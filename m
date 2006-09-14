Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWINRz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWINRz4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWINRz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:55:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:40348 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750855AbWINRzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:55:55 -0400
Date: Thu, 14 Sep 2006 19:55:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060914171320.GB1105@elte.hu>
Message-ID: <Pine.LNX.4.64.0609141935080.6761@scrub.home>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
 <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu>
 <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Sep 2006, Ingo Molnar wrote:

> also, the other disadvantages i listed very much count too. Static 
> tracepoints are fundamentally limited because:
> 
>   - they can only be added at the source code level
> 
>   - modifying them requires a reboot which is not practical in a
>     production environment
> 
>   - there can only be a limited set of them, while many problems need
>     finegrained tracepoints tailored to the problem at hand
> 
>   - conditional tracepoints are typically either nonexistent or very
>     limited.
> 
> for me these are all _independent_ grounds for rejection, as a generic 
> kernel infrastructure.

Tracepoints of course need to be managed, but that's true for both dynamic 
and static tracepoints. Both have their advantages and disadvantages and 
just hammering on the possible problems of static ones (which are not much 
of a problem for other people) is highly unfair and not a reason for 
rejection. If you don't like them, don't use them, nobody forces you, it's 
that simple...

> > You didn't address my main issue at all - kprobes is only available 
> > for a few archs...
> 
> the kprobes infrastructure, despite being fairly young, is widely 
> available: powerpc, i386, x86_64, ia64 and sparc64. The other 
> architectures are free to implement them too, there's nothing 
> hardware-specific about kprobes and the "porting overhead" is in essence 
> a one-time cost - while for static tracepoints the maintainance overhead 
> goes on forever and scales linearly with the number of tracepoints 
> added.

kprobes are not trivial to implement (especially to reach the level of 
perfomance and flexibility of static tracepoints) and until then you deny 
their users/developers a useful tool? 
I also think you highly exaggerate the maintaince overhead of static 
tracepoints, once added they hardly need any maintainance, most of the 
time you can just ignore them. Only if the code drastically changes they 
need to be adjusted, but at that point this should be the smallest 
problem. The kernel is full debug prints, do you seriously suggest to 
throw them out because of their "high maintainance"?

bye, Roman
