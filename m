Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965720AbWKDWSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965720AbWKDWSr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 17:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965719AbWKDWSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 17:18:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:8401 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965720AbWKDWSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 17:18:46 -0500
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20061104140559.GC19760@flint.arm.linux.org.uk>
References: <1162626761.28571.14.camel@localhost.localdomain>
	 <20061104140559.GC19760@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 09:17:18 +1100
Message-Id: <1162678639.28571.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-04 at 14:06 +0000, Russell King wrote:
> On Sat, Nov 04, 2006 at 06:52:41PM +1100, Benjamin Herrenschmidt wrote:
> > In fact, I would be very very very much in favor of, instead of the
> > above, defining a set of:
> > 
> > readsb, readsw, readsl, readsq
> > writesb, writesw, writesl, writesq
> 
> ARM already has these.  Sounds like a good idea for everyone else to also
> implement them. 8)

Ok, powerpc will have these in 2.6.20 then :-)

I'm tempted to remove those mmio_* things from iomap.c completely. I
need to check who uses them, but in all cases, I don't see what they do
in iomap.c, it's not their place.

Versions that would transparently use MMIO or PIO would make sense. A
pure MMIO implementation doesn't, that has to be arch specific. It makes
the generic iomap suddently non-portable in some ways.

So I think we need to make sure all archs grow readsb,sw,sl etc... and
just have iomap use those for the "transparent" versions.

Ben.


