Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbVLMIk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbVLMIk1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVLMIk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:40:27 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:51923 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964771AbVLMIk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:40:26 -0500
Date: Tue, 13 Dec 2005 09:39:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/15] misc: Make x86 doublefault handling optional
Message-ID: <20051213083942.GD10088@elte.hu>
References: <8.282480653@selenic.com> <200511160713.07632.rob@landley.net> <20051116182145.GP31287@waste.org> <f1079b100511161121g1997cfb4jc8e8aec5072c1d92@mail.gmail.com> <20051212103611.GA6416@elte.hu> <p73u0denv3h.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73u0denv3h.fsf@verdi.suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> > 
> > in the past couple of years i saw double-faults at a rate of perhaps 
> > once a year - and i frequently hack lowlevel glue code! So the 
> > usefulness of this code in the field, and especially on an embedded 
> > platforms, is extremely limited.
> 
> If it only saves an hour or developer time on some bug report it has 
> already justified its value.

yes, of course. Are you arguing that all debugging options should be 
made unconditional? Matt's patch simply makes double-fault-debugging 
optional. More than that, it will still be unconditionally enabled 
unless CONFIG_EMBEDDED is specified.

> Also to really save memory there are much better areas of attack than 
> this relatively slim code.

the dynamics of memory reduction patches is just like the dynamics of 
scalability patches: we have to attack on _every front_ and even then 
progress will appear to be very slow. We almost never reject a 
scalability micro-optimization just because there might be larger fruits 
hanging.

> > in fact, i've experienced triple-faults (== spontaneous reboots) to 
> > be at least 10 times more frequent than double-faults! I.e. _if_ 
> > your kernel (or hardware) is screwed up to the degree that it would 
> > double-fault, it will much more likely also triple-fault.
> 
> A common case where this doesn't hold is breaking the [er]sp in kernel 
> code.
> 
> -Andi (who sees double faults more often)

yeah. Still, i see no problem with making it optional. (as long as it 
does not result in significant uglification of the code - which clearly 
is not a problem for this particular patch.)

	Ingo
