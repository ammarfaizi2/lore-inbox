Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbWBPJtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWBPJtO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 04:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030584AbWBPJtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 04:49:14 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:21189 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030441AbWBPJtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 04:49:13 -0500
Date: Thu, 16 Feb 2006 10:47:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Cliff Wickman <cpw@sgi.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       george anzinger <george@mvista.com>
Subject: Re: [RFC] sys_setrlimit() in 2.6.16
Message-ID: <20060216094731.GA32676@elte.hu>
References: <20060214222417.GA8479@sgi.com> <20060216005826.4afc87ae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216005826.4afc87ae.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> This has to be considered a bug.  The spec certainly implies that a 
> limit of zero should be honoured and, probably more importantly, 
> that's how it works in 2.4.
> 
> Problem is, the code in there all assumes that an it_prof_expires of 
> zero means "it was never set", and changing that (add a yes-it-has 
> flag?) would be less than trivial.
> 
> So I think the path of least resistance here is to just convert the 
> caller's zero seconds into one second.  That in fact gives the same 
> behaviour as 2.4: you get whacked after one second or more CPU time.
> 
> (This is not a final patch - that revolting expression in 
> sys_setrlimit() needs help first).

your approach looks good to me. It doesnt make much sense anyway to have 
a task whacked right after startup ... so adding a common-sense "the 
user must have meant some really small value" thing doesnt look all that 
wrong.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
