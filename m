Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWGIEWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWGIEWf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 00:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWGIEWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 00:22:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:6296 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964956AbWGIEWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 00:22:34 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Avi Kivity <avi@argo.co.il>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Mark Lord <lkml@rtr.ca>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44AF8668.2070306@argo.co.il>
References: <1152352309.3120.15.camel@laptopd505.fenrus.org>
	 <44AF8668.2070306@argo.co.il>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 14:19:27 +1000
Message-Id: <1152418768.4128.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I didn't suggest the compiler could or should do it, just that it would 
> be possible (for the _user_) to write portable ISO C code to access PCI 
> mmio registers, if volatile's implementation serialized access.

That isn't possible neither. How to actually serialize access can
require different set of primitives depending on the storage class of
the memory you are accessing, which the C compiler has 0 knowledge
about. (For example, cacheable storage vs. write-through vs.
non-cacheable guarded vs. non-cacheable non-guarded on powerpc, there
are different issues on other architectures).

> With the current implementation of volatile in gcc, it is impossible - 
> you need to resort to inline assembly for some architectures, which is 
> not an ISO C feature.

ISO C has never been about writing device drivers. There is simply no
choice here. You need an atchitecture specific set of accessors. If you
want portable code, then pick a library like libpci and make sure it
contains all you need on all the architectures you need. Then write
portable code on top of it. 

> And I'm not suggesting that it would be a good idea to use volatile even 
> if it was corrected - it would have to take a worst-case approach and 
> thus would generate very bad code.

So what is the point ?

Ben.


