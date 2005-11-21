Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVKUWei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVKUWei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVKUWei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:34:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2223 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751156AbVKUWeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:34:37 -0500
Date: Mon, 21 Nov 2005 14:34:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <1132610954.26560.46.camel@gaston>
Message-ID: <Pine.LNX.4.64.0511211429190.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain> 
 <24299.1132571556@warthog.cambridge.redhat.com>  <20051121121454.GA1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>  <20051121190632.GG1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>  <20051121194348.GH1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>  <20051121211544.GA4924@elte.hu>
  <17282.15177.804471.298409@cargo.ozlabs.ibm.com>  <20051121213527.GA6452@elte.hu>
  <Pine.LNX.4.64.0511211350010.13959@g5.osdl.org> <1132610954.26560.46.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, Benjamin Herrenschmidt wrote:
> 
> The ppc irq handling is more complex than that due to the wide range of
> different hardware. We parse the irq tree from OF and assign them to
> ranges of numbers allocated per controller. Adding some remapping of
> some numbers would add complexity and possible bugs.

Let me rephrase that as: "On ppc we already _do_ irq mapping, but we made 
a mistake to map to 0, so to cover up that mistake we now want everybody 
else to change how they have done things since day 1".

See? You argue that there might be "possible bugs". Yet you totally ignore 
the fact that I can absolutely point to code that we _know_ depends on 
"zero means no irq". So when you argue for changing away from that, I 
GUARANTEE you that it has a higher likelihood of bugs AND that it affects 
a hell of a lot more code than the alternative I propose.

Anyway, let's just stop this discussion. Let's just leave PCI_NO_IRQ as 0 
on x86, and let PPC has it as -1. Problem solved. That way we are 
guaranteed to not introduce any new bugs. It works today, and we can just 
ignore this whole patch-series, since centralizing NO_IRQ is clearly the 
wrong thing to do.

By centralizing NO_IRQ, you either have to break a lot of existing PC 
setups, or you have to potentially break (far fewer) PowerPC setups. So 
let's not do it at all.

		Linus
