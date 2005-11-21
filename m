Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVKUWMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVKUWMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVKUWMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:12:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:59849 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751141AbVKUWMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:12:15 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>
In-Reply-To: <Pine.LNX.4.64.0511211350010.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
	 <24299.1132571556@warthog.cambridge.redhat.com>
	 <20051121121454.GA1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	 <20051121190632.GG1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	 <20051121194348.GH1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
	 <20051121211544.GA4924@elte.hu>
	 <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
	 <20051121213527.GA6452@elte.hu>
	 <Pine.LNX.4.64.0511211350010.13959@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 09:09:13 +1100
Message-Id: <1132610954.26560.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 13:51 -0800, Linus Torvalds wrote:
> 
> On Mon, 21 Nov 2005, Ingo Molnar wrote:
> > 
> > oh well [*]. Then it's gotta be the !dev->irq.valid thing i guess. 
> 
> No it's not.
> 
> The ppc PCI probing could trivilly just turn a 0 into 256 (or equivalent), 
> and mask off the low 7 bits when installing the handler.  They know the 
> interrupt is _really_ 0 from other sources (ie they have a different 
> firmware, with explicit callbacks, and/or hardcoded knowledge).

The ppc irq handling is more complex than that due to the wide range of
different hardware. We parse the irq tree from OF and assign them to
ranges of numbers allocated per controller. Adding some remapping of
some numbers would add complexity and possible bugs.

Ben.


