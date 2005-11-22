Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVKVQnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVKVQnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbVKVQnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:43:52 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:20144 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964991AbVKVQnv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:43:51 -0500
Date: Tue, 22 Nov 2005 09:43:46 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/5] Ensure NO_IRQ is appropriately defined on all architectures
Message-ID: <20051122164345.GM1598@parisc-linux.org>
References: <E1EeQYc-00055n-Gc@localhost.localdomain> <20051122142755.GA28239@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122142755.GA28239@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 02:27:55PM +0000, Christoph Hellwig wrote:
> On Tue, Nov 22, 2005 at 12:19:06AM -0500, Matthew Wilcox wrote:
> > Add a default definition of NO_IRQ to <linux/hardirq.h> and make the
> > definition in <asm/hardirq.h> uniform across all architectures which
> > define it.
> 
> Please put the definition into <asm/irq.h> and <linux/interrupt.h>,
> hardirq.h is rather misnamed and about the internal irq/softirq/preempt
> mask mechanisms.

Either you're wrong or I'm confused.  I don't see the include path which
necessarily drags asm/irq.h in from linux/interrupt.h.  There's a
linux/interrupt.h -> linux/hardirq.h -> asm/hardirq.h path, but not all
asm/hardirq.h files drag in asm/irq.h.  Look at sparc64 or alpha for
examples of that.

Personally, I'd like to see asm/hardirq.h go away and move all its
contents into asm/irq.h.  And I'd like to see asm/irq.h included
explicitly from linux/interrupt.h.  And I'd like to see drivers stop
including asm/irq.h.

While I'm dreaming, I'd like a pony.
