Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWCHRgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWCHRgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWCHRgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:36:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7059 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751667AbWCHRgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:36:17 -0500
Date: Wed, 8 Mar 2006 12:36:05 -0500
From: Alan Cox <alan@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Message-ID: <20060308173605.GB13063@devserv.devel.redhat.com>
References: <20060308145506.GA5095@devserv.devel.redhat.com> <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <9834.1141837491@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9834.1141837491@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 05:04:51PM +0000, David Howells wrote:
> > [For information on bus mastering DMA and coherency please read ....]
> > sincee have a doc on this
> 
> Documentation/pci.txt?

and:

Documentation/DMA-mapping.txt
Documentation/DMA-API.txt
> 
> > The use of volatile generates poorer code and hides the serialization in 
> > type declarations that may be far from the code.
> 
> I'm not sure what you mean by that.

in foo.h

	struct blah {
		volatile int x;	/* need serialization
	}

2 million miles away

	blah.x = 1;
	blah.y = 4;

And you've no idea that its magically serialized due to a type declaration
in a header you've never read. Hence the "dont use volatile" rule

> > Is this true of IA-64 ??
> 
> Are you referring to non-temporal loads and stores?

Yep. But Matthew answered that

> > Should clarify local ordering v SMP ordering for locks implied here.
> 
> Do you mean explain what each sort of lock does?

spin_unlock ensures that local CPU writes before the lock are visible
to all processors before the lock is dropped but it has no effect on 
I/O ordering. Just a need for clarity.

> > > + (*) inX(), outX():
> > > +
> > > +     These are intended to talk to legacy i386 hardware using an alternate bus
> > > +     addressing mode.  They are synchronous as far as the x86 CPUs are
> > 
> > Not really true. Lots of PCI devices use them. Need to talk about "I/O space"
> 
> Which bit is not really true?

The "legacy i386 hardware" bit. Many processors have an I/O space.

