Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVKUVUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVKUVUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVKUVUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:20:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:5321 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750700AbVKUVUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:20:03 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
	 <24299.1132571556@warthog.cambridge.redhat.com>
	 <20051121121454.GA1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	 <20051121190632.GG1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	 <20051121194348.GH1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 08:16:15 +1100
Message-Id: <1132607776.26560.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The fact is, 0 _is_ special. Not just for hardware, but because 0 has a 
> magical meaning as "false" in the C language.

I don't agree, irq 0 has been a valid irq on a number of platforms for
ages (including your own G5, at least some of them have the SATA irq at
0 :) and this didn't cause any problem for most drivers. The few ones
that have done broken assumption have been easily fixed using NO_IRQ.

"Translating" it means some ugly translation work all over the place,
which means overhead in the interrupt path (ok, not that much but
still), plus finding some magic number to put 0 on, which makes things
much more complicated for archs that have interrupts sorted in nice
blocks of power of two, etc... a significant burden on arch/PIC code for
no good reason imho.

I hate arbitrary "translations" when they aren't strictly necessary.
It's common to have a constant for a "not valid" number in spaces where
"0" is a valid value, I don't think that "looking simpler" to dump
driver writers is worth it in this case.

Ben.


