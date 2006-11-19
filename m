Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933213AbWKSUgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933213AbWKSUgP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933230AbWKSUgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:36:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:47594 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S933213AbWKSUgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:36:14 -0500
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
In-Reply-To: <4560BF28.8010406@ru.mvista.com>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	 <1163966437.5826.99.camel@localhost.localdomain>
	 <20061119200650.GA22949@elte.hu>
	 <1163967590.5826.104.camel@localhost.localdomain>
	 <20061119202348.GA27649@elte.hu>  <4560BF28.8010406@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:36:10 +1100
Message-Id: <1163968570.5826.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 23:31 +0300, Sergei Shtylyov wrote:

>    The fasteoi flow seem to only had been used for x86 IOAPIC in the RT patch 
> only *before* PPC took to using them in the mainline...

I don't think so, I asked for the fasteoi to be created while porting
ppc to genirq :-)

> > threaded handlers need a mask() + an ack(), because that's the correct
> 
>     Not all of them. This could be customized on type-by-type basis. I.e. we 
> could call eoi() instead of ack() for fasteoi chips without having to resort 
> to the duplicated ack/eoi handlers.

I still don't see how ack() makes sense in the context of a fasteoi...
You can either just not EOI until it's handled, but you'll indeed
introduce delays for other interrupts of the same priority or lower, or
you can mask() and then eoi(), which is, I think, what Apple does, to
deliver the interrupt to a thread (and later unmask).

In any case, I don't see the need for a separate ack().

Ben.


