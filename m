Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVKUWXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVKUWXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVKUWXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:23:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:3018 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751129AbVKUWXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:23:35 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0511211413390.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
	 <24299.1132571556@warthog.cambridge.redhat.com>
	 <20051121121454.GA1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	 <20051121190632.GG1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	 <20051121194348.GH1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
	 <1132607776.26560.23.camel@gaston>
	 <Pine.LNX.4.64.0511211336440.13959@g5.osdl.org>
	 <1132609994.26560.39.camel@gaston>
	 <Pine.LNX.4.64.0511211413390.13959@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 09:20:44 +1100
Message-Id: <1132611645.26560.50.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If we make PCI_NO_IRQ be -1, then PC's need to remap 0 to that value. In 
> pretty much _exactly_ the same places that I suggest that the ppc code 
> should do it.

No. Remapping a valid number to something else means remapping at
runtime for all things that manipulate an irq : issuing it,
enable/disable callbacks, etc...

"Fixing" the definition of "no irq" on x86 means only changing the boot
code that sets up irq numbers, whatever it is.

Thus what solution is technically superior can be argued based on the
fact that your solution introduce overhead to code path that are hot
during normal kernel operations.

Ben.


