Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937674AbWLFVg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937674AbWLFVg3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937673AbWLFVg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:36:28 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:42333 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937672AbWLFVg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:36:28 -0500
Date: Wed, 6 Dec 2006 14:36:27 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061206213626.GE3013@parisc-linux.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206195820.GA15281@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 07:58:20PM +0000, Russell King wrote:
> No.  If you read what I said, you'll see that you can _cheaply_ use
> cmpxchg in a ll/sc based implementation.  Take an atomic increment
> operation.
> 
> 	do {
> 		old = load_locked(addr);
> 	} while (store_exclusive(old, old + 1, addr);

[...]

> Implementing ll/sc based accessor macros allows both ll/sc _and_ cmpxchg
> architectures to produce optimal code.
> 
> Implementing an cmpxchg based accessor macro allows cmpxchg architectures
> to produce optimal code and ll/sc non-optimal code.

And for those of us with only load-and-zero, that's simply:

#define load_locked(addr) spin_lock(hash(addr)), *addr
#define store_exclusive(addr, old, new) \
			*addr = new, spin_unlock(hash(addr)), 0

which is also optimal for us.
