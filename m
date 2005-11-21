Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVKUVP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVKUVP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVKUVP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:15:58 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:15582 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750731AbVKUVP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:15:57 -0500
Date: Mon, 21 Nov 2005 22:15:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
Message-ID: <20051121211544.GA4924@elte.hu>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain> <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org> <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org> <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org> <20051121194348.GH1598@parisc-linux.org> <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> At which point you might as well just do something like
> 
> 	struct interrupt_descriptor {
> 		unsigned int nr:31;
> 		unsigned int valid:1;
> 	};
> 
> and then people can just say
> 
> 	if (!dev->irq.valid)
> 		return;
> 
> instead, which is also readable, and where you simply cannot do the old 
> "if (!dev->irq)" at all.
> 
> The fact is, 0 _is_ special. Not just for hardware, but because 0 has 
> a magical meaning as "false" in the C language.

yeah, i wanted to suggest this originally, but got distracted by the x86 
quirk that 'IRQ#0' is often the i8253 timer interrupt.

is there any architecture where irq 0 is a legitimate setting that could 
occur in drivers, and which would make NO_IRQ define of 0 non-practical?  
If not (which i think is the case) then we should indeed standardize on 
0. (in one way or another) It's not like any real driver will ever have 
IRQ#0 even on a PC: the timer IRQ is 'known' to be routed to 0, and we 
do a platform-specific setup_irq() on it. Not a good reason to abstract 
the notion of 'no irq' away into a define.

in fact we dont even have to do the irq.valid thing, !dev->irq is 
obviously readable.

	Ingo
