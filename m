Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWINXEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWINXEx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWINXEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:04:53 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:63979 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932104AbWINXEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:04:52 -0400
Date: Fri, 15 Sep 2006 00:56:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914225615.GA29229@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <450971CB.6030601@mbligh.org> <20060914174306.GA18890@elte.hu> <4509B5A4.2070508@mbligh.org> <20060914201448.GA7357@elte.hu> <1158267906.5068.49.camel@localhost> <20060914222318.GA25004@elte.hu> <4509DBBD.6000304@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509DBBD.6000304@mbligh.org>
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


* Martin Bligh <mbligh@mbligh.org> wrote:

> >i disagree. Consider the following example from LTT:
> ...
> >         trace_socket_sendmsg(sock, sock->sk->sk_family,
> >                 sock->sk->sk_type,
> >                 sock->sk->sk_protocol,
> >                 size);
> ...
> 
> >what do the 5 extra lines introduced by trace_socket_sendmsg() tell us? 
> >Nothing. They mostly just duplicate the information i already have from 
> >the function declaration. They obscure the clear view of the function:
>  ...
> >the resulting visual and structural redundancy hurts.
> 
> Couldn't that be easily fixed by just doing
> 
> 	trace_socket_sendmsg(sock, size);
> 
> and have it work out which esoteric parts of the sock we want to 
> trace, and which we don't? Is much less visually invasive, and gives 
> the same effect.

yeah, visual impact is everything. The best that Frank and me came up 
with is:

	_(socket_sendmsg, sock, size);

we could quickly learn to visually skip over lines like that, they have 
a pretty unique geometric form . While if it's called:

	trace_socket_sendmsg(sock, size);

it always looks like a function call in the corner of the eye and 
attracts attention.

the '_()' macro is defined as:

	#define _(x,y,z) STAP_MARK(x,y,z)

(STAP_MARK is an existing SystemTap helper to insert static tracepoints 
into the kernel.)

but the other property of dynamic tracing is still very important too: 
we have the technological freedom to remove static tracepoints, if we 
decide so. With static tracers, once they are in the tree, we are stuck 
with these APIs.

	Ingo
