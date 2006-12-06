Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937200AbWLFT3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937200AbWLFT3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937433AbWLFT3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:29:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60375 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937167AbWLFT3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:29:08 -0500
Date: Wed, 6 Dec 2006 11:28:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0612061126010.3542@woody.osdl.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <20061206190025.GC9959@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Christoph Lameter wrote:
> 
> > For CPUs with load locked + store conditional, it is expensive.
> 
> Because it locks the bus? I am not that familiar with those architectures 
> but it seems that those will have a general problem anyways.

load_locked + store_conditional should _not_ be any more expensive than 
any atomic sequence will always be.

Atomic sequences in SMP are obviously never "cheap". But cmpxchg shouldn't 
be any more expensive than any other atomic sequence if you have 
load-locked and store-conditional.

There are obviously _implementation_ bugs. The early alpha's had such an 
atrocious ldl/stc that it wasn't even funny. That might be true in other 
implementations too, but it's definitely not cmpxchg-specific if so. It 
will affect _any_ atomic ops on such an architecture (atomic_inc() and 
friends)

			Linus
