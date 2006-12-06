Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937714AbWLFWFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937714AbWLFWFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937707AbWLFWFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:05:35 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:54471 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937705AbWLFWFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:05:33 -0500
Date: Wed, 6 Dec 2006 15:05:32 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Lameter <clameter@sgi.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061206220532.GF3013@parisc-linux.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <20061206213626.GE3013@parisc-linux.org> <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 01:52:20PM -0800, Christoph Lameter wrote:
> On Wed, 6 Dec 2006, Matthew Wilcox wrote:
> 
> > And for those of us with only load-and-zero, that's simply:
> > 
> > #define load_locked(addr) spin_lock(hash(addr)), *addr
> > #define store_exclusive(addr, old, new) \
> > 			*addr = new, spin_unlock(hash(addr)), 0
> > 
> > which is also optimal for us.
> 
> This means we tolerate the assignment race for SMP that was pointed out 
> earlier?

What gave you that impression?  It simply wasn't part of this example.

To be honest, it'd be much easier if we only defined these operations on
atomic_t's.  We have all the infrastructure in place for them, and
they're fairly well understood.  If you need different sizes, I'm OK
with an atomic_pointer_t, or whatever.

