Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751667AbWCHRrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWCHRrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWCHRrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:47:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64656 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751667AbWCHRrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:47:03 -0500
Date: Wed, 8 Mar 2006 09:46:44 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: David Howells <dhowells@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
In-Reply-To: <10414.1141839308@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603080940130.5804@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0603080817500.5481@schroedinger.engr.sgi.com> 
 <31492.1141753245@warthog.cambridge.redhat.com>  <10414.1141839308@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2006, David Howells wrote:

> Hmmm... I would hope people looking at this doc would understand that, but
> I'll see what I can come up with.
> 
> > Note that IA64 has a much more complete set of means to reorder stores and
> > loads. i386 and x84_64 processors can only do limited reordering. So it may
> > make sense to deal with general reordering and then explain i386 as a
> > specific limited case.
> 
> Don't you need to use sacrifice_goat() for controlling the IA64? :-)

Likely...
 
> Besides, I'm not sure that I need to explain that any CPU is a limited case;
> I'm primarily trying to define the basic minimal guarantees you can expect
> from using a memory barrier, and what might happen if you don't. It shouldn't
> matter which arch you're dealing with, especially if you're writing a driver.

memory barrier functions have to be targeted to the processor with the 
ability to do the widest amount of reordering. This is the Itanium AFAIK.

> I tried to create arch-specific sections for describing arch-specific implicit
> barriers and the extent of the explicit memory barriers on each arch, but the
> i386 section was generating lots of exceptions that it looked infeasible to
> describe them; besides, you aren't allowed to rely on such features outside of
> arch code (I count arch-specific drivers as "arch code" for this).

i386 does not fully implement things like write barriers since they have 
an implicit ordering of stores.

> > Also the specific barrier functions of various locking elements varies to 
> > some extend.
> 
> Please elaborate.

F.e. spin_unlock has "release" semantics on IA64. That means that prior 
write accesses are visible before the store, read accesses are also 
completed before the store. However, the processor may perform later read 
and write accesses before the results of the store become visible.


