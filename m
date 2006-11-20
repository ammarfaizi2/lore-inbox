Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966251AbWKTR2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966251AbWKTR2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966253AbWKTR2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:28:03 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:12684 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966246AbWKTR1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:27:44 -0500
Date: Mon, 20 Nov 2006 18:26:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi type IRQ handlers
Message-ID: <20061120172642.GA8683@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com> <1163966437.5826.99.camel@localhost.localdomain> <20061119200650.GA22949@elte.hu> <1163967590.5826.104.camel@localhost.localdomain> <20061119202348.GA27649@elte.hu> <1163985380.5826.139.camel@localhost.localdomain> <20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com> <20061120165621.GA1504@elte.hu> <4561DFE1.4020708@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4561DFE1.4020708@ru.mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0937]
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
> 
> Ingo Molnar wrote:
> 
> >>>on PPC64, 'get the vector' initiates an ACK as well - is that done 
> >>>before handle_irq() is done?
> 
> >>  Exactly. How else do_IRQ() would know the vector?
> 
> >the reason i'm asking is that in this case masking is a bit late at this 
> >point and there's a chance for a repeat interrupt.
> 
>    How's that? Acknowledge != EOI on OpenPIC (as well as 8259). 
> Acknoledging sets the bit in the in-service register preventing all 
> the interrupts with same or lower prioriry from being accepted.

ah, ok. The x86 APIC does that automatically, and only an EOI has to be 
passed. So i guess we are in wild agreement ;)

i'm hacking up something now to see whether it makes sense to introduce 
a central threaded flow type, or whether it's better the branch off the 
current flow types (as the code does it right now).

	Ingo
