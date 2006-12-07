Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937866AbWLGAzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937866AbWLGAzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937869AbWLGAzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:55:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60470 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937866AbWLGAzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:55:07 -0500
Date: Wed, 6 Dec 2006 16:54:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Matthew Wilcox <matthew@wil.cx>, Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <Pine.LNX.4.64.0612070130240.1868@scrub.home>
Message-ID: <Pine.LNX.4.64.0612061650240.3542@woody.osdl.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
 <20061206195820.GA15281@flint.arm.linux.org.uk> <20061206213626.GE3013@parisc-linux.org>
 <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com>
 <20061206220532.GF3013@parisc-linux.org> <Pine.LNX.4.64.0612070130240.1868@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2006, Roman Zippel wrote:
> On Wed, 6 Dec 2006, Matthew Wilcox wrote:
> 
> > To be honest, it'd be much easier if we only defined these operations on
> > atomic_t's.  We have all the infrastructure in place for them, and
> > they're fairly well understood.  If you need different sizes, I'm OK
> > with an atomic_pointer_t, or whatever.
> 
> FWIW Seconded.

I disagree.

Any _real_ CPU will simply never care about _anything_ else than just the 
size of the datum in question. There's absolutely no point to only allow 
it on certain types, especially as we _know_ those certain types are 
already going to be more than one, and we also know that they are going to 
be different sizes. In other words, in reality, we have to handle a 
sizeable subset of the whole generic situation, and the "on certain types 
only" situation is only going to be awkward and irritating.

For example, would we have a different "cmpxchg_ptr()" function for the 
atomic pointer thing? With any reasonable CPU just depending on the _size_ 
of the type, I don't see what the problem is with just doing the 
bog-standard "cmpxchg_8/16/32/64" and having the bog-standard case- 
statement in a header file to do it all automatically for you, and then we 
don't need to worry about it.

		Linus
