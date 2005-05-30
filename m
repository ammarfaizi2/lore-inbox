Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVE3XUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVE3XUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVE3XUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:20:46 -0400
Received: from opersys.com ([64.40.108.71]:55311 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261819AbVE3XTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:19:15 -0400
Message-ID: <429BA1D7.2010404@opersys.com>
Date: Mon, 30 May 2005 19:29:27 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, James Bruce <bruce@andrew.cmu.edu>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <20050530222747.GB9972@nietzsche.lynx.com> <429B99B4.9090005@opersys.com> <20050530230557.GF9972@nietzsche.lynx.com>
In-Reply-To: <20050530230557.GF9972@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Huey (hui) wrote:
> When I think about it in terms of dual kernel primitives, I really have
> difficulty thinking about how to use the message queue stuff to integrate
> all of the systems involved in particular with shared buffers. Proper
> locking in those cases is scary to me for both methods, but at least
> the single kernel image stuff uses familiar chunks of memory that I can
> manipulate. I'm open to be proven wrong about this point if you have a
> good example sources to show me. I really am.

Having shared buffers between adeos and Linux and/or rtai and Linux is
common practice. The're all living in the same address space anyway.
So from that point of view, just lock those pages in memory.

The issue then becomes, how do these domain all talk to each other.
At the lowest of levels, Adeos provides a fairly simple inter-domain
communication mechanism: virtual interrupts. If you have a driver that
must absolutely get hard-rt responsiveness, you load it as a priority
Adeos domain and have its hard-rt handler shoot virtual interupts to
its non-rt linux upper half using a virtual interrupt, which can then
do the rest of the work that would be done by an interrupt handler.
The reverse is also possible: use a normal linux driver to feed
virtual interrupts to higher-priority adeos domain.

These are basic primitives, and it isn't difficult to see how fancy
services can be built on. As is RTAI for example.

Again, none of this precludes working to reduce Linux's responsiveness,
but it may just save the need for modifying the locking mechanisms
or threading the interrupt handlers.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
